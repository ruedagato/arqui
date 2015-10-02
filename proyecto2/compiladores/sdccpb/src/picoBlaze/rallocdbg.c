
#include "common.h"
#include "ralloc.h"
#include "rallocdbg.h"

#ifndef debugf
#define debugf(frm, rest)       _picoBlaze_debugf(__FILE__, __LINE__, frm, rest)
#endif
void _picoBlaze_debugf(char *f, int l, char *frm, ...);

#define NEWREG_DEBUG    0

int picoBlaze_ralloc_debug = 0;
FILE *debugF = NULL;

/*-----------------------------------------------------------------*/
/* debugLog - open a file for debugging information                */
/*-----------------------------------------------------------------*/
//static void debugLog(char *inst,char *fmt, ...)
void
debugLog (char *fmt,...)
{
  static int append = 0;        // First time through, open the file without append.

  char buffer[256];
  //char *bufferP=buffer;
  va_list ap;

  if (!picoBlaze_ralloc_debug || !dstFileName)
    return;


  if (!debugF)
    {
      /* create the file name */
      strcpy (buffer, dstFileName);
      strcat (buffer, ".d");

      if (!(debugF = fopen (buffer, (append ? "a+" : "w"))))
        {
          werror (E_FILE_OPEN_ERR, buffer);
          exit (1);
        }
      append = 1;               // Next time debubLog is called, we'll append the debug info

    }

  va_start (ap, fmt);

  vsprintf (buffer, fmt, ap);

  fprintf (debugF, "%s", buffer);
  //fprintf (stderr, "%s", buffer);
/*
   while (isspace((unsigned char)*bufferP)) bufferP++;

   if (bufferP && *bufferP)
   lineCurr = (lineCurr ?
   connectLine(lineCurr,newLineNode(lb)) :
   (lineHead = newLineNode(lb)));
   lineCurr->isInline = _G.inLine;
   lineCurr->isDebug  = _G.debugLine;
 */
  va_end (ap);

}

static void
debugNewLine (void)
{
  if(!picoBlaze_ralloc_debug)return;

  if (debugF)
    fputc ('\n', debugF);
}


/*-----------------------------------------------------------------*/
/* debugLogClose - closes the debug log file (if opened)           */
/*-----------------------------------------------------------------*/
void
debugLogClose (void)
{
  if (debugF) {
    fclose (debugF);
    debugF = NULL;
  }
}

char *
debugAopGet (char *str, operand * op)
{
        if(!picoBlaze_ralloc_debug)return NULL;

        if (str)
                debugLog (str);

        printOperand (op, debugF);
        debugNewLine ();

  return NULL;
}


