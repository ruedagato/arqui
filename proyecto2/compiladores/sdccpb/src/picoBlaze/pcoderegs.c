/*-------------------------------------------------------------------------

  pcoderegs.c - post code generation register optimizations

   Written By -  Scott Dattalo scott@dattalo.com
   Ported To PICOBLAZE By -  m.dubuc@rogers.com

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
   
-------------------------------------------------------------------------*/

/*
  pcoderegs.c

  The purpose of the code in this file is to optimize the register usage.

*/
#include <stdio.h>

#include "common.h"   // Include everything in the SDCC src directory
#include "newalloc.h"
#include "ralloc.h"
#include "device.h"
#include "pcode.h"
#include "pcoderegs.h"
#include "pcodeflow.h"


#define DEBUG_REMOVE1PCODE	0
#define HAVE_DBGREGUSAGE	0


extern void picoBlaze_pCodeInsertAfter(pCode *pc1, pCode *pc2);
extern pCode * picoBlaze_findPrevInstruction(pCode *pci);
extern pBranch * picoBlaze_pBranchAppend(pBranch *h, pBranch *n);
void picoBlaze_unlinkpCode(pCode *pc);
extern int picoBlaze_pCodeSearchCondition(pCode *pc, unsigned int cond);

static int total_registers_saved=0;
static int register_optimization=1;

/*-----------------------------------------------------------------*
 * void AddRegToFlow(regs *reg, pCodeFlow *pcfl)
 *-----------------------------------------------------------------*/
/*
void AddRegToFlow(regs *reg, pCodeFlow *pcfl)
{

  if(!reg || ! pcfl || !isPCFL(pcflow))
    return;

  if(!pcfl->registers) 
    pcfl->registers =  newSet();

}
*/


/*-----------------------------------------------------------------*
 * 
 *-----------------------------------------------------------------*/

#if HAVE_DBGREGUSAGE
static void dbg_regusage(set *fregs)
{
  regs *reg;
  pCode *pcfl;
  pCode *pc;


  for (reg = setFirstItem(fregs) ; reg ;
       reg = setNextItem(fregs)) {

    if(elementsInSet(reg->reglives.usedpCodes)) {
    
      fprintf (stderr, "%s  addr=0x%03x rIdx=0x%03x",
	       reg->name,
	       reg->address,
	       reg->rIdx);

      pcfl = setFirstItem(reg->reglives.usedpFlows);
      if(pcfl)
	fprintf(stderr, "\n   used in seq");

      while(pcfl) {
	fprintf(stderr," 0x%03x",pcfl->seq);
	pcfl = setNextItem(reg->reglives.usedpFlows);
      }

      pcfl = setFirstItem(reg->reglives.assignedpFlows);
      if(pcfl)
	fprintf(stderr, "\n   assigned in seq");

      while(pcfl) {
	fprintf(stderr," 0x%03x",pcfl->seq);
	pcfl = setNextItem(reg->reglives.assignedpFlows);
      }

      pc = setFirstItem(reg->reglives.usedpCodes);
      if(pc)
	fprintf(stderr, "\n   used in instructions ");

      while(pc) {
	pcfl = PCODE(PCI(pc)->pcflow);
	if(pcfl)
	  fprintf(stderr," 0x%03x:",pcfl->seq);
	fprintf(stderr,"0x%03x",pc->seq);

	pc = setNextItem(reg->reglives.usedpCodes);
      }

      fprintf(stderr, "\n");
    }
  }
}

/*-----------------------------------------------------------------*
 * 
 *-----------------------------------------------------------------*/

//static
void dbg_dumpregusage(void)
{

  fprintf(stderr,"***  Register Usage  ***\n");
  fprintf(stderr,"AllocRegs:\n");
  dbg_regusage(picoBlaze_dynAllocRegs);
  fprintf(stderr,"DirectRegs:\n");
  dbg_regusage(picoBlaze_dynDirectRegs);
  fprintf(stderr,"DirectBitRegs:\n");
  dbg_regusage(picoBlaze_dynDirectBitRegs);

}
#endif

/*-----------------------------------------------------------------*
 * void pCodeRegMapLiveRangesInFlow(pCodeFlow *pcfl)
 *-----------------------------------------------------------------*/
