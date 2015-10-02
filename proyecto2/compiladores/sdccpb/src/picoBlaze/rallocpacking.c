
#include "common.h"
#include "ralloc.h"


#include "pcode.h"
#include "gen.h"
#include "device.h"

#include "rallocdbg.h"
#include "rallocpacking.h"


#if 1

#define NO_packRegsForAccUse
#define NO_packRegsForSupport
#define NO_packRegsForOneuse
#define NO_cast_peep

#endif


#ifndef NO_packRegsForSupport
/*-----------------------------------------------------------------*/
/* findAssignToSym : scanning backwards looks for first assig found */
/*-----------------------------------------------------------------*/
static iCode *
findAssignToSym (operand * op, iCode * ic)
{
  iCode *dic;

  debugLog ("%s\n", __FUNCTION__);
  for (dic = ic->prev; dic; dic = dic->prev)
    {

      /* if definition by assignment */
      if (dic->op == '=' &&
          !POINTER_SET (dic) &&
          IC_RESULT (dic)->key == op->key
/*          &&  IS_TRUE_SYMOP(IC_RIGHT(dic)) */
        )
        {

          /* we are interested only if defined in far space */
          /* or in stack space in case of + & - */

          /* if assigned to a non-symbol then return
             true */
          if (!IS_SYMOP (IC_RIGHT (dic)))
            break;

          /* if the symbol is in far space then
             we should not */
          if (isOperandInFarSpace (IC_RIGHT (dic)))
            return NULL;

          /* for + & - operations make sure that
             if it is on the stack it is the same
             as one of the three operands */
          if ((ic->op == '+' || ic->op == '-') &&
              OP_SYMBOL (IC_RIGHT (dic))->onStack)
            {
              if (IC_RESULT (ic)->key != IC_RIGHT (dic)->key &&
                  IC_LEFT (ic)->key != IC_RIGHT (dic)->key &&
                  IC_RIGHT (ic)->key != IC_RIGHT (dic)->key)
                return NULL;
            }

          break;

        }

      /* if we find an usage then we cannot delete it */
      if (IC_LEFT (dic) && IC_LEFT (dic)->key == op->key)
        return NULL;

      if (IC_RIGHT (dic) && IC_RIGHT (dic)->key == op->key)
        return NULL;

      if (POINTER_SET (dic) && IC_RESULT (dic)->key == op->key)
        return NULL;
    }

  /* now make sure that the right side of dic
     is not defined between ic & dic */
  if (dic)
    {
      iCode *sic = dic->next;

      for (; sic != ic; sic = sic->next)
        if (IC_RESULT (sic) &&
            IC_RESULT (sic)->key == IC_RIGHT (dic)->key)
          return NULL;
    }

  return dic;


}
#endif


#ifndef NO_packRegsForSupport
/*-----------------------------------------------------------------*/
/* packRegsForSupport :- reduce some registers for support calls   */
/*-----------------------------------------------------------------*/
static int
packRegsForSupport (iCode * ic, eBBlock * ebp)
{
  int change = 0;

  debugLog ("%s\n", __FUNCTION__);
  /* for the left & right operand :- look to see if the
     left was assigned a true symbol in far space in that
     case replace them */
  if (IS_ITEMP (IC_LEFT (ic)) &&
      OP_SYMBOL (IC_LEFT (ic))->liveTo <= ic->seq)
    {
      iCode *dic = findAssignToSym (IC_LEFT (ic), ic);
      iCode *sic;

      if (!dic)
        goto right;

      debugAopGet ("removing left:", IC_LEFT (ic));

      /* found it we need to remove it from the
         block */
      for (sic = dic; sic != ic; sic = sic->next)
        bitVectUnSetBit (sic->rlive, IC_LEFT (ic)->key);

      IC_LEFT (ic)->operand.symOperand =
        IC_RIGHT (dic)->operand.symOperand;
      IC_LEFT (ic)->key = IC_RIGHT (dic)->operand.symOperand->key;
      remiCodeFromeBBlock (ebp, dic);
      bitVectUnSetBit(OP_SYMBOL(IC_RESULT(dic))->defs,dic->key);
      hTabDeleteItem (&iCodehTab, dic->key, dic, DELETE_ITEM, NULL);
      change++;
    }

  /* do the same for the right operand */
right:
  if (!change &&
      IS_ITEMP (IC_RIGHT (ic)) &&
      OP_SYMBOL (IC_RIGHT (ic))->liveTo <= ic->seq)
    {
      iCode *dic = findAssignToSym (IC_RIGHT (ic), ic);
      iCode *sic;

      if (!dic)
        return change;

      /* if this is a subtraction & the result
         is a true symbol in far space then don't pack */
      if (ic->op == '-' && IS_TRUE_SYMOP (IC_RESULT (dic)))
        {
          sym_link *etype = getSpec (operandType (IC_RESULT (dic)));
          if (IN_FARSPACE (SPEC_OCLS (etype)))
            return change;
        }

      debugAopGet ("removing right:", IC_RIGHT (ic));

      /* found it we need to remove it from the
         block */
      for (sic = dic; sic != ic; sic = sic->next)
        bitVectUnSetBit (sic->rlive, IC_RIGHT (ic)->key);

      IC_RIGHT (ic)->operand.symOperand =
        IC_RIGHT (dic)->operand.symOperand;
      IC_RIGHT (ic)->key = IC_RIGHT (dic)->operand.symOperand->key;

      remiCodeFromeBBlock (ebp, dic);
      bitVectUnSetBit(OP_SYMBOL(IC_RESULT(dic))->defs,dic->key);
      hTabDeleteItem (&iCodehTab, dic->key, dic, DELETE_ITEM, NULL);
      change++;
    }

  return change;
}
#endif



