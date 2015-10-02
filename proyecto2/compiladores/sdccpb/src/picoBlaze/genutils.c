/*-------------------------------------------------------------------------
 genutils.c - source file for code generation for picoBlaze
 	code generation utility functions

	Created by Vangelis Rokas (vrokas@otenet.gr) [Nov-2003]

	Based on :

  Written By -  Sandeep Dutta . sandeep.dutta@usa.net (1998)
         and -  Jean-Louis VERN.jlvern@writeme.com (1999)
  Bug Fixes  -  Wojciech Stryjewski  wstryj1@tiger.lsu.edu (1999 v2.1.9a)
  PIC port   -  Scott Dattalo scott@dattalo.com (2000)
  PICOBLAZE port -  Martin Dubuc m.dubuc@rogers.com (2002)
  
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
  
  Notes:
  000123 mlh	Moved aopLiteral to SDCCglue.c to help the split
  		Made everything static
-------------------------------------------------------------------------*/

/**********************************************************
 * Here is a list with completed genXXXXX functions
 *
 * genNot
 *
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "SDCCglobl.h"
#include "newalloc.h"

#include "common.h"
#include "SDCCpeeph.h"
#include "ralloc.h"
#include "pcode.h"
#include "device.h"
#include "gen.h"

#include "genutils.h"

#if 1
#define picoBlaze_emitcode	DEBUGpicoBlaze_emitcode
#endif

#if defined(GEN_Not)
/*-----------------------------------------------------------------*/
/* picoBlaze_genNot - generate code for ! operation                    */
/*-----------------------------------------------------------------*/
void picoBlaze_genNot (iCode *ic)
{
  int size;
//  symbol *tlbl;

/*
 * result[AOP_CRY,AOP_REG]  = ! left[AOP_CRY, AOP_REG]
 */

    FENTRY;
   
    /* assign asmOps to operand & result */
    picoBlaze_aopOp (IC_LEFT(ic),ic,FALSE);
    picoBlaze_aopOp (IC_RESULT(ic),ic,TRUE);
    DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,IC_LEFT(ic),NULL,IC_RESULT(ic));

    /* if in bit space then a special case */
    if (AOP_TYPE(IC_LEFT(ic)) == AOP_CRY) {
      if (AOP_TYPE(IC_RESULT(ic)) == AOP_CRY) {
        picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
        picoBlaze_emitpcode(POC_XORWF,picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
      } else {
        picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
        picoBlaze_emitpcode(POC_BTFSS,picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
        picoBlaze_emitpcode(POC_INCF,picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
      }
      goto release;
    }

    size = AOP_SIZE(IC_LEFT(ic));


    picoBlaze_toBoolean( IC_LEFT(ic) );
//*//    emitSETC;
//*//    picoBlaze_emitpcode(POC_TSTFSZ, picoBlaze_popCopyReg( &picoBlaze_pc_wreg ));
//*//    emitCLRC;
    picoBlaze_outBitC( IC_RESULT(ic) );

release:    
    /* release the aops */
    picoBlaze_freeAsmop(IC_LEFT(ic),NULL,ic,(RESULTONSTACK(ic) ? 0 : 1));
    picoBlaze_freeAsmop(IC_RESULT(ic),NULL,ic,TRUE);
}

#endif	/* defined(GEN_Not) */



#if defined(GEN_Cpl)
/*-----------------------------------------------------------------*/
/* picoBlaze_genCpl - generate code for complement                     */
/*-----------------------------------------------------------------*/
void picoBlaze_genCpl (iCode *ic)
{
  int offset = 0;
  int size ;

/*
 * result[CRY,REG] = ~left[CRY,REG]
 */
    FENTRY;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    /* assign asmOps to operand & result */
    picoBlaze_aopOp (IC_LEFT(ic),ic,FALSE);
    picoBlaze_aopOp (IC_RESULT(ic),ic,TRUE);
    DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,IC_LEFT(ic),NULL,IC_RESULT(ic));

    /* if both are in bit space then 
     * a special case */
    if (AOP_TYPE(IC_RESULT(ic)) == AOP_CRY
      && AOP_TYPE(IC_LEFT(ic)) == AOP_CRY ) { 

        /* FIXME */
        picoBlaze_emitcode("mov","c,%s",IC_LEFT(ic)->aop->aopu.aop_dir); 
        picoBlaze_emitcode("cpl","c"); 
        picoBlaze_emitcode("mov","%s,c",IC_RESULT(ic)->aop->aopu.aop_dir); 
        goto release; 
    } 

    size = AOP_SIZE(IC_RESULT(ic));
    if (size >= AOP_SIZE(IC_LEFT(ic))) size = AOP_SIZE(IC_LEFT(ic));
    
    while (size--) {
      if (picoBlaze_sameRegs(AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic))) ) {
        picoBlaze_emitpcode(POC_COMF,  picoBlaze_popGet(AOP(IC_LEFT(ic)), offset));
      } else {
        picoBlaze_emitpcode(POC_COMFW, picoBlaze_popGet(AOP(IC_LEFT(ic)),offset));
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(IC_RESULT(ic)),offset));
      }
      offset++;
    }

    /* handle implicit upcast */
    size = AOP_SIZE(IC_RESULT(ic));
    if (offset < size)
    {
      if (SPEC_USIGN(operandType(IC_LEFT(ic)))) {
	while (offset < size) {
	  picoBlaze_emitpcode(POC_SETF, picoBlaze_popGet(AOP(IC_RESULT(ic)), offset));
	  offset++;
	} // while
      } else {
	if ((offset + 1) == size) {
	  /* just one byte to fix */
	  picoBlaze_emitpcode(POC_SETF, picoBlaze_popGet(AOP(IC_RESULT(ic)), offset));
	  picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(IC_RESULT(ic)),offset-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
	  picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(IC_RESULT(ic)), offset));
	} else {
	  /* two or more byte to adjust */
//*//	  picoBlaze_emitpcode(POC_SETF, picoBlaze_popCopyReg( &picoBlaze_pc_wreg ));
	  picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(IC_RESULT(ic)),offset-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
//*//	  picoBlaze_emitpcode(POC_CLRF, picoBlaze_popCopyReg( &picoBlaze_pc_wreg ));
	  while (offset < size) {
	    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(IC_RESULT(ic)), offset));
	    offset++;
	  } // while
	} // if
      }
    } // if

