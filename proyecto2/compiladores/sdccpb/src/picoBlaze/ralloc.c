/*------------------------------------------------------------------------

  ralloc.c - source file for register allocation. PICOBLAZE specific

                Written By -  Sandeep Dutta . sandeep.dutta@usa.net (1998)
                Added Pic Port T.scott Dattalo scott@dattalo.com (2000)
                Added Pic16 Port Martin Dubuc m.dubuc@rogers.com (2002)

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 2, or (at your option) any
   later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

   In other words, you are welcome to use, share and improve this program.
   You are forbidden to forbid anyone else to use, share and improve
   what you give them.   Help stamp out software-hoarding!
-------------------------------------------------------------------------*/

#include "common.h"
#include "ralloc.h"
#include "pcode.h"
#include "gen.h"
#include "device.h"
#include "rallocdbg.h"


//#define USE_ONSTACK


/*-----------------------------------------------------------------*/
/* At this point we start getting processor specific although      */
/* some routines are non-processor specific & can be reused when   */
/* targetting other processors. The decision for this will have    */
/* to be made on a routine by routine basis                        */
/* routines used to pack registers are most definitely not reusable */
/* since the pack the registers depending strictly on the MCU      */
/*-----------------------------------------------------------------*/

regs *picoBlaze_typeRegWithIdx (int idx, int type, int fixed);
extern void genpicoBlazeCode (iCode *);

/* Global data */
static struct
  {
    bitVect *spiltSet;
    set *stackSpil;
    bitVect *regAssigned;
    short blockSpil;
    int slocNum;
    bitVect *funcrUsed;         /* registers used in a function */
    int stackExtend;
    int dataExtend;
  }
_G;

/* Shared with gen.c */
int picoBlaze_ptrRegReq;            /* one byte pointer register required */


set *picoBlaze_dynAllocRegs=NULL;
set *picoBlaze_dynDirectRegs=NULL;
set *picoBlaze_dynDirectBitRegs=NULL;
set *picoBlaze_dynAccessRegs=NULL;

static hTab *dynAllocRegNames=NULL;
static hTab *dynDirectRegNames=NULL;
static hTab *dynDirectBitRegNames=NULL;
static hTab *dynProcRegNames=NULL;
static hTab *dynAccessRegNames=NULL;
//static hTab  *regHash = NULL;    /* a hash table containing ALL registers */

extern set *picoBlaze_sectNames;

set *picoBlaze_rel_udata=NULL;      /* relocatable uninitialized registers */
set *picoBlaze_fix_udata=NULL;      /* absolute uninitialized registers */
set *picoBlaze_equ_data=NULL;       /* registers used by equates */
set *picoBlaze_int_regs=NULL;       /* internal registers placed in access bank 0 to 0x7f */
set *picoBlaze_acs_udata=NULL;      /* access bank variables */

set *picoBlaze_builtin_functions=NULL;

static int dynrIdx=0x00;                //0x20;         // starting temporary register rIdx
static int rDirectIdx=0;

int picoBlaze_nRegs = 16;   // = sizeof (regspicoBlaze) / sizeof (regs);

int picoBlaze_Gstack_base_addr=0; /* The starting address of registers that
                         * are used to pass and return parameters */

int _picoBlaze_inRegAllocator=0;  /* flag that marks whether allocReg happens while
                         * inside the register allocator function */

static void spillThis (symbol *);


FILE *iCodeDumpFile;
int iCodeDumpFileDeep = 0;



#define AOP(op) op->aop


#include "rallocaux.inc.h"

/*-----------------------------------------------------------------*
 Allocation of new dynamic register taken from PIC
 *-----------------------------------------------------------------*/
regs *
picoBlaze_allocProcessorRegister(int rIdx, char * name, short po_type, int alias)
{
	regs *reg = picoBlaze_newReg(REG_GPR, po_type, rIdx, name, 1, alias, NULL);

//      fprintf(stderr,"%s: %s addr =0x%x\n",__FUNCTION__, name, rIdx);

    reg->wasUsed = 0;               // we do not know if they are going to be used at all
    reg->accessBank = 1;            // implicit add access Bank

    hTabAddItem(&dynProcRegNames, regname2key(reg->name), reg);

	return addSet(&picoBlaze_dynDirectRegs, reg);
}




/*-----------------------------------------------------------------*/
/* picoBlaze_newReg - allocate and init memory for a new register            */
/*-----------------------------------------------------------------*/
regs* picoBlaze_newReg(int type, short pc_type, int rIdx, char *name, unsigned size, int alias, operand *refop)
{
	regs *dReg;
	char registerId;

	if (rIdx >= 10)
		registerId = 65+rIdx;
	else
		registerId = 48+rIdx;

	dReg = Safe_calloc(1,sizeof(regs));
    dReg->type = type;
    dReg->pc_type = pc_type;
    dReg->rIdx = rIdx;
    if(name)
            dReg->name = Safe_strdup(name);
    else {
      if(picoBlaze_options.xinst && pc_type == PO_GPR_TEMP) {
        sprintf(buffer,"0x%02x", dReg->rIdx);
      } else {
        sprintf(buffer,"s%c", registerId);
      }

      dReg->name = Safe_strdup(buffer);
    }

    dReg->isFree = 0;
    dReg->wasUsed = 1;
    dReg->isEmitted = 0;

    dReg->isFixed = 0;
    dReg->address = 0;
    dReg->accessBank = 0;


#if NEWREG_DEBUG
        fprintf(stderr,"picoBlaze_newReg @ %p: %s, rIdx = 0x%02x\taccess= %d\tregop= %p\n",dReg, dReg->name,rIdx, dReg->accessBank, refop);
#endif
    dReg->size = size;
    dReg->alias = alias;
    dReg->reg_alias = NULL;
    dReg->reglives.usedpFlows = newSet();
    dReg->reglives.assignedpFlows = newSet();
    dReg->regop = refop;

    if(!(alias == 0x80))
            hTabAddItem(&dynDirectRegNames, regname2key(dReg->name), dReg);

  return dReg;
}

/*-----------------------------------------------------------------*/
/* regWithIdx - Search through a set of registers that matches idx */
/*-----------------------------------------------------------------*/
static regs *
regWithIdx (set *dRegs, int idx, unsigned fixed)
{
  regs *dReg;

//#define D(text)       text
#define D(text)

  for (dReg = setFirstItem(dRegs) ; dReg ;
       dReg = setNextItem(dRegs)) {

        D(fprintf(stderr, "%s:%d testing reg w/rIdx = %d (%d f:%d)\t", __FUNCTION__, __LINE__, dReg->rIdx, idx, fixed));
    if(idx == dReg->rIdx && (fixed == dReg->isFixed)) {
          D(fprintf(stderr, "found!\n"));
      return dReg;
    } else
          D(fprintf(stderr, "not found!\n"));
  }

  return NULL;
}

/*-----------------------------------------------------------------*/
/* regFindFree - Search for a free register in a set of registers  */
/*-----------------------------------------------------------------*/
static regs *
regFindFree (set *dRegs)
{
  regs *dReg;

  for (dReg = setFirstItem(dRegs) ; dReg ;
       dReg = setNextItem(dRegs)) {

//      fprintf(stderr, "%s:%d checking register %s (%p) [rIdx: 0x%02x] if free= %d\n",
//              __FILE__, __LINE__, dReg->name, dReg, dReg->rIdx, dReg->isFree);

    if(dReg->isFree) {
//              fprintf(stderr, "%s:%d free register found, rIdx = %d\n", __FILE__, __LINE__, dReg->rIdx);

      return dReg;
    }
  }

  return NULL;
}

static regs *
regFindFreeNext(set *dRegs, regs *creg)
{
  regs *dReg;

    if(creg) {
      /* position at current register */
      for(dReg = setFirstItem(dRegs); dReg != creg; dReg = setNextItem(dRegs));
    }

    for(dReg = setNextItem(dRegs); dReg; dReg = setNextItem(dRegs)) {
      if(dReg->isFree) {
        return dReg;
      }
    }

  return NULL;
}

/*-----------------------------------------------------------------*/
/* allocReg - allocates register of given type                     */
/*-----------------------------------------------------------------*/
static regs *
allocReg (short type)
{
  regs * reg = NULL;

/* TODO: change to some configurable property of picoblaze port */
#define MAX_PICOBLAZE_NREGS   16


        /* try to reuse some unused registers */
        reg = regFindFree( picoBlaze_dynAllocRegs );

        if(reg) {
//              fprintf(stderr, "%s: [%s][cf:%p] found FREE register %s, rIdx: %d\n", __FILE__, (_picoBlaze_inRegAllocator)?"ralloc":"", currFunc, reg->name, reg->rIdx);
        }

        if(!reg) {
                reg = picoBlaze_newReg(REG_GPR, PO_GPR_TEMP, dynrIdx++, NULL, 1, 0, NULL);
//              fprintf(stderr, "%s [%s][cf:%p] allocating NEW register %s, rIdx: %d\n", __FILE__,
//                                      (_picoBlaze_inRegAllocator)?"ralloc":"", currFunc, reg->name, reg->rIdx);

#if 1
                if(_picoBlaze_inRegAllocator && (dynrIdx > MAX_PICOBLAZE_NREGS)) {
                  //                  debugf("allocating more registers than available\n", 0);
                  //                  return (NULL);
                }

				printf("Adding new dynamic register %s \n", reg->name);
				addSet(&picoBlaze_dynAllocRegs, reg);
                hTabAddItem(&dynAllocRegNames, regname2key(reg->name), reg);
//              fprintf(stderr, "%s:%d added reg to picoBlaze_dynAllocRegs = %p\n", __FUNCTION__, __LINE__, picoBlaze_dynAllocRegs);
#endif
        }

        debugLog ("%s of type %s for register rIdx: %d (0x%x)\n", __FUNCTION__, debugLogRegType (type), dynrIdx-1, dynrIdx-1);

        if(reg) {
                reg->isFree=0;
                reg->accessBank = 1;    /* this is a temporary register alloc in accessBank */
                reg->isLocal = 1;       /* this is a local frame register */
//              reg->wasUsed = 1;
        }

        if (currFunc) {
//              fprintf(stderr, "%s:%d adding %s into function %s regsUsed\n", __FUNCTION__, __LINE__, reg->name, currFunc->name);
                currFunc->regsUsed = bitVectSetBit (currFunc->regsUsed, reg->rIdx);
        }

  return (reg);         // addSet(&picoBlaze_dynAllocRegs,reg);

}


