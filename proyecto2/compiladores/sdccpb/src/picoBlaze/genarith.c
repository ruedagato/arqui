/*-------------------------------------------------------------------------

 genarith.c - source file for code generation - arithmetic

  Written By -  Sandeep Dutta . sandeep.dutta@usa.net (1998)
         and -  Jean-Louis VERN.jlvern@writeme.com (1999)
  Bug Fixes  -  Wojciech Stryjewski  wstryj1@tiger.lsu.edu (1999 v2.1.9a)
  PIC port   -  Scott Dattalo scott@dattalo.com (2000)
  PICOBLAZE port   -  Martin Dubuc m.dubuc@rogers.com (2002)

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
  000123 mlh    Moved aopLiteral to SDCCglue.c to help the split
                Made everything static
-------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "SDCCglobl.h"
#include "newalloc.h"

#if defined(_MSC_VER) && (_MSC_VER < 1300)
#define __FUNCTION__            __FILE__
#endif

#include "common.h"
#include "SDCCpeeph.h"
#include "ralloc.h"
#include "pcode.h"
#include "gen.h"

#if 1
#define picoBlaze_emitcode  DEBUGpicoBlaze_emitcode
#endif

#define BYTEofLONG(l,b) ( (l>> (b<<3)) & 0xff)
void DEBUGpicoBlaze_picoBlaze_AopType(int line_no, operand *left, operand *right, operand *result);
void picoBlaze_emitpcomment(char *, ...);
pCodeOp *picoBlaze_popGet2p(pCodeOp *src, pCodeOp *dst);
const char *picoBlaze_AopType(short type)
{
  switch(type) {
  case AOP_LIT:         return "AOP_LIT";
  case AOP_REG:         return "AOP_REG";
  case AOP_DIR:         return "AOP_DIR";
  case AOP_STK:         return "AOP_STK";
  case AOP_STR:         return "AOP_STR";
  case AOP_CRY:         return "AOP_CRY";
  case AOP_ACC:         return "AOP_ACC";
  case AOP_PCODE:       return "AOP_PCODE";
  case AOP_STA:         return "AOP_STA";
  }

  return "BAD TYPE";
}

const char *picoBlaze_pCodeOpType(pCodeOp *pcop)
{

  if(pcop) {

    switch(pcop->type) {

    case PO_NONE:               return "PO_NONE";
    case PO_GPR_REGISTER:       return  "PO_GPR_REGISTER";
    case PO_GPR_BIT:            return  "PO_GPR_BIT";
    case PO_GPR_TEMP:           return  "PO_GPR_TEMP";
    case PO_LITERAL:            return  "PO_LITERAL";
    case PO_DIR:                return  "PO_DIR";
    case PO_LABEL:              return  "PO_LABEL";
    case PO_GPR_SP:              return  "PO_GPR_SP";
    }
  }

  return "BAD PO_TYPE";
}

const char *picoBlaze_pCodeOpSubType(pCodeOp *pcop)
{

  if(pcop && (pcop->type == PO_GPR_BIT)) {

    switch(PCORB(pcop)->subtype) {

    case PO_NONE:               return "PO_NONE";
    case PO_GPR_REGISTER:       return  "PO_GPR_REGISTER";
    case PO_GPR_BIT:            return  "PO_GPR_BIT";
    case PO_GPR_TEMP:           return  "PO_GPR_TEMP";
    case PO_LITERAL:            return  "PO_LITERAL";
    case PO_DIR:                return  "PO_DIR";
    case PO_LABEL:              return  "PO_LABEL";
    case PO_GPR_SP:              return  "PO_GPR_SP";
    }
  }

  return "BAD PO_TYPE";
}

/*-----------------------------------------------------------------*/
/* picoBlaze_genPlusIncr :- does addition with increment if possible         */
/*-----------------------------------------------------------------*/
bool picoBlaze_genPlusIncr (iCode *ic)
{
  unsigned int icount ;
  unsigned int size = picoBlaze_getDataSize(IC_RESULT(ic));

    FENTRY;

    DEBUGpicoBlaze_emitcode ("; ","result %s, left %s, right %s",
                         picoBlaze_AopType(AOP_TYPE(IC_RESULT(ic))),
                         picoBlaze_AopType(AOP_TYPE(IC_LEFT(ic))),
                         picoBlaze_AopType(AOP_TYPE(IC_RIGHT(ic))));

    /* will try to generate an increment */
    /* if the right side is not a literal
       we cannot */
    if (AOP_TYPE(IC_RIGHT(ic)) != AOP_LIT)
        return FALSE ;

    DEBUGpicoBlaze_emitcode ("; ","%s  %d",__FUNCTION__,__LINE__);
    /* if the literal value of the right hand side
       is greater than 2 then it is faster to add */
    if ((icount = (unsigned int) ulFromVal (AOP(IC_RIGHT(ic))->aopu.aop_lit)) > 2)
        return FALSE ;

    /* if increment 16 bits in register */
    if (picoBlaze_sameRegs(AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic))) &&
        (icount == 1)) {

      int offset = MSB16;

      picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(IC_RESULT(ic)),LSB));
      //picoBlaze_emitcode("incf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),LSB,FALSE,FALSE));

      while(--size) {
//*//        emitSKPNC;
        picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(IC_RESULT(ic)),offset++));
        //picoBlaze_emitcode(" incf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),offset++,FALSE,FALSE));
      }

      return TRUE;
    }

//    DEBUGpicoBlaze_emitcode ("; ","%s  %d",__FUNCTION__,__LINE__);
    /* if left is in accumulator  - probably a bit operation*/                          // VR - why this is a bit operation?!
    if( (AOP_TYPE(IC_LEFT(ic)) == AOP_ACC) &&
        (AOP_TYPE(IC_RESULT(ic)) == AOP_CRY) ) {

      picoBlaze_emitpcode(POC_BCF, picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
      if(icount)
        picoBlaze_emitpcode(POC_XORLW,picoBlaze_popGetLit(1));
      //picoBlaze_emitcode("xorlw","1");
      else
        picoBlaze_emitpcode(POC_ANDLW,picoBlaze_popGetLit(1));
      //picoBlaze_emitcode("andlw","1");

//*//      emitSKPZ;
      picoBlaze_emitpcode(POC_BSF, picoBlaze_popGet(AOP(IC_RESULT(ic)),0));

      return TRUE;
    }


    /* if the sizes are greater than 1 then we cannot */
    if (AOP_SIZE(IC_RESULT(ic)) > 1 ||
        AOP_SIZE(IC_LEFT(ic)) > 1   )
        return FALSE ;

    /* If we are incrementing the same register by two: */

    if (picoBlaze_sameRegs(AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic))) ) {

      while (icount--)
        picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
      //picoBlaze_emitcode("incf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE));

      return TRUE ;
    }

    DEBUGpicoBlaze_emitcode ("; ","couldn't increment ");

    return FALSE ;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_outBitAcc - output a bit in acc                                 */
/*-----------------------------------------------------------------*/
void picoBlaze_outBitAcc(operand *result)
{
    symbol *tlbl = newiTempLabel(NULL);
    /* if the result is a bit */
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    assert(0); // not implemented for PICOBLAZE?

    if (AOP_TYPE(result) == AOP_CRY){
        picoBlaze_aopPut(AOP(result),"a",0);
    }
    else {
        picoBlaze_emitcode("jz","%05d_DS_",tlbl->key+100);
        picoBlaze_emitcode("mov","a,#01");
        picoBlaze_emitcode("","%05d_DS_:",tlbl->key+100);
        picoBlaze_outAcc(result);
    }
}