release:
    /* release the aops */
    picoBlaze_freeAsmop(IC_LEFT(ic),NULL,ic,(RESULTONSTACK(ic) ? 0 : 1));
    picoBlaze_freeAsmop(IC_RESULT(ic),NULL,ic,TRUE);
}
#endif	/* defined(GEN_Cpl) */



/*-----------------------------------------------------------------*/
/* Helper function to dump operand into comment lines              */
/*-----------------------------------------------------------------*/

void picoBlaze_DumpValue(char *prefix, value *val)
{
//	char s[INITIAL_INLINEASM];  
	if(!val) return;

	DEBUGpicoBlaze_emitcode (";", " %s Dump value",prefix);
	DEBUGpicoBlaze_emitcode (";", " %s name:%s",prefix,val->name);
}

void picoBlaze_DumpPcodeOp(char *prefix, pCodeOp *pcop)
{
//	char s[INITIAL_INLINEASM];  
	if(!pcop) return;

	DEBUGpicoBlaze_emitcode (";", " %s Dump pCodeOp",prefix);
	DEBUGpicoBlaze_emitcode (";", " %s name:%s",prefix,pcop->name);
	if(pcop->type == PO_NONE) {
		DEBUGpicoBlaze_emitcode (";", " %s type:PO_NONE",prefix);
	}
	if(pcop->type == PO_GPR_REGISTER) {
		DEBUGpicoBlaze_emitcode (";", " %s type:PO_GPR_REGISTER",prefix);
	}
	if(pcop->type == PO_GPR_BIT) {
		DEBUGpicoBlaze_emitcode (";", " %s type:PO_GPR_BIT",prefix);
	}
	if(pcop->type == PO_GPR_TEMP) {
		DEBUGpicoBlaze_emitcode (";", " %s type:PO_GPR_TEMP",prefix);
	}
	if(pcop->type == PO_LITERAL) {
		DEBUGpicoBlaze_emitcode (";", " %s type:PO_LITERAL",prefix);
		DEBUGpicoBlaze_emitcode (";", " %s lit:%s",prefix,PCOL(pcop)->lit);
	}
	if(pcop->type == PO_DIR) {
		DEBUGpicoBlaze_emitcode (";", " %s type:PO_DIR",prefix);
	}
	if(pcop->type == PO_LABEL) {
		DEBUGpicoBlaze_emitcode (";", " %s type:PO_LABEL",prefix);
	}
	if(pcop->type == PO_GPR_SP) {
		DEBUGpicoBlaze_emitcode (";", " %s type:PO_GPR_SP",prefix);
	}
}