#ifndef NO_packRegsForOneuse
/*-----------------------------------------------------------------*/
/* packRegsForOneuse : - will reduce some registers for single Use */
/*-----------------------------------------------------------------*/
static iCode *
packRegsForOneuse (iCode * ic, operand * op, eBBlock * ebp)
{
  bitVect *uses;
  iCode *dic, *sic;

  return NULL;

  debugLog ("%s\n", __FUNCTION__);
  /* if returning a literal then do nothing */
  if (!IS_SYMOP (op))
    return NULL;

  if(OP_SYMBOL(op)->remat || OP_SYMBOL(op)->ruonly)
    return NULL;

  /* only upto 2 bytes since we cannot predict
     the usage of b, & acc */
  if (getSize (operandType (op)) > (picoBlaze_fReturnSizePic - 1)
      && ic->op != RETURN
      && ic->op != SEND
      && !POINTER_SET(ic)
      && !POINTER_GET(ic)
      )
    return NULL;

  /* this routine will mark the a symbol as used in one
     instruction use only && if the definition is local
     (ie. within the basic block) && has only one definition &&
     that definition is either a return value from a
     function or does not contain any variables in
     far space */

#if 1
  if (bitVectnBitsOn (OP_USES (op)) > 1)
    return NULL;
#endif

  /* if it has only one defintion */
  if (bitVectnBitsOn (OP_DEFS (op)) > 1)
    return NULL;                /* has more than one definition */

  /* get that definition */
  if (!(dic =
        hTabItemWithKey (iCodehTab,
                         bitVectFirstBit (OP_DEFS (op)))))
    return NULL;

  /* found the definition now check if it is local */
  if (dic->seq < ebp->fSeq ||
      dic->seq > ebp->lSeq)
    return NULL;                /* non-local */

  /* now check if it is the return from
     a function call */
  if (dic->op == CALL || dic->op == PCALL)
    {
      if (ic->op != SEND && ic->op != RETURN &&
          !POINTER_SET(ic) && !POINTER_GET(ic))
        {
          OP_SYMBOL (op)->ruonly = 1;
          return dic;
        }
      dic = dic->next;
    }
  else
    {


  /* otherwise check that the definition does
     not contain any symbols in far space */
  if (isOperandInFarSpace (IC_LEFT (dic)) ||
      isOperandInFarSpace (IC_RIGHT (dic)) ||
      IS_OP_RUONLY (IC_LEFT (ic)) ||
      IS_OP_RUONLY (IC_RIGHT (ic)))
    {
      return NULL;
    }

  /* if pointer set then make sure the pointer
     is one byte */
  if (POINTER_SET (dic) &&
      !IS_DATA_PTR (aggrToPtr (operandType (IC_RESULT (dic)), FALSE)))
    return NULL;

  if (POINTER_GET (dic) &&
      !IS_DATA_PTR (aggrToPtr (operandType (IC_LEFT (dic)), FALSE)))
    return NULL;
    }

  sic = dic;

  /* also make sure the intervenening instructions
     don't have any thing in far space */
  for (dic = dic->next; dic && dic != ic; dic = dic->next)
    {

      /* if there is an intervening function call then no */
      if (dic->op == CALL || dic->op == PCALL)
        return NULL;
      /* if pointer set then make sure the pointer
         is one byte */
      if (POINTER_SET (dic) &&
          !IS_DATA_PTR (aggrToPtr (operandType (IC_RESULT (dic)), FALSE)))
        return NULL;

      if (POINTER_GET (dic) &&
          !IS_DATA_PTR (aggrToPtr (operandType (IC_LEFT (dic)), FALSE)))
        return NULL;

      /* if address of & the result is remat then okay */
      if (dic->op == ADDRESS_OF &&
          OP_SYMBOL (IC_RESULT (dic))->remat)
        continue;

      /* if operand has size of three or more & this
         operation is a '*','/' or '%' then 'b' may
         cause a problem */
      if ((dic->op == '%' || dic->op == '/' || dic->op == '*') &&
          getSize (operandType (op)) >= 2)
        return NULL;

      /* if left or right or result is in far space */
      if (isOperandInFarSpace (IC_LEFT (dic)) ||
          isOperandInFarSpace (IC_RIGHT (dic)) ||
          isOperandInFarSpace (IC_RESULT (dic)) ||
          IS_OP_RUONLY (IC_LEFT (dic)) ||
          IS_OP_RUONLY (IC_RIGHT (dic)) ||
          IS_OP_RUONLY (IC_RESULT (dic)))
        {
          return NULL;
        }
    }

  OP_SYMBOL (op)->ruonly = 1;
  return sic;

}
#endif


/*-----------------------------------------------------------------*/
/* packForPush - hueristics to reduce iCode for pushing            */
/*-----------------------------------------------------------------*/
void
packForReceive (iCode * ic, eBBlock * ebp)
{
  iCode *dic;

  debugLog ("%s\n", __FUNCTION__);
  debugAopGet ("  result:", IC_RESULT (ic));
  debugAopGet ("  left:", IC_LEFT (ic));
  debugAopGet ("  right:", IC_RIGHT (ic));

  if (!ic->next)
    return;

  for (dic = ic->next; dic; dic = dic->next)
    {
      if (IC_LEFT (dic) && (IC_RESULT (ic)->key == IC_LEFT (dic)->key))
        debugLog ("    used on left\n");
      if (IC_RIGHT (dic) && IC_RESULT (ic)->key == IC_RIGHT (dic)->key)
        debugLog ("    used on right\n");
      if (IC_RESULT (dic) && IC_RESULT (ic)->key == IC_RESULT (dic)->key)
        debugLog ("    used on result\n");

      if ((IC_LEFT (dic) && (IC_RESULT (ic)->key == IC_LEFT (dic)->key)) ||
        (IC_RESULT (dic) && IC_RESULT (ic)->key == IC_RESULT (dic)->key))
        return;
    }

  debugLog ("  hey we can remove this unnecessary assign\n");
}
/*-----------------------------------------------------------------*/
/* packForPush - hueristics to reduce iCode for pushing            */
/*-----------------------------------------------------------------*/
void
packForPush (iCode * ic, eBBlock * ebp)
{
  iCode *dic;
  const char *iLine;

  debugLog ("%s\n", __FUNCTION__);
  if (ic->op != IPUSH || !IS_ITEMP (IC_LEFT (ic)))
    return;

  /* must have only definition & one usage */
  if (bitVectnBitsOn (OP_DEFS (IC_LEFT (ic))) != 1 ||
      bitVectnBitsOn (OP_USES (IC_LEFT (ic))) != 1)
    return;

  /* find the definition */
  if (!(dic = hTabItemWithKey (iCodehTab,
                               bitVectFirstBit (OP_DEFS (IC_LEFT (ic))))))
    return;

  /* if definition is not assignment,
   * or is not pointer (because pointer might have changed) */
  if (dic->op != '=' || POINTER_SET (dic))
    return;

  /* we must ensure that we can use the delete the assignment,
   * because the source might have been modified in between.
   * Until I know how to fix this, I'll use the adhoc fix
   * to check the liveranges */
  if((OP_LIVEFROM(IC_RIGHT(dic))==0) || (OP_LIVETO(IC_RIGHT(dic))==0))
    return;
//  debugf2("IC_RIGHT(dic): from %d to %d\n", OP_LIVEFROM(IC_RIGHT(dic)), OP_LIVETO(IC_RIGHT(dic)));



  /* we now we know that it has one & only one def & use
     and the that the definition is an assignment */
  IC_LEFT (ic) = IC_RIGHT (dic);

  iLine = printILine(dic);
  debugf("remiCodeFromeBBlock: %s\n", iLine);
  dbuf_free(iLine);

  remiCodeFromeBBlock (ebp, dic);
  bitVectUnSetBit(OP_SYMBOL(IC_RESULT(dic))->defs,dic->key);
  hTabDeleteItem (&iCodehTab, dic->key, dic, DELETE_ITEM, NULL);
}