/*-----------------------------------------------------------------*/
/* picoBlaze_genPlusBits - generates code for addition of two bits           */
/*-----------------------------------------------------------------*/
void picoBlaze_genPlusBits (iCode *ic)
{
  FENTRY;

  DEBUGpicoBlaze_emitcode ("; ","result %s, left %s, right %s",
                       picoBlaze_AopType(AOP_TYPE(IC_RESULT(ic))),
                       picoBlaze_AopType(AOP_TYPE(IC_LEFT(ic))),
                       picoBlaze_AopType(AOP_TYPE(IC_RIGHT(ic))));
  /*
    The following block of code will add two bits.
    Note that it'll even work if the destination is
    the carry (C in the status register).
    It won't work if the 'Z' bit is a source or destination.
  */

  /* If the result is stored in the accumulator (w) */
  //if(strcmp(picoBlaze_aopGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE),"a") == 0 ) {
  switch(AOP_TYPE(IC_RESULT(ic))) {
  case AOP_ACC:
//*//    picoBlaze_emitpcode(POC_CLRF, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
    picoBlaze_emitpcode(POC_XORLW, picoBlaze_popGetLit(1));
    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
    picoBlaze_emitpcode(POC_XORLW, picoBlaze_popGetLit(1));
    break;
  case AOP_REG:
    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0));
    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
    picoBlaze_emitpcode(POC_XORLW, picoBlaze_popGetLit(1));
    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
    picoBlaze_emitpcode(POC_XORLW, picoBlaze_popGetLit(1));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
    break;
  default:
    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
    picoBlaze_emitpcode(POC_BCF,   picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
    picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
    picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
    break;
  }
}

#if 1
/*-----------------------------------------------------------------*/
/* genAddlit - generates code for addition                         */
/*-----------------------------------------------------------------*/
static void genAddLit2byte (operand *result, int offr, int lit)
{
  FENTRY;

  switch(lit & 0xff) {
  case 0:
    break;
  case 1:
    picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),offr));
    break;
  case 0xff:
    picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),offr));
    break;
  default:
    picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lit&0xff));
    picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),offr));
  }

}
#endif

static void emitMOVWF(operand *reg, int offset)
{
  if(!reg)
    return;

  if (AOP_TYPE(reg) == AOP_ACC) {
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d ignoring mov into W",__FUNCTION__,__LINE__);
    return;
  }

  picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(reg),offset));

}


#if 1

static void genAddLit (iCode *ic, int lit)
{

  int size,same;
  int lo, offset;

  operand *result;
  operand *left;

  FENTRY;

  left = IC_LEFT(ic);
  result = IC_RESULT(ic);
  same = picoBlaze_sameRegs(AOP(left), AOP(result));
  size = picoBlaze_getDataSize(result);

  if ((AOP_PCODE == AOP_TYPE(left))
          && (0))
  {
      /* see #1888004 for an example case for this */
      for (offset = 0; offset < size; offset++) {
          picoBlaze_emitpcode(POC_MOVLW, picoBlaze_newpCodeOpImmd(AOP(left)->aopu.pcop->name,
                  offset, PCOI(AOP(left)->aopu.pcop)->index + lit, 0));
          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offset));
      } // for
      return;
  } // if

  if(same) {

    /* Handle special cases first */
    if(size == 1)
      genAddLit2byte (result, 0, lit);

    else if(size == 2) {
      int hi = 0xff & (lit >> 8);
      lo = lit & 0xff;

      switch(hi) {
      case 0:

        /* lit = 0x00LL */
        DEBUGpicoBlaze_emitcode ("; hi = 0","%s  %d",__FUNCTION__,__LINE__);
        switch(lo) {
        case 0:
          break;
        case 1:
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),0));
//*//          emitSKPNZ;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        case 0xff:
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_INCFSZW, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));

          break;
        default:
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lit&0xff));
          picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),0));
//*//          emitSKPNC;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));


        }
        break;

      case 1:
        /* lit = 0x01LL */
        DEBUGpicoBlaze_emitcode ("; hi = 1","%s  %d",__FUNCTION__,__LINE__);
        switch(lo) {
        case 0:  /* 0x0100 */
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        case 1:  /* 0x0101  */
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),0));
//*//          emitSKPNZ;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        case 0xff: /* 0x01ff */
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_INCFSZW, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        default: /* 0x01LL */
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
          picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),0));
//*//          emitSKPNC;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
        }
        break;

      case 0xff:
        DEBUGpicoBlaze_emitcode ("; hi = ff","%s  %d",__FUNCTION__,__LINE__);
        /* lit = 0xffLL */
        switch(lo) {
        case 0:  /* 0xff00 */
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        case 1:  /*0xff01 */
          picoBlaze_emitpcode(POC_INCFSZ, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),MSB16));
          break;
/*      case 0xff: * 0xffff *
          picoBlaze_emitpcode(POC_INCFSZW, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16,FALSE,FALSE));
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          break;
*/
        default:
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
          picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),0));
//*//          emitSKPC;
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),MSB16));

        }

        break;

      default:
        DEBUGpicoBlaze_emitcode ("; hi is generic","%d   %s  %d",hi,__FUNCTION__,__LINE__);

        /* lit = 0xHHLL */
        switch(lo) {
        case 0:  /* 0xHH00 */
          genAddLit2byte (result, MSB16, hi);
          break;
        case 1:  /* 0xHH01 */
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(hi));
          picoBlaze_emitpcode(POC_ADDWFC,picoBlaze_popGet(AOP(result),MSB16));
          break;
/*      case 0xff: * 0xHHff *
          picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),MSB16,FALSE,FALSE));
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(hi));
          picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),MSB16,FALSE,FALSE));
          break;
*/      default:  /* 0xHHLL */
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
          picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(hi));
          picoBlaze_emitpcode(POC_ADDWFC,picoBlaze_popGet(AOP(result),MSB16));
          break;
        }

      }
    } else {
      int carry_info = 0;
      int offset = 0;
      /* size > 2 */
      DEBUGpicoBlaze_emitcode (";  add lit to long","%s  %d",__FUNCTION__,__LINE__);

      while(size--) {
        lo = BYTEofLONG(lit,0);

        if(carry_info) {
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
          picoBlaze_emitpcode(POC_ADDWFC, picoBlaze_popGet(AOP(result),offset));
        }else {
          /* no carry info from previous step */
          /* this means this is the first time to add */
          switch(lo) {
          case 0:
            break;
          case 1:
            picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),offset));
            carry_info=1;
            break;
          default:
            picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
            picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),offset));
            if(lit <0x100)
              carry_info = 3;  /* Were adding only one byte and propogating the carry */
            else
              carry_info = 2;
            break;
          }
        }
        offset++;
        lit >>= 8;
      }

/*
      lo = BYTEofLONG(lit,0);

      if(lit < 0x100) {
        if(lo) {
          if(lo == 1) {
            picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
            emitSKPNZ;
          } else {
            picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
            picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
            emitSKPNC;
          }
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),1,FALSE,FALSE));
          emitSKPNZ;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),2,FALSE,FALSE));
          emitSKPNZ;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),3,FALSE,FALSE));

        }
      }

*/
    }
  } else {
    int offset = 1;
    DEBUGpicoBlaze_emitcode (";  left and result aren't same","%s  %d",__FUNCTION__,__LINE__);

    if(size == 1) {

      if(AOP_TYPE(left) == AOP_ACC) {
        /* left addend is already in accumulator */
        switch(lit & 0xff) {
        case 0:
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
          break;
        default:
          picoBlaze_emitpcode(POC_ADDLW, picoBlaze_popGetLit(lit & 0xff));
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
        }
      } else {
        /* left addend is in a register */
        switch(lit & 0xff) {
        case 0:
          picoBlaze_mov2w(AOP(left),0);
          emitMOVWF(result, 0);
          break;
        case 1:
          picoBlaze_emitpcode(POC_INCFW, picoBlaze_popGet(AOP(left),0));
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
          break;
        case 0xff:
          picoBlaze_emitpcode(POC_DECFW, picoBlaze_popGet(AOP(left),0));
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
          break;
        default:
          picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
          picoBlaze_emitpcode(POC_ADDFW, picoBlaze_popGet(AOP(left),0));
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
        }
      }

//    } else if (picoBlaze_isLitAop(AOP(left))) {
//      // adding two literals
//      assert ( !"adding two literals is not yet supported" );
    } else {
      int clear_carry=0;

      /* left is not the accumulator */
      if(lit & 0xff) {
        picoBlaze_mov2w(AOP(left),0);
        picoBlaze_emitpcode(POC_ADDLW, picoBlaze_popGetLit(lit & 0xff));
      } else {
        picoBlaze_mov2w(AOP(left),0);
        /* We don't know the state of the carry bit at this point */
        clear_carry = 1;
      }
      //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
      emitMOVWF(result,0);
      while(--size) {
        lit >>= 8;
        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
        if (offset < AOP_SIZE(left)) {
          picoBlaze_emitpcode(clear_carry ? POC_ADDFW : POC_ADDFWC, picoBlaze_popGet(AOP(left),offset));
          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offset));
        } else {
          picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result),offset));
          if (!SPEC_USIGN(operandType(IC_LEFT(ic)))) {
            /* sign-extend left (in result) */
            picoBlaze_emitpcode (POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(left),AOP_SIZE(left)-1,7));
            picoBlaze_emitpcode(POC_SETF, picoBlaze_popGet(AOP(result),offset));
          }
          picoBlaze_emitpcode(clear_carry ? POC_ADDWF : POC_ADDWFC, picoBlaze_popGet(AOP(result),offset));
        }
        clear_carry = 0;
        offset++;
      }
    }
  }
}