static void pCodeRegMapLiveRangesInFlow(pCodeFlow *pcfl)
{

  pCode *pc=NULL;
  pCode *pcprev=NULL;

  regs *reg;

  if(!pcfl)
    return;


  pc = picoBlaze_findNextInstruction(pcfl->pc.next);

  while(picoBlaze_isPCinFlow(pc,PCODE(pcfl))) {


    reg = picoBlaze_getRegFromInstruction(pc);

    if(reg) {


//      fprintf(stderr, "%s:%d: trying to get first operand from pCode reg= %s\n", __FILE__, __LINE__, reg->name);
      addSetIfnotP(& (PCFL(pcfl)->registers), reg);

      if((PCC_REGISTER | PCC_LITERAL) & PCI(pc)->inCond)
	addSetIfnotP(& (reg->reglives.usedpFlows), pcfl);

      if(PCC_REGISTER & PCI(pc)->outCond)
	addSetIfnotP(& (reg->reglives.assignedpFlows), pcfl);

	addSetIfnotP(& (reg->reglives.usedpCodes), pc);

//    reg->wasUsed=1;

#if 1
	/* check to see if this pCode has 2 memory operands,
	   and set up the second operand too */
	if(PCI(pc)->is2MemOp) {
			reg = picoBlaze_getRegFromInstruction2(pc);
			if(reg) {
//				fprintf(stderr, "%s:%d: trying to get second operand from pCode reg= %s\n", __FILE__, __LINE__, reg->name);
				addSetIfnotP(& (PCFL(pcfl)->registers), reg);

				if((PCC_REGISTER | PCC_LITERAL) & PCI(pc)->inCond)
					addSetIfnotP(& (reg->reglives.usedpFlows), pcfl);
					
				if((PCC_REGISTER | PCC_REGISTER2) & PCI(pc)->outCond)
					addSetIfnotP(& (reg->reglives.assignedpFlows), pcfl);
			
				addSetIfnotP(& (reg->reglives.usedpCodes), pc);
				
//				reg->wasUsed=1;
			}
	}
#endif

    }


    pcprev = pc;
    pc = picoBlaze_findNextInstruction(pc->next);

  }

}

/*-----------------------------------------------------------------*
 * void picoBlaze_pCodeRegMapLiveRanges(pBlock *pb) 
 *-----------------------------------------------------------------*/
void picoBlaze_pCodeRegMapLiveRanges(pBlock *pb)
{
  pCode *pcflow;

  for( pcflow = picoBlaze_findNextpCode(pb->pcHead, PC_FLOW); 
       pcflow != NULL;
       pcflow = picoBlaze_findNextpCode(pcflow->next, PC_FLOW) ) {

    if(!isPCFL(pcflow)) {
      fprintf(stderr, "pCodeRegMapLiveRanges - pcflow is not a flow object ");
      continue;
    }
    pCodeRegMapLiveRangesInFlow(PCFL(pcflow));
  }


#if HAVE_DBGREGUSAGE
  dbg_dumpregusage();
#endif

}


/*-----------------------------------------------------------------*
 *
 *-----------------------------------------------------------------*/
static void Remove1pcode(pCode *pc, regs *reg)
{
  pCode *pcn=NULL;

  if(!reg || !pc)
    return;

  deleteSetItem (&(reg->reglives.usedpCodes),pc);

#if DEBUG_REMOVE1PCODE
  fprintf(stderr,"removing instruction:\n");
  pc->print(stderr,pc);
#endif

  if(PCI(pc)->label) {
    pcn = picoBlaze_findNextInstruction(pc->next);

    if(pcn)
      PCI(pcn)->label = picoBlaze_pBranchAppend(PCI(pcn)->label,PCI(pc)->label);
  }

  if(PCI(pc)->cline) {
    if(!pcn)
      pcn = picoBlaze_findNextInstruction(pc->next);

    if(pcn) {
      if(PCI(pcn)->cline) {

#if DEBUG_REMOVE1PCODE
	fprintf(stderr, "source line has been optimized completely out\n");
	pc->print(stderr,pc);
#endif

      } else {
	PCI(pcn)->cline = PCI(pc)->cline;
      }
    }
  }

  pc->destruct(pc);

}