char *
picoBlaze_decodeOp (unsigned int op)
{
	// function for debugging purposes
	
		if (op < 128 && op > ' ') {
                buffer[0] = (op & 0xff);
                buffer[1] = 0;
          return buffer;
        }

        switch (op) {
                case IDENTIFIER:        return "IDENTIFIER";
                case TYPE_NAME:         return "TYPE_NAME";
                case CONSTANT:          return "CONSTANT";
                case STRING_LITERAL:    return "STRING_LITERAL";
                case SIZEOF:            return "SIZEOF";
                case PTR_OP:            return "PTR_OP";
                case INC_OP:            return "INC_OP";
                case DEC_OP:            return "DEC_OP";
                case LEFT_OP:           return "LEFT_OP";
                case RIGHT_OP:          return "RIGHT_OP";
                case LE_OP:             return "LE_OP";
                case GE_OP:             return "GE_OP";
                case EQ_OP:             return "EQ_OP";
                case NE_OP:             return "NE_OP";
                case AND_OP:            return "AND_OP";
                case OR_OP:             return "OR_OP";
                case MUL_ASSIGN:        return "MUL_ASSIGN";
                case DIV_ASSIGN:        return "DIV_ASSIGN";
                case MOD_ASSIGN:        return "MOD_ASSIGN";
                case ADD_ASSIGN:        return "ADD_ASSIGN";
                case SUB_ASSIGN:        return "SUB_ASSIGN";
                case LEFT_ASSIGN:       return "LEFT_ASSIGN";
                case RIGHT_ASSIGN:      return "RIGHT_ASSIGN";
                case AND_ASSIGN:        return "AND_ASSIGN";
                case XOR_ASSIGN:        return "XOR_ASSIGN";
                case OR_ASSIGN:         return "OR_ASSIGN";
                case TYPEDEF:           return "TYPEDEF";
                case EXTERN:            return "EXTERN";
                case STATIC:            return "STATIC";
                case AUTO:              return "AUTO";
                case REGISTER:          return "REGISTER";
                case CODE:              return "CODE";
                case EEPROM:            return "EEPROM";
                case INTERRUPT:         return "INTERRUPT";
                case AT:                return "AT";
                case SBIT:              return "SBIT";
                case REENTRANT:         return "REENTRANT";
                case USING:             return "USING";
                case XDATA:             return "XDATA";
                case DATA:              return "DATA";
                case IDATA:             return "IDATA";
                case PDATA:             return "PDATA";
                case VAR_ARGS:          return "VAR_ARGS";
                case CRITICAL:          return "CRITICAL";
                case NONBANKED:         return "NONBANKED";
                case BANKED:            return "BANKED";
                case CHAR:              return "CHAR";
                case SHORT:             return "SHORT";
                case INT:               return "INT";
                case LONG:              return "LONG";
                case SIGNED:            return "SIGNED";
                case UNSIGNED:          return "UNSIGNED";
                case FLOAT:             return "FLOAT";
                case DOUBLE:            return "DOUBLE";
                case CONST:             return "CONST";
                case VOLATILE:          return "VOLATILE";
                case VOID:              return "VOID";
                case BIT:               return "BIT";
                case STRUCT:            return "STRUCT";
                case UNION:             return "UNION";
                case ENUM:              return "ENUM";
                case RANGE:             return "RANGE";
                case FAR:               return "FAR";
                case CASE:              return "CASE";
                case DEFAULT:           return "DEFAULT";
                case IF:                return "IF";
                case ELSE:              return "ELSE";
                case SWITCH:            return "SWITCH";
                case WHILE:             return "WHILE";
                case DO:                return "DO";
                case FOR:               return "FOR";
                case GOTO:              return "GOTO";
                case CONTINUE:          return "CONTINUE";
                case BREAK:             return "BREAK";
                case RETURN:            return "RETURN";
                case INLINEASM:         return "INLINEASM";
                case IFX:               return "IFX";
                case ADDRESS_OF:        return "ADDRESS_OF";
                case GET_VALUE_AT_ADDRESS:      return "GET_VALUE_AT_ADDRESS";
                case SPIL:              return "SPIL";
                case UNSPIL:            return "UNSPIL";
                case GETHBIT:           return "GETHBIT";
                case BITWISEAND:        return "BITWISEAND";
                case UNARYMINUS:        return "UNARYMINUS";
                case IPUSH:             return "IPUSH";
                case IPOP:              return "IPOP";
                case PCALL:             return "PCALL";
                case FUNCTION:          return "FUNCTION";
                case ENDFUNCTION:       return "ENDFUNCTION";
                case JUMPTABLE:         return "JUMPTABLE";
                case RRC:               return "RRC";
                case RLC:               return "RLC";
                case CAST:              return "CAST";
                case CALL:              return "CALL";
                case PARAM:             return "PARAM  ";
                case NULLOP:            return "NULLOP";
                case BLOCK:             return "BLOCK";
                case LABEL:             return "LABEL";
                case RECEIVE:           return "RECEIVE";
                case SEND:              return "SEND";
                case DUMMY_READ_VOLATILE:       return "DUMMY_READ_VOLATILE";
        }
        sprintf (buffer, "unkown op %d %c", op, op & 0xff);

  return buffer;
}


