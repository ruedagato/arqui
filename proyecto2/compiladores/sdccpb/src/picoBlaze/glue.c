/*-------------------------------------------------------------------------

  glue.c - glues everything we have done together into one file.
                Written By -  Sandeep Dutta . sandeep.dutta@usa.net (1998)

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

#include "../common.h"
#include <time.h>
#include "ralloc.h"
#include "pcode.h"
#include "newalloc.h"
#include "gen.h"
#include "device.h"
#include "main.h"
#include "dbuf_string.h"
#include <string.h>


extern symbol *interrupts[256];
void picoBlaze_printIval (symbol * sym, sym_link * type, initList * ilist, char ptype, void *p);
extern int noAlloc;
extern set *publics;
extern set *externs;
extern unsigned maxInterrupts;
extern symbol *mainf;
extern char *VersionString;
extern struct dbuf_s *codeOutBuf;
extern char *iComments1;
extern char *iComments2;

extern int picoBlaze_initsfpnt;
extern unsigned long pFile_isize;

extern unsigned long picoBlaze_countInstructions();
set *picoBlaze_localFunctions = NULL;
set *picoBlaze_rel_idataSymSet=NULL;
set *picoBlaze_fix_idataSymSet=NULL;

extern DEFSETFUNC (closeTmpFiles);
extern DEFSETFUNC (rmTmpFiles);

extern void picoBlaze_AnalyzeBanking (void);
extern void picoBlaze_writeUsedRegs(FILE *);

extern void initialComments (FILE * afile);
extern void printPublics (FILE * afile);

void  picoBlaze_pCodeInitRegisters(void);
pCodeOp *picoBlaze_popCopyReg(pCodeOpReg *pc);
extern void picoBlaze_pCodeConstString(char *name, char *value, unsigned length);


/*-----------------------------------------------------------------*/
/* aopLiteral - string from a literal value                        */
/*-----------------------------------------------------------------*/
unsigned int picoBlazeaopLiteral (value *val, int offset)
{
  union {
    float f;
    unsigned char c[4];
  } fl;

  /* if it is a float then it gets tricky */
  /* otherwise it is fairly simple */
  if (!(IS_FLOAT(val->type) || IS_FIXED(val->type))) {
    unsigned long v = ulFromVal (val);

    return ( (v >> (offset * 8)) & 0xff);  /* just select the byte we are interested in */
  }

  if(IS_FIXED16X16(val->type)) {
    unsigned long v = (unsigned long)fixed16x16FromDouble( floatFromVal( val ) );

    return ( (v >> (offset * 8)) & 0xff);
  }

  /* it is type float */
  fl.f = (float) floatFromVal(val);
#ifdef WORDS_BIGENDIAN
  return fl.c[3-offset];
#else
  return fl.c[offset];
#endif

}

iCode *tic;
symbol *nsym;
char tbuffer[512], *picoBlaze_tbuf=tbuffer;;


/*-----------------------------------------------------------------*/
/* emitRegularMap - emit code for maps with no special cases       */
/*-----------------------------------------------------------------*/
static void
picoBlazeemitRegularMap (memmap * map, bool addPublics, bool arFlag)
{
  symbol *sym;
//  int i, size, bitvars = 0;;

//      fprintf(stderr, "%s:%d map name= %s\n", __FUNCTION__, __LINE__, map->sname);

        if(addPublics)
                dbuf_printf (&map->oBuf, ";\t.area\t%s\n", map->sname);
                /* print the area name */

        for (sym = setFirstItem (map->syms); sym; sym = setNextItem (map->syms)) {

                /* if extern then add to externs */
                if (IS_EXTERN (sym->etype)) {
                        /* reduce overhead while linking by not declaring
                         * extern unused external functions (usually declared
                         * in header files) */
                        if(IS_FUNC(sym->type) && !sym->used)continue;

                        /* make sure symbol is not in publics section */
                        if(!picoBlaze_checkSym(publics, sym))
                                picoBlaze_checkAddSym(&externs, sym);
                        continue;
                }

                /* if allocation required check is needed
                 * then check if the symbol really requires
                 * allocation only for local variables */
                 if (arFlag && !IS_AGGREGATE (sym->type) &&
                        !(sym->_isparm && !IS_REGPARM (sym->etype)) &&
                        !sym->allocreq && sym->level) {

//                      fprintf(stderr, "%s:%d special case, continuing...\n", __FILE__, __LINE__);

                        continue;
                }

                /* if global variable & not static or extern
                 * and addPublics allowed then add it to the public set */
                if ((sym->used) && (sym->level == 0 ||
                        (sym->_isparm && !IS_REGPARM (sym->etype))) &&
                        addPublics &&
                        !IS_STATIC (sym->etype) && !IS_FUNC(sym->type)) {

                        picoBlaze_checkAddSym(&publics, sym);
                } else
                        /* new version */
                        if(IS_STATIC(sym->etype)
                                && !sym->ival) /* && !sym->level*/ {
                          regs *reg;
                          sectSym *ssym;
                          int found=0;

//                            debugf("adding symbol %s\n", sym->name);
#define SET_IMPLICIT    1

#if SET_IMPLICIT
                                if(IS_STRUCT(sym->type))
                                        sym->implicit = 1;
#endif

                                reg = picoBlaze_allocDirReg( operandFromSymbol( sym ));

                                if(reg) {
                                  for(ssym=setFirstItem(picoBlaze_sectSyms); ssym; ssym=setNextItem(picoBlaze_sectSyms)) {
                                    if(!strcmp(ssym->name, reg->name))found=1;
                                  }

                                  if(!found)
                                    picoBlaze_checkAddReg(&picoBlaze_rel_udata, reg);


                                }
                        }

                /* if extern then do nothing or is a function
                 * then do nothing */
                if (IS_FUNC (sym->type) && !IS_STATIC(sym->etype)) {
                        if(SPEC_OCLS(sym->etype) == code) {
//                              fprintf(stderr, "%s:%d: symbol added: %s\n", __FILE__, __LINE__, sym->rname);
                                picoBlaze_checkAddSym(&publics, sym);
                        }
                        continue;
                }

                /* if is has an absolute address then generate
                an equate for this no need to allocate space */
                if (SPEC_ABSA (sym->etype)) {
//                              fprintf (stderr,"; %s == 0x%04x\t\treqv= %p nRegs= %d\n",
//                                      sym->name, SPEC_ADDR (sym->etype), sym->reqv, sym->regType);

                        dbuf_printf (&map->oBuf, "%s\tEQU\t0x%04x\n",
                                sym->rname,
                                SPEC_ADDR (sym->etype));

                        /* emit only if it is global */
                        if(sym->level == 0) {
                          regs *reg;

                                reg = picoBlaze_dirRegWithName( sym->name );
                                if(!reg) {
                                        /* here */
//                                      fprintf(stderr, "%s:%d: implicit add of symbol = %s\n",
//                                                      __FUNCTION__, __LINE__, sym->name);

                                        /* if IS_STRUCT is omitted the following
                                         * fixes structures but break char/int etc */
#if SET_IMPLICIT
                                        if(IS_STRUCT(sym->type))
                                                sym->implicit = 1;              // mark as implicit
#endif
                                        if(!sym->ival) {
                                                reg = picoBlaze_allocDirReg( operandFromSymbol(sym) );
                                                if(reg) {
                                                        if(picoBlaze_checkAddReg(&picoBlaze_fix_udata, reg)) {
                                                                /* and add to globals list if not exist */
                                                                addSet(&publics, sym);
                                                        }
                                                }
                                        } else
                                                addSet(&publics, sym);
                                }
                        }
                } else {
                        if(!sym->used && (sym->level == 0)) {
                          regs *reg;

                                /* symbol not used, just declared probably, but its in
                                 * level 0, so we must declare it fine as global */

//                              fprintf(stderr, "EXTRA symbol declaration sym= %s\n", sym->name);

#if SET_IMPLICIT
                                if(IS_STRUCT(sym->type))
                                        sym->implicit = 1;              // mark as implicit
#endif
                                if(!sym->ival) {
                                        if(IS_AGGREGATE(sym->type)) {
                                                reg=picoBlaze_allocRegByName(sym->rname, getSize( sym->type ), NULL);
                                        } else {
                                                reg = picoBlaze_allocDirReg( operandFromSymbol( sym ) );
                                        }

                                        {
                                          sectSym *ssym;
                                          int found=0;

                                                if(reg) {
                                                  for(ssym=setFirstItem(picoBlaze_sectSyms); ssym; ssym=setNextItem(picoBlaze_sectSyms)) {
                                                    if(!strcmp(ssym->name, reg->name))found=1;
                                                  }

                                                  if(!found)
                                                    if(picoBlaze_checkAddReg(&picoBlaze_rel_udata, reg)) {
                                                      addSetHead(&publics, sym);
                                                    }
                                                }
                                        }



                                } else

                                        addSetHead(&publics, sym);
                        }
                }

                /* FIXME -- VR Fix the following, so that syms to be placed
                 * in the idata section and let linker decide about their fate */

                /* if it has an initial value then do it only if
                        it is a global variable */

                if (sym->ival
                  && ((sym->level == 0)
                      || IS_STATIC(sym->etype)) ) {
                  ast *ival = NULL;

                        if (IS_AGGREGATE (sym->type)) {
                                if(SPEC_ABSA(sym->etype))
                                        addSet(&picoBlaze_fix_idataSymSet, copySymbol(sym));
                                else
                                        addSet(&picoBlaze_rel_idataSymSet, copySymbol(sym));
//                              ival = initAggregates (sym, sym->ival, NULL);
                        } else {
                                if(SPEC_ABSA(sym->etype))
                                        addSet(&picoBlaze_fix_idataSymSet, copySymbol(sym));
                                else
                                        addSet(&picoBlaze_rel_idataSymSet, copySymbol(sym));

//                                      ival = newNode ('=', newAst_VALUE(symbolVal (sym)),
//                                              decorateType (resolveSymbols (list2expr (sym->ival)), RESULT_TYPE_NONE));
                        }

                        if(ival) {
                                setAstFileLine (ival, sym->fileDef, sym->lineDef);
                                codeOutBuf = &statsg->oBuf;
                                GcurMemmap = statsg;
                                eBBlockFromiCode (iCodeFromAst (ival));
                                sym->ival = NULL;
                        }
                }
        }
}