void picoBlaze_DumpAop(char *prefix, asmop *aop)
{
	char s[INITIAL_INLINEASM];  
	if(!aop) return;

	DEBUGpicoBlaze_emitcode (";", " %s Dump asmop",prefix);
	if (aop->type == AOP_LIT)
	{
		DEBUGpicoBlaze_emitcode (";", " %s type:AOP_LIT",prefix);
		sprintf(s,"%s (aopu.aop_lit)",prefix);
		picoBlaze_DumpValue(s,aop->aopu.aop_lit);
	}
	if (aop->type == AOP_REG)
		DEBUGpicoBlaze_emitcode (";", " %s type:AOP_REG",prefix);
	if (aop->type == AOP_DIR)
	{
		DEBUGpicoBlaze_emitcode (";", " %s type:AOP_DIR",prefix);
		DEBUGpicoBlaze_emitcode (";", " %s aopu.aop_dir:%s",prefix,aop->aopu.aop_dir);
	}
	if (aop->type == AOP_STK)
		DEBUGpicoBlaze_emitcode (";", " %s type:AOP_STK",prefix);
	if (aop->type == AOP_STA)
		DEBUGpicoBlaze_emitcode (";", " %s type:AOP_STA",prefix);
	if (aop->type == AOP_STR)
	{
		DEBUGpicoBlaze_emitcode (";", " %s type:AOP_STR",prefix);
		DEBUGpicoBlaze_emitcode (";", " %s aopu.aop_str:%s/%s/%s/%s",prefix,aop->aopu.aop_str[0],
				aop->aopu.aop_str[1],aop->aopu.aop_str[2],aop->aopu.aop_str[3]);
	}
	if (aop->type == AOP_CRY)
		DEBUGpicoBlaze_emitcode (";", " %s type:AOP_CRY",prefix);
	if (aop->type == AOP_ACC)
		DEBUGpicoBlaze_emitcode (";", " %s type:AOP_ACC",prefix);
	if (aop->type == AOP_PCODE)
	{
		DEBUGpicoBlaze_emitcode (";", " %s type:AOP_PCODE",prefix);
		sprintf(s,"%s (aopu.pcop)",prefix);
		picoBlaze_DumpPcodeOp(s,aop->aopu.pcop);
	}


	DEBUGpicoBlaze_emitcode (";", " %s coff:%d",prefix,aop->coff);
	DEBUGpicoBlaze_emitcode (";", " %s size:%d",prefix,aop->size);
	DEBUGpicoBlaze_emitcode (";", " %s code:%d",prefix,aop->code);
	DEBUGpicoBlaze_emitcode (";", " %s paged:%d",prefix,aop->paged);
	DEBUGpicoBlaze_emitcode (";", " %s freed:%d",prefix,aop->freed);

}