/*-----------------------------------------------------------------*/
/* farSpacePackable - returns the packable icode for far variables */
/*-----------------------------------------------------------------*/
static iCode *
farSpacePackable (iCode * ic)
{
  iCode *dic;

  debugLog ("%s\n", __FUNCTION__);
  /* go thru till we find a definition for the
     symbol on the right */
  for (dic = ic->prev; dic; dic = dic->prev)
    {

      /* if the definition is a call then no */
      if ((dic->op == CALL || dic->op == PCALL) &&
          IC_RESULT (dic)->key == IC_RIGHT (ic)->key)
        {
          return NULL;
        }

      /* if shift by unknown amount then not */
      if ((dic->op == LEFT_OP || dic->op == RIGHT_OP) &&
          IC_RESULT (dic)->key == IC_RIGHT (ic)->key)
        return NULL;

      /* if pointer get and size > 1 */
      if (POINTER_GET (dic) &&
          getSize (aggrToPtr (operandType (IC_LEFT (dic)), FALSE)) > 1)
        return NULL;

      if (POINTER_SET (dic) &&
          getSize (aggrToPtr (operandType (IC_RESULT (dic)), FALSE)) > 1)
        return NULL;

      /* if any three is a true symbol in far space */
      if (IC_RESULT (dic) &&
          IS_TRUE_SYMOP (IC_RESULT (dic)) &&
          isOperandInFarSpace (IC_RESULT (dic)))
        return NULL;

      if (IC_RIGHT (dic) &&
          IS_TRUE_SYMOP (IC_RIGHT (dic)) &&
          isOperandInFarSpace (IC_RIGHT (dic)) &&
          !isOperandEqual (IC_RIGHT (dic), IC_RESULT (ic)))
        return NULL;

      if (IC_LEFT (dic) &&
          IS_TRUE_SYMOP (IC_LEFT (dic)) &&
          isOperandInFarSpace (IC_LEFT (dic)) &&
          !isOperandEqual (IC_LEFT (dic), IC_RESULT (ic)))
        return NULL;

      if (isOperandEqual (IC_RIGHT (ic), IC_RESULT (dic)))
        {
          if ((dic->op == LEFT_OP ||
               dic->op == RIGHT_OP ||
               dic->op == '-') &&
              IS_OP_LITERAL (IC_RIGHT (dic)))
            return NULL;
          else
            return dic;
        }
    }

  return NULL;
}

void replaceOperandWithOperand(eBBlock *ebp, iCode *ic, operand *src, iCode *dic, operand *dst);