/*-----------------------------------------------------------------*/
/* picoBlaze_initPointer - pointer initialization code massaging       */
/*-----------------------------------------------------------------*/
static value *
picoBlaze_initPointer (initList * ilist, sym_link *toType)
{
  value *val;
  ast *expr;

  if (!ilist) {
      return valCastLiteral(toType, 0.0);
  }

  expr = decorateType(resolveSymbols( list2expr (ilist) ), FALSE);
//  expr = list2expr( ilist );

  if (!expr)
    goto wrong;

  /* try it the old way first */
  if (expr->etype && (val = constExprValue (expr, FALSE)))
    return val;

  /* ( ptr + constant ) */
  if (IS_AST_OP (expr) &&
      (expr->opval.op == '+' || expr->opval.op == '-') &&
      IS_AST_SYM_VALUE (expr->left) &&
      (IS_ARRAY(expr->left->ftype) || IS_PTR(expr->left->ftype)) &&
      compareType(toType, expr->left->ftype) &&
      IS_AST_LIT_VALUE (expr->right)) {
    return valForCastAggr (expr->left, expr->left->ftype,
                           expr->right,
                           expr->opval.op);
  }

  /* (char *)&a */
  if (IS_AST_OP(expr) && expr->opval.op==CAST &&
      IS_AST_OP(expr->right) && expr->right->opval.op=='&') {
    if (compareType(toType, expr->left->ftype)!=1) {
      werror (W_INIT_WRONG);
      printFromToType(expr->left->ftype, toType);
    }
    // skip the cast ???
    expr=expr->right;
  }

  /* no then we have to do these cludgy checks */
  /* pointers can be initialized with address of
     a variable or address of an array element */
  if (IS_AST_OP (expr) && expr->opval.op == '&') {
    /* address of symbol */
    if (IS_AST_SYM_VALUE (expr->left) && expr->left->etype) {
      val = AST_VALUE (expr->left);
      val->type = newLink (DECLARATOR);
      if(SPEC_SCLS (expr->left->etype) == S_CODE) {
        DCL_TYPE (val->type) = CPOINTER;
        DCL_PTR_CONST (val->type) = port->mem.code_ro;
      }
      else if (SPEC_SCLS (expr->left->etype) == S_XDATA)
        DCL_TYPE (val->type) = FPOINTER;
      else if (SPEC_SCLS (expr->left->etype) == S_XSTACK)
        DCL_TYPE (val->type) = PPOINTER;
      else if (SPEC_SCLS (expr->left->etype) == S_IDATA)
        DCL_TYPE (val->type) = IPOINTER;
      else if (SPEC_SCLS (expr->left->etype) == S_EEPROM)
        DCL_TYPE (val->type) = EEPPOINTER;
      else
        DCL_TYPE (val->type) = POINTER;

      val->type->next = expr->left->ftype;
      val->etype = getSpec (val->type);
      return val;
    }

    /* if address of indexed array */
    if (IS_AST_OP (expr->left) && expr->left->opval.op == '[')
      return valForArray (expr->left);

    /* if address of structure element then
       case 1. a.b ; */
    if (IS_AST_OP (expr->left) &&
        expr->left->opval.op == '.') {
      return valForStructElem (expr->left->left,
                               expr->left->right);
    }

    /* case 2. (&a)->b ;
       (&some_struct)->element */
    if (IS_AST_OP (expr->left) &&
        expr->left->opval.op == PTR_OP &&
        IS_ADDRESS_OF_OP (expr->left->left)) {
      return valForStructElem (expr->left->left->left,
                               expr->left->right);
    }
  }
  /* case 3. (((char *) &a) +/- constant) */
  if (IS_AST_OP (expr) &&
      (expr->opval.op == '+' || expr->opval.op == '-') &&
      IS_AST_OP (expr->left) && expr->left->opval.op == CAST &&
      IS_AST_OP (expr->left->right) &&
      expr->left->right->opval.op == '&' &&
      IS_AST_LIT_VALUE (expr->right)) {

    return valForCastAggr (expr->left->right->left,
                           expr->left->left->opval.lnk,
                           expr->right, expr->opval.op);

  }
  /* case 4. (char *)(array type) */
  if (IS_CAST_OP(expr) && IS_AST_SYM_VALUE (expr->right) &&
      IS_ARRAY(expr->right->ftype)) {

    val = copyValue (AST_VALUE (expr->right));
    val->type = newLink (DECLARATOR);
    if (SPEC_SCLS (expr->right->etype) == S_CODE) {
      DCL_TYPE (val->type) = CPOINTER;
      DCL_PTR_CONST (val->type) = port->mem.code_ro;
    }
    else if (SPEC_SCLS (expr->right->etype) == S_XDATA)
      DCL_TYPE (val->type) = FPOINTER;
    else if (SPEC_SCLS (expr->right->etype) == S_XSTACK)
      DCL_TYPE (val->type) = PPOINTER;
    else if (SPEC_SCLS (expr->right->etype) == S_IDATA)
      DCL_TYPE (val->type) = IPOINTER;
    else if (SPEC_SCLS (expr->right->etype) == S_EEPROM)
      DCL_TYPE (val->type) = EEPPOINTER;
    else
      DCL_TYPE (val->type) = POINTER;
    val->type->next = expr->right->ftype->next;
    val->etype = getSpec (val->type);
    return val;
  }

 wrong:
  if (expr)
    werrorfl (expr->filename, expr->lineno, E_INCOMPAT_PTYPES);
  else
    werror (E_INCOMPAT_PTYPES);
  return NULL;

}