#else
    /* this fails when result is an SFR because value is written there
     * during addition and not at the end */

static void genAddLit (iCode *ic, int lit)
{

  int size,sizeL,same;
  int i, llit;

  operand *result;
  operand *left;

    FENTRY;


  left = IC_LEFT(ic);
  result = IC_RESULT(ic);
  same = picoBlaze_sameRegs(AOP(left), AOP(result));
  size = picoBlaze_getDataSize(result);
  sizeL = picoBlaze_getDataSize(left);
  llit = lit;

#define MIN(a,b)        (((a) < (b)) ? (a) : (b))
  /* move left to result -- possibly sign extend */
  for (i=0; i < MIN(size, sizeL); i++) {
    picoBlaze_mov2f (AOP(result), AOP(left), i);
  } // for i
#undef MIN

  /* extend to result size */
  picoBlaze_addSign(result, sizeL, !IS_UNSIGNED(operandType(left)));

  /* special cases */
  if (lit == 0) {
    /* nothing to do */
  } else if (lit == 1) {
    switch (size) {
    case 1:
      /* handled below */
      break;
    case 2:
      picoBlaze_emitpcode (POC_INFSNZ, picoBlaze_popGet (AOP(result), 0));
      break;
    default:
      assert (size > 2);
      picoBlaze_emitpcode (POC_INCF, picoBlaze_popGet(AOP(result), 0));
      for (i=1; i < size-1; i++) {
        emitSKPNC; /* a jump here saves up to 2(size-2)cycles */
        picoBlaze_emitpcode (POC_INCF, picoBlaze_popGet(AOP(result), i));
      } // for i
      emitSKPNC;
      break;
    } // switch

    picoBlaze_emitpcode (POC_INCF, picoBlaze_popGet (AOP(result), size-1));
  } else {
    /* general case */

    /* add literal to result */
    for (i=0; i < size; i++) {
      picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit (llit));
      llit >>= 8; /* FIXME: arithmetic right shift for signed literals? */
      picoBlaze_emitpcode (i == 0 ? POC_ADDWF : POC_ADDWFC,
        picoBlaze_popGet (AOP(result), i));
    }
  }

#if 0

  if(same) {

    /* Handle special cases first */
    if(size == 1)
      genAddLit2byte (result, 0, lit);

    else if(size == 2) {
      int hi = 0xff & (lit >> 8);
      lo = lit & 0xff;

      switch(hi) {
      case 0:

        /* lit = 0x00LL */
        DEBUGpicoBlaze_emitcode ("; hi = 0","%s  %d",__FUNCTION__,__LINE__);
        switch(lo) {
        case 0:
          break;
        case 1:
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),0));
          emitSKPNZ;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        case 0xff:
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_INCFSZW, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));

          break;
        default:
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lit&0xff));
          picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),0));
          emitSKPNC;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));


        }
        break;

      case 1:
        /* lit = 0x01LL */
        DEBUGpicoBlaze_emitcode ("; hi = 1","%s  %d",__FUNCTION__,__LINE__);
        switch(lo) {
        case 0:  /* 0x0100 */
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        case 1:  /* 0x0101  */
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),0));
          emitSKPNZ;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        case 0xff: /* 0x01ff */
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_INCFSZW, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        default: /* 0x01LL */
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
          picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),0));
          emitSKPNC;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16));
        }
        break;

      case 0xff:
        DEBUGpicoBlaze_emitcode ("; hi = ff","%s  %d",__FUNCTION__,__LINE__);
        /* lit = 0xffLL */
        switch(lo) {
        case 0:  /* 0xff00 */
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),MSB16));
          break;
        case 1:  /*0xff01 */
          picoBlaze_emitpcode(POC_INCFSZ, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),MSB16));
          break;
/*      case 0xff: * 0xffff *
          picoBlaze_emitpcode(POC_INCFSZW, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),MSB16,FALSE,FALSE));
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          break;
*/
        default:
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
          picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),0));
          emitSKPC;
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),MSB16));

        }

        break;

      default:
        DEBUGpicoBlaze_emitcode ("; hi is generic","%d   %s  %d",hi,__FUNCTION__,__LINE__);

        /* lit = 0xHHLL */
        switch(lo) {
        case 0:  /* 0xHH00 */
          genAddLit2byte (result, MSB16, hi);
          break;
        case 1:  /* 0xHH01 */
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(hi));
          picoBlaze_emitpcode(POC_ADDWFC,picoBlaze_popGet(AOP(result),MSB16));
          break;
/*      case 0xff: * 0xHHff *
          picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),MSB16,FALSE,FALSE));
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(hi));
          picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),MSB16,FALSE,FALSE));
          break;
*/      default:  /* 0xHHLL */
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
          picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),0));
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(hi));
          picoBlaze_emitpcode(POC_ADDWFC,picoBlaze_popGet(AOP(result),MSB16));
          break;
        }

      }
    } else {
      int carry_info = 0;
      int offset = 0;
      /* size > 2 */
      DEBUGpicoBlaze_emitcode (";  add lit to long","%s  %d",__FUNCTION__,__LINE__);

      while(size--) {
        lo = BYTEofLONG(lit,0);

        if(carry_info) {
          picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
          picoBlaze_emitpcode(POC_ADDWFC, picoBlaze_popGet(AOP(result),offset));
        }else {
          /* no carry info from previous step */
          /* this means this is the first time to add */
          switch(lo) {
          case 0:
            break;
          case 1:
            picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),offset));
            carry_info=1;
            break;
          default:
            picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
            picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),offset));
            if(lit <0x100)
              carry_info = 3;  /* Were adding only one byte and propogating the carry */
            else
              carry_info = 2;
            break;
          }
        }
        offset++;
        lit >>= 8;
      }