static int insideLRBlock(pCode *pc)
{
  pCode *pc1;
  int t1=-1, t2=-1;

    pc1 = pc->prev;
    while(pc1) {
      if(isPCINFO(pc1) && (PCINF(pc1)->type == INF_LOCALREGS)) {
        t1 = PCOLR (PCINF (pc1)->oper1)->type;
        break;
      }
      pc1 = pc1->prev;
    }
    
    pc1 = pc->next;
    while(pc1) {
      if(isPCINFO(pc1) && (PCINF(pc1)->type == INF_LOCALREGS)) {
        t2 = PCOLR (PCINF (pc1)->oper1)->type;
        break;
      }
      pc1 = pc1->next;
    }
    
    if((t1 == LR_ENTRY_BEGIN && t2 == LR_ENTRY_END)
      || (t1 == LR_EXIT_BEGIN && t2 == LR_EXIT_END))
        return 1;

  return 0;
}

    
static void RemoveRegFromLRBlock(regs *reg)
{
  if(elementsInSet(reg->reglives.usedpCodes) == 2) {
    pCode *pc1;

      /* only continue if there are just 2 uses of the register,
       * in in the local *entry* block and one in the local *exit* block */
        
      /* search for entry block */
      pc1 = indexSet(reg->reglives.usedpCodes, 1);

      if(insideLRBlock( pc1 )) {
        fprintf(stderr, "usedpCodes[0] inside LR block\n");
        deleteSetItem(&pc1->pb->tregisters, PCOR(PCI(pc1)->pcop)->r);
        Remove1pcode(pc1, reg);
      }

      pc1 = indexSet(reg->reglives.usedpCodes, 0);
      if(insideLRBlock( pc1 )) {
        fprintf(stderr, "usedpCodes[1] inside LR block\n");
        deleteSetItem(&pc1->pb->tregisters, PCOR(PCI(pc1)->pcop)->r);
        Remove1pcode(pc1, reg);
      }
        
      /* remove r0x00 */
      reg->isFree = 1;
      reg->wasUsed = 0;
  }
}

        

/*-----------------------------------------------------------------*
 *
 *-----------------------------------------------------------------*/
static void Remove2pcodes(pCode *pcflow, pCode *pc1, pCode *pc2, regs *reg, int can_free)
{
  if(!reg)
    return;

  if(pc1)
    Remove1pcode(pc1, reg);

  if(pc2) {
    Remove1pcode(pc2, reg);
    deleteSetItem (&(PCFL(pcflow)->registers), reg);

    if(can_free) {
      reg->isFree = 1;
      reg->wasUsed = 0;
    }

  }

  pCodeRegMapLiveRangesInFlow(PCFL(pcflow));
  
#if 1
//  fprintf(stderr, "register %s is used in %d pCodes, assigned in %d pCodes\n", reg->name,
//      elementsInSet(reg->reglives.usedpCodes),
//      elementsInSet(reg->reglives.assignedpFlows));
  
  RemoveRegFromLRBlock(reg);
#endif
  
}

/*-----------------------------------------------------------------*
 *
 *-----------------------------------------------------------------*/
static int regUsedinRange(pCode *pc1, pCode *pc2, regs *reg)
{
  int i=0;
  regs *testreg;

  do {
    testreg = picoBlaze_getRegFromInstruction(pc1);
    if(testreg && (testreg->rIdx == reg->rIdx)) {
      return 1;
    }

    if(PCI(pc1)->is2MemOp) {
      testreg = picoBlaze_getRegFromInstruction2(pc1);
      if(testreg && (testreg->rIdx == reg->rIdx)) {
        return 1;
      }
    }

    pc1 = picoBlaze_findNextInstruction(pc1->next);

  } while (pc1 && (pc1 != pc2) && (i++ < 100)) ;

  if(i >= 100)
    fprintf(stderr, "warning, regUsedinRange searched through too many pcodes\n");

  return 0;
}

/*-----------------------------------------------------------------*
 * void pCodeOptime2pCodes(pCode *pc1, pCode *pc2) 
 *
 * ADHOC pattern checking 
 * Now look for specific sequences that are easy to optimize.
 * Many of these sequences are characteristic of the compiler
 * (i.e. it'd probably be a waste of time to apply these adhoc
 * checks to hand written assembly.)
 * 
 *
 *-----------------------------------------------------------------*/