void picoBlaze_DumpSymbol(char *prefix, symbol *sym)
{
	char s[INITIAL_INLINEASM];  
	if(!sym) return;

	DEBUGpicoBlaze_emitcode (";", " %s Dump symbol",prefix);
	DEBUGpicoBlaze_emitcode (";", " %s name:%s",prefix,sym->name);
	DEBUGpicoBlaze_emitcode (";", " %s rname:%s",prefix,sym->rname);
	DEBUGpicoBlaze_emitcode (";", " %s level:%d",prefix,sym->level);
	DEBUGpicoBlaze_emitcode (";", " %s block:%d",prefix,sym->block);
	DEBUGpicoBlaze_emitcode (";", " %s key:%d",prefix,sym->key);
	DEBUGpicoBlaze_emitcode (";", " %s implicit:%d",prefix,sym->implicit);
	DEBUGpicoBlaze_emitcode (";", " %s undefined:%d",prefix,sym->undefined);
	DEBUGpicoBlaze_emitcode (";", " %s _isparm:%d",prefix,sym->_isparm);
	DEBUGpicoBlaze_emitcode (";", " %s ismyparm:%d",prefix,sym->ismyparm);
	DEBUGpicoBlaze_emitcode (";", " %s isitmp:%d",prefix,sym->isitmp);
	DEBUGpicoBlaze_emitcode (";", " %s islbl:%d",prefix,sym->islbl);
	DEBUGpicoBlaze_emitcode (";", " %s isref:%d",prefix,sym->isref);
	DEBUGpicoBlaze_emitcode (";", " %s isind:%d",prefix,sym->isind);
	DEBUGpicoBlaze_emitcode (";", " %s isinvariant:%d",prefix,sym->isinvariant);
	DEBUGpicoBlaze_emitcode (";", " %s cdef:%d",prefix,sym->cdef);
	DEBUGpicoBlaze_emitcode (";", " %s addrtaken:%d",prefix,sym->addrtaken);
	DEBUGpicoBlaze_emitcode (";", " %s isreqv:%d",prefix,sym->isreqv);
	DEBUGpicoBlaze_emitcode (";", " %s udChked:%d",prefix,sym->udChked);
	DEBUGpicoBlaze_emitcode (";", " %s isLiveFcall:%d",prefix,sym->isLiveFcall);
	DEBUGpicoBlaze_emitcode (";", " %s isspilt:%d",prefix,sym->isspilt);
	DEBUGpicoBlaze_emitcode (";", " %s spillA:%d",prefix,sym->spillA);
	DEBUGpicoBlaze_emitcode (";", " %s remat:%d",prefix,sym->remat);
	DEBUGpicoBlaze_emitcode (";", " %s isptr:%d",prefix,sym->isptr);
	DEBUGpicoBlaze_emitcode (";", " %s uptr:%d",prefix,sym->uptr);
	DEBUGpicoBlaze_emitcode (";", " %s isFree:%d",prefix,sym->isFree);
	DEBUGpicoBlaze_emitcode (";", " %s islocal:%d",prefix,sym->islocal);
	DEBUGpicoBlaze_emitcode (";", " %s blockSpil:%d",prefix,sym->blockSpil);
	DEBUGpicoBlaze_emitcode (";", " %s remainSpil:%d",prefix,sym->remainSpil);
	DEBUGpicoBlaze_emitcode (";", " %s stackSpil:%d",prefix,sym->stackSpil);
	DEBUGpicoBlaze_emitcode (";", " %s onStack:%d",prefix,sym->onStack);
	DEBUGpicoBlaze_emitcode (";", " %s iaccess:%d",prefix,sym->iaccess);
	DEBUGpicoBlaze_emitcode (";", " %s ruonly:%d",prefix,sym->ruonly);
	DEBUGpicoBlaze_emitcode (";", " %s spildir:%d",prefix,sym->spildir);
	DEBUGpicoBlaze_emitcode (";", " %s ptrreg:%d",prefix,sym->ptrreg);
	DEBUGpicoBlaze_emitcode (";", " %s noSpilLoc:%d",prefix,sym->noSpilLoc);
	DEBUGpicoBlaze_emitcode (";", " %s isstrlit:%d",prefix,sym->isstrlit);
	DEBUGpicoBlaze_emitcode (";", " %s accuse:%d",prefix,sym->accuse);
	DEBUGpicoBlaze_emitcode (";", " %s dptr:%d",prefix,sym->dptr);
	DEBUGpicoBlaze_emitcode (";", " %s allocreq:%d",prefix,sym->allocreq);
	DEBUGpicoBlaze_emitcode (";", " %s stack:%d",prefix,sym->stack);
	DEBUGpicoBlaze_emitcode (";", " %s xstack:%d",prefix,sym->xstack);
	DEBUGpicoBlaze_emitcode (";", " %s nRegs:%d",prefix,sym->nRegs);
	DEBUGpicoBlaze_emitcode (";", " %s regType:%d",prefix,sym->regType);

	// struct regs !!!

	if(sym->aop)
	{
		sprintf(s,"%s (aop)",prefix);
		picoBlaze_DumpAop(s,sym->aop);
	} else {
		DEBUGpicoBlaze_emitcode (";", " %s aop:NULL",prefix);
	}
}

