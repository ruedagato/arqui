// simple shortcut function to mark register as free

DEFSETFUNC (markRegFree)
{
  ((regs *)item)->isFree = 1;
//  ((regs *)item)->wasUsed = 0;

  return 0;
}

DEFSETFUNC (picoBlaze_deallocReg)
{
  fprintf(stderr,"deallocting register %s\n",((regs *)item)->name);
  ((regs *)item)->isFree = 1;
  ((regs *)item)->wasUsed = 0;

  return 0;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_deallocStackSpil - this will set the stack pointer back         */
/*-----------------------------------------------------------------*/
DEFSETFUNC (picoBlaze_deallocStackSpil)
{
  symbol *sym = item;

  debugLog ("%s\n", __FUNCTION__);
  deallocLocal (sym);
  return 0;
}

/*-----------------------------------------------------------------*/
/* isFree - will return 1 if the a free spil location is found     */
/*-----------------------------------------------------------------*/
static
DEFSETFUNC (isFree)
{
  symbol *sym = item;
  V_ARG (symbol **, sloc);
  V_ARG (symbol *, fsym);

  debugLog ("%s\n", __FUNCTION__);
  /* if already found */
  if (*sloc)
    return 0;

  /* if it is free && and the itmp assigned to
     this does not have any overlapping live ranges
     with the one currently being assigned and
     the size can be accomodated  */
  if (sym->isFree &&
      noOverLap (sym->usl.itmpStack, fsym) &&
      getSize (sym->type) >= getSize (fsym->type))
    {
      *sloc = sym;
      return 1;
    }

  return 0;
}


/*-----------------------------------------------------------------*/
/* freeAllRegs - mark all registers as free                        */
/*-----------------------------------------------------------------*/
void picoBlaze_freeAllRegs ()
{
  debugLog ("%s\n", __FUNCTION__);

  applyToSet(picoBlaze_dynAllocRegs,markRegFree);
}



/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
void picoBlaze_deallocateAllRegs ()
{
  debugLog ("%s\n", __FUNCTION__);

  applyToSet(picoBlaze_dynAllocRegs,picoBlaze_deallocReg);
}


/*-----------------------------------------------------------------*/
/* regname2key - compute hash key from name of a register          */
/*-----------------------------------------------------------------*/
static int regname2key(char const *name)
{
  int key = 0;

  if(!name)
    return 0;

  while(*name) {
    key += (*name++) + 1;
  }

  return ( (key + (key >> 4) + (key>>8)) & 0x3f);
}

/*------------------------------------------------------------------*/
/* verifyRegsAssigned - make sure an iTemp is properly initialized; */
/* it should either have registers or have beed spilled. Otherwise, */
/* there was an uninitialized variable, so just spill this to get   */
/* the operand in a valid state.                                    */
/*------------------------------------------------------------------*/
static void
verifyRegsAssigned (operand *op, iCode * ic)
{
  symbol * sym;

  if (!op) return;
  if (!IS_ITEMP (op)) return;

  sym = OP_SYMBOL (op);
  if (sym->isspilt) return;
  if (!sym->nRegs) return;
  if (sym->regs[0]) return;

  werrorfl (ic->filename, ic->lineno, W_LOCAL_NOINIT,
            sym->prereqv ? sym->prereqv->name : sym->name);
  spillThis (sym);
}