/*
      lo = BYTEofLONG(lit,0);

      if(lit < 0x100) {
        if(lo) {
          if(lo == 1) {
            picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
            emitSKPNZ;
          } else {
            picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lo));
            picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
            emitSKPNC;
          }
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),1,FALSE,FALSE));
          emitSKPNZ;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),2,FALSE,FALSE));
          emitSKPNZ;
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),3,FALSE,FALSE));

        }
      }

*/
    }
  } else {
    int offset = 1;
    DEBUGpicoBlaze_emitcode (";  left and result aren't same","%s  %d",__FUNCTION__,__LINE__);

    if(size == 1) {

      if(AOP_TYPE(left) == AOP_ACC) {
        /* left addend is already in accumulator */
        switch(lit & 0xff) {
        case 0:
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
          break;
        default:
          picoBlaze_emitpcode(POC_ADDLW, picoBlaze_popGetLit(lit & 0xff));
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
        }
      } else {
        /* left addend is in a register */
        switch(lit & 0xff) {
        case 0:
          picoBlaze_mov2w(AOP(left),0);
          emitMOVWF(result, 0);
          break;
        case 1:
          picoBlaze_emitpcode(POC_INCFW, picoBlaze_popGet(AOP(left),0));
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
          break;
        case 0xff:
          picoBlaze_emitpcode(POC_DECFW, picoBlaze_popGet(AOP(left),0));
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
          break;
        default:
          picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
          picoBlaze_emitpcode(POC_ADDFW, picoBlaze_popGet(AOP(left),0));
          //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
          emitMOVWF(result,0);
        }
      }

    } else {
      int clear_carry=0;

      /* left is not the accumulator */
      if(lit & 0xff) {
        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
        picoBlaze_emitpcode(POC_ADDFW, picoBlaze_popGet(AOP(left),0));
      } else {
        picoBlaze_mov2w(AOP(left),0);
        /* We don't know the state of the carry bit at this point */
        clear_carry = 1;
      }
      //picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0,FALSE,FALSE));
      emitMOVWF(result,0);
      while(--size) {

        lit >>= 8;
        if(lit & 0xff) {
          if(clear_carry) {
            /* The ls byte of the lit must've been zero - that
               means we don't have to deal with carry */

            picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
            picoBlaze_emitpcode(POC_ADDFW,  picoBlaze_popGet(AOP(left),offset));
            picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offset));

            clear_carry = 0;

          } else {
            picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
            picoBlaze_emitpcode(POC_ADDFWC, picoBlaze_popGet(AOP(left),offset));
            picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offset));
          }

        } else {
          picoBlaze_emitpcode(POC_CLRF,  picoBlaze_popGet(AOP(result),offset));
          picoBlaze_mov2w(AOP(left),offset);
          picoBlaze_emitpcode(POC_ADDWFC, picoBlaze_popGet(AOP(result),offset));
        }
        offset++;
      }
    }
  }
#endif
}

#endif

/*-----------------------------------------------------------------*/
/* picoBlaze_genPlus - generates code for addition                     */
/*-----------------------------------------------------------------*/
void picoBlaze_genPlus (iCode *ic)
{
  int i, size, offset = 0;
  operand *result, *left, *right;

    FENTRY;

    /* special cases :- */
        result = IC_RESULT(ic);
        left = IC_LEFT(ic);
        right = IC_RIGHT(ic);
        picoBlaze_aopOp (left,ic,FALSE);
        picoBlaze_aopOp (right,ic,FALSE);
        picoBlaze_aopOp (result,ic,TRUE);
        DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left, right, result);
        // picoBlaze_DumpOp("(left)",left);

        /* if literal, literal on the right or
        if left requires ACC or right is already
        in ACC */

        if ( (AOP_TYPE(left) == AOP_LIT) || (picoBlaze_sameRegs(AOP(right), AOP(result))) ) {
                operand *t = right;
                right = IC_RIGHT(ic) = left;
                left = IC_LEFT(ic) = t;
        }

        /* if both left & right are in bit space */
        if (AOP_TYPE(left) == AOP_CRY &&
                AOP_TYPE(right) == AOP_CRY) {
                picoBlaze_genPlusBits (ic);
                goto release ;
        }

        /* if left in bit space & right literal */
        if (AOP_TYPE(left) == AOP_CRY &&
                AOP_TYPE(right) == AOP_LIT) {
                /* if result in bit space */
                if(AOP_TYPE(result) == AOP_CRY){
                        if(ulFromVal (AOP(right)->aopu.aop_lit) != 0L) {
                                picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(result),0));
                                if (!picoBlaze_sameRegs(AOP(left), AOP(result)) )
                                        picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(left),0));
                                picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(result),0));
                        }
                } else {
                        unsigned long lit = ulFromVal (AOP(right)->aopu.aop_lit);
                        size = picoBlaze_getDataSize(result);
                        while (size--) {
                                picoBlaze_emitpcode (POC_CLRF, picoBlaze_popGet (AOP(result), offset));
                                picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit ((lit >> (8*offset)) & 0xFF));
                                picoBlaze_emitpcode (POC_ADDWFC, picoBlaze_popGet(AOP(result), offset++));
                                //MOVA(picoBlaze_aopGet(AOP(right),offset,FALSE,FALSE));
                                //picoBlaze_emitcode("addc","a,#00  ;%d",__LINE__);
                                //picoBlaze_aopPut(AOP(result),"a",offset++);
                        }
                }
        goto release ;
        } // left == CRY

        /* if I can do an increment instead
        of add then GOOD for ME */
        if (picoBlaze_genPlusIncr (ic) == TRUE)
                goto release;

        size = picoBlaze_getDataSize(result);

        if(AOP(right)->type == AOP_LIT) {
                /* Add a literal to something else */
                //bool know_W=0;
                unsigned lit = (unsigned) ulFromVal (AOP(right)->aopu.aop_lit);
                //unsigned l1=0;

                //offset = 0;
                DEBUGpicoBlaze_emitcode(";","adding lit to something. size %d",size);

                genAddLit (ic,  lit);
                goto release;

        } else if(AOP_TYPE(right) == AOP_CRY) {

                picoBlaze_emitcode(";bitadd","right is bit: %s",picoBlaze_aopGet(AOP(right),0,FALSE,FALSE));
                picoBlaze_emitcode(";bitadd","left is bit: %s",picoBlaze_aopGet(AOP(left),0,FALSE,FALSE));
                picoBlaze_emitcode(";bitadd","result is bit: %s",picoBlaze_aopGet(AOP(result),0,FALSE,FALSE));

                /* here we are adding a bit to a char or int */
                if(size == 1) {
                        if (picoBlaze_sameRegs(AOP(left), AOP(result)) ) {

                                picoBlaze_emitpcode(POC_BTFSC , picoBlaze_popGet(AOP(right),0));
                                picoBlaze_emitpcode(POC_INCF ,  picoBlaze_popGet(AOP(result),0));
                        } else { // not same

                                if(AOP_TYPE(left) == AOP_ACC) {
                                        picoBlaze_emitpcode(POC_BTFSC , picoBlaze_popGet(AOP(right),0));
                                        picoBlaze_emitpcode(POC_XORLW , picoBlaze_popGetLit(1));
                                } else {
                                        picoBlaze_mov2w(AOP(left),0);
                                        picoBlaze_emitpcode(POC_BTFSC , picoBlaze_popGet(AOP(right),0));
                                        picoBlaze_emitpcode(POC_INCFW , picoBlaze_popGet(AOP(left),0));
                                }

                                if(AOP_TYPE(result) != AOP_ACC) {

                                        if(AOP_TYPE(result) == AOP_CRY) {
                                                picoBlaze_emitpcode(POC_ANDLW , picoBlaze_popGetLit(1));
                                                picoBlaze_emitpcode(POC_BCF ,   picoBlaze_popGet(AOP(result),0));
//*//                                                emitSKPZ;
                                                picoBlaze_emitpcode(POC_BSF ,   picoBlaze_popGet(AOP(result),0));
                                        } else {
                                                picoBlaze_emitpcode(POC_MOVWF ,   picoBlaze_popGet(AOP(result),0));
                                        }
                                }
                        }

                } else {
                        int offset = 1;
                        DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
                        if (picoBlaze_sameRegs(AOP(left), AOP(result)) ) {
//*//                                emitCLRZ;
                                picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(right),0));
                                picoBlaze_emitpcode(POC_INCF,  picoBlaze_popGet(AOP(result),0));
                        } else {
//*//                                emitCLRZ; // needed here as well: INCFW is not always executed, Z is undefined then
                                picoBlaze_mov2w(AOP(left),0);
                                picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(right),0));
                                picoBlaze_emitpcode(POC_INCFW, picoBlaze_popGet(AOP(left),0));
                                emitMOVWF(right,0);
                        }

                        while(--size){
//*//                                emitSKPZ;
                                picoBlaze_emitpcode(POC_INCF,  picoBlaze_popGet(AOP(result),offset++));
                        }

                }

        } else {
                // add bytes

                // Note: the following is an example of WISC code, eg.
                // it's supposed to run on a Weird Instruction Set Computer :o)

                DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

                if ( AOP_TYPE(left) == AOP_ACC) {
                        DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
                        picoBlaze_emitpcode(POC_ADDFW, picoBlaze_popGet(AOP(right),0));
                        if ( AOP_TYPE(result) != AOP_ACC)
                                picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),0));
                        goto release; // we're done, since WREG is 1 byte
                }


                DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

                size = min( AOP_SIZE(result), AOP_SIZE(right) );
                size = min( size, AOP_SIZE(left) );
                offset = 0;

                if(picoBlaze_debug_verbose) {
//                      fprintf(stderr, "%s:%d result: %d\tleft: %d\tright: %d\n", __FILE__, __LINE__,
//                              AOP_SIZE(result), AOP_SIZE(left), AOP_SIZE(right));
//                      fprintf(stderr, "%s:%d size of operands: %d\n", __FILE__, __LINE__, size);
                }



                if ((AOP_TYPE(left) == AOP_PCODE) && (
                                (AOP(left)->aopu.pcop->type == PO_LITERAL) ||
//                              (AOP(left)->aopu.pcop->type == PO_DIR) ||   // patch 9
                                (0)))
                {
                        // add to literal operand

                        // add first bytes
                        for(i=0; i<size; i++) {
                                if (AOP_TYPE(right) == AOP_ACC) {
                                        picoBlaze_emitpcode(POC_ADDLW, picoBlaze_popGet(AOP(left),i));
                                } else {
                                        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(left),i));
                                        if(i) { // add with carry
                                                picoBlaze_emitpcode(POC_ADDFWC, picoBlaze_popGet(AOP(right),i));
                                        } else { // add without
                                                picoBlaze_emitpcode(POC_ADDFW, picoBlaze_popGet(AOP(right),i));
                                        }
                                }
                                picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),i));
                        }

                        DEBUGpicoBlaze_picoBlaze_AopTypeSign(__LINE__, NULL, right, NULL);

                        // add leftover bytes
                        if (SPEC_USIGN(getSpec(operandType(right)))) {
                                // right is unsigned
                                for(i=size; i< AOP_SIZE(result); i++) {
                                        picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result),i));
                                        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(left),i));
                                        picoBlaze_emitpcode(POC_ADDWFC, picoBlaze_popGet(AOP(result),i));
                                }

                        } else {
                                // right is signed, oh dear ...
                                for(i=size; i< AOP_SIZE(result); i++) {
                                        picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result),i));
                                        picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(right),size-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
                                        picoBlaze_emitpcode(POC_SETF, picoBlaze_popGet(AOP(result),i));
                                        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(left),i));
                                        picoBlaze_emitpcode(POC_ADDWFC, picoBlaze_popGet(AOP(result),i));
                                }

                        }
                        goto release;

                } else {
                        // add regs

			if (picoBlaze_sameRegs(AOP(left), AOP(result))
			    && (AOP_SIZE(left) < AOP_SIZE(result)))
			{
			    // extend left operand, sign-bit still intact
			    picoBlaze_addSign (result, AOP_SIZE(left), !SPEC_USIGN(getSpec(operandType(left))));
			}

                        // add first bytes
                        for(i=0; i<size; i++) {
                                if (AOP_TYPE(right) != AOP_ACC)
                                  picoBlaze_mov2w(AOP(right),i);
                                if (picoBlaze_sameRegs(AOP(left), AOP(result)))
                                {
                                        if(i) { // add with carry
                                                picoBlaze_emitpcode(POC_ADDWFC, picoBlaze_popGet(AOP(left),i));
                                        } else { // add without
                                                picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(left),i));
                                        }
                                } else { // not same
                                        if(i) { // add with carry
                                                picoBlaze_emitpcode(POC_ADDFWC, picoBlaze_popGet(AOP(left),i));
                                        } else { // add without
                                                picoBlaze_emitpcode(POC_ADDFW, picoBlaze_popGet(AOP(left),i));
                                        }
                                        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),i));
                                }
                        }

                        // add leftover bytes
                        // either left or right is too short
                        for (i=size; i < AOP_SIZE(result); i++) {
                          // get right operand into WREG
                          if (i < AOP_SIZE(right)) {
                            picoBlaze_mov2w (AOP(right), i);
			  } else {
                            // right is too short, not overwritten with result
//*//                            picoBlaze_emitpcode (POC_CLRF, picoBlaze_popCopyReg (&picoBlaze_pc_wreg));
                            if (!SPEC_USIGN(getSpec(operandType(right)))) {
                              // right operand is signed
			      // Make sure that right's sign is not yet overwritten
			      assert (!picoBlaze_sameRegs (AOP(right), AOP(result)));
                              picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(right),AOP_SIZE(right)-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
//*//                              picoBlaze_emitpcode(POC_SETF, picoBlaze_popCopyReg (&picoBlaze_pc_wreg));
                            }
                          }

                          // get left+WREG+CARRY into result
			  if (picoBlaze_sameRegs (AOP(left), AOP(result))) {
			    // left might have been extended in result above
			    picoBlaze_emitpcode (POC_ADDWFC, picoBlaze_popGet (AOP(result), i));
			  } else if (i < AOP_SIZE(left)) {
                            picoBlaze_emitpcode (POC_ADDFWC, picoBlaze_popGet (AOP(left), i));
                            picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),i));
                          } else {
                            // left is too short, not overwritten with result
                            picoBlaze_emitpcode (POC_CLRF, picoBlaze_popGet (AOP(result), i));
                            if (!SPEC_USIGN(getSpec(operandType(left)))) {
                              // left operand is signed
                              picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(left),AOP_SIZE(left)-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
                              picoBlaze_emitpcode(POC_SETF, picoBlaze_popGet (AOP(result), i));
                            }
                            picoBlaze_emitpcode (POC_ADDWFC, picoBlaze_popGet (AOP(result), i));
                          }
                        } // for i
                        goto release;
                }

        }

        assert( 0 );