/*-----------------------------------------------------------------*/
/* printPointerType - generates ival for pointer type              */
/*-----------------------------------------------------------------*/
static void
_picoBlaze_printPointerType (const char *name, char ptype, void *p)
{
  char buf[256];

  sprintf (buf, "LOW(%s)", name);
  picoBlaze_emitDS (buf, ptype, p);
  sprintf (buf, "HIGH(%s)", name);
  picoBlaze_emitDS (buf, ptype, p);
}

/*-----------------------------------------------------------------*/
/* printPointerType - generates ival for pointer type              */
/*-----------------------------------------------------------------*/
static void
picoBlaze_printPointerType (const char *name, char ptype, void *p)
{
  _picoBlaze_printPointerType (name, ptype, p);
  //picoBlaze_flushDB(ptype, p); /* breaks char* const arr[] = {&c, &c, &c}; */
}

/*-----------------------------------------------------------------*/
/* printGPointerType - generates ival for generic pointer type     */
/*-----------------------------------------------------------------*/
static void
picoBlaze_printGPointerType (const char *iname, const unsigned int itype,
  char ptype, void *p)
{
  char buf[256];

  _picoBlaze_printPointerType (iname, ptype, p);

  switch (itype)
    {
    case CPOINTER: /* fall through */
    case FUNCTION: /* fall through */
    case GPOINTER:
      /* GPTRs pointing to __data space should be reported as POINTERs */
      sprintf (buf, "UPPER(%s)", iname);
      picoBlaze_emitDS (buf, ptype, p);
      break;

    case POINTER:  /* fall through */
    case FPOINTER: /* fall through */
    case IPOINTER: /* fall through */
    case PPOINTER: /* __data space */
      sprintf (buf, "0x%02x", GPTR_TAG_DATA);
      picoBlaze_emitDS (buf, ptype, p);
      break;

    default:
      debugf ("itype = %d\n", itype );
      assert (0);
    }

    if (itype == GPOINTER) {
      fprintf(stderr, "%s: initialized generic pointer with unknown storage class assumes object in code space\n", __func__);
    }

  //picoBlaze_flushDB(ptype, p); /* might break char* const arr[] = {...}; */
}


/* set to 0 to disable debug messages */
#define DEBUG_PRINTIVAL 0

/*-----------------------------------------------------------------*/
/* picoBlaze_printIvalType - generates ival for int/char               */
/*-----------------------------------------------------------------*/
static void
picoBlaze_printIvalType (symbol *sym, sym_link * type, initList * ilist, char ptype, void *p)
{
  value *val;
  int i;

//  fprintf(stderr, "%s for symbol %s\n",__FUNCTION__, sym->rname);

#if DEBUG_PRINTIVAL
  fprintf(stderr, "%s\n",__FUNCTION__);
#endif


  /* if initList is deep */
  if (ilist && ilist->type == INIT_DEEP)
    ilist = ilist->init.deep;

  if (!IS_AGGREGATE(sym->type) && getNelements(type, ilist)>1) {
    werror (W_EXCESS_INITIALIZERS, "scalar", sym->name, sym->lineDef);
  }

  if (!(val = list2val (ilist))) {
    // assuming a warning has been thrown
    val = constCharVal (0);
  }

  if (val->type != type) {
    val = valCastLiteral(type, floatFromVal(val));
  }

  for (i = 0; i < getSize (type); i++) {
    picoBlaze_emitDB(picoBlazeaopLiteral(val, i), ptype, p);
  } // for
}