void picoBlaze_DumpOp(char *prefix, operand *op)
{
	char s[INITIAL_INLINEASM];  
	if(!op) return;

	DEBUGpicoBlaze_emitcode (";", " %s Dump operand",prefix);
	if(IS_SYMOP(op))
		DEBUGpicoBlaze_emitcode (";", " %s type: SYMBOL",prefix);
	if(IS_VALOP(op))
		DEBUGpicoBlaze_emitcode (";", " %s type: VALUE",prefix);
	if(IS_TYPOP(op))
		DEBUGpicoBlaze_emitcode (";", " %s type: TYPE",prefix);
	DEBUGpicoBlaze_emitcode (";", " %s isaddr:%d",prefix,op->isaddr);
	DEBUGpicoBlaze_emitcode (";", " %s isvolatile:%d",prefix,op->isvolatile);
	DEBUGpicoBlaze_emitcode (";" ," %s isGlobal:%d",prefix,op->isGlobal);
	DEBUGpicoBlaze_emitcode (";", " %s isPtr:%d",prefix,op->isPtr);
	DEBUGpicoBlaze_emitcode (";", " %s isGptr:%d",prefix,op->isGptr);
	DEBUGpicoBlaze_emitcode (";", " %s isParm:%d",prefix,op->isParm);
	DEBUGpicoBlaze_emitcode (";", " %s isLiteral:%d",prefix,op->isLiteral);
	DEBUGpicoBlaze_emitcode (";", " %s key:%d",prefix,op->key);
	if(IS_SYMOP(op)) {
		sprintf(s,"%s (symOperand)",prefix);
		picoBlaze_DumpSymbol(s,op->operand.symOperand);
	}

}

void picoBlaze_DumpOpX(FILE *fp, char *prefix, operand *op)
{
  if(!op)return;
    
  fprintf(fp, "%s [", prefix);
  fprintf(fp, "%s", IS_SYMOP(op)?"S":" ");
  fprintf(fp, "%s", IS_VALOP(op)?"V":" ");
  fprintf(fp, "%s", IS_TYPOP(op)?"T":" ");
  fprintf(fp, "] ");

  fprintf(fp, "isaddr:%d,", op->isaddr);
  fprintf(fp, "isvolatile:%d,", op->isvolatile);
  fprintf(fp, "isGlobal:%d,", op->isGlobal);
  fprintf(fp, "isPtr:%d,", op->isPtr);
  fprintf(fp, "isParm:%d,", op->isParm);
  fprintf(fp, "isLit:%d\n", op->isLiteral);
}  
    

void _picoBlaze_debugf(char *f, int l, char *frm, ...)
{
  va_list ap;
  
    va_start(ap, frm);
    fprintf(stderr, "%s:%d ", f, l);
    vfprintf(stderr, frm, ap);
    va_end(ap);
}



void picoBlaze_gpsimio2_pcop(pCodeOp *pcop)
{
//*//  picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(pcop, picoBlaze_popCopyReg(&picoBlaze_pc_gpsimio2)));
}

void picoBlaze_gpsimio2_lit(unsigned char lit)
{
  picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit));
//*//  picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(&picoBlaze_pc_wreg), picoBlaze_popCopyReg(&picoBlaze_pc_gpsimio2)));
}

void picoBlaze_gpsimio2_str(char *buf)
{
  while(*buf) {
    picoBlaze_gpsimio2_lit(*buf);
    buf++;
  }
}

void picoBlaze_gpsimDebug_StackDump(char *fname, int line, char *info)
{
  picoBlaze_emitpcomment("; gpsim debug stack dump; %s @ %d\tinfo: ", fname, line, info);
  
  picoBlaze_gpsimio2_str("&c[S:");
  picoBlaze_gpsimio2_str(info);
  picoBlaze_gpsimio2_str("] &h");
  
//*//  picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(&picoBlaze_pc_fsr1h),
//*//                picoBlaze_popCopyReg(&picoBlaze_pc_gpsimio2)));
//*//  picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(&picoBlaze_pc_fsr1l),
//*//                picoBlaze_popCopyReg(&picoBlaze_pc_gpsimio2)));

  picoBlaze_gpsimio2_lit('\n');
}