release:
        picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
        picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
        picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* picoBlaze_genMinusDec :- does subtraction with decrement if possible     */
/*-----------------------------------------------------------------*/
bool picoBlaze_genMinusDec (iCode *ic)
{
    unsigned int icount ;
    unsigned int size = picoBlaze_getDataSize(IC_RESULT(ic));

    FENTRY;
    /* will try to generate an increment */
    /* if the right side is not a literal
    we cannot */
    if ((AOP_TYPE(IC_RIGHT(ic)) != AOP_LIT) ||
        (AOP_TYPE(IC_LEFT(ic)) == AOP_CRY) ||
        (AOP_TYPE(IC_RESULT(ic)) == AOP_CRY) )
        return FALSE ;

    DEBUGpicoBlaze_emitcode ("; lit val","%d",(unsigned int) ulFromVal (AOP(IC_RIGHT(ic))->aopu.aop_lit));

    /* if the literal value of the right hand side
    is greater than 4 then it is not worth it */
    if ((icount = (unsigned int) ulFromVal (AOP(IC_RIGHT(ic))->aopu.aop_lit)) > 2)
        return FALSE ;

    /* if decrement 16 bits in register */
    if (picoBlaze_sameRegs(AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic))) &&
        (size > 1) &&
        (icount == 1)) {

      if(size == 2) {
        picoBlaze_emitpcode(POC_DECF,    picoBlaze_popGet(AOP(IC_RESULT(ic)),LSB));
//*//        emitSKPC;
        picoBlaze_emitpcode(POC_DECF,    picoBlaze_popGet(AOP(IC_RESULT(ic)),MSB16));

        picoBlaze_emitcode("decf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),LSB,FALSE,FALSE));
        picoBlaze_emitcode("incfsz","%s,w",picoBlaze_aopGet(AOP(IC_RESULT(ic)),LSB,FALSE,FALSE));
        picoBlaze_emitcode(" decf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),MSB16,FALSE,FALSE));
      } else {
        /* size is 3 or 4 */
        picoBlaze_emitpcode(POC_DECF,   picoBlaze_popGet(AOP(IC_RESULT(ic)),LSB));
//*//        picoBlaze_emitpcode(POC_CLRF,   picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
        picoBlaze_emitpcode(POC_SUBWFB_D1,   picoBlaze_popGet(AOP(IC_RESULT(ic)),MSB16));
        picoBlaze_emitpcode(POC_SUBWFB_D1,   picoBlaze_popGet(AOP(IC_RESULT(ic)),MSB24));

        picoBlaze_emitcode("movlw","0xff");
        picoBlaze_emitcode("addwf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),LSB,FALSE,FALSE));

        //emitSKPNC;
        picoBlaze_emitcode("addwf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),MSB16,FALSE,FALSE));
        //emitSKPNC;
        picoBlaze_emitcode("addwf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),MSB24,FALSE,FALSE));

        if(size > 3) {
          picoBlaze_emitpcode(POC_SUBWFB_D1,   picoBlaze_popGet(AOP(IC_RESULT(ic)),MSB32));

          picoBlaze_emitcode("skpnc","");
          //emitSKPNC;
          picoBlaze_emitcode("addwf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),MSB32,FALSE,FALSE));
        }

      }

      return TRUE;

    }

    /* if the sizes are greater than 1 then we cannot */
    if (AOP_SIZE(IC_RESULT(ic)) > 1 ||
        AOP_SIZE(IC_LEFT(ic)) > 1   )
        return FALSE ;

    /* we can if the aops of the left & result match or
    if they are in registers and the registers are the
    same */
    if (picoBlaze_sameRegs(AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic)))) {

      while (icount--)
        picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(IC_RESULT(ic)),0));

        //picoBlaze_emitcode ("decf","%s,f",picoBlaze_aopGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE));

        return TRUE ;
    }

    DEBUGpicoBlaze_emitcode ("; returning"," result=%s, left=%s",
                   picoBlaze_aopGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE),
                   picoBlaze_aopGet(AOP(IC_LEFT(ic)),0,FALSE,FALSE));
    if(size==1) {

      picoBlaze_emitcode("decf","%s,w",picoBlaze_aopGet(AOP(IC_LEFT(ic)),0,FALSE,FALSE));
      picoBlaze_emitcode("movwf","%s",picoBlaze_aopGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE));

      picoBlaze_emitpcode(POC_DECFW,  picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
      picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(IC_RESULT(ic)),0));

      return TRUE;
    }

    return FALSE ;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_addSign - propogate sign bit to higher bytes                    */