static int pCodeOptime2pCodes(pCode *pc1, pCode *pc2, pCode *pcfl_used, regs *reg, int can_free, int optimize_level)
{
  pCode *pct1, *pct2;
  regs  *reg1, *reg2;

  int t = total_registers_saved;

  if(pc2->seq < pc1->seq) {
    pct1 = pc2;
    pc2 = pc1;
    pc1 = pct1;
  }
/*
  fprintf(stderr,"pCodeOptime2pCodes\n");
  pc1->print(stderr,pc1);
  pc2->print(stderr,pc2);
*/
  if((PCI(pc1)->op == POC_CLRF) && (PCI(pc2)->op == POC_MOVFW) ){

    /*
      clrf  reg
      stuff...
      movf  reg,w

      can be replaced with

      stuff...
      movlw 0
    */

    pCode *newpc;
    //fprintf(stderr, "   CLRF/MOVFW. instruction after MOVFW is:\n");
    pct1 = picoBlaze_findNextInstruction(pc2->next);

    if(PCI(pct1)->op == POC_MOVWF) {
      newpc = picoBlaze_newpCode(POC_CLRF, PCI(pct1)->pcop);
      pct1->destruct(pct1);
    } else {
      newpc = picoBlaze_newpCode(POC_MOVLW, picoBlaze_newpCodeOpLit(0));
    }

    picoBlaze_pCodeInsertAfter(pc2, newpc);
    PCI(newpc)->pcflow = PCFL(pcfl_used);
    newpc->seq = pc2->seq;

    /* take care if register is used after pc2, if yes, then don't delete
     * clrf reg, because, reg should be initialized with zero */
    {
      pCode *spc;
      int maxSeq=0;

        for(spc=setFirstItem(reg->reglives.usedpCodes);spc;spc=setNextItem(reg->reglives.usedpCodes)) {
          if(maxSeq < spc->seq)maxSeq = spc->seq;
        }

//        fprintf(stderr, "pc1->seq = %d\tpc2->seq = %d\tspc->seq = %d\n", pc1->seq, pc2->seq, maxSeq);

        if(maxSeq > pc2->seq) {
          /* this means that a pCode uses register after pc2, then
           * we can't delete pc1 pCode */
          Remove2pcodes(pcfl_used, NULL, pc2, reg, can_free);
        } else {
          /* we can remove both pCodes */
          Remove2pcodes(pcfl_used, pc1, pc2, reg, can_free);
        }
    }
    total_registers_saved++;  // debugging stats.

  } else if((PCI(pc1)->op == POC_CLRF) && (PCI(pc2)->op == POC_IORFW) ){
    //fprintf(stderr, "   CLRF/IORFW.\n");

    pct2 = picoBlaze_findNextInstruction(pc2->next);

    if(picoBlaze_pCodeSearchCondition(pct2, PCC_Z) > 0) {
      pct2 = picoBlaze_newpCode(POC_IORLW, picoBlaze_newpCodeOpLit(0));
      pct2->seq = pc2->seq;
      PCI(pct2)->pcflow = PCFL(pcfl_used);
      picoBlaze_pCodeInsertAfter(pc1,pct2);
    }
    Remove2pcodes(pcfl_used, pc1, pc2, reg, can_free);
    total_registers_saved++;  // debugging stats.

  }  else if(PCI(pc1)->op == POC_MOVWF) {

    reg1 = picoBlaze_getRegFromInstruction(pc1);

    if(reg1->type == REG_GPR)return (total_registers_saved != t);

    pct2 = picoBlaze_findNextInstruction(pc2->next);

    if(PCI(pc2)->op == POC_MOVFW) {

      if(PCI(pct2)->op == POC_MOVWF) {
	/*
	  Change:

	    movwf   reg

	    stuff...

	    movf    reg,w
            movwf   reg2

	  To:

	    
	*/
	reg2 = picoBlaze_getRegFromInstruction(pct2);
	if(reg2 && !regUsedinRange(pc1,pc2,reg2))  {
//	if(reg2 && !regUsedinRange(pc1,pc2,reg2)) 

	  if(picoBlaze_pCodeSearchCondition(pct2, PCC_Z) < 1) {
	    pCode *pct3 = picoBlaze_findNextInstruction(pct2->next);
	    pct2->seq = pc1->seq;
	    picoBlaze_unlinkpCode(pct2);
	    picoBlaze_pCodeInsertAfter(picoBlaze_findPrevInstruction(pc1->prev),pct2);

#define usesW(x)       ((x) && (isPCI(x)) && ( (PCI(x)->inCond & PCC_W) != 0))

	    if(usesW(pct3))
	      ; // Remove2pcodes(pcfl_used, pc1, NULL, reg, can_free);
	    else {
	      Remove2pcodes(pcfl_used, pc1, pc2, reg, can_free);
	      total_registers_saved++;  // debugging stats.
	      return 1;
            }
          } else {
//            fprintf(stderr,"didn't optimize because Z bit is used\n");
	  }
	}
      }
    }

    pct1 = picoBlaze_findPrevInstruction(pc1->prev);
    if(pct1 && (PCI(pct1)->pcflow == PCI(pc1)->pcflow)) {

      if ( (PCI(pct1)->op == POC_MOVFW) &&
	   (PCI(pc2)->op == POC_MOVFW)) {

	reg1 = picoBlaze_getRegFromInstruction(pct1);
	if(reg1 && !regUsedinRange(pc1,pc2,reg1)) {
	  

	  /*
	    Change:

	    movf   reg1,w
	    movwf  reg

	    stuff...
	    movf   reg,w

	    To:

	    stuff...

	    movf   reg1,w

	    Or, if we're not deleting the register then the "To" is:

	    stuff...

	    movf   reg1,w
	    movwf  reg


	  */
	  pct2 = picoBlaze_newpCode(PCI(pc2)->op, PCI(pct1)->pcop);
	  picoBlaze_pCodeInsertAfter(pc2, pct2);
	  PCI(pct2)->pcflow = PCFL(pcfl_used);
	  pct2->seq = pc2->seq;

	  if(can_free) {
	    Remove2pcodes(pcfl_used, pc1, pc2, reg, can_free);
	  } else {
	    /* If we're not freeing the register then that means (probably)
	     * the register is needed somewhere else.*/
	    picoBlaze_unlinkpCode(pc1);
	    picoBlaze_pCodeInsertAfter(pct2, pc1);

	    Remove2pcodes(pcfl_used, pc2, NULL, reg, can_free);
	  }

	  Remove2pcodes(pcfl_used, pct1, NULL, reg1, 0);
	  total_registers_saved++;  // debugging stats.

	}
      } else if ( (PCI(pct1)->op == POC_MOVWF) &&
	   (PCI(pc2)->op == POC_MOVFW)) {

//	   fprintf(stderr,"movwf MOVWF/MOVFW\n");

	if(optimize_level > 1 && can_free) {
	  pct2 = picoBlaze_newpCode(POC_MOVFW, PCI(pc1)->pcop);
	  picoBlaze_pCodeInsertAfter(pc2, pct2);
	  Remove2pcodes(pcfl_used, pc1, pc2, reg, 1);
	  total_registers_saved++;  // debugging stats.
	}
      }


    }

  }

  return (total_registers_saved != t);
}