/*--------------------------------------------------------------------*/
/* picoBlaze_printIvalChar - generates initital value for character array */
/*--------------------------------------------------------------------*/
static int
picoBlaze_printIvalChar (symbol *sym, sym_link * type, initList * ilist, char *s, char ptype, void *p)
{
  value *val;
  int remain, len, ilen;

  if(!p)
    return 0;

#if DEBUG_PRINTIVAL
  fprintf(stderr, "%s\n",__FUNCTION__);
#endif

  if(!s) {
    val = list2val (ilist);

    /* if the value is a character string  */
    if(IS_ARRAY (val->type) && IS_CHAR (val->etype)) {
      /* length of initializer string (might contain \0, so do not use strlen) */
      ilen = DCL_ELEM(val->type);

      /* len is 0 if declartion equals initializer,
       * >0 if declaration greater than initializer
       * <0 if declaration less than initializer
       * Strategy: if >0 emit 0x00 for the rest of the length,
       * if <0 then emit only the length of declaration elements
       * and warn user
       */
      len = DCL_ELEM (type) - ilen;

//      fprintf(stderr, "%s:%d ilen = %i len = %i DCL_ELEM(type) = %i SPEC_CVAL-len = %i\n", __FILE__, __LINE__,
//        ilen, len, DCL_ELEM(type), strlen(SPEC_CVAL(val->etype).v_char));

      if(len >= 0) {
        /* emit initializer */
        for(remain=0; remain<ilen; remain++) {
          picoBlaze_emitDB(SPEC_CVAL(val->etype).v_char[ remain ], ptype, p);
        } // for

        /* fill array with 0x00 */
        while(len--) {
          picoBlaze_emitDB(0x00, ptype, p);
        } // while
      } else if (!DCL_ELEM (type)) {
        // flexible arrays: char str[] = "something"; */
        for(remain=0; remain<ilen; remain++) {
          picoBlaze_emitDB(SPEC_CVAL(val->etype).v_char[ remain ], ptype, p);
        } // for
      } else {
        werror (W_EXCESS_INITIALIZERS, "array of chars", sym->name, sym->lineDef);
        for(remain=0; remain<DCL_ELEM (type); remain++) {
          picoBlaze_emitDB(SPEC_CVAL(val->etype).v_char[ remain ], ptype, p);
        } // for
      } // if


//      if((remain = (DCL_ELEM (type) - strlen (SPEC_CVAL (val->etype).v_char) - 1)) > 0) {
//      }
      return 1;
    } else return 0;
  } else {
    for(remain=0; remain<strlen(s); remain++) {
        picoBlaze_emitDB(s[remain], ptype, p);
    }
  }
  return 1;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_printIvalArray - generates code for array initialization        */
/*-----------------------------------------------------------------*/
static void
picoBlaze_printIvalArray (symbol * sym, sym_link * type, initList * ilist,
                char ptype, void *p)
{
  initList *iloop;
  int lcnt = 0, size = 0;

  if(!p)
    return;


#if DEBUG_PRINTIVAL
  fprintf(stderr, "%s\n",__FUNCTION__);
#endif
  /* take care of the special   case  */
  /* array of characters can be init  */
  /* by a string                      */
  if (IS_CHAR (type->next) && ilist) {
    if (!IS_LITERAL(list2val(ilist)->etype)) {
      werror (W_INIT_WRONG);
      return;
    }

    if(picoBlaze_printIvalChar (sym, type,
                       (ilist->type == INIT_DEEP ? ilist->init.deep : ilist),
                       SPEC_CVAL (sym->etype).v_char, ptype, p))
      return;
  }
  /* not the special case             */
  if (ilist && ilist->type != INIT_DEEP)
    {
      werror (E_INIT_STRUCT, sym->name);
      return;
    }

  iloop = (ilist ? ilist->init.deep : NULL);
  lcnt = DCL_ELEM (type);

  for (;;)
    {
      size++;
      picoBlaze_printIval (sym, type->next, iloop, ptype, p);
      iloop = (iloop ? iloop->next : NULL);


      /* if not array limits given & we */
      /* are out of initialisers then   */
      if (!DCL_ELEM (type) && !iloop)
        break;

      /* no of elements given and we    */
      /* have generated for all of them */
      if (!--lcnt) {
        /* if initializers left */
        if (iloop) {
          werror (W_EXCESS_INITIALIZERS, "array", sym->name, sym->lineDef);
        }
        break;
      }
    }

  return;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_printIvalBitFields - generate initializer for bitfields   */
/*-----------------------------------------------------------------*/
static void
picoBlaze_printIvalBitFields(symbol **sym, initList **ilist, char ptype, void *p)
{
  value *val ;
  symbol *lsym = *sym;
  initList *lilist = *ilist ;
  unsigned long ival = 0;
  unsigned long i;
  int size =0;


#if DEBUG_PRINTIVAL
  fprintf(stderr, "%s\n",__FUNCTION__);
#endif


  do {
    val = list2val(lilist);
    if (size) {
      if (SPEC_BLEN(lsym->etype) > 8) {
        size += ((SPEC_BLEN (lsym->etype) / 8) +
                 (SPEC_BLEN (lsym->etype) % 8 ? 1 : 0));
      }
    } else {
      size = ((SPEC_BLEN (lsym->etype) / 8) +
              (SPEC_BLEN (lsym->etype) % 8 ? 1 : 0));
    }
    i = (ulFromVal (val) & ((1ul << SPEC_BLEN (lsym->etype)) - 1ul));
    i <<= SPEC_BSTR (lsym->etype);
    ival |= i;
    if (! ( lsym->next &&
          (lilist && lilist->next) &&
          (IS_BITFIELD(lsym->next->type)) &&
          (SPEC_BSTR(lsym->next->etype)))) break;
    lsym = lsym->next;
    lilist = lilist->next;
  } while (1);

  for (i = 0; i < size; i++) {
    picoBlaze_emitDB(BYTE_IN_LONG(ival, i), ptype, p);
  } // for

  *sym = lsym;
  *ilist = lilist;
}


/*-----------------------------------------------------------------*/
/* printIvalStruct - generates initial value for structures        */
/*-----------------------------------------------------------------*/
static void
picoBlaze_printIvalStruct (symbol * sym, sym_link * type,
                 initList * ilist, char ptype, void *p)
{
  symbol *sflds;
  initList *iloop = NULL;


#if DEBUG_PRINTIVAL
  fprintf(stderr, "%s\n",__FUNCTION__);
#endif

  sflds = SPEC_STRUCT (type)->fields;

  if (ilist) {
    if (ilist->type != INIT_DEEP) {
      werrorfl (sym->fileDef, sym->lineDef, E_INIT_STRUCT, sym->name);
      return;
    }

    iloop = ilist->init.deep;
  }

  for (; sflds; sflds = sflds->next, iloop = (iloop ? iloop->next : NULL)) {
//    fprintf(stderr, "%s:%d sflds: %p\tiloop = %p\n", __FILE__, __LINE__, sflds, iloop);
    if (IS_BITFIELD(sflds->type)) {
      picoBlaze_printIvalBitFields(&sflds, &iloop, ptype, p);
    } else {
      picoBlaze_printIval (sym, sflds->type, iloop, ptype, p);
    }
  }
  if (iloop) {
    werrorfl (sym->fileDef, sym->lineDef, W_EXCESS_INITIALIZERS, "struct", sym->name);
  }
  return;
}

/*-----------------------------------------------------------------*/
/* printIvalUnion - generates initial value for unions             */
/*-----------------------------------------------------------------*/
static void
picoBlaze_printIvalUnion (symbol * sym, sym_link * type,
                 initList * ilist, char ptype, void *p)
{
  //symbol *sflds;
  initList *iloop = NULL;
  int size;
  symbol *sflds = NULL;

#if DEBUG_PRINTIVAL
  fprintf(stderr, "%s\n",__FUNCTION__);
#endif

  assert (type);

  sflds = SPEC_STRUCT (type)->fields;

  if (ilist) {
    if (ilist->type != INIT_DEEP) {
      werrorfl (sym->fileDef, sym->lineDef, E_INIT_STRUCT, sym->name);
      return;
    }

    iloop = ilist->init.deep;
  }

  size = SPEC_STRUCT(type)->size;
  sflds = SPEC_STRUCT(type)->fields;
  picoBlaze_printIval (sym, sflds->type, iloop, ptype, p);

  /* if the first field is not the longest, fill with 0s */
  while (size > getSize (sflds->type)) {
      picoBlaze_emitDB(0, ptype, p);
      size--;
  } // while
}

static int
picoBlaze_isUnion( symbol *sym, sym_link *type )
{
  if (type && SPEC_STRUCT(type)->type == UNION) return 1;
  return 0;
}

/*--------------------------------------------------------------------------*/
/* picoBlaze_printIvalCharPtr - generates initial values for character pointers */
/*--------------------------------------------------------------------------*/
static int
picoBlaze_printIvalCharPtr (symbol * sym, sym_link * type, value * val, char ptype, void *p)
{
  int size = 0;
  int i;

  /* PENDING: this is _very_ mcs51 specific, including a magic
     number...
     It's also endin specific.

     VR - Attempting to port this function to picoBlaze port - 8-Jun-2004
   */


#if DEBUG_PRINTIVAL
  fprintf(stderr, "%s\n",__FUNCTION__);
#endif

  size = getSize (type);

  if (val->name && strlen (val->name))
    {
      if (size == 1)            /* This appears to be Z80 specific?? */
        {
          picoBlaze_emitDS(val->name, ptype, p);
        }
      else if (size == 2)
        {
          picoBlaze_printPointerType (val->name, ptype, p);
        }
      else if (size == 3)
        {
          int type;
          type = PTR_TYPE (SPEC_OCLS (val->etype));
          if (val->sym && val->sym->isstrlit) {
            // this is a literal string
            type = CPOINTER;
          }
          picoBlaze_printGPointerType(val->name, type, ptype, p);
        }
      else
        {
          fprintf (stderr, "*** internal error: unknown size in "
                   "printIvalCharPtr.\n");
          assert(0);
        }
    }
  else
    {
      // these are literals assigned to pointers
      for (i = 0; i < size; i++)
        {
          picoBlaze_emitDB(picoBlazeaopLiteral(val, i), ptype, p);
        } // for
    }

  if (val->sym && val->sym->isstrlit) { // && !isinSet(statsg->syms, val->sym)) {
        if(ptype == 'p' && !isinSet(statsg->syms, val->sym))addSet (&statsg->syms, val->sym);
        else if(ptype == 'f' /*&& !isinSet(picoBlaze_rel_idataSymSet, val->sym)*/)addSet(&picoBlaze_rel_idataSymSet, val->sym);
  }

  return 1;
}

/*-----------------------------------------------------------------------*/
/* picoBlaze_printIvalFuncPtr - generate initial value for function pointers */
/*-----------------------------------------------------------------------*/
static void
picoBlaze_printIvalFuncPtr (sym_link * type, initList * ilist, char ptype, void *p)
{
  value *val;
  int dLvl = 0;


#if DEBUG_PRINTIVAL
  fprintf(stderr, "%s\n",__FUNCTION__);
#endif

  if (ilist)
    val = list2val (ilist);
  else
    val = valCastLiteral(type, 0.0);

  if (!val) {
    // an error has been thrown already
    val = constCharVal (0);
  }

  if (IS_LITERAL(val->etype)) {
    if (0 && compareType(type, val->etype) == 0) {
      werrorfl (ilist->filename, ilist->lineno, E_INCOMPAT_TYPES);
      printFromToType (val->type, type);
    }
    picoBlaze_printIvalCharPtr (NULL, type, val, ptype, p);
    return;
  }

  /* check the types   */
  if ((dLvl = compareType (val->type, type->next)) <= 0)
    {
      picoBlaze_emitDB(0x00, ptype, p);
      return;
    }

  /* now generate the name */
  if (!val->sym) {
      picoBlaze_printGPointerType (val->name, CPOINTER /*DCL_TYPE(val->type)*/, ptype, p);
  } else {
      picoBlaze_printGPointerType (val->sym->rname, CPOINTER /*DCL_TYPE(val->type)*/, ptype, p);

      if(IS_FUNC(val->sym->type) && !val->sym->used && !IS_STATIC(val->sym->etype)) {

        if(!picoBlaze_checkSym(publics, val->sym))
          if(picoBlaze_checkAddSym(&externs, val->sym) && (ptype == 'f')) {
            /* this has not been declared as extern
             * so declare it as a 'late extern' just after the symbol */
            fprintf((FILE *)p, ";\tdeclare symbol as extern\n");
            fprintf((FILE *)p, "\textern\t%s\n", val->sym->rname);
            fprintf((FILE *)p, ";\tcontinue variable declaration\n");
          }
      }
  }

  return;
}


/*-----------------------------------------------------------------*/
/* picoBlaze_printIvalPtr - generates initial value for pointers       */
/*-----------------------------------------------------------------*/
static void
picoBlaze_printIvalPtr (symbol * sym, sym_link * type, initList * ilist, char ptype, void *p)
{
  value *val;
  int size;
  int i;

  /* if deep then   */
  if (ilist && (ilist->type == INIT_DEEP))
    ilist = ilist->init.deep;

  /* function pointer     */
  if (IS_FUNC (type->next))
    {
      picoBlaze_printIvalFuncPtr (type, ilist, ptype, p);
      return;
    }

  if (!(val = picoBlaze_initPointer (ilist, type)))
    return;

  /* if character pointer */
  if (IS_CHAR (type->next))
    if (picoBlaze_printIvalCharPtr (sym, type, val, ptype, p))
      return;

  /* check the type      */
  if (compareType (type, val->type) == 0) {
    werrorfl (ilist->filename, ilist->lineno, W_INIT_WRONG);
    printFromToType (val->type, type);
  }

  size = getSize (type);

  /* if val is literal */
  if (IS_LITERAL (val->etype))
    {
      for (i = 0; i < size; i++)
        {
          picoBlaze_emitDB(picoBlazeaopLiteral(val, i), ptype, p);
        } // for
      return;
    }

  if (size == 1)                /* Z80 specific?? */
    {
      picoBlaze_emitDS(val->name, ptype, p);
    }
  else if (size == 2)
    {
      picoBlaze_printPointerType (val->name, ptype, p);
    }
  else if (size == 3)
    {
      int itype = 0;
      itype = PTR_TYPE (SPEC_OCLS (val->etype));
      picoBlaze_printGPointerType (val->name, itype, ptype, p);
    }
  else
    {
      assert(0);
    }
}



/*-----------------------------------------------------------------*/
/* picoBlaze_printIval - generates code for initial value                    */
/*-----------------------------------------------------------------*/
void picoBlaze_printIval (symbol * sym, sym_link * type, initList * ilist, char ptype, void *p)
{
//  sym_link *itype;

  if (!p)
    return;

  /* if structure then */
  if (IS_STRUCT (type))
    {
      if (picoBlaze_isUnion(sym, type))
        {
          //fprintf(stderr,"%s union\n",__FUNCTION__);
          picoBlaze_printIvalUnion (sym, type, ilist, ptype, p);
        } else {
          //fprintf(stderr,"%s struct\n",__FUNCTION__);
          picoBlaze_printIvalStruct (sym, type, ilist, ptype, p);
        }
      return;
    }

  /* if this is an array */
  if (IS_ARRAY (type))
    {
//      fprintf(stderr,"%s array\n",__FUNCTION__);
      picoBlaze_printIvalArray (sym, type, ilist, ptype, p);
      return;
    }

  /* if this is a pointer */
  if (IS_PTR (type))
    {
//      fprintf(stderr,"%s pointer\n",__FUNCTION__);
      picoBlaze_printIvalPtr (sym, type, ilist, ptype, p);
      return;
    }


  /* if type is SPECIFIER */
  if (IS_SPEC (type))
    {
//      fprintf(stderr,"%s spec\n",__FUNCTION__);
      picoBlaze_printIvalType (sym, type, ilist, ptype, p);
      return;
    }
}

static int
PICOBLAZE_IS_CONFIG_ADDRESS(int address)
{
  return ((address >= picoBlaze->cwInfo.confAddrStart && address <= picoBlaze->cwInfo.confAddrEnd));
}

static int
PICOBLAZE_IS_IDLOC_ADDRESS(int address)
{
   return ((address >= picoBlaze->idInfo.idAddrStart && address <= picoBlaze->idInfo.idAddrEnd));
}

/*-----------------------------------------------------------------*/
/* emitStaticSeg - emitcode for the static segment                 */
/*-----------------------------------------------------------------*/
static void
picoBlazeemitStaticSeg (memmap * map)
{
  symbol *sym;
  static int didcode = 0;

  //fprintf(stderr, "%s\n",__FUNCTION__);

  picoBlaze_initDB ();

  /* for all variables in this segment do */
  for (sym = setFirstItem (map->syms); sym; sym = setNextItem (map->syms))
    {


      if (SPEC_ABSA (sym->etype) && PICOBLAZE_IS_CONFIG_ADDRESS (SPEC_ADDR (sym->etype)))
        {
          picoBlaze_assignConfigWordValue (SPEC_ADDR (sym->etype), (int) ulFromVal (list2val (sym->ival)));

          continue;
        }

      if (SPEC_ABSA (sym->etype) && PICOBLAZE_IS_IDLOC_ADDRESS (SPEC_ADDR (sym->etype)))
        {
          picoBlaze_assignIdByteValue (SPEC_ADDR (sym->etype), (char) ulFromVal (list2val (sym->ival)));

          continue;
        }

      /* if it is "extern" then do nothing */
      if (IS_EXTERN (sym->etype) /* && !SPEC_ABSA(sym->etype) */ )
        {
          picoBlaze_checkAddSym (&externs, sym);
          continue;
        }

      /* if it is not static add it to the public
         table */
      if (!IS_STATIC (sym->etype))
        {
          /* do not emit if it is a config word declaration */
          picoBlaze_checkAddSym (&publics, sym);
        }

      /* print extra debug info if required */
      if (options.debug || sym->level == 0)
        {
          /* NOTE to me - cdbFile may be null in which case,
           * the sym name will be printed to stdout. oh well */
          debugFile->writeSymbol (sym);
        }

      /* if it has an absolute address */
      if (SPEC_ABSA (sym->etype))
        {
//        fprintf(stderr, "%s:%d spec_absa is true for symbol: %s\n",
//                __FILE__, __LINE__, sym->name);

          if (!sym->ival && IS_ARRAY (sym->type) && IS_CHAR (sym->type->next) && SPEC_CVAL (sym->etype).v_char)
            {
              /* symbol has absolute address but no initial value */
              /* special case for character strings */

//            fprintf(stderr, "%s:%d printing code string from %s\n", __FILE__, __LINE__, sym->rname);

              picoBlaze_pCodeConstString (sym->rname, SPEC_CVAL (sym->etype).v_char, getSize (sym->type));
            }
          else
            {
              pBlock *pb;
              symbol *asym;
              absSym *abSym;
              pCode *pcf;

              /* symbol has absolute address and initial value */
              ++noAlloc;
              resolveIvalSym (sym->ival, sym->type);
              asym = newSymbol (sym->rname, 0);
              abSym = Safe_calloc (1, sizeof (absSym));
              strcpy (abSym->name, sym->rname);
              abSym->address = SPEC_ADDR (sym->etype);
              addSet (&absSymSet, abSym);

              pb = picoBlaze_newpCodeChain (NULL, 'A', picoBlaze_newpCodeCharP ("; Starting pCode block for absolute Ival"));
              picoBlaze_addpBlock (pb);

              pcf = picoBlaze_newpCodeFunction (moduleName, asym->name);
              PCF (pcf)->absblock = 1;

              picoBlaze_addpCode2pBlock (pb, pcf);
              picoBlaze_addpCode2pBlock (pb, picoBlaze_newpCodeLabel (sym->rname, -1));
              //fprintf(stderr, "%s:%d [1] generating init for label: %s\n", __FILE__, __LINE__, sym->rname);
              /* if it has an initial value */
              if (sym->ival)
                {
                  picoBlaze_printIval (sym, sym->type, sym->ival, 'p', (void *) pb);
                  picoBlaze_flushDB ('p', (void *) pb);
                }

              picoBlaze_addpCode2pBlock (pb, picoBlaze_newpCodeFunction (NULL, NULL));
              --noAlloc;
            }
        }
      else
        {
//        fprintf(stderr, "%s:%d spec_absa is false for symbol: %s\n",
//               __FILE__, __LINE__, sym->name);


          /* if it has an initial value */
          if (sym->ival)
            {
              pBlock *pb;

              /* symbol doesn't have absolute address but has initial value */
              dbuf_printf (&code->oBuf, "%s:\n", sym->rname);
              ++noAlloc;
              resolveIvalSym (sym->ival, sym->type);

              pb = picoBlaze_newpCodeChain (NULL, 'P', picoBlaze_newpCodeCharP ("; Starting pCode block for Ival"));
              picoBlaze_addpBlock (pb);

              if (!didcode)
                {
                  /* make sure that 'code' directive is emitted before, once */
                  picoBlaze_addpCode2pBlock (pb, picoBlaze_newpCodeAsmDir ("code", NULL));

                  ++didcode;
                }

              picoBlaze_addpCode2pBlock (pb, picoBlaze_newpCodeLabel (sym->rname, -1));
              //fprintf(stderr, "%s:%d [2] generating init for label: %s\n", __FILE__, __LINE__, sym->rname);
              picoBlaze_printIval (sym, sym->type, sym->ival, 'p', (void *) pb);
              picoBlaze_flushDB ('p', (void *) pb);
              --noAlloc;
            }
          else
            {

              /* symbol doesn't have absolute address and no initial value */
              /* allocate space */
//            fprintf(stderr, "%s:%d [3] generating init for label: %s\n", __FILE__, __LINE__, sym->rname);
              dbuf_printf (&code->oBuf, "%s:\n", sym->rname);
              /* special case for character strings */
              if (IS_ARRAY (sym->type) && IS_CHAR (sym->type->next) && SPEC_CVAL (sym->etype).v_char)
                {

//                fprintf(stderr, "%s:%d printing code string for %s\n", __FILE__, __LINE__, sym->rname);

                  picoBlaze_pCodeConstString (sym->rname, SPEC_CVAL (sym->etype).v_char, getSize (sym->type));
                }
              else
                {
                  assert (0);
                }
            }
        }
    }
}

/*-----------------------------------------------------------------*/
/* picoBlaze_emitConfigRegs - emits the configuration registers              */
/*-----------------------------------------------------------------*/
void picoBlaze_emitConfigRegs(FILE *of)
{
  int i;

        for(i=0;i<=(picoBlaze->cwInfo.confAddrEnd-picoBlaze->cwInfo.confAddrStart);i++)
                if(picoBlaze->cwInfo.crInfo[i].emit)        //mask != -1)
                        fprintf (of, "\t__config 0x%x, 0x%hhx\n",
                                picoBlaze->cwInfo.confAddrStart+i,
                                picoBlaze->cwInfo.crInfo[i].value);
}

void picoBlaze_emitIDRegs(FILE *of)
{
  int i;

        for(i=0;i<=(picoBlaze->idInfo.idAddrEnd-picoBlaze->idInfo.idAddrStart);i++)
                if(picoBlaze->idInfo.irInfo[i].emit)
                        fprintf (of, "\t__idlocs 0x%06x, 0x%hhx\n",
                                picoBlaze->idInfo.idAddrStart+i,
                                picoBlaze->idInfo.irInfo[i].value);
}


static void
picoBlazeemitMaps ()
{
  /* no special considerations for the following
     data, idata & bit & xdata */
  picoBlazeemitRegularMap (data, TRUE, TRUE);
  picoBlazeemitRegularMap (idata, TRUE, TRUE);
  picoBlazeemitRegularMap (bit, TRUE, FALSE);
  picoBlazeemitRegularMap (xdata, TRUE, TRUE);
  picoBlazeemitRegularMap (sfrbit, FALSE, FALSE);
  picoBlazeemitRegularMap (code, TRUE, FALSE);
  picoBlazeemitStaticSeg (statsg);
  picoBlazeemitStaticSeg (c_abs);
}

/*-----------------------------------------------------------------*/
/* createInterruptVect - creates the interrupt vector              */
/*-----------------------------------------------------------------*/
static void
picoBlazecreateInterruptVect (struct dbuf_s * vBuf)
{
        /* if the main is only a prototype ie. no body then do nothing */

}


/*-----------------------------------------------------------------*/
/* picoBlazeinitialComments - puts in some initial comments            */
/*-----------------------------------------------------------------*/
static void
picoBlazeinitialComments (FILE * afile)
{
    initialComments (afile);
    fprintf (afile, "; PICOBLAZE port for the Xilinx 8-bit PicoBlaze-3 softcore\n");
    if (picoBlaze_options.xinst) {
        fprintf (afile, "; * Extended Instruction Set\n");
    } // if

    if (picoBlaze_mplab_comp) {
        fprintf(afile, "; * MPLAB/MPASM/MPASMWIN/MPLINK compatibility mode enabled\n");
    } // if
    fprintf (afile, iComments2);

    if (options.debug) {
        fprintf (afile, "\n\t.ident \"SDCC version %s #%s [picoBlaze port]%s\"\n",
                SDCC_VERSION_STR, getBuildNumber(), (!picoBlaze_options.xinst?"":" {extended}") );
    } // if
}

int
picoBlaze_stringInSet(const char *str, set **world, int autoAdd)
{
  char *s;

  if (!str) return 1;
  assert(world);

  for (s = setFirstItem(*world); s; s = setNextItem(*world))
  {
    /* found in set */
    if (0 == strcmp(s, str)) return 1;
  }

  /* not found */
  if (autoAdd) addSet(world, Safe_strdup(str));
  return 0;
}

static int
picoBlaze_emitSymbolIfNew(FILE *file, const char *fmt, const char *sym, int checkLocals)
{
  static set *emitted = NULL;

  if (!picoBlaze_stringInSet(sym, &emitted, 1)) {
    /* sym was not in emittedSymbols */
    if (!checkLocals || !picoBlaze_stringInSet(sym, &picoBlaze_localFunctions, 0)) {
      /* sym is not a locally defined function---avoid bug #1443651 */
      fprintf( file, fmt, sym );
      return 0;
    }
  }
  return 1;
}

/*-----------------------------------------------------------------*/
/* printPublics - generates global declarations for publics        */
/*-----------------------------------------------------------------*/
static void
picoBlazeprintPublics (FILE *afile)
{
  symbol *sym;

        fprintf (afile, "\n%s", iComments2);
        fprintf (afile, "; public variables in this module\n");
        fprintf (afile, "%s", iComments2);

        for(sym = setFirstItem (publics); sym; sym = setNextItem (publics))
          /* sanity check */
          if(!IS_STATIC(sym->etype))
                picoBlaze_emitSymbolIfNew(afile, "\tglobal %s\n", sym->rname, 0);
}

/*-----------------------------------------------------------------*/
/* printExterns - generates extern declarations for externs        */
/*-----------------------------------------------------------------*/
static void
picoBlaze_printExterns(FILE *afile)
{
  symbol *sym;

        /* print nothing if no externs to declare */
        if(!elementsInSet(externs) && !elementsInSet(picoBlaze_builtin_functions))
                return;

        fprintf(afile, "\n%s", iComments2);
        fprintf(afile, "; extern variables in this module\n");
        fprintf(afile, "%s", iComments2);

        for(sym = setFirstItem(externs); sym; sym = setNextItem(externs))
                picoBlaze_emitSymbolIfNew(afile, "\textern %s\n", sym->rname, 1);

        for(sym = setFirstItem(picoBlaze_builtin_functions); sym; sym = setNextItem(picoBlaze_builtin_functions))
                picoBlaze_emitSymbolIfNew(afile, "\textern _%s\n", sym->name, 1);
}

/*-----------------------------------------------------------------*/
/* emitOverlay - will emit code for the overlay stuff              */
/*-----------------------------------------------------------------*/
static void
picoBlazeemitOverlay (struct dbuf_s *aBuf)
{
  set *ovrset;

  if (!elementsInSet (ovrSetSets))
    dbuf_printf (aBuf, ";\t.area\t%s\n", port->mem.overlay_name);

  /* for each of the sets in the overlay segment do */
  for (ovrset = setFirstItem (ovrSetSets); ovrset;
       ovrset = setNextItem (ovrSetSets))
    {

      symbol *sym;

      if (elementsInSet (ovrset))
        {
          /* this dummy area is used to fool the assembler
             otherwise the assembler will append each of these
             declarations into one chunk and will not overlay
             sad but true */
          dbuf_printf (aBuf, ";\t.area _DUMMY\n");
          /* output the area informtion */
          dbuf_printf (aBuf, ";\t.area\t%s\n", port->mem.overlay_name); /* MOF */
        }

      for (sym = setFirstItem (ovrset); sym;
           sym = setNextItem (ovrset))
        {

          /* if extern then do nothing */
          if (IS_EXTERN (sym->etype))
            continue;

          /* if allocation required check is needed
             then check if the symbol really requires
             allocation only for local variables */
          if (!IS_AGGREGATE (sym->type) &&
              !(sym->_isparm && !IS_REGPARM (sym->etype))
              && !sym->allocreq && sym->level)
            continue;

          /* if global variable & not static or extern
             and addPublics allowed then add it to the public set */
          if ((sym->_isparm && !IS_REGPARM (sym->etype))
              && !IS_STATIC (sym->etype)) {
//            fprintf(stderr, "%s:%d %s accessed\n", __FILE__, __LINE__, __FUNCTION__);
              picoBlaze_checkAddSym(&publics, sym);
//          addSetHead (&publics, sym);
          }

          /* if extern then do nothing or is a function
             then do nothing */
          if (IS_FUNC (sym->type))
            continue;


          /* if is has an absolute address then generate
             an equate for this no need to allocate space */
          if (SPEC_ABSA (sym->etype))
            {

              if (options.debug || sym->level == 0)
                dbuf_printf (aBuf, " == 0x%04x\n", SPEC_ADDR (sym->etype));

              dbuf_printf (aBuf, "%s\t=\t0x%04x\n",
                       sym->rname,
                       SPEC_ADDR (sym->etype));
            }
          else
            {
              if (options.debug || sym->level == 0)
                dbuf_printf (aBuf, "==.\n");

              /* allocate space */
              dbuf_printf (aBuf, "%s:\n", sym->rname);
              dbuf_printf (aBuf, "\t.ds\t0x%04x\n", (unsigned int) getSize (sym->type) & 0xffff);
            }

        }
    }
}

static void
emitStatistics(FILE *asmFile)
{
  unsigned long isize, udsize, ramsize;
  picoBlaze_statistics.isize = picoBlaze_countInstructions();
  isize = (picoBlaze_statistics.isize >= 0) ? picoBlaze_statistics.isize : 0;
  udsize = (picoBlaze_statistics.udsize >= 0) ? picoBlaze_statistics.udsize : 0;
  ramsize = picoBlaze ? picoBlaze->RAMsize : 0x200;
  ramsize -= 256; /* ignore access bank and SFRs */
  if (ramsize == 0) ramsize = 64; /* prevent division by zero (below) */

  fprintf (asmFile, "\n\n; Statistics:\n");
  fprintf (asmFile, "; code size:\t%5ld (0x%04lx) bytes (%5.2f%%)\n;           \t%5ld (0x%04lx) words\n",
    isize, isize, (isize*100.0)/(128UL << 10),
    isize>>1, isize>>1);
  fprintf (asmFile, "; udata size:\t%5ld (0x%04lx) bytes (%5.2f%%)\n",
    udsize, udsize, (udsize*100.0) / (1.0 * ramsize));
  fprintf (asmFile, "; access size:\t%5ld (0x%04lx) bytes\n",
    picoBlaze_statistics.intsize, picoBlaze_statistics.intsize);

  fprintf (asmFile, "\n\n");
}


extern int indentDeep;
/*-----------------------------------------------------------------*/
/* glue - the final glue that hold the whole thing together        */
/*-----------------------------------------------------------------*/
void
picoBlazeglue ()
{
  FILE *asmFile;
  struct dbuf_s ovrBuf;
  struct dbuf_s vBuf;

  // close iCode Dump File (opened in the first call of ralloc.c::picoBlaze_assignRegisters(...)
  if (picoBlaze_options.json_flag && iCodeDumpFile)
  {
	  indentDeep--;
	  dumpICode("]");
	  fclose(iCodeDumpFile);
	 
	  exit(0);
  }



    dbuf_init(&ovrBuf, 4096);
    dbuf_init(&vBuf, 4096);

    mainf = newSymbol ("main", 0);
    mainf->block = 0;

    mainf = findSymWithLevel(SymbolTab, mainf);

    picoBlaze_pCodeInitRegisters();

    if(picoBlaze_options.no_crt && mainf && IFFUNC_HASBODY(mainf->type)) {
      pBlock *pb = picoBlaze_newpCodeChain(NULL,'X',picoBlaze_newpCodeCharP("; Starting pCode block"));

        picoBlaze_addpBlock(pb);

        /* entry point @ start of CSEG */
        picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeLabel("__sdcc_program_startup",-1));

        if(picoBlaze_initsfpnt) {
          picoBlaze_addpCode2pBlock(pb, picoBlaze_newpCode(POC_LFSR,
                  picoBlaze_popGetLit2(1, picoBlaze_newpCodeOpRegFromStr("_stack_end"))));
          picoBlaze_addpCode2pBlock(pb, picoBlaze_newpCode(POC_LFSR,
                  picoBlaze_popGetLit2(2, picoBlaze_newpCodeOpRegFromStr("_stack_end"))));
        }

        /* put in the call to main */
        picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCode(POC_CALL,picoBlaze_newpCodeOp("_main",PO_GPR_REGISTER)));

        if (options.mainreturn) {
          picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeCharP(";\treturn from main will return to caller\n"));
          picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCode(POC_RETURN,NULL));
        } else {
          picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeCharP(";\treturn from main will lock up\n"));
          picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCode(POC_GOTO,picoBlaze_newpCodeOp("$",PO_GPR_REGISTER)));
        }
    }

    /* At this point we've got all the code in the form of pCode structures */
    /* Now it needs to be rearranged into the order it should be placed in the */
    /* code space */

    picoBlaze_movepBlock2Head('P');              // Last
    picoBlaze_movepBlock2Head(code->dbName);
    picoBlaze_movepBlock2Head('X');
    picoBlaze_movepBlock2Head(statsg->dbName);   // First

    /* print the global struct definitions */

    /* PENDING: this isnt the best place but it will do */
    if (port->general.glue_up_main) {
      /* create the interrupt vector table */
      picoBlazecreateInterruptVect (&vBuf);
    }

    /* emit code for the all the variables declared */
    picoBlazeemitMaps ();

    /* do the overlay segments */
    picoBlazeemitOverlay(&ovrBuf);
    picoBlaze_AnalyzepCode('*');

    picoBlaze_AnalyzepCode('*');


    if(picoBlaze_debug_verbose)
      picoBlaze_pcode_test();

    /* now put it all together into the assembler file */
    /* create the assembler file name */
    if((noAssemble || options.c1mode)  && fullDstFileName) {
      sprintf (buffer, fullDstFileName);
    } else {
      sprintf (buffer, dstFileName);
      strcat (buffer, ".asm");
    }

    if(!(asmFile = fopen (buffer, "w"))) {
      werror (E_FILE_OPEN_ERR, buffer);
      exit (1);
    }

    /* initial comments */
    picoBlazeinitialComments (asmFile);

    /* print module name */
    if(options.debug)
      fprintf(asmFile, "\t.file\t\"%s\"\n", fullSrcFileName);

    /* Let the port generate any global directives, etc. */
    if(port->genAssemblerPreamble) {
      port->genAssemblerPreamble(asmFile);
    }

    /* Put all variables into a cblock */
    picoBlaze_AnalyzeBanking();

    /* print the global variables in this module */
    picoBlazeprintPublics (asmFile);

    /* print the extern variables to this module */
    picoBlaze_printExterns(asmFile);

    picoBlaze_writeUsedRegs(asmFile);

    /* copy the interrupt vector table */
    if(mainf && IFFUNC_HASBODY(mainf->type)) {
      fprintf (asmFile, "\n%s", iComments2);
      fprintf (asmFile, "; interrupt vector \n");
      fprintf (asmFile, "%s", iComments2);
      dbuf_write_and_destroy (&vBuf, asmFile);
    }

    /* copy global & static initialisations */
    fprintf (asmFile, "\n%s", iComments2);
    fprintf (asmFile, "; global & static initialisations\n");
    fprintf (asmFile, "%s", iComments2);

    if(picoBlaze_debug_verbose)
      fprintf(asmFile, "; A code from now on!\n");

    picoBlaze_copypCode(asmFile, 'A');

    if(picoBlaze_options.no_crt) {
      if(mainf && IFFUNC_HASBODY(mainf->type)) {
        fprintf(asmFile, "\tcode\n");
        fprintf(asmFile,"__sdcc_gsinit_startup:\n");
      }
    }

//    dbuf_write_and_destroy (&code->oBuf, stderr);

    fprintf(asmFile, "; I code from now on!\n");
    picoBlaze_copypCode(asmFile, 'I');

    if(picoBlaze_debug_verbose)
      fprintf(asmFile, "; dbName from now on!\n");

    picoBlaze_copypCode(asmFile, statsg->dbName);

    if(picoBlaze_options.no_crt) {
      if (port->general.glue_up_main && mainf && IFFUNC_HASBODY(mainf->type)) {
        fprintf (asmFile,"\tgoto\t__sdcc_program_startup\n");
      }
    }

    if(picoBlaze_debug_verbose)
      fprintf(asmFile, "; X code from now on!\n");

    picoBlaze_copypCode(asmFile, 'X');

    if(picoBlaze_debug_verbose)
      fprintf(asmFile, "; M code from now on!\n");

    picoBlaze_copypCode(asmFile, 'M');

    picoBlaze_copypCode(asmFile, code->dbName);

    picoBlaze_copypCode(asmFile, 'P');

    emitStatistics(asmFile);

    fprintf (asmFile,"\tend\n");
    fclose (asmFile);
}