/*-----------------------------------------------------------------*/
/* packRegsForAssign - register reduction for assignment           */
/*-----------------------------------------------------------------*/
static int
packRegsForAssign (iCode * ic, eBBlock * ebp)
{
  iCode *dic, *sic;

  debugLog ("%d\t%s\n", __LINE__, __FUNCTION__);
  debugLog ("ic->op = %s\n", picoBlaze_decodeOp( ic->op ) );
  debugAopGet ("  result:", IC_RESULT (ic));
  debugAopGet ("  left:", IC_LEFT (ic));
  debugAopGet ("  right:", IC_RIGHT (ic));

//      fprintf(stderr, "%s:%d symbol = %s\n", __FILE__, __LINE__, OP_SYMBOL( IC_RESULT(ic))->name);

        debugLog(" %d - actuall processing\n", __LINE__ );

  if (!IS_ITEMP (IC_RESULT (ic))) {
    picoBlaze_allocDirReg(IC_RESULT (ic));
    debugLog ("  %d - result is not temp\n", __LINE__);
  }

//  if(IS_VALOP(IC_RIGHT(ic)))return 0;

/* See BUGLOG0001 - VR */
#if 1
  if (!IS_ITEMP (IC_RIGHT (ic)) /*&& (!IS_PARM(IC_RESULT(ic)))*/) {
    debugLog ("  %d - not packing - right is not temp\n", __LINE__);
    picoBlaze_allocDirReg(IC_RIGHT (ic));
    return 0;
  }
#endif

  if (OP_SYMBOL (IC_RIGHT (ic))->isind ||
      OP_LIVETO (IC_RIGHT (ic)) > ic->seq)
    {
      debugLog ("  %d - not packing - right side fails \n", __LINE__);
      return 0;
    }

  /* if the true symbol is defined in far space or on stack
     then we should not since this will increase register pressure */
  if (isOperandInFarSpace (IC_RESULT (ic)))
    {
      if ((dic = farSpacePackable (ic)))
        goto pack;
      else
        return 0;

    }

  /* find the definition of iTempNN scanning backwards if we find a
     a use of the true symbol before we find the definition then
     we cannot pack */
  for (dic = ic->prev; dic; dic = dic->prev)
    {

      /* if there is a function call and this is
         a parameter & not my parameter then don't pack it */
      if ((dic->op == CALL || dic->op == PCALL) &&
          (OP_SYMBOL (IC_RESULT (ic))->_isparm &&
           !OP_SYMBOL (IC_RESULT (ic))->ismyparm))
        {
          debugLog ("  %d - \n", __LINE__);
          dic = NULL;
          break;
        }


      if (SKIP_IC2 (dic))
        continue;

        debugLog("%d\tSearching for iTempNN\n", __LINE__);

      if (IS_TRUE_SYMOP (IC_RESULT (dic)) &&
          IS_OP_VOLATILE (IC_RESULT (dic)))
        {
          debugLog ("  %d - dic is VOLATILE \n", __LINE__);
          dic = NULL;
          break;
        }

#if 1
      if( IS_SYMOP( IC_RESULT(dic)) &&
        IS_BITFIELD( OP_SYMBOL(IC_RESULT(dic))->etype ) ) {

          debugLog (" %d - result is bitfield\n", __LINE__);
          dic = NULL;
          break;
        }
#endif

      if (IS_SYMOP (IC_RESULT (dic)) &&
          IC_RESULT (dic)->key == IC_RIGHT (ic)->key)
        {
          /* A previous result was assigned to the same register - we'll our definition */
          debugLog ("  %d - dic result key == ic right key -- pointer set=%c\n",
                    __LINE__, ((POINTER_SET (dic)) ? 'Y' : 'N'));
          if (POINTER_SET (dic))
            dic = NULL;

          break;
        }

      if (IS_SYMOP (IC_RIGHT (dic)) &&
          (IC_RIGHT (dic)->key == IC_RESULT (ic)->key ||
           IC_RIGHT (dic)->key == IC_RIGHT (ic)->key))
        {
          debugLog ("  %d - dic right key == ic rightor result key\n", __LINE__);
          dic = NULL;
          break;
        }

      if (IS_SYMOP (IC_LEFT (dic)) &&
          (IC_LEFT (dic)->key == IC_RESULT (ic)->key ||
           IC_LEFT (dic)->key == IC_RIGHT (ic)->key))
        {
          debugLog ("  %d - dic left key == ic rightor result key\n", __LINE__);
          dic = NULL;
          break;
        }

      if (POINTER_SET (dic) &&
          IC_RESULT (dic)->key == IC_RESULT (ic)->key)
        {
          debugLog ("  %d - dic result key == ic result key -- pointer set=Y\n",
                    __LINE__);
          dic = NULL;
          break;
        }
    }

  if (!dic)
    return 0;                   /* did not find */

#if 1
        /* This code is taken from the hc08 port. Do not know
         * if it fits for picoBlaze, but I leave it here just in case */

        /* if assignment then check that right is not a bit */
        if (ASSIGNMENT (ic) && !POINTER_SET (ic)) {
          sym_link *etype = operandType (IC_RESULT (dic));

                if (IS_BITFIELD (etype)) {
                        /* if result is a bit too then it's ok */
                        etype = operandType (IC_RESULT (ic));
                        if (!IS_BITFIELD (etype)) {
                                debugLog(" %d bitfields\n");
                          return 0;
                        }
                }
        }
#endif

  /* if the result is on stack or iaccess then it must be
     the same atleast one of the operands */
  if (OP_SYMBOL (IC_RESULT (ic))->onStack ||
      OP_SYMBOL (IC_RESULT (ic))->iaccess)
    {
      /* the operation has only one symbol
         operator then we can pack */
      if ((IC_LEFT (dic) && !IS_SYMOP (IC_LEFT (dic))) ||
          (IC_RIGHT (dic) && !IS_SYMOP (IC_RIGHT (dic))))
        goto pack;

      if (!((IC_LEFT (dic) &&
             IC_RESULT (ic)->key == IC_LEFT (dic)->key) ||
            (IC_RIGHT (dic) &&
             IC_RESULT (ic)->key == IC_RIGHT (dic)->key)))
        return 0;
    }
pack:
  debugLog ("  packing. removing %s\n", OP_SYMBOL (IC_RIGHT (ic))->rname);
  debugLog ("  replacing with %s\n", OP_SYMBOL (IC_RESULT (dic))->rname);
  /* found the definition */
  /* replace the result with the result of */
  /* this assignment and remove this assignment */


    bitVectUnSetBit(OP_SYMBOL(IC_RESULT(dic))->defs,dic->key);
    IC_RESULT (dic) = IC_RESULT (ic);

    if (IS_ITEMP (IC_RESULT (dic)) && OP_SYMBOL (IC_RESULT (dic))->liveFrom > dic->seq)
      {
        OP_SYMBOL (IC_RESULT (dic))->liveFrom = dic->seq;
      }
    /* delete from liverange table also
       delete from all the points inbetween and the new
       one */
    for (sic = dic; sic != ic; sic = sic->next)
      {
        bitVectUnSetBit (sic->rlive, IC_RESULT (ic)->key);
        if (IS_ITEMP (IC_RESULT (dic)))
          bitVectSetBit (sic->rlive, IC_RESULT (dic)->key);
      }

    remiCodeFromeBBlock (ebp, ic);
    bitVectUnSetBit(OP_SYMBOL(IC_RESULT(ic))->defs,ic->key);

    debugLog("  %d\n", __LINE__ );
    hTabDeleteItem (&iCodehTab, ic->key, ic, DELETE_ITEM, NULL);
    OP_DEFS (IC_RESULT (dic)) = bitVectSetBit (OP_DEFS (IC_RESULT (dic)), dic->key);
    return 1;
}