/*-----------------------------------------------------------------*
 * void pCodeRegOptimeRegUsage(pBlock *pb) 
 *-----------------------------------------------------------------*/
static void OptimizeRegUsage(set *fregs, int optimize_multi_uses, int optimize_level)
{
  regs *reg;
  int used;
  pCode *pc1=NULL, *pc2=NULL;


  while(fregs) {
    pCode *pcfl_used, *pcfl_assigned;

    /* Step through the set by directly accessing the 'next' pointer.
     * We could also step through by using the set API, but the 
     * the (debug) calls to print instructions affect the state
     * of the set pointers */

    reg = fregs->item;
    fregs = fregs->next;

    pcfl_used = setFirstItem(reg->reglives.usedpFlows);
    pcfl_assigned = setFirstItem(reg->reglives.assignedpFlows);

    used = elementsInSet(reg->reglives.usedpCodes);
//	fprintf(stderr, "%s:%d register %s used %d times in pCode\n", __FILE__, __LINE__, reg->name, used);
    if(used == 2) { 

      /*
       * In this section, all registers that are used in only in two 
       * instructions are examined. If possible, they're optimized out.
       */


      pc1 = setFirstItem(reg->reglives.usedpCodes);
      pc2 = setNextItem(reg->reglives.usedpCodes);

      if(pcfl_used && pcfl_assigned) {

	/* 
	   expected case - the register has been assigned a value and is
	   subsequently used 
	*/

	//fprintf(stderr," used only twice\n");
	if(pcfl_used->seq == pcfl_assigned->seq && !(setNextItem(reg->reglives.usedpFlows)) && !(setNextItem(reg->reglives.assignedpFlows))) {

	  //fprintf(stderr, "  and used in same flow\n");

	  pCodeOptime2pCodes(pc1, pc2, pcfl_used, reg, 1,optimize_level);

	} else {
	  // fprintf(stderr, "  and used in different flows\n");

	}

      } else if(pcfl_used) {

	/*
	  register has been used twice without ever being assigned */
	//fprintf(stderr,"WARNING %s: reg %s used without being assigned\n",__FUNCTION__,reg->name);

      } else {
//		fprintf(stderr,"WARNING %s: reg %s assigned without being used\n",__FUNCTION__,reg->name);
	Remove2pcodes(pcfl_assigned, pc1, pc2, reg, 1);
	total_registers_saved++;  // debugging stats.
      }
    } else {

      /* register has been used either once, or more than twice */

      if(used && !pcfl_used && pcfl_assigned) {
	pCode *pc;

		fprintf(stderr,"WARNING %s: reg %s assigned without being used\n",__FUNCTION__,reg->name);

	pc = setFirstItem(reg->reglives.usedpCodes);
	while(pc) {

	  pcfl_assigned = PCODE(PCI(pc)->pcflow);
	  Remove1pcode(pc, reg);

	  deleteSetItem (&(PCFL(pcfl_assigned)->registers), reg);
	  /*
	  deleteSetItem (&(reg->reglives.usedpCodes),pc);
	  pc->destruct(pc);
	  */
	  pc = setNextItem(reg->reglives.usedpCodes);
	}


	reg->isFree = 1;
	reg->wasUsed = 0;

	total_registers_saved++;  // debugging stats.
      } else if( (used > 2) && optimize_multi_uses) {

	set *rset1=NULL;
	set *rset2=NULL;
	int searching=1;

	pCodeFlow *pcfl1=NULL, *pcfl2=NULL;

	/* examine the number of times this register is used */


	rset1 = reg->reglives.usedpCodes;
	while(rset1 && searching) {

	  pc1 = rset1->item;
	  rset2 = rset1->next;

	  if(pc1 && isPCI(pc1) &&  ( (pcfl1 = PCI(pc1)->pcflow) != NULL) ) {

	    //while(rset2 && searching) {
	    if(rset2) {

	      pc2 = rset2->item;
	      if(pc2 && isPCI(pc2)  &&  ( (pcfl2 = PCI(pc2)->pcflow) != NULL) )  {
		if(pcfl2 == pcfl1) {

		  if(pCodeOptime2pCodes(pc1, pc2, pcfl_used, reg, 0,optimize_level))
		    searching = 0;
		}
	      }

	      //rset2 = rset2->next;
	      
	    }
	  }
	  rset1 = rset1->next;
	}
      }
    }

  }

}


/*-----------------------------------------------------------------*
 * void RegsUnMapLiveRanges(set *regset)
 *
 *-----------------------------------------------------------------*/
static void  RegsSetUnMapLiveRanges(set *regset)
{
  regs *reg;

  while(regset) {
    reg = regset->item;
    regset = regset->next;
    
    deleteSet(&reg->reglives.usedpCodes);
    deleteSet(&reg->reglives.usedpFlows);
    deleteSet(&reg->reglives.assignedpFlows);

  }

}

void  picoBlaze_RegsUnMapLiveRanges(void)
{
  RegsSetUnMapLiveRanges(picoBlaze_dynAllocRegs);
  RegsSetUnMapLiveRanges(picoBlaze_dynDirectRegs);
  RegsSetUnMapLiveRanges(picoBlaze_dynDirectBitRegs);
}