const char *picoBlaze_gptr_fns[4][2] = {
  { "_gptrget1", "_gptrput1" },
  { "_gptrget2", "_gptrput2" },
  { "_gptrget3", "_gptrput3" },
  { "_gptrget4", "_gptrput4" } };

extern set *externs;
  
/* generate a call to the generic pointer read/write functions */
void picoBlaze_callGenericPointerRW(int rw, int size)
{
  char buf[32];
  symbol *sym;

    if(size>4) {
      werror(W_POSSBUG2, __FILE__, __LINE__);
      abort();
    }

    strcpy(buf, port->fun_prefix);
    strcat(buf, picoBlaze_gptr_fns[size-1][rw]);
    
    picoBlaze_emitpcode (POC_CALL, picoBlaze_popGetWithString (buf));
    
    sym = newSymbol( buf, 0 );
    sym->used++;
    strcpy(sym->rname, buf);
    picoBlaze_checkAddSym(&externs, sym);
}



/* check all condition and return appropriate instruction, POC_CPFSGT or POC_CPFFSLT */
static int selectCompareOp(resolvedIfx *rIfx, iCode *ifx,
        operand *result, int offset, int invert_op)
{
  /* add code here */
  
  /* check condition, > or < ?? */
  if(rIfx->condition != 0)invert_op ^= 1;
  
  if(ifx && IC_FALSE(ifx))invert_op ^= 1;

  if(!ifx)invert_op ^= 1;

  DEBUGpicoBlaze_emitcode("; +++", "%s:%d %s] rIfx->condition= %d, ifx&&IC_FALSE(ifx)= %d, invert_op = %d",
      __FILE__, __LINE__, __FUNCTION__, rIfx->condition, (ifx && IC_FALSE(ifx)), invert_op);
  
  /* do selection */
  if(!invert_op)return POC_CPFSGT;
  else return POC_CPFSLT;
}

/* return 1 if function handles compare, 0 otherwise */
/* this functions handles special cases like:
 * reg vs. zero
 * reg vs. one
 */
int picoBlaze_genCmp_special(operand *left, operand *right, operand *result,
                    iCode *ifx, resolvedIfx *rIfx, int sign)
{
  int size;
  int offs=0;
  symbol *tmplbl;
  unsigned long lit;
  int op, cmp_op=0, cond_pre;

    FENTRY;
    
    if(!(picoBlaze_options.opt_flags & OF_OPTIMIZE_CMP))return 0;

    size = max(AOP_SIZE(left), AOP_SIZE(right));

    cond_pre = rIfx->condition; // must restore old value on return with 0!!!
    
    if(!isAOP_REGlike(left)) {
      operand *dummy;

        dummy = left;
        left = right;
        right = dummy;
        
        /* invert comparing operand */
//        cmp_op ^= 1;
        rIfx->condition ^= 1;
    }
    
    
    if(isAOP_REGlike(left) && isAOP_LIT(right)) {
      /* comparing register vs. literal */
      lit = ulFromVal(AOP(right)->aopu.aop_lit);
      
      
      if(size == 1) {
        op = selectCompareOp(rIfx, ifx, result, offs, cmp_op);
        
        DEBUGpicoBlaze_emitcode("%%", "comparing operand %s, condition: %d", (op==POC_CPFSLT?"POC_CPFSLT":"POC_CPFSGT"), rIfx->condition);

        if(!sign) {
          /* unsigned compare */
          switch( lit ) {
            case 0:
              if(ifx && IC_FALSE(ifx)) {
                tmplbl = newiTempLabel( NULL );
                picoBlaze_emitpcode(POC_TSTFSZ, picoBlaze_popGet(AOP(left), 0));
                picoBlaze_emitpcode(POC_BRA, picoBlaze_popGetLabel(tmplbl->key));
                picoBlaze_emitpcode(POC_GOTO, picoBlaze_popGetLabel(rIfx->lbl->key));
                picoBlaze_emitpLabel(tmplbl->key);

                ifx->generated = 1;
                return 1;
              }
              break;
          }	/* switch */

        }	/* if(!sign) */

      }		/* if(size==1) */

    }		/* */
      
  rIfx->condition = cond_pre;
  return 0;
}