/*-----------------------------------------------------------------*/
/* isBitwiseOptimizable - requirements of JEAN LOUIS VERN          */
/*-----------------------------------------------------------------*/
static bool
isBitwiseOptimizable (iCode * ic)
{
  sym_link *ltype = getSpec (operandType (IC_LEFT (ic)));
  sym_link *rtype = getSpec (operandType (IC_RIGHT (ic)));

  debugLog ("%s\n", __FUNCTION__);
  /* bitwise operations are considered optimizable
     under the following conditions (Jean-Louis VERN)

     x & lit
     bit & bit
     bit & x
     bit ^ bit
     bit ^ x
     x   ^ lit
     x   | lit
     bit | bit
     bit | x
   */
  if (IS_LITERAL (rtype) ||
      (IS_BITVAR (ltype) && IN_BITSPACE (SPEC_OCLS (ltype))))
    return TRUE;
  else
    return FALSE;
}




/*--------------------------------------------------------------------*/
/* picoBlaze_packRegisters - does some transformations to reduce          */
/*                   register pressure                                */
/*                                                                    */
/*--------------------------------------------------------------------*/
static void
picoBlaze_packRegisters (eBBlock * ebp)
{
  iCode *ic;
  int change = 0;

  debugLog ("%s\n", __FUNCTION__);

  while (1) {

    change = 0;

    /* look for assignments of the form */
    /* iTempNN = TRueSym (someoperation) SomeOperand */
    /*       ....                       */
    /* TrueSym := iTempNN:1             */
    for (ic = ebp->sch; ic; ic = ic->next)
      {
//              debugLog("%d\n", __LINE__);
        /* find assignment of the form TrueSym := iTempNN:1 */
        if ( (ic->op == '=') && !POINTER_SET (ic) ) // patch 11
          change += packRegsForAssign (ic, ebp);
        /* debug stuff */
        if (ic->op == '=')
          {
            if (POINTER_SET (ic))
              debugLog ("pointer is set\n");
            debugAopGet ("  result:", IC_RESULT (ic));
            debugAopGet ("  left:", IC_LEFT (ic));
            debugAopGet ("  right:", IC_RIGHT (ic));
          }

      }

    if (!change)
      break;
  }

  for (ic = ebp->sch; ic; ic = ic->next) {

    if(IS_SYMOP ( IC_LEFT(ic))) {
      sym_link *etype = getSpec (operandType (IC_LEFT (ic)));

      debugAopGet ("x  left:", IC_LEFT (ic));

      if(IS_CODEPTR(OP_SYMBOL(IC_LEFT(ic))->type))

      debugLog ("    is a pointer\n");

      if(IS_PTR(OP_SYMBOL(IC_LEFT(ic))->type))
        debugLog ("    is a ptr\n");

      if(IS_OP_VOLATILE(IC_LEFT(ic)))
        debugLog ("    is volatile\n");

      isData(etype);

        if(IS_OP_VOLATILE(IC_LEFT(ic))) {
            debugLog ("  %d - left is not temp, allocating\n", __LINE__);
            picoBlaze_allocDirReg(IC_LEFT (ic));
        }

      printSymType("c  ", OP_SYMBOL(IC_LEFT(ic))->type);
    }

    if(IS_SYMOP ( IC_RIGHT(ic))) {
      debugAopGet ("  right:", IC_RIGHT (ic));
      printSymType("    ", OP_SYMBOL(IC_RIGHT(ic))->type);
    }

    if(IS_SYMOP ( IC_RESULT(ic))) {
      debugAopGet ("  result:", IC_RESULT (ic));
      printSymType("     ", OP_SYMBOL(IC_RESULT(ic))->type);
    }

    if(IS_TRUE_SYMOP ( IC_RIGHT(ic))) {
      debugAopGet ("  right:", IC_RIGHT (ic));
      printSymType("    ", OP_SYMBOL(IC_RIGHT(ic))->type);
//      picoBlaze_allocDirReg(IC_RIGHT(ic));
    }

    if(IS_TRUE_SYMOP ( IC_RESULT(ic))) {
      debugAopGet ("  result:", IC_RESULT (ic));
      printSymType("     ", OP_SYMBOL(IC_RESULT(ic))->type);
//      picoBlaze_allocDirReg(IC_RESULT(ic));
    }


    if (POINTER_SET (ic))
      debugLog ("  %d - Pointer set\n", __LINE__);

      /* Look for two subsequent iCodes with */
      /*   iTemp := _c;         */
      /*   _c = iTemp & op;     */
      /* and replace them by    */
      /*   iTemp := _c;         */
      /*   _c = _c & op;        */
      if ((ic->op == BITWISEAND || ic->op == '|' || ic->op == '^')
        && ic->prev
        && ic->prev->op == '='
        && IS_ITEMP (IC_LEFT (ic))
        && IC_LEFT (ic) == IC_RESULT (ic->prev)
        && isOperandEqual (IC_RESULT(ic), IC_RIGHT(ic->prev)))
        {
          iCode* ic_prev = ic->prev;
          symbol* prev_result_sym = OP_SYMBOL (IC_RESULT (ic_prev));

          ReplaceOpWithCheaperOp (&IC_LEFT (ic), IC_RESULT (ic));
          if (IC_RESULT (ic_prev) != IC_RIGHT (ic)) {
            bitVectUnSetBit (OP_USES (IC_RESULT (ic_prev)), ic->key);
            if (/*IS_ITEMP (IC_RESULT (ic_prev)) && */
              prev_result_sym->liveTo == ic->seq)
            {
              prev_result_sym->liveTo = ic_prev->seq;
            }
          }
          bitVectSetBit (OP_USES (IC_RESULT (ic)), ic->key);

          bitVectSetBit (ic->rlive, IC_RESULT (ic)->key);

          if (bitVectIsZero (OP_USES (IC_RESULT (ic_prev)))) {
            bitVectUnSetBit (ic->rlive, IC_RESULT (ic)->key);
            bitVectUnSetBit (OP_DEFS (IC_RESULT (ic_prev)), ic_prev->key);
            remiCodeFromeBBlock (ebp, ic_prev);
            hTabDeleteItem (&iCodehTab, ic_prev->key, ic_prev, DELETE_ITEM, NULL);
          }
        }

    /* if this is an itemp & result of a address of a true sym
       then mark this as rematerialisable   */
    if (ic->op == ADDRESS_OF &&
        IS_ITEMP (IC_RESULT (ic)) &&
        IS_TRUE_SYMOP (IC_LEFT (ic)) &&
        bitVectnBitsOn (OP_DEFS (IC_RESULT (ic))) == 1 &&
        !OP_SYMBOL (IC_LEFT (ic))->onStack)
      {

        debugLog ("  %d - %s. result is rematerializable\n", __LINE__,__FUNCTION__);

        OP_SYMBOL (IC_RESULT (ic))->remat = 1;
        OP_SYMBOL (IC_RESULT (ic))->rematiCode = ic;
        SPIL_LOC (IC_RESULT (ic)) = NULL;

      }

    /* if straight assignment then carry remat flag if
       this is the only definition */
    if (ic->op == '=' &&
        !POINTER_SET (ic) &&
        IS_SYMOP (IC_RIGHT (ic)) &&
        OP_SYMBOL (IC_RIGHT (ic))->remat &&
        bitVectnBitsOn (OP_SYMBOL (IC_RESULT (ic))->defs) <= 1)
      {
        debugLog ("  %d - %s. straight rematerializable\n", __LINE__,__FUNCTION__);

        OP_SYMBOL (IC_RESULT (ic))->remat =
          OP_SYMBOL (IC_RIGHT (ic))->remat;
        OP_SYMBOL (IC_RESULT (ic))->rematiCode =
          OP_SYMBOL (IC_RIGHT (ic))->rematiCode;
      }

    /* if this is a +/- operation with a rematerizable
       then mark this as rematerializable as well */
    if ((ic->op == '+' || ic->op == '-') &&
        (IS_SYMOP (IC_LEFT (ic)) &&
         IS_ITEMP (IC_RESULT (ic)) &&
         OP_SYMBOL (IC_LEFT (ic))->remat &&
         bitVectnBitsOn (OP_DEFS (IC_RESULT (ic))) == 1 &&
         IS_OP_LITERAL (IC_RIGHT (ic))))
      {
        debugLog ("  %d - %s. rematerializable because op is +/-\n", __LINE__,__FUNCTION__);
        //int i =
        operandLitValue (IC_RIGHT (ic));
        OP_SYMBOL (IC_RESULT (ic))->remat = 1;
        OP_SYMBOL (IC_RESULT (ic))->rematiCode = ic;
        SPIL_LOC (IC_RESULT (ic)) = NULL;
      }

    /* mark the pointer usages */
    if (POINTER_SET (ic) && IS_SYMOP (IC_RESULT (ic)))
      {
        OP_SYMBOL (IC_RESULT (ic))->uptr = 1;
        debugLog ("  marking as a pointer (set) =>");
        debugAopGet ("  result:", IC_RESULT (ic));

      }

    if (POINTER_GET (ic))
      {
        if(IS_SYMOP(IC_LEFT(ic))) {
          OP_SYMBOL (IC_LEFT (ic))->uptr = 1;
          debugLog ("  marking as a pointer (get) =>");
          debugAopGet ("  left:", IC_LEFT (ic));
        }

        if(getenv("OPTIMIZE_BITFIELD_POINTER_GET")) {
          if(IS_ITEMP(IC_LEFT(ic)) && IS_BITFIELD(OP_SYM_ETYPE(IC_LEFT(ic)))) {
            iCode *dic = ic->prev;

            fprintf(stderr, "%s:%d might give opt POINTER_GET && IS_BITFIELD(IC_LEFT)\n", __FILE__, __LINE__);

            if(dic && dic->op == '='
              && isOperandEqual(IC_RESULT(dic), IC_LEFT(ic))) {

                fprintf(stderr, "%s:%d && prev is '=' && prev->result == ic->left\n", __FILE__, __LINE__);


                /* replace prev->left with ic->left */
                IC_LEFT(ic) = IC_RIGHT(dic);
                IC_RIGHT(ic->prev) = NULL;

                /* remove ic->prev iCode (assignment) */
                remiCodeFromeBBlock (ebp, dic);
                bitVectUnSetBit(OP_SYMBOL(IC_RESULT(dic))->defs,ic->key);


                hTabDeleteItem (&iCodehTab, dic->key, dic, DELETE_ITEM, NULL);
            }
          }
        }
      }

        //debugLog("  %d   %s\n", __LINE__, __FUNCTION__);

    if (!SKIP_IC2 (ic))
      {
        //debugLog("  %d   %s\n", __LINE__, __FUNCTION__ );
        /* if we are using a symbol on the stack
           then we should say picoBlaze_ptrRegReq */
        if (ic->op == IFX && IS_SYMOP (IC_COND (ic)))
          picoBlaze_ptrRegReq += ((OP_SYMBOL (IC_COND (ic))->onStack ||
                               OP_SYMBOL (IC_COND (ic))->iaccess) ? 1 : 0);
        else if (ic->op == JUMPTABLE && IS_SYMOP (IC_JTCOND (ic)))
          picoBlaze_ptrRegReq += ((OP_SYMBOL (IC_JTCOND (ic))->onStack ||
                               OP_SYMBOL (IC_JTCOND (ic))->iaccess) ? 1 : 0);
        else
          {

                //debugLog("   %d   %s\n", __LINE__, __FUNCTION__ );
            if (IS_SYMOP (IC_LEFT (ic)))
              picoBlaze_ptrRegReq += ((OP_SYMBOL (IC_LEFT (ic))->onStack ||
                                   OP_SYMBOL (IC_LEFT (ic))->iaccess) ? 1 : 0);
            if (IS_SYMOP (IC_RIGHT (ic)))
              picoBlaze_ptrRegReq += ((OP_SYMBOL (IC_RIGHT (ic))->onStack ||
                                   OP_SYMBOL (IC_RIGHT (ic))->iaccess) ? 1 : 0);
            if (IS_SYMOP (IC_RESULT (ic)))
              picoBlaze_ptrRegReq += ((OP_SYMBOL (IC_RESULT (ic))->onStack ||
                                   OP_SYMBOL (IC_RESULT (ic))->iaccess) ? 1 : 0);
          }

        debugLog ("  %d - pointer reg req = %d\n", __LINE__,picoBlaze_ptrRegReq);

      }

    /* if the condition of an if instruction
       is defined in the previous instruction then
       mark the itemp as a conditional */
    if ((IS_CONDITIONAL (ic) ||
         ((ic->op == BITWISEAND ||
           ic->op == '|' ||
           ic->op == '^') &&
          isBitwiseOptimizable (ic))) &&
        ic->next && ic->next->op == IFX &&
        isOperandEqual (IC_RESULT (ic), IC_COND (ic->next)) &&
        OP_SYMBOL (IC_RESULT (ic))->liveTo <= ic->next->seq)
      {

        debugLog ("  %d\n", __LINE__);
        OP_SYMBOL (IC_RESULT (ic))->regType = REG_CND;
        continue;
      }

        debugLog(" %d\n", __LINE__);

#ifndef NO_packRegsForSupport
    /* reduce for support function calls */
    if (ic->supportRtn || ic->op == '+' || ic->op == '-')
      packRegsForSupport (ic, ebp);
#endif

    /* if a parameter is passed, it's in W, so we may not
       need to place a copy in a register */
    if (ic->op == RECEIVE)
      packForReceive (ic, ebp);

#ifndef NO_packRegsForOneuse
    /* some cases the redundant moves can
       can be eliminated for return statements */
    if ((ic->op == RETURN || ic->op == SEND) &&
        !isOperandInFarSpace (IC_LEFT (ic)) &&
        !options.model)
      packRegsForOneuse (ic, IC_LEFT (ic), ebp);
#endif

#ifndef NO_packRegsForOneuse
    /* if pointer set & left has a size more than
       one and right is not in far space */
    if (POINTER_SET (ic) &&
        !isOperandInFarSpace (IC_RIGHT (ic)) &&
        !OP_SYMBOL (IC_RESULT (ic))->remat &&
        !IS_OP_RUONLY (IC_RIGHT (ic)) &&
        getSize (aggrToPtr (operandType (IC_RESULT (ic)), FALSE)) > 1)

      packRegsForOneuse (ic, IC_RESULT (ic), ebp);
#endif

#ifndef NO_packRegsForOneuse
    /* if pointer get */
    if (POINTER_GET (ic) &&
        !isOperandInFarSpace (IC_RESULT (ic)) &&
        !OP_SYMBOL (IC_LEFT (ic))->remat &&
        !IS_OP_RUONLY (IC_RESULT (ic)) &&
        getSize (aggrToPtr (operandType (IC_LEFT (ic)), FALSE)) > 1)

      packRegsForOneuse (ic, IC_LEFT (ic), ebp);
      debugLog("%d - return from packRegsForOneuse\n", __LINE__);
#endif

#ifndef NO_cast_peep
    /* if this is cast for intergral promotion then
       check if only use of  the definition of the
       operand being casted/ if yes then replace
       the result of that arithmetic operation with
       this result and get rid of the cast */
    if (ic->op == CAST) {

      sym_link *fromType = operandType (IC_RIGHT (ic));
      sym_link *toType = operandType (IC_LEFT (ic));

      debugLog ("  %d - casting\n", __LINE__);

      if (IS_INTEGRAL (fromType) && IS_INTEGRAL (toType) &&
          getSize (fromType) != getSize (toType)) {


        iCode *dic = packRegsForOneuse (ic, IC_RIGHT (ic), ebp);
        if (dic) {

          if (IS_ARITHMETIC_OP (dic)) {
                    debugLog("   %d   %s\n", __LINE__, __FUNCTION__ );

            bitVectUnSetBit(OP_SYMBOL(IC_RESULT(dic))->defs,dic->key);
            IC_RESULT (dic) = IC_RESULT (ic);
            remiCodeFromeBBlock (ebp, ic);
            bitVectUnSetBit(OP_SYMBOL(IC_RESULT(ic))->defs,ic->key);
            hTabDeleteItem (&iCodehTab, ic->key, ic, DELETE_ITEM, NULL);
            OP_DEFS (IC_RESULT (dic)) = bitVectSetBit (OP_DEFS (IC_RESULT (dic)), dic->key);
            ic = ic->prev;
          }  else

            OP_SYMBOL (IC_RIGHT (ic))->ruonly = 0;
        }
      } else {

        /* if the type from and type to are the same
           then if this is the only use then packit */
        if (compareType (operandType (IC_RIGHT (ic)),
                         operandType (IC_LEFT (ic))) == 1) {

          iCode *dic = packRegsForOneuse (ic, IC_RIGHT (ic), ebp);
          if (dic) {

                   debugLog(" %d\n", __LINE__);

            bitVectUnSetBit(OP_SYMBOL(IC_RESULT(dic))->defs,dic->key);
            IC_RESULT (dic) = IC_RESULT (ic);
            bitVectUnSetBit(OP_SYMBOL(IC_RESULT(ic))->defs,ic->key);
            remiCodeFromeBBlock (ebp, ic);
            hTabDeleteItem (&iCodehTab, ic->key, ic, DELETE_ITEM, NULL);
            OP_DEFS (IC_RESULT (dic)) = bitVectSetBit (OP_DEFS (IC_RESULT (dic)), dic->key);
            ic = ic->prev;
          }
        }
      }
    }
#endif

#if 1
    /* there are some problems with packing variables
     * it seems that the live range estimator doesn't
     * estimate correctly the liveranges of some symbols */

    /* pack for PUSH
       iTempNN := (some variable in farspace) V1
       push iTempNN ;
       -------------
       push V1
    */
    if (ic->op == IPUSH)
      {
        packForPush (ic, ebp);
      }
#endif

#ifndef NO_packRegsForAccUse
    /* pack registers for accumulator use, when the
       result of an arithmetic or bit wise operation
       has only one use, that use is immediately following
       the defintion and the using iCode has only one
       operand or has two operands but one is literal &
       the result of that operation is not on stack then
       we can leave the result of this operation in acc:b
       combination */
    if ((IS_ARITHMETIC_OP (ic)

         || IS_BITWISE_OP (ic)

         || ic->op == LEFT_OP || ic->op == RIGHT_OP

         ) &&
        IS_ITEMP (IC_RESULT (ic)) &&
        getSize (operandType (IC_RESULT (ic))) <= 1)

      packRegsForAccUse (ic);
#endif

  }
}