/*-----------------------------------------------------------------*/
void picoBlaze_addSign(operand *result, int offset, int sign)
{
  int size = (picoBlaze_getDataSize(result) - offset);
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

  if(size > 0){
    if(sign && offset) {

      if(size == 1) {
        picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),offset));
        picoBlaze_emitpcode(POC_BTFSC,picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(result),offset-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
        picoBlaze_emitpcode(POC_SETF, picoBlaze_popGet(AOP(result),offset));
      } else {

        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0));
        picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(result),offset-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0xff));
        while(size--)
          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offset+size));

      }
    } else
      while(size--)
        picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),offset++));
  }
}

/*-----------------------------------------------------------------*/
/* picoBlaze_genMinus - generates code for subtraction                       */
/*-----------------------------------------------------------------*/
void picoBlaze_genMinus (iCode *ic)
{
  int size, offset = 0, same=0;
  unsigned long lit = 0L;

    FENTRY;
  picoBlaze_aopOp (IC_LEFT(ic),ic,FALSE);
  picoBlaze_aopOp (IC_RIGHT(ic),ic,FALSE);
  picoBlaze_aopOp (IC_RESULT(ic),ic,TRUE);

  if (AOP_TYPE(IC_RESULT(ic)) == AOP_CRY  &&
      AOP_TYPE(IC_RIGHT(ic)) == AOP_LIT) {
    operand *t = IC_RIGHT(ic);
    IC_RIGHT(ic) = IC_LEFT(ic);
    IC_LEFT(ic) = t;
  }

  DEBUGpicoBlaze_emitcode ("; ","result %s, left %s, right %s",
                   picoBlaze_AopType(AOP_TYPE(IC_RESULT(ic))),
                   picoBlaze_AopType(AOP_TYPE(IC_LEFT(ic))),
                   picoBlaze_AopType(AOP_TYPE(IC_RIGHT(ic))));

  /* special cases :- */
  /* if both left & right are in bit space */
  if (AOP_TYPE(IC_LEFT(ic)) == AOP_CRY &&
      AOP_TYPE(IC_RIGHT(ic)) == AOP_CRY) {
    picoBlaze_genPlusBits (ic);
    goto release ;
  }

  /* if I can do an decrement instead
     of subtract then GOOD for ME */
//  if (picoBlaze_genMinusDec (ic) == TRUE)
//    goto release;

  size = picoBlaze_getDataSize(IC_RESULT(ic));
  same = picoBlaze_sameRegs(AOP(IC_RIGHT(ic)), AOP(IC_RESULT(ic)));

  if(AOP(IC_RIGHT(ic))->type == AOP_LIT) {
    /* Add a literal to something else */

    lit = ulFromVal (AOP(IC_RIGHT(ic))->aopu.aop_lit);
    lit = - (long)lit;

    genAddLit ( ic,  lit);
  } else if(AOP_TYPE(IC_RIGHT(ic)) == AOP_CRY) {
    // bit subtraction

    picoBlaze_emitcode(";bitsub","right is bit: %s",picoBlaze_aopGet(AOP(IC_RIGHT(ic)),0,FALSE,FALSE));
    picoBlaze_emitcode(";bitsub","left is bit: %s",picoBlaze_aopGet(AOP(IC_LEFT(ic)),0,FALSE,FALSE));
    picoBlaze_emitcode(";bitsub","result is bit: %s",picoBlaze_aopGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE));

    /* here we are subtracting a bit from a char or int */
    if(size == 1) {
      if (picoBlaze_sameRegs(AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic))) ) {

        picoBlaze_emitpcode(POC_BTFSC , picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
        picoBlaze_emitpcode(POC_DECF ,  picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
      } else {

        if(AOP_TYPE(IC_LEFT(ic)) == AOP_ACC) {
          picoBlaze_emitpcode(POC_BTFSC , picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
          picoBlaze_emitpcode(POC_XORLW , picoBlaze_popGetLit(1));
        }else  if( (AOP_TYPE(IC_LEFT(ic)) == AOP_LIT) ) {

          lit = ulFromVal (AOP(IC_LEFT(ic))->aopu.aop_lit);

          if(AOP_TYPE(IC_RESULT(ic)) == AOP_CRY) {
            if (picoBlaze_sameRegs(AOP(IC_RIGHT(ic)), AOP(IC_RESULT(ic))) ) {
              if(lit & 1) {
                picoBlaze_emitpcode(POC_MOVLW , picoBlaze_popGetLit(1));
                picoBlaze_emitpcode(POC_XORWF , picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
              }
            }else{
              picoBlaze_emitpcode(POC_BCF ,     picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
              if(lit & 1)
                picoBlaze_emitpcode(POC_BTFSS , picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
              else
                picoBlaze_emitpcode(POC_BTFSC , picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
              picoBlaze_emitpcode(POC_BSF ,     picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
            }
            goto release;
          } else {
            picoBlaze_emitpcode(POC_MOVLW , picoBlaze_popGetLit(lit & 0xff));
            picoBlaze_emitpcode(POC_BTFSC , picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
            picoBlaze_emitpcode(POC_MOVLW , picoBlaze_popGetLit((lit-1) & 0xff));
            //picoBlaze_emitpcode(POC_MOVWF , picoBlaze_popGet(AOP(IC_RESULT(ic)),0));

          }

        } else {
          picoBlaze_mov2w(AOP(IC_LEFT(ic)),0);
          picoBlaze_emitpcode(POC_BTFSC , picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
          picoBlaze_emitpcode(POC_DECFW , picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
        }

        if(AOP_TYPE(IC_RESULT(ic)) != AOP_ACC) {

          picoBlaze_emitpcode(POC_MOVWF ,   picoBlaze_popGet(AOP(IC_RESULT(ic)),0));

        } else  {
          picoBlaze_emitpcode(POC_ANDLW , picoBlaze_popGetLit(1));
/*
          picoBlaze_emitpcode(POC_BCF ,   picoBlaze_popGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE));
          emitSKPZ;
          picoBlaze_emitpcode(POC_BSF ,   picoBlaze_popGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE));
*/
        }

      }

    }
  } else   if((AOP(IC_LEFT(ic))->type == AOP_LIT) &&
              (AOP_TYPE(IC_RIGHT(ic)) != AOP_ACC)) {

    lit = ulFromVal (AOP(IC_LEFT(ic))->aopu.aop_lit);
    DEBUGpicoBlaze_emitcode ("; left is lit","line %d result %s, left %s, right %s",__LINE__,
                   picoBlaze_AopType(AOP_TYPE(IC_RESULT(ic))),
                   picoBlaze_AopType(AOP_TYPE(IC_LEFT(ic))),
                   picoBlaze_AopType(AOP_TYPE(IC_RIGHT(ic))));


    if( (size == 1) && ((lit & 0xff) == 0) ) {
      /* res = 0 - right */
      if (picoBlaze_sameRegs(AOP(IC_RIGHT(ic)), AOP(IC_RESULT(ic))) ) {
        picoBlaze_emitpcode(POC_NEGF,  picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
      } else {
        picoBlaze_emitpcode(POC_COMFW,  picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
        picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
        picoBlaze_emitpcode(POC_INCF,   picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
      }
      goto release;
    }

    picoBlaze_mov2w(AOP(IC_RIGHT(ic)),0);
    picoBlaze_emitpcode(POC_SUBLW, picoBlaze_popGetLit(lit & 0xff));
    picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(IC_RESULT(ic)),0));


    offset = 0;
    while(--size) {
      lit >>= 8;
      offset++;
      if(same) {
        // here we have x = lit - x   for sizeof(x)>1
        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
        picoBlaze_emitpcode(POC_SUBFWB_D1,  picoBlaze_popGet(AOP(IC_RESULT(ic)),offset));
      } else {
        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
        picoBlaze_emitpcode(POC_SUBFWB_D0,  picoBlaze_popGet(AOP(IC_RIGHT(ic)),offset));
        picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(IC_RESULT(ic)),offset));
      }
    }


  } else {

    DEBUGpicoBlaze_emitcode ("; ","line %d result %s, left %s, right %s",__LINE__,
                   picoBlaze_AopType(AOP_TYPE(IC_RESULT(ic))),
                   picoBlaze_AopType(AOP_TYPE(IC_LEFT(ic))),
                   picoBlaze_AopType(AOP_TYPE(IC_RIGHT(ic))));

    if ((AOP_SIZE(IC_LEFT(ic)) < AOP_SIZE(IC_RESULT(ic)))
	    && picoBlaze_sameRegs (AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic)))) {
	// extend left in result
	picoBlaze_addSign (IC_RESULT(ic), AOP_SIZE(IC_LEFT(ic)), !SPEC_USIGN(getSpec(operandType(IC_LEFT(ic)))));
    }

    if ((AOP_SIZE(IC_RIGHT(ic)) < AOP_SIZE(IC_RESULT(ic)))
	    && picoBlaze_sameRegs (AOP(IC_RIGHT(ic)), AOP(IC_RESULT(ic)))) {
	// extend right in result---fails if left resides in result as well...
	assert ((IC_LEFT(ic) == IC_RIGHT(ic)) || !picoBlaze_sameRegs (AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic))));
	picoBlaze_addSign (IC_RESULT(ic), AOP_SIZE(IC_RIGHT(ic)), !SPEC_USIGN(getSpec(operandType(IC_RIGHT(ic)))));
    }

    if(AOP_TYPE(IC_LEFT(ic)) == AOP_ACC) {
      DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
      picoBlaze_emitpcode(POC_SUBFW, picoBlaze_popGet(AOP(IC_RIGHT(ic)),0));
      picoBlaze_emitpcode(POC_SUBLW, picoBlaze_popGetLit(0));
      if ( AOP_TYPE(IC_RESULT(ic)) != AOP_ACC)
        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
    } else {

        DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
        if(AOP_TYPE(IC_RIGHT(ic)) != AOP_ACC)
          picoBlaze_mov2w(AOP(IC_RIGHT(ic)),0);

        if (picoBlaze_sameRegs(AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic))) )
          picoBlaze_emitpcode(POC_SUBWF, picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
        else {
          if( (AOP_TYPE(IC_LEFT(ic)) == AOP_LIT) ) {
            picoBlaze_emitpcode(POC_SUBLW, picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
          } else {
            picoBlaze_emitpcode(POC_SUBFW, picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
          }
          if ( AOP_TYPE(IC_RESULT(ic)) != AOP_ACC) {
            if ( AOP_TYPE(IC_RESULT(ic)) == AOP_CRY) {
              picoBlaze_emitpcode(POC_BCF ,   picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
//*//              emitSKPZ;
              picoBlaze_emitpcode(POC_BSF ,   picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
            }else
              picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
          }
        }
    }

    /*
      picoBlaze_emitpcode(POC_MOVFW,  picoBlaze_popGet(AOP(IC_RIGHT(ic)),0,FALSE,FALSE));

      if (picoBlaze_sameRegs(AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic))) ) {
      picoBlaze_emitpcode(POC_SUBFW,  picoBlaze_popGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE));
      } else {
      picoBlaze_emitpcode(POC_SUBFW,  picoBlaze_popGet(AOP(IC_LEFT(ic)),0,FALSE,FALSE));
      picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(IC_RESULT(ic)),0,FALSE,FALSE));
      }
    */
    offset = 1;
    size--;

    while (size--) {
      if (picoBlaze_sameRegs (AOP(IC_RIGHT(ic)), AOP(IC_RESULT(ic)))) {
        picoBlaze_mov2w (AOP(IC_RESULT(ic)), offset);
      } else if (offset < AOP_SIZE(IC_RIGHT(ic)))
        picoBlaze_mov2w(AOP(IC_RIGHT(ic)),offset);
      else {
	// right operand is too short, not overwritten with result
//*//        picoBlaze_emitpcode (POC_CLRF, picoBlaze_popCopyReg (&picoBlaze_pc_wreg));
        if (!SPEC_USIGN(operandType(IC_RIGHT(ic)))) {
          // signed -- sign extend the right operand
          picoBlaze_emitpcode (POC_BTFSC, picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(IC_RIGHT(ic)),AOP_SIZE(IC_RIGHT(ic))-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
//*//          picoBlaze_emitpcode (POC_SETF, picoBlaze_popCopyReg (&picoBlaze_pc_wreg));
        }
      }
      if (picoBlaze_sameRegs(AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic)))) {
        picoBlaze_emitpcode(POC_SUBWFB_D1, picoBlaze_popGet(AOP(IC_RESULT(ic)),offset));
      } else if (offset < AOP_SIZE(IC_LEFT(ic))) {
        picoBlaze_emitpcode(POC_SUBWFB_D0,  picoBlaze_popGet(AOP(IC_LEFT(ic)),offset));
        picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(IC_RESULT(ic)),offset));
      } else {
        // left operand is too short, not overwritten with result
        picoBlaze_emitpcode (POC_CLRF, picoBlaze_popGet(AOP(IC_RESULT(ic)), offset));
        if (!SPEC_USIGN(operandType(IC_LEFT(ic)))) {
          // signed -- sign extend the left operand
          picoBlaze_emitpcode (POC_BTFSC, picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(IC_LEFT(ic)),AOP_SIZE(IC_LEFT(ic))-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
          picoBlaze_emitpcode (POC_SETF, picoBlaze_popGet(AOP(IC_RESULT(ic)), offset)); // keep CARRY/#BORROW bit intact!
        }
        picoBlaze_emitpcode(POC_SUBWFB_D1, picoBlaze_popGet(AOP(IC_RESULT(ic)),offset));
      }
      offset++;
    }
  }

  //    adjustArithmeticResult(ic);

 release:
  picoBlaze_freeAsmop(IC_LEFT(ic),NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(IC_RIGHT(ic),NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(IC_RESULT(ic),NULL,ic,TRUE);
}


/*-----------------------------------------------------------------*
 * pic_genMult8XLit_n - multiplication of two 8-bit numbers.
 *
 *
 *-----------------------------------------------------------------*/
void picoBlaze_genMult8XLit_n (operand *left,
    operand *right,
    operand *result)
{
  int lit;
  int same;
  int size = AOP_SIZE(result);
  int i;

  FENTRY;
  DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,right,result);

  if (AOP_TYPE(right) != AOP_LIT){
    fprintf(stderr,"%s %d - right operand is not a literal\n",__FILE__,__LINE__);
    exit(1);
  }

  lit = (int) ulFromVal (AOP(right)->aopu.aop_lit);
  assert( (lit >= -128) && (lit < 256) );
  picoBlaze_emitpcomment("Unrolled 8 X 8 multiplication");
  picoBlaze_emitpcomment("FIXME: the function does not support result==WREG");

  same = picoBlaze_sameRegs(AOP(left), AOP(result));
  if(same) {
    switch(lit & 0x00ff) {
      case 0:
        while (size--) {
          picoBlaze_emitpcode(POC_CLRF,  picoBlaze_popGet(AOP(result),size));
        } // while
        return;

      case 2:
        /* sign extend left in result */
        picoBlaze_addSign(result, 1, !IS_UNSIGNED(operandType(left)));
        // its faster to left shift
//*//        emitCLRC;
        picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(left),0));
        if (size > 1)
          picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),1));
        return;

      default:
        if(AOP_TYPE(left) != AOP_ACC)
          picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(left), 0));
        picoBlaze_emitpcode(POC_MULLW, picoBlaze_popGetLit(lit & 0x00ff));
//*//        picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(
//*//                &picoBlaze_pc_prodl), picoBlaze_popGet(AOP(result), 0)));
        /* Adjust result's high bytes below! */
    }
  } else {
    // operands different
    switch(lit & 0x00ff) {
      case 0:
        while (size--) {
          picoBlaze_emitpcode(POC_CLRF,  picoBlaze_popGet(AOP(result),size));
        } // while
        return;

      case 2:
        if (IS_UNSIGNED(operandType(result))) {
          for (i=1; i < size; i++) {
            picoBlaze_emitpcode(POC_CLRF,  picoBlaze_popGet(AOP(result),i));
          } // for
        } else {
          /* sign extend left to result */
          picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0));
          picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(left), 0, 7));
          picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0xff));
          for (i=1; i < size; i++) {
            picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(result),i));
          } // for
        }