/*-----------------------------------------------------------------*/
/* picoBlaze_dirRegWithName - search for register by name                    */
/*-----------------------------------------------------------------*/
regs *
picoBlaze_dirRegWithName (char *name)
{
  int hkey;
  regs *reg;

  if(!name)
    return NULL;

  /* hash the name to get a key */

  hkey = regname2key(name);

//      fprintf(stderr, "%s:%d: name = %s\thash = %d\n", __FUNCTION__, __LINE__, name, hkey);

  reg = hTabFirstItemWK(dynDirectRegNames, hkey);

  while(reg) {

    if(STRCASECMP(reg->name, name) == 0) {
//              fprintf(stderr, "%s:%d: FOUND name = %s\thash = %d\n", __FUNCTION__, __LINE__, reg->name, hkey);
      return(reg);
    }

    reg = hTabNextItemWK (dynDirectRegNames);

  }

  return NULL; // name wasn't found in the hash table
}

/*-----------------------------------------------------------------*/
/* picoBlaze_allocRegWithName - search for register by name                    */
/*-----------------------------------------------------------------*/
regs *
picoBlaze_allocRegWithName (char *name)
{
  int hkey;
  regs *reg;

  if(!name)
    return NULL;

  /* hash the name to get a key */

  hkey = regname2key(name);

  //fprintf(stderr, "%s:%d: name = %s\thash = %d\n", __FUNCTION__, __LINE__, name, hkey);

  reg = hTabFirstItemWK(dynAllocRegNames, hkey);

  while(reg) {

    if(STRCASECMP(reg->name, name) == 0) {
      return(reg);
    }

    reg = hTabNextItemWK (dynAllocRegNames);

  }

  return NULL; // name wasn't found in the hash table

}


/*-----------------------------------------------------------------*/
/* picoBlaze_procregWithName - search for register by name                    */
/*-----------------------------------------------------------------*/
regs *
picoBlaze_procregWithName (char *name)
{
  int hkey;
  regs *reg;

  if(!name)
    return NULL;

  /* hash the name to get a key */

  hkey = regname2key(name);

//      fprintf(stderr, "%s:%d: name = %s\thash = %d\n", __FUNCTION__, __LINE__, name, hkey);

  reg = hTabFirstItemWK(dynProcRegNames, hkey);

  while(reg) {

    if(STRCASECMP(reg->name, name) == 0) {
      return(reg);
    }

    reg = hTabNextItemWK (dynProcRegNames);

  }

  return NULL; // name wasn't found in the hash table

}

/*-----------------------------------------------------------------*/
/* picoBlaze_accessRegWithName - search for register by name           */
/*-----------------------------------------------------------------*/
regs *
picoBlaze_accessRegWithName (char *name)
{
  int hkey;
  regs *reg;

  if(!name)
    return NULL;

  /* hash the name to get a key */

  hkey = regname2key(name);

//      fprintf(stderr, "%s:%d: name = %s\thash = %d\n", __FUNCTION__, __LINE__, name, hkey);

  reg = hTabFirstItemWK(dynAccessRegNames, hkey);

  while(reg) {

    if(STRCASECMP(reg->name, name) == 0) {
      return(reg);
    }

    reg = hTabNextItemWK (dynAccessRegNames);

  }

  return NULL; // name wasn't found in the hash table

}

regs *picoBlaze_regWithName(char *name)
{
  regs *reg;

        reg = picoBlaze_dirRegWithName( name );
        if(reg)return reg;

        reg = picoBlaze_procregWithName( name );
        if(reg)return reg;

        reg = picoBlaze_allocRegWithName( name );
        if(reg)return reg;

        reg = picoBlaze_accessRegWithName( name );
        if(reg)return reg;

  return NULL;
}