#ifndef NO_packRegsForAccUse

/*-----------------------------------------------------------------*/
/* packRegsForAccUse - pack registers for acc use                  */
/*-----------------------------------------------------------------*/
static void
packRegsForAccUse (iCode * ic)
{
  iCode *uic;

  debugLog ("%s\n", __FUNCTION__);

  /* if this is an aggregate, e.g. a one byte char array */
  if (IS_AGGREGATE(operandType(IC_RESULT(ic)))) {
    return;
  }
  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);

  /* if + or - then it has to be one byte result */
  if ((ic->op == '+' || ic->op == '-')
      && getSize (operandType (IC_RESULT (ic))) > 1)
    return;

  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  /* if shift operation make sure right side is not a literal */
  if (ic->op == RIGHT_OP &&
      (isOperandLiteral (IC_RIGHT (ic)) ||
       getSize (operandType (IC_RESULT (ic))) > 1))
    return;

  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  if (ic->op == LEFT_OP &&
      (isOperandLiteral (IC_RIGHT (ic)) ||
       getSize (operandType (IC_RESULT (ic))) > 1))
    return;

  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  if (IS_BITWISE_OP (ic) &&
      getSize (operandType (IC_RESULT (ic))) > 1)
    return;


  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  /* has only one definition */
  if (bitVectnBitsOn (OP_DEFS (IC_RESULT (ic))) > 1)
    return;

  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  /* has only one use */
  if (bitVectnBitsOn (OP_USES (IC_RESULT (ic))) > 1)
    return;

  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  /* and the usage immediately follows this iCode */
  if (!(uic = hTabItemWithKey (iCodehTab,
                               bitVectFirstBit (OP_USES (IC_RESULT (ic))))))
    return;

  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  if (ic->next != uic)
    return;

  /* if it is a conditional branch then we definitely can */
  if (uic->op == IFX)
    goto accuse;

  if (uic->op == JUMPTABLE)
    return;

  /* if the usage is not is an assignment
     or an arithmetic / bitwise / shift operation then not */
  if (POINTER_SET (uic) &&
      getSize (aggrToPtr (operandType (IC_RESULT (uic)), FALSE)) > 1)
    return;

  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  if (uic->op != '=' &&
      !IS_ARITHMETIC_OP (uic) &&
      !IS_BITWISE_OP (uic) &&
      uic->op != LEFT_OP &&
      uic->op != RIGHT_OP)
    return;

  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  /* if used in ^ operation then make sure right is not a
     literl */
  if (uic->op == '^' && isOperandLiteral (IC_RIGHT (uic)))
    return;

  /* if shift operation make sure right side is not a literal */
  if (uic->op == RIGHT_OP &&
      (isOperandLiteral (IC_RIGHT (uic)) ||
       getSize (operandType (IC_RESULT (uic))) > 1))
    return;

  if (uic->op == LEFT_OP &&
      (isOperandLiteral (IC_RIGHT (uic)) ||
       getSize (operandType (IC_RESULT (uic))) > 1))
    return;

  /* make sure that the result of this icode is not on the
     stack, since acc is used to compute stack offset */
  if (IS_TRUE_SYMOP (IC_RESULT (uic)) &&
      OP_SYMBOL (IC_RESULT (uic))->onStack)
    return;

  /* if either one of them in far space then we cannot */
  if ((IS_TRUE_SYMOP (IC_LEFT (uic)) &&
       isOperandInFarSpace (IC_LEFT (uic))) ||
      (IS_TRUE_SYMOP (IC_RIGHT (uic)) &&
       isOperandInFarSpace (IC_RIGHT (uic))))
    return;

  /* if the usage has only one operand then we can */
  if (IC_LEFT (uic) == NULL ||
      IC_RIGHT (uic) == NULL)
    goto accuse;

  /* make sure this is on the left side if not
     a '+' since '+' is commutative */
  if (ic->op != '+' &&
      IC_LEFT (uic)->key != IC_RESULT (ic)->key)
    return;