//*//        emitCLRC;
        picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left), 0));
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), 0));
        if (size > 1)
          picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),1));
        return;

      default:
        if(AOP_TYPE(left) != AOP_ACC)
          picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(left), 0));
        picoBlaze_emitpcode(POC_MULLW, picoBlaze_popGetLit(lit));
//*//        picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(
//*//                &picoBlaze_pc_prodl), picoBlaze_popGet(AOP(result), 0)));
        /* Adjust result's high bytes below! */
    }
  }

  if (size > 1) {
    /* We need to fix PRODH for
     * (a) literals < 0 and
     * (b) signed register operands < 0.
     */
    //printf( "%s: lit %d, left unsigned: %d\n", __FUNCTION__, lit, SPEC_USIGN(getSpec(operandType(left))));
    if (lit < 0) {
      /* literal negative (i.e. in [-128..-1]), high byte == -1 */
      picoBlaze_mov2w(AOP(left), 0);
//*//      picoBlaze_emitpcode(POC_SUBWF, picoBlaze_popCopyReg(&picoBlaze_pc_prodh));
    }

    if (!SPEC_USIGN(getSpec(operandType(left)))) {
      /* register operand signed, determine signedness of high byte */
      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0x00ff));
      picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(left), 0, 7));
//*//      picoBlaze_emitpcode(POC_SUBWF, picoBlaze_popCopyReg(&picoBlaze_pc_prodh));
    }