/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
char *
debugLogRegType (short type)
{
        if(!picoBlaze_ralloc_debug)return NULL;
        switch (type) {
                case REG_GPR: return "REG_GPR";
                case REG_PTR: return "REG_PTR";
                case REG_CND: return "REG_CND";
        }
        sprintf (buffer, "unknown reg type %d", type);

  return buffer;
}

void
dumpEbbsToDebug (eBBlock ** ebbs, int count)
{
  int i;

  if (!picoBlaze_ralloc_debug || !debugF)
    return;

  for (i = 0; i < count; i++)
    {
      fprintf (debugF, "\n----------------------------------------------------------------\n");
      fprintf (debugF, "Basic Block %s : loop Depth = %d noPath = %d , lastinLoop = %d\n",
               ebbs[i]->entryLabel->name,
               ebbs[i]->depth,
               ebbs[i]->noPath,
               ebbs[i]->isLastInLoop);
      fprintf (debugF, "depth 1st num %d : bbnum = %d 1st iCode = %d , last iCode = %d\n",
               ebbs[i]->dfnum,
               ebbs[i]->bbnum,
               ebbs[i]->fSeq,
               ebbs[i]->lSeq);
      fprintf (debugF, "visited %d : hasFcall = %d\n",
               ebbs[i]->visited,
               ebbs[i]->hasFcall);

      fprintf (debugF, "\ndefines bitVector :");
      bitVectDebugOn (ebbs[i]->defSet, debugF);
      fprintf (debugF, "\nlocal defines bitVector :");
      bitVectDebugOn (ebbs[i]->ldefs, debugF);
      fprintf (debugF, "\npointers Set bitvector :");
      bitVectDebugOn (ebbs[i]->ptrsSet, debugF);
      fprintf (debugF, "\nin pointers Set bitvector :");
      bitVectDebugOn (ebbs[i]->inPtrsSet, debugF);
      fprintf (debugF, "\ninDefs Set bitvector :");
      bitVectDebugOn (ebbs[i]->inDefs, debugF);
      fprintf (debugF, "\noutDefs Set bitvector :");
      bitVectDebugOn (ebbs[i]->outDefs, debugF);
      fprintf (debugF, "\nusesDefs Set bitvector :");
      bitVectDebugOn (ebbs[i]->usesDefs, debugF);
      fprintf (debugF, "\n----------------------------------------------------------------\n");
      printiCChain (ebbs[i]->sch, debugF);
    }
}

/*-----------------------------------------------------------------*/
/* some debug code to print the symbol S_TYPE. Note that
 * the function checkSClass in src/SDCCsymt.c dinks with
 * the S_TYPE in ways the PIC port doesn't fully like...*/
/*-----------------------------------------------------------------*/
void isData(sym_link *sl)
{
  FILE *of = stderr;

    if(!picoBlaze_ralloc_debug)return;

    if(!sl)return;

    if(debugF)
      of = debugF;

    for ( ; sl; sl=sl->next) {
      if(!IS_DECL(sl) ) {
        switch (SPEC_SCLS(sl)) {
          case S_DATA: fprintf (of, "data "); break;
          case S_XDATA: fprintf (of, "xdata "); break;
          case S_SBIT: fprintf (of, "sbit "); break;
          case S_CODE: fprintf (of, "code "); break;
          case S_IDATA: fprintf (of, "idata "); break;
          case S_PDATA: fprintf (of, "pdata "); break;
          case S_LITERAL: fprintf (of, "literal "); break;
          case S_STACK: fprintf (of, "stack "); break;
          case S_XSTACK: fprintf (of, "xstack "); break;
          case S_BIT: fprintf (of, "bit "); break;
          case S_EEPROM: fprintf (of, "eeprom "); break;
          default: break;
        }
      }
    }
}

void printSymType(char * str, sym_link *sl)
{
        if(!picoBlaze_ralloc_debug)return;

        debugLog ("    %s Symbol type: ",str);
        printTypeChain (sl, debugF);
        debugLog ("\n");
}