#if 1
  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  /* if one of them is a literal then we can */
  if ( ((IC_LEFT (uic) && IS_OP_LITERAL (IC_LEFT (uic))) ||
        (IC_RIGHT (uic) && IS_OP_LITERAL (IC_RIGHT (uic))))  &&
       (getSize (operandType (IC_RESULT (uic))) <= 1))
    {
      OP_SYMBOL (IC_RESULT (ic))->accuse = 1;
      return;
    }
#endif

  debugLog ("  %s:%d\n", __FUNCTION__,__LINE__);
  /* if the other one is not on stack then we can */
  if (IC_LEFT (uic)->key == IC_RESULT (ic)->key &&
      (IS_ITEMP (IC_RIGHT (uic)) ||
       (IS_TRUE_SYMOP (IC_RIGHT (uic)) &&
        !OP_SYMBOL (IC_RIGHT (uic))->onStack)))
    goto accuse;

  if (IC_RIGHT (uic)->key == IC_RESULT (ic)->key &&
      (IS_ITEMP (IC_LEFT (uic)) ||
       (IS_TRUE_SYMOP (IC_LEFT (uic)) &&
        !OP_SYMBOL (IC_LEFT (uic))->onStack)))
    goto accuse;

  return;

accuse:
  debugLog ("%s - Yes we are using the accumulator\n", __FUNCTION__);
  OP_SYMBOL (IC_RESULT (ic))->accuse = 1;


}
#endif