//*//    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(
//*//            &picoBlaze_pc_prodh), picoBlaze_popGet(AOP(result), 1)));

    /* Need to sign-extend here. */
    picoBlaze_addSign(result, 2, !IS_UNSIGNED(operandType(result)));
  } // if
}


/*-----------------------------------------------------------------*
 * genMult8X8_n - multiplication of two 8-bit numbers.
 *
 *
 *-----------------------------------------------------------------*/
void picoBlaze_genMult8X8_n (operand *left, operand *right, operand *result)

{
  FENTRY;


  if (AOP_TYPE(right) == AOP_LIT) {
    picoBlaze_genMult8XLit_n(left,right,result);
    return;
  }

  /* cases:
     A = A x B  B = A x B
     A = B x C
     W = A x B
     W = W x B  W = B x W
     */
  /* if result == right then exchange left and right */
  if(picoBlaze_sameRegs(AOP(result), AOP(right))) {
    operand *tmp;
    tmp = left;
    left = right;
    right = tmp;
  }

  if(AOP_TYPE(left) != AOP_ACC) {
    // left is not WREG
    if(AOP_TYPE(right) != AOP_ACC) {
      picoBlaze_mov2w(AOP(left), 0);
      picoBlaze_emitpcode(POC_MULWF, picoBlaze_popGet(AOP(right), 0));
    } else {
      picoBlaze_emitpcode(POC_MULWF, picoBlaze_popGet(AOP(left), 0));
    }
  } else {
    // left is WREG, right cannot be WREG (or can?!)
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(right), 0));
  }

  /* result is in PRODL:PRODH */
  if(AOP_TYPE(result) != AOP_ACC) {
  //*//  picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(
//*//            &picoBlaze_pc_prodl), picoBlaze_popGet(AOP(result), 0)));


    if(AOP_SIZE(result)>1) {

      /* If s8 x s8 --> s16 multiplication was called for, fixup high byte.
       * (left=a1a0, right=b1b0, X1: high byte, X0: low byte)
       *
       *    a1a0 * b1b0
       * --------------
       *      a1b0 a0b0
       * a1b1 a0b1
       * ---------------
       *           a0b0  a1= 0, b1= 0 (both unsigned)
       *       -b0 a0b0  a1=-1, b1= 0 (a signed and < 0, b unsigned or >= 0)
       *       -a0 a0b0  a1= 0, b1=-1 (b signed and < 0, a unsigned or >= 0)
       *  -(a0+b0) a0b0  a1=-1, b1=-1 (a and b signed and < 0)
       *
       *  Currently, PRODH:PRODL holds a0b0 as 16 bit value; we need to
       *  subtract a0 and/or b0 from PRODH. */
      if (!IS_UNSIGNED(operandType(right))) {
        /* right operand (b1) signed and < 0, then subtract left op (a0) */
        picoBlaze_mov2w( AOP(left), 0 );
        picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(right), 0, 7));
//*//        picoBlaze_emitpcode(POC_SUBWF, picoBlaze_popCopyReg(&picoBlaze_pc_prodh));
      }

      if (!IS_UNSIGNED(getSpec(operandType(left)))) {
        /* left operand (a1) signed and < 0, then subtract right op (b0) */
        picoBlaze_mov2w( AOP(right), 0 );
        picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(left), 0, 7));
//*//        picoBlaze_emitpcode(POC_SUBWF, picoBlaze_popCopyReg(&picoBlaze_pc_prodh));
      }

//*//      picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(
//*//              &picoBlaze_pc_prodh), picoBlaze_popGet(AOP(result), 1)));

      /* Must sign-extend here. */
      picoBlaze_addSign(result, 2, !IS_UNSIGNED(operandType(left)));
    }
  } else {
//*//    picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(&picoBlaze_pc_prodl));
  }
}


/*-----------------------------------------------------------------*
 * picoBlaze_genMult8X8_8 - multiplication of two 8-bit numbers        *
 *-----------------------------------------------------------------*/
void picoBlaze_genMult8X8_8 (operand *left,
                         operand *right,
                         operand *result)
{
  FENTRY;

  if(AOP_TYPE(right) == AOP_LIT)
    picoBlaze_genMult8XLit_n(left,right,result);
  else
    picoBlaze_genMult8X8_n(left,right,result);
}