/*-----------------------------------------------------------------*/
/* picoBlaze_allocDirReg - allocates register of given type                  */
/*-----------------------------------------------------------------*/
regs *
picoBlaze_allocDirReg (operand *op )
{
  regs *reg;
  char *name;

        if(!IS_SYMOP(op)) {
                debugLog ("%s BAD, op is NULL\n", __FUNCTION__);
//              fprintf(stderr, "%s BAD, op is NULL\n", __FUNCTION__);
          return NULL;
        }

        name = OP_SYMBOL (op)->rname[0] ? OP_SYMBOL (op)->rname : OP_SYMBOL (op)->name;


        if(!SPEC_OCLS( OP_SYM_ETYPE(op))) {
                return NULL;
        }

        if(!IN_DIRSPACE( SPEC_OCLS( OP_SYM_ETYPE(op)))
                || !IN_FARSPACE(SPEC_OCLS( OP_SYM_ETYPE(op))) ) {

        }



        if (IS_CODE ( OP_SYM_ETYPE(op)) ) {
//              fprintf(stderr, "%s:%d sym: %s in codespace\n", __FUNCTION__, __LINE__, OP_SYMBOL(op)->name);
                return NULL;
        }

        if(IS_ITEMP(op))return NULL;

//      if(IS_STATIC(OP_SYM_ETYPE(op)))return NULL;

        if(IN_STACK(OP_SYM_ETYPE(op)))return NULL;

        debugLog ("%s:%d symbol name %s\n", __FUNCTION__, __LINE__, name);
//      fprintf(stderr, "%s symbol name %s\tSTATIC:%d\n", __FUNCTION__,name, IS_STATIC(OP_SYM_ETYPE(op)));

        {
                if(SPEC_CONST ( OP_SYM_ETYPE(op)) && (IS_CHAR ( OP_SYM_ETYPE(op)) )) {
                        debugLog(" %d  const char\n",__LINE__);
                        debugLog(" value = %s \n",SPEC_CVAL( OP_SYM_ETYPE(op)));
//                      fprintf(stderr, " %d  const char\n",__LINE__);
//                      fprintf(stderr, " value = %s \n",SPEC_CVAL( OP_SYM_ETYPE(op)));
                }


                debugLog("  %d  storage class %d \n",__LINE__,SPEC_SCLS( OP_SYM_ETYPE(op)));
                if (IS_CODE ( OP_SYM_ETYPE(op)) )
                        debugLog(" %d  code space\n",__LINE__);

                if (IS_INTEGRAL ( OP_SYM_ETYPE(op)) )
                        debugLog(" %d  integral\n",__LINE__);

                if (IS_LITERAL ( OP_SYM_ETYPE(op)) )
                        debugLog(" %d  literal\n",__LINE__);

                if (IS_SPEC ( OP_SYM_ETYPE(op)) )
                        debugLog(" %d  specifier\n",__LINE__);

                debugAopGet(NULL, op);
        }


        reg = picoBlaze_dirRegWithName(name);

        if(!reg) {
          int address = 0;
          int regtype = REG_GPR;

                /* if this is at an absolute address, then get the address. */
                if (SPEC_ABSA ( OP_SYM_ETYPE(op)) ) {
                        address = SPEC_ADDR ( OP_SYM_ETYPE(op));
//                      fprintf(stderr,"reg %s is at an absolute address: 0x%03x\n",name,address);
                }

                /* Register wasn't found in hash, so let's create
                 * a new one and put it in the hash table AND in the
                 * dynDirectRegNames set */
                if(IS_CODE(OP_SYM_ETYPE(op)) || IN_CODESPACE( SPEC_OCLS( OP_SYM_ETYPE(op)))) {
                        debugLog("%s:%d sym: %s in codespace\n", __FUNCTION__, __LINE__, OP_SYMBOL(op)->name);
                  return NULL;
                }

                if(!IN_DIRSPACE( SPEC_OCLS( OP_SYM_ETYPE(op)))
                        || !IN_FARSPACE(SPEC_OCLS( OP_SYM_ETYPE(op))) ) {
                }

                reg = picoBlaze_newReg(regtype, PO_DIR, rDirectIdx++, name,getSize (OP_SYMBOL (op)->type),0, op);
                debugLog ("%d  -- added %s to hash, size = %d\n", __LINE__, name,reg->size);

                if( SPEC_SCLS( OP_SYM_ETYPE( op ) ) == S_REGISTER ) {
                        fprintf(stderr, "%s:%d symbol %s is declared as register\n", __FILE__, __LINE__,
                                name);

                        reg->accessBank = 1;
                        picoBlaze_checkAddReg(&picoBlaze_dynAccessRegs, reg);
                        hTabAddItem(&dynAccessRegNames, regname2key(name), reg);

                  return (reg);
                }



                if (IS_BITVAR (OP_SYM_ETYPE(op))) {
//                      fprintf(stderr, "%s:%d adding %s in bit registers\n", __FILE__, __LINE__, reg->name);
                        addSet(&picoBlaze_dynDirectBitRegs, reg);
                        reg->isBitField = 1;
                } else {
//                      fprintf(stderr, "%s:%d adding %s in direct registers\n", __FILE__, __LINE__, reg->name);
//                      addSet(&picoBlaze_dynDirectRegs, reg);

#if 1
                  if(!(IS_STATIC(OP_SYM_ETYPE(op))
                      && OP_SYMBOL(op)->ival
                  ))
#endif
                    picoBlaze_checkAddReg(&picoBlaze_dynDirectRegs, reg);
                }

        } else {
//              debugLog ("  -- %s is declared at address 0x30000x\n",name);
          return (reg);                 /* This was NULL before, but since we found it
                                         * why not just return it?! */
        }

        if (SPEC_ABSA ( OP_SYM_ETYPE(op)) ) {
                reg->isFixed = 1;
                reg->address = SPEC_ADDR ( OP_SYM_ETYPE(op));

                /* work around for user defined registers in access bank */
                if((reg->address>= 0x00 && reg->address < picoBlaze->acsSplitOfs)
                        || (reg->address >= (0xf00 + picoBlaze->acsSplitOfs) && reg->address <= 0xfff))
                        reg->accessBank = 1;

                debugLog ("  -- and it is at a fixed address 0x%02x\n",reg->address);
        }

  return reg;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_allocRegByName - allocates register of given type                  */
/*-----------------------------------------------------------------*/
regs *
picoBlaze_allocRegByName (char *name, int size, operand *op)
{

  regs *reg;

  if(!name) {
    fprintf(stderr, "%s - allocating a NULL register\n",__FUNCTION__);
    exit(1);
  }

  /* First, search the hash table to see if there is a register with this name */
  reg = picoBlaze_dirRegWithName(name);

  if(!reg) {

    /* Register wasn't found in hash, so let's create
     * a new one and put it in the hash table AND in the
     * dynDirectRegNames set */

        //fprintf (stderr,"%s:%d symbol name %s\tregop= %p\n", __FUNCTION__, __LINE__, name, op);

    reg = picoBlaze_newReg(REG_GPR, PO_GPR_REGISTER, rDirectIdx++, name,size,0, op);

    debugLog ("%d  -- added %s to hash, size = %d\n", __LINE__, name,reg->size);
        //fprintf(stderr, "  -- added %s to hash, size = %d\n", name,reg->size);

    //hTabAddItem(&dynDirectRegNames, regname2key(name), reg);  /* initially commented out */
    addSet(&picoBlaze_dynDirectRegs, reg);
  }

  return reg;
}

/*-----------------------------------------------------------------*/
/* RegWithIdx - returns pointer to register with index number       */
/*-----------------------------------------------------------------*/
regs *picoBlaze_typeRegWithIdx (int idx, int type, int fixed)
{

  regs *dReg;

  debugLog ("%s - requesting index = 0x%x\n", __FUNCTION__,idx);
//  fprintf(stderr, "%s - requesting index = 0x%x (type = %d [%s])\n", __FUNCTION__, idx, type, decodeRegType(type));

  switch (type) {

  case REG_GPR:
    if( (dReg = regWithIdx ( picoBlaze_dynAllocRegs, idx, fixed)) != NULL) {

      debugLog ("Found a Dynamic Register!\n");
      return dReg;
    }
    if( (dReg = regWithIdx ( picoBlaze_dynDirectRegs, idx, fixed)) != NULL ) {
      debugLog ("Found a Direct Register!\n");
      return dReg;
    }

    break;

  case REG_CND:
  case REG_PTR:
  default:
    break;
  }


  return NULL;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_regWithIdx - returns pointer to register with index number*/
/*-----------------------------------------------------------------*/
regs *
picoBlaze_regWithIdx (int idx)
{
  regs *dReg;

  if( (dReg = picoBlaze_typeRegWithIdx(idx,REG_GPR,0)) != NULL)
    return dReg;

  return NULL;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_allocWithIdx - returns pointer to register with index number (creates it if necessary) */
/*-----------------------------------------------------------------*/
regs *
picoBlaze_allocWithIdx (int idx)
{

  regs *dReg=NULL;

  debugLog ("%s - allocating with index = 0x%x\n", __FUNCTION__,idx);
//  fprintf(stderr, "%s - allocating with index = 0x%x\n", __FUNCTION__,idx);

  if( (dReg = regWithIdx ( picoBlaze_dynAllocRegs, idx,0)) != NULL) {

    debugLog ("Found a Dynamic Register!\n");
  } else {

    debugLog ("Dynamic Register not found\n");

#if 1
        dReg = picoBlaze_newReg(REG_GPR, PO_GPR_TEMP, idx, NULL, 1, 0, NULL);
        addSet(&picoBlaze_dynAllocRegs, dReg);
        hTabAddItem(&dynAllocRegNames, regname2key(dReg->name), dReg);
#endif

        if(!dReg) {
//      return (NULL);
    //fprintf(stderr,"%s %d - requested register: 0x%x\n",__FUNCTION__,__LINE__,idx);
            werror (E_INTERNAL_ERROR, __FILE__, __LINE__,
                    "allocWithIdx not found");
            exit (1);
        }
  }

  dReg->wasUsed = 1;
  dReg->isFree = 0;

  return dReg;
}
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
regs *
picoBlaze_findFreeReg(short type)
{
  //  int i;
  regs* dReg;

  switch (type) {
  case REG_GPR:
    if((dReg = regFindFree(picoBlaze_dynAllocRegs)) != NULL)
      return dReg;
//      return (addSet(&picoBlaze_dynAllocRegs,picoBlaze_newReg(REG_GPR, PO_GPR_TEMP,dynrIdx++,NULL,1,0, NULL)));
    return allocReg( REG_GPR );

  case REG_PTR:
  case REG_CND:
  default:
    return NULL;
  }
}

regs *
picoBlaze_findFreeRegNext(short type, regs *creg)
{
  //  int i;
  regs* dReg;

  switch (type) {
  case REG_GPR:
    if((dReg = regFindFreeNext(picoBlaze_dynAllocRegs, creg)) != NULL)
      return dReg;
//        return (addSet(&picoBlaze_dynAllocRegs,picoBlaze_newReg(REG_GPR, PO_GPR_TEMP,dynrIdx++,NULL,1,0, NULL)));
    return (allocReg( REG_GPR ) );

  case REG_PTR:
  case REG_CND:
  default:
    return NULL;
  }
}
/*-----------------------------------------------------------------*/
/* freeReg - frees a register                                      */
/*-----------------------------------------------------------------*/
static void
freeReg (regs * reg)
{
        debugLog ("%s\n", __FUNCTION__);
//      fprintf(stderr, "%s:%d register %s (%p) is freed\n", __FILE__, __LINE__, reg->name, reg);
        reg->isFree = 1;
}


/*-----------------------------------------------------------------*/
/* nFreeRegs - returns number of free registers                    */
/*-----------------------------------------------------------------*/
static int
nFreeRegs (int type)
{
  regs *reg;
  int nfr=0;


                /* although I fixed the register allocation/freeing scheme
                 * the for loop below doesn't give valid results. I do not
                 * know why yet. -- VR 10-Jan-2003 */

        return 100;


  /* dynamically allocate as many as we need and worry about
   * fitting them into a PIC later */

  debugLog ("%s\n", __FUNCTION__);

        for(reg = setFirstItem(picoBlaze_dynAllocRegs); reg; reg = setNextItem(picoBlaze_dynAllocRegs))
                if((reg->type == type) && reg->isFree) nfr++;

        fprintf(stderr, "%s:%d # of free registers= %d\n", __FILE__, __LINE__, nfr);
  return nfr;
}

/*-----------------------------------------------------------------*/
/* nfreeRegsType - free registers with type                         */
/*-----------------------------------------------------------------*/
static int
nfreeRegsType (int type)
{
  int nfr;
  debugLog ("%s\n", __FUNCTION__);
  if (type == REG_PTR)
    {
      if ((nfr = nFreeRegs (type)) == 0)
        return nFreeRegs (REG_GPR);
    }

  return nFreeRegs (type);
}

extern void picoBlaze_groupRegistersInSection(set *regset);

extern void picoBlaze_dump_equates(FILE *of, set *equs);
extern void picoBlaze_dump_access(FILE *of, set *section);
//extern void picoBlaze_dump_map(void);
extern void picoBlaze_dump_usection(FILE *of, set *section, int fix);
extern void picoBlaze_dump_isection(FILE *of, set *section, int fix);
extern void picoBlaze_dump_int_registers(FILE *of, set *section);
extern void picoBlaze_dump_idata(FILE *of, set *idataSymSet);

extern void picoBlaze_dump_gsection(FILE *of, set *sections);

static void packBits(set *bregs)
{
  set *regset;
  regs *breg;
  regs *bitfield=NULL;
  regs *relocbitfield=NULL;
  int bit_no=0;
  int byte_no=-1;
  char buffer[20];


  for (regset = bregs ; regset ;
       regset = regset->next) {

    breg = regset->item;
    breg->isBitField = 1;
    //fprintf(stderr,"bit reg: %s\n",breg->name);

    if(breg->isFixed) {
      //fprintf(stderr,"packing bit at fixed address = 0x%03x\n",breg->address);

      bitfield = picoBlaze_typeRegWithIdx (breg->address >> 3, -1 , 1);
      breg->rIdx = breg->address & 7;
      breg->address >>= 3;

      if(!bitfield) {
        sprintf (buffer, "fbitfield%02x", breg->address);
        //fprintf(stderr,"new bit field\n");
        bitfield = picoBlaze_newReg(REG_GPR, PO_GPR_BIT,breg->address,buffer,1,0, NULL);
        bitfield->isBitField = 1;
        bitfield->isFixed = 1;
        bitfield->address = breg->address;
        addSet(&picoBlaze_dynDirectRegs,bitfield);
        //hTabAddItem(&dynDirectRegNames, regname2key(buffer), bitfield);
      } else {
        //fprintf(stderr,"  which is occupied by %s (addr = %d)\n",bitfield->name,bitfield->address);
        ;
      }
      breg->reg_alias = bitfield;
      bitfield = NULL;

    } else {
      if(!relocbitfield || bit_no >7) {
        byte_no++;
        bit_no=0;
        sprintf (buffer, "bitfield%d", byte_no);
        //fprintf(stderr,"new relocatable bit field\n");
        relocbitfield = picoBlaze_newReg(REG_GPR, PO_GPR_BIT,rDirectIdx++,buffer,1,0, NULL);
        relocbitfield->isBitField = 1;
        addSet(&picoBlaze_dynDirectRegs,relocbitfield);
        //hTabAddItem(&dynDirectRegNames, regname2key(buffer), relocbitfield);

      }

      breg->reg_alias = relocbitfield;
      breg->address = rDirectIdx;   /* byte_no; */
      breg->rIdx = bit_no++;
    }
  }

}

void picoBlaze_writeUsedRegs(FILE *of)
{
  packBits(picoBlaze_dynDirectBitRegs);

  picoBlaze_groupRegistersInSection(picoBlaze_dynAllocRegs);
  picoBlaze_groupRegistersInSection(picoBlaze_dynDirectRegs);
  picoBlaze_groupRegistersInSection(picoBlaze_dynDirectBitRegs);
  picoBlaze_groupRegistersInSection(picoBlaze_dynAccessRegs);

  /* dump equates */
  picoBlaze_dump_equates(of, picoBlaze_equ_data);

//      picoBlaze_dump_esection(of, picoBlaze_rel_eedata, 0);
//      picoBlaze_dump_esection(of, picoBlaze_fix_eedata, 0);

  /* dump access bank symbols */
  picoBlaze_dump_access(of, picoBlaze_acs_udata);

  /* dump initialised data */
  picoBlaze_dump_isection(of, picoBlaze_rel_idataSymSet, 0);
  picoBlaze_dump_isection(of, picoBlaze_fix_idataSymSet, 1);

  if(!picoBlaze_options.xinst) {
    /* dump internal registers */
    picoBlaze_dump_int_registers(of, picoBlaze_int_regs);
  }

  /* dump generic section variables */
  picoBlaze_dump_gsection(of, picoBlaze_sectNames);

  /* dump other variables */
  picoBlaze_dump_usection(of, picoBlaze_rel_udata, 0);
  picoBlaze_dump_usection(of, picoBlaze_fix_udata, 1);
}


/*-----------------------------------------------------------------*/
/* computeSpillable - given a point find the spillable live ranges */
/*-----------------------------------------------------------------*/
static bitVect *
computeSpillable (iCode * ic)
{
  bitVect *spillable;

  debugLog ("%s\n", __FUNCTION__);
  /* spillable live ranges are those that are live at this
     point . the following categories need to be subtracted
     from this set.
     a) - those that are already spilt
     b) - if being used by this one
     c) - defined by this one */

  spillable = bitVectCopy (ic->rlive);
  spillable =
    bitVectCplAnd (spillable, _G.spiltSet);     /* those already spilt */
  spillable =
    bitVectCplAnd (spillable, ic->uses);        /* used in this one */
  bitVectUnSetBit (spillable, ic->defKey);
  spillable = bitVectIntersect (spillable, _G.regAssigned);
  return spillable;

}

/*-----------------------------------------------------------------*/
/* noSpilLoc - return true if a variable has no spil location      */
/*-----------------------------------------------------------------*/
static int
noSpilLoc (symbol * sym, eBBlock * ebp, iCode * ic)
{
  debugLog ("%s\n", __FUNCTION__);
  return (SYM_SPIL_LOC (sym) ? 0 : 1);
}

/*-----------------------------------------------------------------*/
/* hasSpilLoc - will return 1 if the symbol has spil location      */
/*-----------------------------------------------------------------*/
static int
hasSpilLoc (symbol * sym, eBBlock * ebp, iCode * ic)
{
  debugLog ("%s\n", __FUNCTION__);
  return (SYM_SPIL_LOC (sym) ? 1 : 0);
}

/*-----------------------------------------------------------------*/
/* directSpilLoc - will return 1 if the splilocation is in direct  */
/*-----------------------------------------------------------------*/
static int
directSpilLoc (symbol * sym, eBBlock * ebp, iCode * ic)
{
  debugLog ("%s\n", __FUNCTION__);
  if (SYM_SPIL_LOC (sym) &&
      (IN_DIRSPACE (SPEC_OCLS (SYM_SPIL_LOC (sym)->etype))))
    return 1;
  else
    return 0;
}

/*-----------------------------------------------------------------*/
/* hasSpilLocnoUptr - will return 1 if the symbol has spil location */
/*                    but is not used as a pointer                 */
/*-----------------------------------------------------------------*/
static int
hasSpilLocnoUptr (symbol * sym, eBBlock * ebp, iCode * ic)
{
  debugLog ("%s\n", __FUNCTION__);
  return ((SYM_SPIL_LOC (sym) && !sym->uptr) ? 1 : 0);
}

/*-----------------------------------------------------------------*/
/* rematable - will return 1 if the remat flag is set              */
/*-----------------------------------------------------------------*/
static int
rematable (symbol * sym, eBBlock * ebp, iCode * ic)
{
  debugLog ("%s\n", __FUNCTION__);
  return sym->remat;
}

/*-----------------------------------------------------------------*/
/* notUsedInRemaining - not used or defined in remain of the block */
/*-----------------------------------------------------------------*/
static int
notUsedInRemaining (symbol * sym, eBBlock * ebp, iCode * ic)
{
  debugLog ("%s\n", __FUNCTION__);
  return ((usedInRemaining (operandFromSymbol (sym), ic) ? 0 : 1) &&
          allDefsOutOfRange (sym->defs, ebp->fSeq, ebp->lSeq));
}

/*-----------------------------------------------------------------*/
/* allLRs - return true for all                                    */
/*-----------------------------------------------------------------*/
static int
allLRs (symbol * sym, eBBlock * ebp, iCode * ic)
{
  debugLog ("%s\n", __FUNCTION__);
  return 1;
}

/*-----------------------------------------------------------------*/
/* liveRangesWith - applies function to a given set of live range  */
/*-----------------------------------------------------------------*/
static set *
liveRangesWith (bitVect * lrs, int (func) (symbol *, eBBlock *, iCode *),
                eBBlock * ebp, iCode * ic)
{
  set *rset = NULL;
  int i;

  debugLog ("%s\n", __FUNCTION__);
  if (!lrs || !lrs->size)
    return NULL;

  for (i = 1; i < lrs->size; i++)
    {
      symbol *sym;
      if (!bitVectBitValue (lrs, i))
        continue;

      /* if we don't find it in the live range
         hash table we are in serious trouble */
      if (!(sym = hTabItemWithKey (liveRanges, i)))
        {
          werror (E_INTERNAL_ERROR, __FILE__, __LINE__,
                  "liveRangesWith could not find liveRange");
          exit (1);
        }

      if (func (sym, ebp, ic) && bitVectBitValue (_G.regAssigned, sym->key))
        addSetHead (&rset, sym);
    }

  return rset;
}


/*-----------------------------------------------------------------*/
/* leastUsedLR - given a set determines which is the least used    */
/*-----------------------------------------------------------------*/
static symbol *
leastUsedLR (set * sset)
{
  symbol *sym = NULL, *lsym = NULL;

  debugLog ("%s\n", __FUNCTION__);
  sym = lsym = setFirstItem (sset);

  if (!lsym)
    return NULL;

  for (; lsym; lsym = setNextItem (sset))
    {

      /* if usage is the same then prefer
         the spill the smaller of the two */
      if (lsym->used == sym->used)
        if (getSize (lsym->type) < getSize (sym->type))
          sym = lsym;

      /* if less usage */
      if (lsym->used < sym->used)
        sym = lsym;

    }

  setToNull ((void *) &sset);
  sym->blockSpil = 0;
  return sym;
}

/*-----------------------------------------------------------------*/
/* noOverLap - will iterate through the list looking for over lap  */
/*-----------------------------------------------------------------*/
static int
noOverLap (set * itmpStack, symbol * fsym)
{
  symbol *sym;
  debugLog ("%s\n", __FUNCTION__);


  for (sym = setFirstItem (itmpStack); sym;
       sym = setNextItem (itmpStack))
    {
      if (sym->liveTo > fsym->liveFrom)
        return 0;

    }

  return 1;
}



/*-----------------------------------------------------------------*/
/* spillLRWithPtrReg :- will spil those live ranges which use PTR  */
/*-----------------------------------------------------------------*/
static void
spillLRWithPtrReg (symbol * forSym)
{
  symbol *lrsym;
  regs *r0, *r1;
  int k;

  debugLog ("%s\n", __FUNCTION__);
  if (!_G.regAssigned ||
      bitVectIsZero (_G.regAssigned))
    return;

  r0 = picoBlaze_regWithIdx (s0_IDX);
  r1 = picoBlaze_regWithIdx (s1_IDX);

  /* for all live ranges */
  for (lrsym = hTabFirstItem (liveRanges, &k); lrsym;
       lrsym = hTabNextItem (liveRanges, &k))
    {
      int j;

      /* if no registers assigned to it or
         spilt */
      /* if it does not overlap with this then
         not need to spill it */

      if (lrsym->isspilt || !lrsym->nRegs ||
          (lrsym->liveTo < forSym->liveFrom))
        continue;

      /* go thru the registers : if it is either
         r0 or r1 then spil it */
      for (j = 0; j < lrsym->nRegs; j++)
        if (lrsym->regs[j] == r0 ||
            lrsym->regs[j] == r1)
          {
            spillThis (lrsym);
            break;
          }
    }

}

/*-----------------------------------------------------------------*/
/* createStackSpil - create a location on the stack to spil        */
/*-----------------------------------------------------------------*/
static symbol *
createStackSpil (symbol * sym)
{
  symbol *sloc = NULL;
  int useXstack, model, noOverlay;

  char slocBuffer[30];
  debugLog ("%s\n", __FUNCTION__);

  /* first go try and find a free one that is already
     existing on the stack */
  if (applyToSet (_G.stackSpil, isFree, &sloc, sym))
    {
      /* found a free one : just update & return */
      SYM_SPIL_LOC (sym) = sloc;
      sym->stackSpil = 1;
      sloc->isFree = 0;
      addSetHead (&sloc->usl.itmpStack, sym);
      return sym;
    }

  /* could not then have to create one , this is the hard part
     we need to allocate this on the stack : this is really a
     hack!! but cannot think of anything better at this time */

  if (sprintf (slocBuffer, "sloc%d", _G.slocNum++) >= sizeof (slocBuffer))
    {
      fprintf (stderr, "kkkInternal error: slocBuffer overflowed: %s:%d\n",
               __FILE__, __LINE__);
      exit (1);
    }

  sloc = newiTemp (slocBuffer);

  /* set the type to the spilling symbol */
  sloc->type = copyLinkChain (sym->type);
  sloc->etype = getSpec (sloc->type);
  SPEC_SCLS (sloc->etype) = S_DATA;
  SPEC_EXTR (sloc->etype) = 0;
  SPEC_STAT (sloc->etype) = 0;

  /* we don't allow it to be allocated`
     onto the external stack since : so we
     temporarily turn it off ; we also
     turn off memory model to prevent
     the spil from going to the external storage
     and turn off overlaying
   */

  useXstack = options.useXstack;
  model = options.model;
  noOverlay = options.noOverlay;
  options.noOverlay = 1;
  options.model = options.useXstack = 0;

  allocLocal (sloc);

  options.useXstack = useXstack;
  options.model = model;
  options.noOverlay = noOverlay;
  sloc->isref = 1;              /* to prevent compiler warning */

  /* if it is on the stack then update the stack */
  if (IN_STACK (sloc->etype))
    {
      currFunc->stack += getSize (sloc->type);
      _G.stackExtend += getSize (sloc->type);
    }
  else
    _G.dataExtend += getSize (sloc->type);

  /* add it to the _G.stackSpil set */
  addSetHead (&_G.stackSpil, sloc);
  SYM_SPIL_LOC (sym) = sloc;
  sym->stackSpil = 1;

  /* add it to the set of itempStack set
     of the spill location */
  addSetHead (&sloc->usl.itmpStack, sym);
  return sym;
}

/*-----------------------------------------------------------------*/
/* isSpiltOnStack - returns true if the spil location is on stack  */
/*-----------------------------------------------------------------*/
static bool
isSpiltOnStack (symbol * sym)
{
  sym_link *etype;

  debugLog ("%s\n", __FUNCTION__);
  if (!sym)
    return FALSE;

  if (!sym->isspilt)
    return FALSE;

/*     if (sym->_G.stackSpil) */
/*      return TRUE; */

  if (!SYM_SPIL_LOC (sym))
    return FALSE;

  etype = getSpec (SYM_SPIL_LOC (sym)->type);
  if (IN_STACK (etype))
    return TRUE;

  return FALSE;
}

/*-----------------------------------------------------------------*/
/* spillThis - spils a specific operand                            */
/*-----------------------------------------------------------------*/
static void
spillThis (symbol * sym)
{
  int i;
  debugLog ("%s : %s\n", __FUNCTION__, sym->rname);

  /* if this is rematerializable or has a spillLocation
     we are okay, else we need to create a spillLocation
     for it */
  if (!(sym->remat || SYM_SPIL_LOC (sym)))
    createStackSpil (sym);


  /* mark it has spilt & put it in the spilt set */
  sym->isspilt = 1;
  _G.spiltSet = bitVectSetBit (_G.spiltSet, sym->key);

  bitVectUnSetBit (_G.regAssigned, sym->key);

  for (i = 0; i < sym->nRegs; i++)

    if (sym->regs[i])
      {
        freeReg (sym->regs[i]);
        sym->regs[i] = NULL;
      }

  /* if spilt on stack then free up r0 & r1
     if they could have been assigned to some
     LIVE ranges */
  if (!picoBlaze_ptrRegReq && isSpiltOnStack (sym))
    {
      picoBlaze_ptrRegReq++;
      spillLRWithPtrReg (sym);
    }

  if (SYM_SPIL_LOC (sym) && !sym->remat)
    SYM_SPIL_LOC (sym)->allocreq = 1;
  return;
}

/*-----------------------------------------------------------------*/
/* selectSpil - select a iTemp to spil : rather a simple procedure */
/*-----------------------------------------------------------------*/
static symbol *
selectSpil (iCode * ic, eBBlock * ebp, symbol * forSym)
{
  bitVect *lrcs = NULL;
  set *selectS;
  symbol *sym;

  debugLog ("%s\n", __FUNCTION__);
  /* get the spillable live ranges */
  lrcs = computeSpillable (ic);

  /* get all live ranges that are rematerizable */
  if ((selectS = liveRangesWith (lrcs, rematable, ebp, ic)))
    {

      /* return the least used of these */
      return leastUsedLR (selectS);
    }

  /* get live ranges with spillLocations in direct space */
  if ((selectS = liveRangesWith (lrcs, directSpilLoc, ebp, ic)))
    {
      sym = leastUsedLR (selectS);
      strcpy (sym->rname, (SYM_SPIL_LOC (sym)->rname[0] ?
                           SYM_SPIL_LOC (sym)->rname :
                           SYM_SPIL_LOC (sym)->name));
      sym->spildir = 1;
      /* mark it as allocation required */
      SYM_SPIL_LOC (sym)->allocreq = 1;
      return sym;
    }

  /* if the symbol is local to the block then */
  if (forSym->liveTo < ebp->lSeq)
    {

      /* check if there are any live ranges allocated
         to registers that are not used in this block */
      if (!_G.blockSpil && (selectS = liveRangesWith (lrcs, notUsedInBlock, ebp, ic)))
        {
          sym = leastUsedLR (selectS);
          /* if this is not rematerializable */
          if (!sym->remat)
            {
              _G.blockSpil++;
              sym->blockSpil = 1;
            }
          return sym;
        }

      /* check if there are any live ranges that not
         used in the remainder of the block */
      if (!_G.blockSpil &&
          !isiCodeInFunctionCall (ic) &&
          (selectS = liveRangesWith (lrcs, notUsedInRemaining, ebp, ic)))
        {
          sym = leastUsedLR (selectS);
          if (!sym->remat)
            {
              sym->remainSpil = 1;
              _G.blockSpil++;
            }
          return sym;
        }
    }

  /* find live ranges with spillocation && not used as pointers */
  if ((selectS = liveRangesWith (lrcs, hasSpilLocnoUptr, ebp, ic)))
    {

      sym = leastUsedLR (selectS);
      /* mark this as allocation required */
      SYM_SPIL_LOC (sym)->allocreq = 1;
      return sym;
    }

  /* find live ranges with spillocation */
  if ((selectS = liveRangesWith (lrcs, hasSpilLoc, ebp, ic)))
    {

      sym = leastUsedLR (selectS);
      SYM_SPIL_LOC (sym)->allocreq = 1;
      return sym;
    }

  /* couldn't find then we need to create a spil
     location on the stack , for which one? the least
     used ofcourse */
  if ((selectS = liveRangesWith (lrcs, noSpilLoc, ebp, ic)))
    {

      /* return a created spil location */
      sym = createStackSpil (leastUsedLR (selectS));
      SYM_SPIL_LOC (sym)->allocreq = 1;
      return sym;
    }

  /* this is an extreme situation we will spill
     this one : happens very rarely but it does happen */
  spillThis (forSym);
  return forSym;

}

/*-----------------------------------------------------------------*/
/* spilSomething - spil some variable & mark registers as free     */
/*-----------------------------------------------------------------*/
static bool
spilSomething (iCode * ic, eBBlock * ebp, symbol * forSym)
{
  symbol *ssym;
  int i;

  debugLog ("%s\n", __FUNCTION__);
  /* get something we can spil */
  ssym = selectSpil (ic, ebp, forSym);

  /* mark it as spilt */
  ssym->isspilt = 1;
  _G.spiltSet = bitVectSetBit (_G.spiltSet, ssym->key);

  /* mark it as not register assigned &
     take it away from the set */
  bitVectUnSetBit (_G.regAssigned, ssym->key);

  /* mark the registers as free */
  for (i = 0; i < ssym->nRegs; i++)
    if (ssym->regs[i])
      freeReg (ssym->regs[i]);

  /* if spilt on stack then free up r0 & r1
     if they could have been assigned to as gprs */
  if (!picoBlaze_ptrRegReq && isSpiltOnStack (ssym))
    {
      picoBlaze_ptrRegReq++;
      spillLRWithPtrReg (ssym);
    }

  /* if this was a block level spil then insert push & pop
     at the start & end of block respectively */
  if (ssym->blockSpil)
    {
      iCode *nic = newiCode (IPUSH, operandFromSymbol (ssym), NULL);
      /* add push to the start of the block */
      addiCodeToeBBlock (ebp, nic, (ebp->sch->op == LABEL ?
                                    ebp->sch->next : ebp->sch));
      nic = newiCode (IPOP, operandFromSymbol (ssym), NULL);
      /* add pop to the end of the block */
      addiCodeToeBBlock (ebp, nic, NULL);
    }

  /* if spilt because not used in the remainder of the
     block then add a push before this instruction and
     a pop at the end of the block */
  if (ssym->remainSpil)
    {

      iCode *nic = newiCode (IPUSH, operandFromSymbol (ssym), NULL);
      /* add push just before this instruction */
      addiCodeToeBBlock (ebp, nic, ic);

      nic = newiCode (IPOP, operandFromSymbol (ssym), NULL);
      /* add pop to the end of the block */
      addiCodeToeBBlock (ebp, nic, NULL);
    }

  if (ssym == forSym)
    return FALSE;
  else
    return TRUE;
}

/*-----------------------------------------------------------------*/
/* getRegPtr - will try for PTR if not a GPR type if not spil      */
/*-----------------------------------------------------------------*/
static regs *
getRegPtr (iCode * ic, eBBlock * ebp, symbol * sym)
{
  regs *reg;
  int j;

  debugLog ("%s\n", __FUNCTION__);
tryAgain:
  /* try for a ptr type */
  if ((reg = allocReg (REG_PTR)))
    return reg;

  /* try for gpr type */
  if ((reg = allocReg (REG_GPR)))
    return reg;

  /* we have to spil */
  if (!spilSomething (ic, ebp, sym))
    return NULL;

  /* make sure partially assigned registers aren't reused */
  for (j=0; j<=sym->nRegs; j++)
    if (sym->regs[j])
      sym->regs[j]->isFree = 0;

  /* this looks like an infinite loop but
     in really selectSpil will abort  */
  goto tryAgain;
}

/*-----------------------------------------------------------------*/
/* getRegGpr - will try for GPR if not spil                        */
/*-----------------------------------------------------------------*/
static regs *
getRegGpr (iCode * ic, eBBlock * ebp, symbol * sym)
{
  regs *reg;
  int j;

  debugLog ("%s\n", __FUNCTION__);
tryAgain:
  /* try for gpr type */
  if ((reg = allocReg (REG_GPR)))
    return reg;

  if (!picoBlaze_ptrRegReq)
    if ((reg = allocReg (REG_PTR)))
      return reg;

  /* we have to spil */
  if (!spilSomething (ic, ebp, sym))
    return NULL;

  /* make sure partially assigned registers aren't reused */
  for (j=0; j<=sym->nRegs; j++)
    if (sym->regs[j])
      sym->regs[j]->isFree = 0;

  /* this looks like an infinite loop but
     in really selectSpil will abort  */
  goto tryAgain;
}

/*-----------------------------------------------------------------*/
/* symHasReg - symbol has a given register                         */
/*-----------------------------------------------------------------*/
static bool
symHasReg (symbol * sym, regs * reg)
{
  int i;

  debugLog ("%s\n", __FUNCTION__);
  for (i = 0; i < sym->nRegs; i++)
    if (sym->regs[i] == reg)
      return TRUE;

  return FALSE;
}

/*-----------------------------------------------------------------*/
/* deassignLRs - check the live to and if they have registers & are */
/*               not spilt then free up the registers              */
/*-----------------------------------------------------------------*/
static void
deassignLRs (iCode * ic, eBBlock * ebp)
{
  symbol *sym;
  int k;
  symbol *result;

  debugLog ("%s\n", __FUNCTION__);
  for (sym = hTabFirstItem (liveRanges, &k); sym;
       sym = hTabNextItem (liveRanges, &k))
    {

      symbol *psym = NULL;
      /* if it does not end here */
      if (sym->liveTo > ic->seq)
        continue;

      /* if it was spilt on stack then we can
         mark the stack spil location as free */
      if (sym->isspilt)
        {
          if (sym->stackSpil)
            {
              SYM_SPIL_LOC (sym)->isFree = 1;
              sym->stackSpil = 0;
            }
          continue;
        }

      if (!bitVectBitValue (_G.regAssigned, sym->key))
        continue;

      /* special case for shifting: there is a case where shift count
       * can be allocated in the same register as the result, so do not
       * free right registers if same as result registers, cause genShiftLeft
       * will fail -- VR */
       if(ic->op == LEFT_OP)
         continue;

      /* special case check if this is an IFX &
         the privious one was a pop and the
         previous one was not spilt then keep track
         of the symbol */
      if (ic->op == IFX && ic->prev &&
          ic->prev->op == IPOP &&
          !ic->prev->parmPush &&
          !OP_SYMBOL (IC_LEFT (ic->prev))->isspilt)
        psym = OP_SYMBOL (IC_LEFT (ic->prev));

      if (sym->nRegs)
        {
          int i = 0;

          bitVectUnSetBit (_G.regAssigned, sym->key);

          /* if the result of this one needs registers
             and does not have it then assign it right
             away */
          if (IC_RESULT (ic) &&
              !(SKIP_IC2 (ic) ||        /* not a special icode */
                ic->op == JUMPTABLE ||
                ic->op == IFX ||
                ic->op == IPUSH ||
                ic->op == IPOP ||
                ic->op == RETURN ||
                POINTER_SET (ic)) &&
              (result = OP_SYMBOL (IC_RESULT (ic))) &&  /* has a result */
              result->liveTo > ic->seq &&       /* and will live beyond this */
              result->liveTo <= ebp->lSeq &&    /* does not go beyond this block */
              result->liveFrom == ic->seq &&    /* does not start before here */
              result->regType == sym->regType &&        /* same register types */
              result->nRegs &&  /* which needs registers */
              !result->isspilt &&       /* and does not already have them */
              !result->remat &&
              !bitVectBitValue (_G.regAssigned, result->key) &&
          /* the number of free regs + number of regs in this LR
             can accomodate the what result Needs */
              ((nfreeRegsType (result->regType) +
                sym->nRegs) >= result->nRegs)
            )
            {

              for (i = 0; i < result->nRegs; i++)
                if (i < sym->nRegs)
                  result->regs[i] = sym->regs[i];
                else
                  result->regs[i] = getRegGpr (ic, ebp, result);

              _G.regAssigned = bitVectSetBit (_G.regAssigned, result->key);

            }

          /* free the remaining */
          for (; i < sym->nRegs; i++)
            {
              if (psym)
                {
                  if (!symHasReg (psym, sym->regs[i]))
                    freeReg (sym->regs[i]);
                }
              else
                freeReg (sym->regs[i]);
            }
        }
    }
}


/*-----------------------------------------------------------------*/
/* reassignLR - reassign this to registers                         */
/*-----------------------------------------------------------------*/
static void
reassignLR (operand * op)
{
  symbol *sym = OP_SYMBOL (op);
  int i;

  debugLog ("%s\n", __FUNCTION__);
  /* not spilt any more */
  sym->isspilt = sym->blockSpil = sym->remainSpil = 0;
  bitVectUnSetBit (_G.spiltSet, sym->key);

  _G.regAssigned = bitVectSetBit (_G.regAssigned, sym->key);

  _G.blockSpil--;

  for (i = 0; i < sym->nRegs; i++)
    sym->regs[i]->isFree = 0;
}

/*-----------------------------------------------------------------*/
/* willCauseSpill - determines if allocating will cause a spill    */
/*-----------------------------------------------------------------*/
static int
willCauseSpill (int nr, int rt)
{
  debugLog ("%s\n", __FUNCTION__);
  /* first check if there are any avlb registers
     of te type required */
  if (rt == REG_PTR)
    {
      /* special case for pointer type
         if pointer type not avlb then
         check for type gpr */
      if (nFreeRegs (rt) >= nr)
        return 0;
      if (nFreeRegs (REG_GPR) >= nr)
        return 0;
    }
  else
    {
      if (picoBlaze_ptrRegReq)
        {
          if (nFreeRegs (rt) >= nr)
            return 0;
        }
      else
        {
          if (nFreeRegs (REG_PTR) +
              nFreeRegs (REG_GPR) >= nr)
            return 0;
        }
    }

  debugLog (" ... yep it will (cause a spill)\n");
  /* it will cause a spil */
  return 1;
}

/*-----------------------------------------------------------------*/
/* positionRegs - the allocator can allocate same registers to res- */
/* ult and operand, if this happens make sure they are in the same */
/* position as the operand otherwise chaos results                 */
/*-----------------------------------------------------------------*/
static void
positionRegs (symbol * result, symbol * opsym, int lineno)
{
  int count = min (result->nRegs, opsym->nRegs);
  int i, j = 0, shared = 0;

  debugLog ("%s\n", __FUNCTION__);
  /* if the result has been spilt then cannot share */
  if (opsym->isspilt)
    return;
again:
  shared = 0;
  /* first make sure that they actually share */
  for (i = 0; i < count; i++)
    {
      for (j = 0; j < count; j++)
        {
          if (result->regs[i] == opsym->regs[j] && i != j)
            {
              shared = 1;
              goto xchgPositions;
            }
        }
    }
xchgPositions:
  if (shared)
    {
      regs *tmp = result->regs[i];
      result->regs[i] = result->regs[j];
      result->regs[j] = tmp;
      goto again;
    }
}


/*-----------------------------------------------------------------*/
/* assignRegistersSerially - serially allocate registers to the variables  */
/*-----------------------------------------------------------------*/
static void assignRegistersSerially (eBBlock ** ebbs, int count)
{
  int i;
  iCode *ic;

  debugLog ("%s\n", __FUNCTION__);
  /* for all blocks */
  for (i = 0; i < count; i++)
    {
      if (ebbs[i]->noPath &&
          (ebbs[i]->entryLabel != entryLabel &&
           ebbs[i]->entryLabel != returnLabel))
        continue;

      /* of all instructions do */
      for (ic = ebbs[i]->sch; ic; ic = ic->next)
        {

          /* take away registers from live
             ranges that end at this instruction */
          deassignLRs (ic, ebbs[i]);

          /* now we need to allocate registers
             only for the result */
          if (IC_RESULT (ic) && (ic->op != IFX)) /* ZK: skip problematic IFX iCode TODO: IF and other conditions and jump tables users */
            {
  			  symbol *sym = OP_SYMBOL (IC_RESULT (ic)); 
              int j;

              /* else we assign registers to it */
              _G.regAssigned = bitVectSetBit (_G.regAssigned, sym->key);

              for (j = 0; j < sym->nRegs; j++)
                {
                  if (sym->regType == REG_PTR)
                    sym->regs[j] = getRegPtr (ic, ebbs[i], sym);
                  else
                    sym->regs[j] = getRegGpr (ic, ebbs[i], sym);

                  /* if the allocation falied which means
                     this was spilt then break */
                  if (!sym->regs[j])
                    break;
                }
            }

        }
    }
}


/*-----------------------------------------------------------------*/
/* serialRegAssign - serially allocate registers to the variables  */
/*-----------------------------------------------------------------*/
static void
serialRegAssign (eBBlock ** ebbs, int count)
{
  int i;
  iCode *ic;

  debugLog ("%s\n", __FUNCTION__);
  /* for all blocks */
  for (i = 0; i < count; i++)
    {
      if (ebbs[i]->noPath &&
          (ebbs[i]->entryLabel != entryLabel &&
           ebbs[i]->entryLabel != returnLabel))
        continue;

      /* of all instructions do */
      for (ic = ebbs[i]->sch; ic; ic = ic->next)
        {

          debugLog ("  op: %s\n", picoBlaze_decodeOp (ic->op));

                if(IC_RESULT(ic) && !IS_ITEMP( IC_RESULT(ic)))
                        picoBlaze_allocDirReg(IC_RESULT(ic));

                if(IC_LEFT(ic) && !IS_ITEMP( IC_LEFT(ic)))
                        picoBlaze_allocDirReg(IC_LEFT(ic));

                if(IC_RIGHT(ic) && !IS_ITEMP( IC_RIGHT(ic)))
                        picoBlaze_allocDirReg(IC_RIGHT(ic));

          /* if this is an ipop that means some live
             range will have to be assigned again */
          if (ic->op == IPOP)
            reassignLR (IC_LEFT (ic));

          /* if result is present && is a true symbol */
          if (IC_RESULT (ic) && ic->op != IFX &&
              IS_TRUE_SYMOP (IC_RESULT (ic)))
            OP_SYMBOL (IC_RESULT (ic))->allocreq = 1;

          /* take away registers from live
             ranges that end at this instruction */
          deassignLRs (ic, ebbs[i]);

          /* some don't need registers */
          if (SKIP_IC2 (ic) ||
              ic->op == JUMPTABLE ||
              ic->op == IFX ||
              ic->op == IPUSH ||
              ic->op == IPOP ||
              (IC_RESULT (ic) && POINTER_SET (ic)))
            continue;

          /* now we need to allocate registers
             only for the result */
          if (IC_RESULT (ic))
            {
              symbol *sym = OP_SYMBOL (IC_RESULT (ic));
              bitVect *spillable;
              int willCS;
              int j;
              int ptrRegSet = 0;

              /* Make sure any spill location is definately allocated */
              if (sym->isspilt && !sym->remat && SYM_SPIL_LOC (sym) &&
                  !SYM_SPIL_LOC (sym)->allocreq)
                {
                  SYM_SPIL_LOC (sym)->allocreq++;
                }

              /* if it does not need or is spilt
                 or is already assigned to registers
                 or will not live beyond this instructions */
              if (!sym->nRegs ||
                  sym->isspilt ||
                  bitVectBitValue (_G.regAssigned, sym->key) ||
                  sym->liveTo <= ic->seq)
                continue;

              /* if some liverange has been spilt at the block level
                 and this one live beyond this block then spil this
                 to be safe */
              if (_G.blockSpil && sym->liveTo > ebbs[i]->lSeq)
                {
                  spillThis (sym);
                  continue;
                }
              /* if trying to allocate this will cause
                 a spill and there is nothing to spill
                 or this one is rematerializable then
                 spill this one */
              willCS = willCauseSpill (sym->nRegs, sym->regType);

              /* explicit turn off register spilling */
              willCS = 0;

              spillable = computeSpillable (ic);
              if (sym->remat ||
                  (willCS && bitVectIsZero (spillable)))
                {

                  spillThis (sym);
                  continue;

                }

              /* If the live range preceeds the point of definition
                 then ideally we must take into account registers that
                 have been allocated after sym->liveFrom but freed
                 before ic->seq. This is complicated, so spill this
                 symbol instead and let fillGaps handle the allocation. */
              if (sym->liveFrom < ic->seq)
                {
                    spillThis (sym);
                    continue;
                }

              /* if it has a spillocation & is used less than
                 all other live ranges then spill this */
                if (willCS) {
                    if (SYM_SPIL_LOC (sym)) {
                        symbol *leastUsed = leastUsedLR (liveRangesWith (spillable,
                                                                         allLRs, ebbs[i], ic));
                        if (leastUsed && leastUsed->used > sym->used) {
                            spillThis (sym);
                            continue;
                        }
                    } else {
                        /* if none of the liveRanges have a spillLocation then better
                           to spill this one than anything else already assigned to registers */
                        if (liveRangesWith(spillable,noSpilLoc,ebbs[i],ic)) {
                            /* if this is local to this block then we might find a block spil */
                            if (!(sym->liveFrom >= ebbs[i]->fSeq && sym->liveTo <= ebbs[i]->lSeq)) {
                                spillThis (sym);
                                continue;
                            }
                        }
                    }
                }

              if (ic->op == RECEIVE)
                debugLog ("When I get clever, I'll optimize the receive logic\n");

              if(POINTER_GET(ic) && IS_BITFIELD(getSpec(operandType(IC_RESULT(ic))))
                && (SPEC_BLEN(getSpec(operandType(IC_RESULT(ic))))==1)
                && (ic->next->op == IFX)
                && (OP_LIVETO(IC_RESULT(ic)) == ic->next->seq)) {

                /* skip register allocation since none will be used */
                for(j=0;j<sym->nRegs;j++)
                  sym->regs[j] = picoBlaze_newReg(REG_GPR, PO_GPR_TEMP, 0, "bad", 1, 0, NULL);
//                OP_SYMBOL(IC_RESULT(ic))->nRegs = 0;

                continue;
              }

              /* if we need ptr regs for the right side
                 then mark it */
              if (POINTER_GET (ic) && IS_SYMOP( IC_LEFT(ic) ) && getSize (OP_SYMBOL (IC_LEFT (ic))->type)
                  <= (unsigned) PTRSIZE)
                {
                  picoBlaze_ptrRegReq++;
                  ptrRegSet = 1;
                }
              /* else we assign registers to it */
              _G.regAssigned = bitVectSetBit (_G.regAssigned, sym->key);

              if(debugF)
                bitVectDebugOn(_G.regAssigned, debugF);

              for (j = 0; j < sym->nRegs; j++)
                {
                  if (sym->regType == REG_PTR)
                    sym->regs[j] = getRegPtr (ic, ebbs[i], sym);
                  else
                    sym->regs[j] = getRegGpr (ic, ebbs[i], sym);

                  /* if the allocation falied which means
                     this was spilt then break */
                  if (!sym->regs[j])
                    break;
                }
              debugLog ("  %d - \n", __LINE__);

              /* if it shares registers with operands make sure
                 that they are in the same position */
              if (IC_LEFT (ic) && IS_SYMOP (IC_LEFT (ic)) &&
                  OP_SYMBOL (IC_LEFT (ic))->nRegs && ic->op != '=')
                positionRegs (OP_SYMBOL (IC_RESULT (ic)),
                              OP_SYMBOL (IC_LEFT (ic)), ic->lineno);
              /* do the same for the right operand */
              if (IC_RIGHT (ic) && IS_SYMOP (IC_RIGHT (ic)) &&
                  OP_SYMBOL (IC_RIGHT (ic))->nRegs && ic->op != '=')
                positionRegs (OP_SYMBOL (IC_RESULT (ic)),
                              OP_SYMBOL (IC_RIGHT (ic)), ic->lineno);

              debugLog ("  %d - \n", __LINE__);
              if (ptrRegSet)
                {
                  debugLog ("  %d - \n", __LINE__);
                  picoBlaze_ptrRegReq--;
                  ptrRegSet = 0;
                }

            }
        }
    }

    /* Check for and fix any problems with uninitialized operands */
    for (i = 0; i < count; i++)
      {
        iCode *ic;

        if (ebbs[i]->noPath &&
            (ebbs[i]->entryLabel != entryLabel &&
             ebbs[i]->entryLabel != returnLabel))
            continue;

        for (ic = ebbs[i]->sch; ic; ic = ic->next)
          {
            if (SKIP_IC2 (ic))
              continue;

            if (ic->op == IFX)
              {
                verifyRegsAssigned (IC_COND (ic), ic);
                continue;
              }

            if (ic->op == JUMPTABLE)
              {
                verifyRegsAssigned (IC_JTCOND (ic), ic);
                continue;
              }

            verifyRegsAssigned (IC_RESULT (ic), ic);
            verifyRegsAssigned (IC_LEFT (ic), ic);
            verifyRegsAssigned (IC_RIGHT (ic), ic);
          }
      }

}

/*-----------------------------------------------------------------*/
/* rUmaskForOp :- returns register mask for an operand             */
/*-----------------------------------------------------------------*/
static bitVect *
rUmaskForOp (operand * op)
{
  bitVect *rumask;
  symbol *sym;
  int j;

  debugLog ("%s\n", __FUNCTION__);
  /* only temporaries are assigned registers */
  if (!IS_ITEMP (op))
    return NULL;

  sym = OP_SYMBOL (op);

  /* if spilt or no registers assigned to it
     then nothing */
  if (sym->isspilt || !sym->nRegs)
    return NULL;

  rumask = newBitVect (picoBlaze_nRegs);

  for (j = 0; j < sym->nRegs; j++)
    {
      rumask = bitVectSetBit (rumask,
                              sym->regs[j]->rIdx);
    }

  return rumask;
}

/*-----------------------------------------------------------------*/
/* regsUsedIniCode :- returns bit vector of registers used in iCode */
/*-----------------------------------------------------------------*/
static bitVect *
regsUsedIniCode (iCode * ic)
{
  bitVect *rmask = newBitVect (picoBlaze_nRegs);

  debugLog ("%s\n", __FUNCTION__);
  /* do the special cases first */
  if (ic->op == IFX)
    {
      rmask = bitVectUnion (rmask,
                            rUmaskForOp (IC_COND (ic)));
      goto ret;
    }

  /* for the jumptable */
  if (ic->op == JUMPTABLE)
    {
      rmask = bitVectUnion (rmask,
                            rUmaskForOp (IC_JTCOND (ic)));

      goto ret;
    }

  /* of all other cases */
  if (IC_LEFT (ic))
    rmask = bitVectUnion (rmask,
                          rUmaskForOp (IC_LEFT (ic)));


  if (IC_RIGHT (ic))
    rmask = bitVectUnion (rmask,
                          rUmaskForOp (IC_RIGHT (ic)));

  if (IC_RESULT (ic))
    rmask = bitVectUnion (rmask,
                          rUmaskForOp (IC_RESULT (ic)));

ret:
  return rmask;
}

/*-----------------------------------------------------------------*/
/* createRegMask - for each instruction will determine the regsUsed */
/*-----------------------------------------------------------------*/
static void
createRegMask (eBBlock ** ebbs, int count)
{
  int i;

  debugLog ("%s\n", __FUNCTION__);
  /* for all blocks */
  for (i = 0; i < count; i++)
    {
      iCode *ic;

      if (ebbs[i]->noPath &&
          (ebbs[i]->entryLabel != entryLabel &&
           ebbs[i]->entryLabel != returnLabel))
        continue;

      /* for all instructions */
      for (ic = ebbs[i]->sch; ic; ic = ic->next)
        {

          int j;

          if (SKIP_IC2 (ic) || !ic->rlive)
            continue;

          /* first mark the registers used in this
             instruction */
          ic->rUsed = regsUsedIniCode (ic);
          _G.funcrUsed = bitVectUnion (_G.funcrUsed, ic->rUsed);

          /* now create the register mask for those
             registers that are in use : this is a
             super set of ic->rUsed */
          ic->rMask = newBitVect (picoBlaze_nRegs + 1);

          /* for all live Ranges alive at this point */
          for (j = 1; j < ic->rlive->size; j++)
            {
              symbol *sym;
              int k;

              /* if not alive then continue */
              if (!bitVectBitValue (ic->rlive, j))
                continue;

              /* find the live range we are interested in */
              if (!(sym = hTabItemWithKey (liveRanges, j)))
                {
                  werror (E_INTERNAL_ERROR, __FILE__, __LINE__,
                          "createRegMask cannot find live range");
                  exit (0);
                }

              /* if no register assigned to it */
              if (!sym->nRegs || sym->isspilt)
                continue;

              /* for all the registers allocated to it */
              for (k = 0; k < sym->nRegs; k++)
                if (sym->regs[k])
                  ic->rMask =
                    bitVectSetBit (ic->rMask, sym->regs[k]->rIdx);
            }
        }
    }
}

/*-----------------------------------------------------------------*/
/* rematStr - returns the rematerialized string for a remat var    */
/*-----------------------------------------------------------------*/
static symbol *
rematStr (symbol * sym)
{
  iCode *ic = sym->rematiCode;
  symbol *psym = NULL;
  int offset = 0;

  debugLog ("%s\n", __FUNCTION__);

  while (ic->op == '+' || ic->op == '-') {
    /* if plus or minus print the right hand side */

    offset += (int) operandLitValue (IC_RIGHT (ic));
    ic = OP_SYMBOL (IC_LEFT (ic))->rematiCode;
  } // while

  psym = newSymbol (OP_SYMBOL (IC_LEFT (ic))->rname, 1);
  psym->offset = offset;
  return psym;
}

/*-----------------------------------------------------------------*/
/* regTypeNum - computes the type & number of registers required   */
/*-----------------------------------------------------------------*/
static void
regTypeNum ()
{
  symbol *sym;
  int k;
  iCode *ic;

  debugLog ("%s\n", __FUNCTION__);
  /* for each live range do */
  for (sym = hTabFirstItem (liveRanges, &k); sym;
       sym = hTabNextItem (liveRanges, &k)) {

    debugLog ("  %d - %s\n", __LINE__, sym->rname);
    //fprintf(stderr,"  %d - %s\n", __LINE__, sym->rname);

    /* if used zero times then no registers needed */
    if ((sym->liveTo - sym->liveFrom) == 0)
      continue;


    /* if the live range is a temporary */
    if (sym->isitmp) {

      debugLog ("  %d - itemp register\n", __LINE__);

      /* if the type is marked as a conditional */
      if (sym->regType == REG_CND)
        continue;

      /* if used in return only then we don't
         need registers */
      if (sym->ruonly || sym->accuse) {
        if (IS_AGGREGATE (sym->type) || sym->isptr)
          sym->type = aggrToPtr (sym->type, FALSE);
        debugLog ("  %d - no reg needed - used as a return\n", __LINE__);
        continue;
      }

      /* if the symbol has only one definition &
         that definition is a get_pointer and the
         pointer we are getting is rematerializable and
         in "data" space */

      if (bitVectnBitsOn (sym->defs) == 1 &&
          (ic = hTabItemWithKey (iCodehTab,
                                 bitVectFirstBit (sym->defs))) &&
          POINTER_GET (ic) &&
          !IS_BITVAR (sym->etype) &&
          (aggrToPtrDclType (operandType (IC_LEFT (ic)), FALSE) == POINTER)) {

//        continue;       /* FIXME -- VR */
        if (ptrPseudoSymSafe (sym, ic)) {

          symbol *psym;

          debugLog ("  %d - \n", __LINE__);

          /* create a psuedo symbol & force a spil */
          //X symbol *psym = newSymbol (rematStr (OP_SYMBOL (IC_LEFT (ic))), 1);
          psym = rematStr (OP_SYMBOL (IC_LEFT (ic)));
          psym->type = sym->type;
          psym->etype = sym->etype;
          psym->psbase = ptrBaseRematSym (OP_SYMBOL (IC_LEFT (ic)));
          strcpy (psym->rname, psym->name);
          sym->isspilt = 1;
          SYM_SPIL_LOC (sym) = psym;
          continue;
        }

        /* if in data space or idata space then try to
           allocate pointer register */

      }

      /* if not then we require registers */
      sym->nRegs = ((IS_AGGREGATE (sym->type) || sym->isptr) ?
                    getSize (sym->type = aggrToPtr (sym->type, FALSE)) :
                    getSize (sym->type));



    if(IS_CODEPTR (sym->type)) {
      // what IS this ???? (HJD)
      debugLog ("  %d const pointer type requires %d registers, changing to 3\n",__LINE__,sym->nRegs); // patch 14
      sym->nRegs = 3; // patch 14
    }

      if (sym->nRegs > 4) {
        fprintf (stderr, "allocated more than 4 or 0 registers for type ");
        printTypeChain (sym->type, stderr);
        fprintf (stderr, "\n");
      }

      /* determine the type of register required */
      if (sym->nRegs == 1 &&
          IS_PTR (sym->type) &&
          sym->uptr)
        sym->regType = REG_PTR;
      else
        sym->regType = REG_GPR;


      debugLog ("  reg name %s,  reg type %s\n", sym->rname, debugLogRegType (sym->regType));

    }
    else
      /* for the first run we don't provide */
      /* registers for true symbols we will */
      /* see how things go                  */
      sym->nRegs = 0;

  }

}



extern int indentDeep;
/*-----------------------------------------------------------------*/
/* picoBlaze_assignRegisters - assigns registers to each live range as need  */
/*-----------------------------------------------------------------*/
void
picoBlaze_assignRegisters (ebbIndex * ebbi)
{
  eBBlock ** ebbs = ebbi->bbOrder;
  int count = ebbi->count;
  iCode *ic;
  int i;

  debugLog ("<><><><><><><><><><><><><><><><><>\nstarting\t%s:%s", __FILE__, __FUNCTION__);
  debugLog ("\nebbs before optimizing:\n");
  dumpEbbsToDebug (ebbs, count);

  _picoBlaze_inRegAllocator = 1;

  picoBlaze_freeAllRegs();

  setToNull ((void *) &_G.funcrUsed);
  picoBlaze_ptrRegReq = _G.stackExtend = _G.dataExtend = 0;

  {
    regs *reg;
    int hkey;

    debugLog("dir registers allocated so far:\n");
    reg = hTabFirstItem(dynDirectRegNames, &hkey);

  }

  /* liveranges probably changed by register packing
     so we compute them again */
  recomputeLiveRanges (ebbs, count);

  if (options.dump_pack)
    dumpEbbsToFileExt (DUMP_PACK, ebbi);

  /* first determine for each live range the number of
     registers & the type of registers required for each */
  regTypeNum ();

  /* start counting function temporary registers from zero */
  /* XXX: Resetting dynrIdx breaks register allocation,
   *      see #1489055, #1483693 (?), and #1445850! */
  //dynrIdx = 0;

  /* and serially allocate registers */
  //serialRegAssign (ebbs, count);
  assignRegistersSerially(ebbs, count);

  //picoBlaze_freeAllRegs();

  /* if stack was extended then tell the user */
  if (_G.stackExtend)
    {
/*      werror(W_TOOMANY_SPILS,"stack", */
/*             _G.stackExtend,currFunc->name,""); */
      _G.stackExtend = 0;
    }

  if (_G.dataExtend)
    {
/*      werror(W_TOOMANY_SPILS,"data space", */
/*             _G.dataExtend,currFunc->name,""); */
      _G.dataExtend = 0;
    }

  /* after that create the register mask
     for each of the instruction */
  createRegMask (ebbs, count);

  /* redo that offsets for stacked automatic variables */
  redoStackOffsets ();

  if (options.dump_rassgn)
    dumpEbbsToFileExt (DUMP_RASSGN, ebbi);

//  dumpLR(ebbs, count);

  /* now get back the chain */
  ic = iCodeLabelOptimize (iCodeFromeBBlock (ebbs, count));

  debugLog ("ebbs after optimizing:\n");
  dumpEbbsToDebug (ebbs, count);

  _picoBlaze_inRegAllocator = 0;

  // Open JSON code file (intermediate representation of intermediate iCode)
  // Dump file is opened during the first call of this function for the first generated iCode function
  if (picoBlaze_options.json_flag && !iCodeDumpFile) 
  {
	  iCodeDumpFile = fopen (picoBlaze_options.json_dumpfile, "w");
	  dumpICode("[\n");
	  indentDeep++;
  }

  genpicoBlazeCode (ic);

  //  closing the JSON code Dump file iCodeDumpFile is in glue.c

   /* free up any _G.stackSpil locations allocated */
  applyToSet (_G.stackSpil, picoBlaze_deallocStackSpil);
  _G.slocNum = 0;
  setToNull ((void *) &_G.stackSpil);
  setToNull ((void *) &_G.spiltSet);
  /* mark all registers as free */
  picoBlaze_freeAllRegs ();


  debugLog ("leaving\n<><><><><><><><><><><><><><><><><>\n");
  debugLogClose ();
  return;
}
