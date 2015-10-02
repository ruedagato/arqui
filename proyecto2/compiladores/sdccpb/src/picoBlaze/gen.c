 /*-------------------------------------------------------------------------
 gen.c - source file for code generation for picoBlaze

  Written By -  Sandeep Dutta . sandeep.dutta@usa.net (1998)
         and -  Jean-Louis VERN.jlvern@writeme.com (1999)
  Bug Fixes  -  Wojciech Stryjewski  wstryj1@tiger.lsu.edu (1999 v2.1.9a)
  PIC port   -  Scott Dattalo scott@dattalo.com (2000)
  PICOBLAZE port -  Martin Dubuc m.dubuc@rogers.com (2002)
             -  Vangelis Rokas <vrokas AT users.sourceforge.net> (2003-2006)
  Bug Fixes  -  Raphael Neider <rneider AT web.de> (2004,2005)
  Bug Fixes  -  Borut Razem <borut.razem AT siol.net> (2007)
  Bug Fixes  -  Mauro Giachero <maurogiachero AT users.sourceforge.net> (2008)

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

#include "common.h"
#include "SDCCpeeph.h"
#include "ralloc.h"
#include "pcode.h"
#include "gen.h"
#include "genutils.h"
#include "device.h"
#include "main.h"
#include "glue.h"

#include "json/json.h"

/* The PIC port(s) do not need to distinguish between POINTER and FPOINTER. */
#define PIC_IS_DATA_PTR(x)      (IS_DATA_PTR(x) || IS_FARPTR(x))
#define PIC_IS_FARPTR(x)        (IS_DATA_PTR(x) || IS_FARPTR(x))
#define PIC_IS_TAGGED(x)        (IS_GENPTR(x) || IS_CODEPTR(x))
#define IS_DIRECT(op)           ((AOP_TYPE(op) == AOP_PCODE) && (AOP(op)->aopu.pcop->type == PO_DIR))

/* Wrapper to execute `code' at most once. */
#define PERFORM_ONCE(id,code)   do { static char id = 0; if (!id) { id = 1; code } } while (0)

void picoBlaze_genMult8X8_n (operand *, operand *, operand *);
extern void picoBlaze_printpBlock(FILE *of, pBlock *pb);
static asmop *newAsmop (short type);
static pCodeOp *picoBlaze_popRegFromString(char *str, int size, int offset, operand *op);
extern pCode *picoBlaze_newpCodeAsmDir(char *asdir, char *argfmt, ...);
static void mov2fp(pCodeOp *dst, asmop *src, int offset);
static pCodeOp *picoBlaze_popRegFromIdx(int rIdx);

int picoBlaze_labelOffset=0;
extern int picoBlaze_debug_verbose;

extern set *externs;

// JSON global json_object (contains array of iCodes)
//struct json_object * jo;	// TODO: initialize
extern int indentDeep;
int firstiCode = TRUE;

/* max_key keeps track of the largest label number used in
   a function. This is then used to adjust the label offset
   for the next function.
*/
static int max_key=0;
static int GpsuedoStkPtr=0;

pCodeOp *picoBlaze_popGetImmd(char *name, unsigned int offset, int index);

const char *picoBlaze_AopType(short type);
static iCode *ifxForOp ( operand *op, iCode *ic );

void picoBlaze_pushpCodeOp(pCodeOp *pcop);
void picoBlaze_poppCodeOp(pCodeOp *pcop);


#define BYTEofLONG(l,b) ( (l>> (b<<3)) & 0xff)

/* set the following macro to 1 to enable passing the
 * first byte of functions parameters via WREG */
#define USE_WREG_IN_FUNC_PARAMS 0


/* this is the down and dirty file with all kinds of
   kludgy & hacky stuff. This is what it is all about
   CODE GENERATION for a specific MCU . some of the
   routines may be reusable, will have to see */
static char *zero = "#0x00";
static char *one  = "#0x01";


/*
 * Function return value policy (MSB-->LSB):
 *  8 bits      -> WREG
 * 16 bits      -> PRODL:WREG
 * 24 bits      -> PRODH:PRODL:WREG
 * 32 bits      -> FSR0L:PRODH:PRODL:WREG
 * >32 bits     -> on stack, and FSR0 points to the beginning (TODO: choose another register in case of PicoBlaze)
 */
char *fReturnpicoBlaze[] = { "WREG", "PRODL", "PRODH", "FSR0L" };
unsigned picoBlaze_fReturnSizePic = 4; /* shared with ralloc.c */
static char **fReturn = fReturnpicoBlaze;

static char *accUse[] = {"WREG"};

static struct {
    short accInUse;
    short inLine;
    short debugLine;
    short nRegsSaved;
    set *sendSet;
    set *stackRegSet;
    int usefastretfie;
    bitVect *fregsUsed;                 /* registers used in function */
    bitVect *sregsAlloc;
    set *sregsAllocSet;                 /* registers used to store stack variables */
    int stack_lat;                      /* stack offset latency */
    int resDirect;
    int useWreg;                        /* flag when WREG is used to pass function parameter */
} _G;

extern struct dbuf_s *codeOutBuf;

static lineNode *lineHead = NULL;
static lineNode *lineCurr = NULL;

static unsigned char   SLMask[] = {0xFF ,0xFE, 0xFC, 0xF8, 0xF0,
0xE0, 0xC0, 0x80, 0x00};
static unsigned char   SRMask[] = {0xFF, 0x7F, 0x3F, 0x1F, 0x0F,
0x07, 0x03, 0x01, 0x00};

static pBlock *pb;


void directEmitCode(char * aString)
{

    char buffer[INITIAL_INLINEASM];
	sprintf(buffer,"#### %s", aString);
    picoBlaze_addpBlock(picoBlaze_newpCodeChain(GcurMemmap,0,picoBlaze_newpCodeCharP(buffer)));
}

void directEmitCodeFormated(char * format, char * aString, ...)
{
	va_list ap;
    char buffer[INITIAL_INLINEASM];
	char buffer2[INITIAL_INLINEASM];
	sprintf(buffer,"#### %s", format);
	va_start(ap, aString);
	sprintf(buffer2,buffer, aString, ap);
	va_end(ap);
    picoBlaze_addpBlock(picoBlaze_newpCodeChain(GcurMemmap,0,picoBlaze_newpCodeCharP(buffer2)));
}


void directEmitComment(char * aString)
{
   char buffer[INITIAL_INLINEASM];
   sprintf(buffer,"#### **** %s", aString);
   picoBlaze_addpBlock(picoBlaze_newpCodeChain(GcurMemmap,0,picoBlaze_newpCodeCharP(buffer)));
}

void dumpICode(char * format, ...)
{
	// Is JSON dump enabled?
	if(picoBlaze_options.json_flag)
	{
		int i; 
		va_list ap;

		for (i=0; i<4*iCodeDumpFileDeep; i++)
			fprintf(iCodeDumpFile, " ");

		va_start(ap, format);
			vfprintf(iCodeDumpFile, format, ap);
		va_end(ap);
	}
}



void iDumpS(char * name, char * val)
{
	// Is JSON dump enabled?
	if (!picoBlaze_options.json_flag)
		return;

	if (val)
		dumpICode("\"%s\": \"%s\",\n", name, val); 
	else
		dumpICode("\"%s\": \"\",\n", name); 
}

void iDumpStruct(char * aString, int isEnd)
{
	// Is JSON dump enabled?
	if (!picoBlaze_options.json_flag)
		return;

	if (isEnd)
		iCodeDumpFileDeep--;
	
	dumpICode("%s\n", aString);

	if (!isEnd)
		iCodeDumpFileDeep++;
}

//void iDumpOperand(operand * op)
//{
//	// Is JSON dump enabled?
////	if (!picoBlaze_options.json_flag)
////		return;
//
//	iDumpS("structType", "operand");
//	// operand type
//	iDumpU("type", op->type);
//	if(op->type == SYMBOL)
//		iDumpS("typeValue", "SYMBOL");
//	else if(op->type == VALUE)
//		iDumpS("typeValue", "VALUE");
//	else if(op->type ==	TYPE)
//		iDumpS("typeValue", "TYPE");
//	else 
//		iDumpS("typeValue", "N/A");
//
//	// operand type is VALUE => valOperand
//	if (op->type == VALUE)
//	{
//		iDumpStruct("\"valOperand\": {", 0);
//		iDumpS("structType", "value");
//		iDumpS("name", (OP_VALUE(op)->name));
//
//		iDumpStruct("\"type\": {", 0);
//		iDumpS("structType", "sym_link");
//		iDumpU("class", (OP_VALUE(op))->type->class); // SYM_LINK_CLASS enum value
//		iDumpU("tdef", (OP_VALUE(op))->type->tdef);
//		iDumpStruct("\"select\": {", 0);
//		// select
//		  if(OP_VALUE(op)->type->class == SPECIFIER)
//		  {
//			  specifier s = (OP_VALUE(op)->type->select.s);
//			  // s:specifier
//			  iDumpS("structType", "specifier");
//			  iDumpU("noun", s.noun);
//			  //if(s.noun == V_INT)
//				iDumpU("v_int", s.const_val.v_int);
//			  if(s.noun == V_CHAR)
//				iDumpI("v_char", s.const_val.v_char);
//		  }
//		  else if(OP_VALUE(op)->type->class == DECLARATOR)
//		  {
//			  // d:declarator
//			  iDumpS("structType", "declarator");
//		  }
//		  else
//		  {
//				// TODO error, class is undefined	  
//		  }
//		iDumpStruct("},", 1);
//		// funcAttrs
//		// next
//
//		iDumpU("vArgs", (OP_VALUE(op)->vArgs));
//
//		iDumpStruct("},", 1);
//		iDumpStruct("},", 1);
//	}
//
//	iDumpU("isLiteral", op->isLiteral);
//	iDumpU("isParam", op->isParm);
//
//	
//}

//struct json_object * jsonDumpiCode(iCode * ic)
//{
//	struct json_object * iCodeObj = json_object_new_object();
//	struct json_object * seqObj = json_object_new_int(ic->seq);
//	struct json_object * fileNameObj = json_object_new_string(ic->filename);
//	struct json_object * leftOperandObj = jsonDumpOperand((ic->ulrrcnd).lrr.left);
//	//json_object_init();
//	MC_SET_DEBUG(1);
//
//	// TODO
//
//	return iCodeObj;
//}
struct json_object * jsonDumpSymbol(symbol * sym);

struct json_object * jsonDumpSymLink(sym_link * symlink, enum OP_TYPE type)
{
	struct json_object * symLinkObj;// = json_object_new_object();
	struct json_object * specifierObj;
	struct json_object * declaratorObj;
	struct json_object * funAttrsObj;
	struct json_object * funArgsArrayObj;
	struct json_object * funParamObj;

	struct specifier s;
	struct declarator d;
	bool genFunAttrs = 0;

		symLinkObj = json_object_new_object();
		json_object_object_add(symLinkObj, "structType", json_object_new_string("sym_link"));
		json_object_object_add(symLinkObj, "class", json_object_new_int(symlink->class));		// SYM_LINK_CLASS enum value
		json_object_object_add(symLinkObj, "tdef", json_object_new_int((unsigned int)(symlink->tdef)));

		// select
		  if(symlink->class == SPECIFIER)
		  {
			  // s:specifier
			  specifierObj = json_object_new_object();
			  
			  s = (symlink->select.s);
			  
			  json_object_object_add(specifierObj, "structType", json_object_new_string("specifier"));
			  json_object_object_add(specifierObj, "noun", json_object_new_int(s.noun));
			  if(s.noun == V_INT)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_INT"));
			  else if(s.noun == V_FLOAT)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_FLOAT"));
			  else if(s.noun == V_FIXED16X16)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_FIXED16X16"));
			  else if(s.noun == V_CHAR)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_CHAR"));
			  else if(s.noun == V_VOID)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_VOID"));
			  else if(s.noun == V_STRUCT)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_STRUCT"));
			  else if(s.noun == V_LABEL)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_LABEL"));
			  else if(s.noun == V_BIT)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_BIT"));
			  else if(s.noun == V_BITFIELD)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_BITFIELD"));
			  else if(s.noun == V_SBIT)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_SBIT"));
			  else if(s.noun == V_DOUBLE)
				json_object_object_add(specifierObj, "nounValue", json_object_new_string("V_DOUBLE"));

			  if (type == SYMBOL || type == VALUE)
			  {

				  if(s.b_long == 1)
					json_object_object_add(specifierObj, "b_long", json_object_new_int(s.b_long));
				  if(s.b_short == 1)
					json_object_object_add(specifierObj, "b_short", json_object_new_int(s.b_short));
				  if(s.b_unsigned == 1)
					json_object_object_add(specifierObj, "b_unsigned", json_object_new_int(s.b_unsigned));
				  if(s.b_signed == 1)
					json_object_object_add(specifierObj, "b_signed", json_object_new_int(s.b_signed));
				  if(s.b_static == 1)
					json_object_object_add(specifierObj, "b_static", json_object_new_int(s.b_static));
				  if(s.b_extern == 1)
					json_object_object_add(specifierObj, "b_extern", json_object_new_int(s.b_extern));
				  if(s.b_inline == 1)
					json_object_object_add(specifierObj, "b_inline", json_object_new_int(s.b_inline));
				  if(s.b_absadr == 1)
				  {
					json_object_object_add(specifierObj, "b_absadr", json_object_new_int(s.b_absadr));
					json_object_object_add(specifierObj, "address", json_object_new_int(s._addr));
				  }
				  if(s.b_volatile == 1)
					json_object_object_add(specifierObj, "b_volatile", json_object_new_int(s.b_volatile));
				  if(s.b_const == 1)
					json_object_object_add(specifierObj, "b_const", json_object_new_int(s.b_const));
				  if(s.b_isenum == 1)
					json_object_object_add(specifierObj, "b_isenum", json_object_new_int(s.b_isenum));
				  if(s.b_restrict == 1)
					json_object_object_add(specifierObj, "b_restrict", json_object_new_int(s.b_restrict));
				  if(s.b_typedef == 1)
					json_object_object_add(specifierObj, "b_typedef", json_object_new_int(s.b_typedef));
				  if(s.b_isregparm == 1)
					json_object_object_add(specifierObj, "b_isregparm", json_object_new_int(s.b_isregparm));

				  //if(s.noun == V_INT)
					json_object_object_add(specifierObj, "v_int", json_object_new_int(s.const_val.v_int));
				  if(s.noun == V_CHAR)
					json_object_object_add(specifierObj, "v_char", json_object_new_int((int)s.const_val.v_char));

				  if(s.noun == V_INT || s.noun == V_FIXED16X16)
				  {
					json_object_object_add(specifierObj, "v_uint", json_object_new_int(s.const_val.v_uint));
					json_object_object_add(specifierObj, "v_long", json_object_new_int(s.const_val.v_long));
					json_object_object_add(specifierObj, "v_ulong", json_object_new_int(s.const_val.v_ulong));
				  }

				  if(s.noun == V_FLOAT || s.noun == V_DOUBLE)
				  {
					  //json_object_object_add(specifierObj, "v_float", json_object_new_float(s.const_val.v_float));
				  }

				  // TODO: v_enum? Do we need to export s.storage_class (see STORAGE_CLASS enum)
			  }
			  else if (type == TYPE)
			  {
				  // TODO: if needed some extra listing
			  }
			  else
			  {
				  // TODO: error
			  }

			  json_object_object_add(symLinkObj, "select", specifierObj);
		  }
		  else if(symlink->class == DECLARATOR)
		  {
			  // d:declarator
			  declaratorObj = json_object_new_object();
			  d = symlink->select.d;
			  json_object_object_add(declaratorObj, "structType", json_object_new_string("declarator"));

			  /* types of declarators: enum DECLARATOR_TYPE */
			  if (d.dcl_type == POINTER)
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("POINTER"));
			  else if (d.dcl_type == FPOINTER)
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("FPOINTER"));
			  else if (d.dcl_type == CPOINTER)
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("CPOINTER"));
			  else if (d.dcl_type == GPOINTER)
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("GPOINTER"));
			  else if (d.dcl_type == PPOINTER)
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("PPOINTER"));
			  else if (d.dcl_type == IPOINTER)
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("IPOINTER"));
			  else if (d.dcl_type == UPOINTER) /* unknown pointer used only when parsing */
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("UPOINTER"));
			  else if (d.dcl_type == EEPPOINTER) /* pointer to eeprom     */
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("EEPPOINTER"));
			  else if (d.dcl_type == ARRAY)
			  {
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("ARRAY"));
				json_object_object_add(declaratorObj, "num_elem", json_object_new_int((unsigned int)d.num_elem));
			  }
			  else if (d.dcl_type == FUNCTION)
			  {
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("FUNCTION"));
				genFunAttrs = TRUE;
			  }
			  else 
				json_object_object_add(declaratorObj, "dcl_type", json_object_new_string("N/A"));


			  json_object_object_add(symLinkObj, "select", declaratorObj);
		  }
		  else
		  {
				// TODO error, class is undefined	  
		  }


	if (genFunAttrs)	// see select.d.dcl_type==DECLARATOR_TYPE::FUNCTION
	{
		value * arg = symlink->funcAttrs.args;
		//int i = 0;
		funAttrsObj = json_object_new_object();
		funArgsArrayObj = json_object_new_array();

		// properties of declared function (caleesaves, interrupt handler, inline req., reentrancy, ...)
		json_object_object_add(funAttrsObj, "calleeSaves", json_object_new_int((unsigned int)symlink->funcAttrs.calleeSaves));
		json_object_object_add(funAttrsObj, "reent", json_object_new_int((unsigned int)symlink->funcAttrs.reent));
		json_object_object_add(funAttrsObj, "intrtn", json_object_new_int((unsigned int)symlink->funcAttrs.intrtn)); // if the declared function is an interrupt handler
		json_object_object_add(funAttrsObj, "intno", json_object_new_int((unsigned int)symlink->funcAttrs.intno)); // the number of interrupt handler (as in function handler() __interrupt(intno=implicit 256))
		// TODO: more properties and statistics of the function such as inlining, spiling, used reg. banks, ...

		while(arg)
		{
			funParamObj = json_object_new_object();
			json_object_object_add(funParamObj, "structType", json_object_new_string("value"));
			json_object_object_add(funParamObj, "name", json_object_new_string(arg->name));
			if (arg->sym != NULL)
				json_object_object_add(funParamObj, "sym", jsonDumpSymbol(arg->sym));

			json_object_array_add(funArgsArrayObj, funParamObj);
			arg = arg->next;
			//i++;
		}

		if (symlink->funcAttrs.args != NULL)
		{
			json_object_object_add(funAttrsObj, "args", funArgsArrayObj);
		}
		json_object_object_add(symLinkObj, "funAttrs", funAttrsObj);
	}

	return symLinkObj;
}


struct json_object * jsonDumpSymbol(symbol * sym)
{
	struct json_object * symbolObj = json_object_new_object();
	//struct json_object * symLinkObj;
	//struct json_object * specifierObj;
	//struct json_object * declaratorObj;

	json_object_object_add(symbolObj, "structType", json_object_new_string("symbol"));
	// OP_SYMBOL->type
	json_object_object_add(symbolObj, "name", json_object_new_string(sym->name));
	json_object_object_add(symbolObj, "rname", json_object_new_string(sym->rname));

	json_object_object_add(symbolObj, "level", json_object_new_int((int)sym->level)); /* declaration lev,fld offset */
	json_object_object_add(symbolObj, "block", json_object_new_int((int)sym->block)); /* sequential block # of definition */
	json_object_object_add(symbolObj, "key", json_object_new_int((int)sym->key));
	json_object_object_add(symbolObj, "flexArrayLength", json_object_new_int((unsigned int)sym->flexArrayLength)); 
	/*  if the symbol specifies a struct
		with a "flexible array member", then the additional length in bytes for
		the "fam" is stored here. Because the length can be different from symbol
		to symbol AND v_struct isn't copied in copyLinkChain(), it's located here
		in the symbol and not in v_struct or the declarator */

	json_object_object_add(symbolObj, "implicit", json_object_new_int((unsigned int)sym->implicit));		/* implicit flag                     */
	json_object_object_add(symbolObj, "undefined", json_object_new_int((unsigned int)sym->undefined));	/* undefined variable                */
	json_object_object_add(symbolObj, "infertype", json_object_new_int((unsigned int)sym->infertype));	/* type should be inferred from first assign */
	json_object_object_add(symbolObj, "_isparm", json_object_new_int((unsigned int)sym->_isparm));		/* is a parameter          */
	json_object_object_add(symbolObj, "ismyparm", json_object_new_int((unsigned int)sym->ismyparm));		/* is parameter of the function being generated */
	json_object_object_add(symbolObj, "isitmp", json_object_new_int((unsigned int)sym->isitmp));			/* is an intermediate temp */
	json_object_object_add(symbolObj, "islbl", json_object_new_int((unsigned int)sym->islbl));			/* is a temporary label */
	json_object_object_add(symbolObj, "islocal", json_object_new_int((unsigned int)sym->islocal));			/* is a local variable */
	json_object_object_add(symbolObj, "isref", json_object_new_int((unsigned int)sym->isref));			/* has been referenced  */
	json_object_object_add(symbolObj, "isind", json_object_new_int((unsigned int)sym->isind));			/* is a induction variable */
	json_object_object_add(symbolObj, "isinvariant", json_object_new_int((unsigned int)sym->isinvariant));  /* is a loop invariant  */
	json_object_object_add(symbolObj, "cdef", json_object_new_int((unsigned int)sym->cdef));				/* compiler defined symbol */
	json_object_object_add(symbolObj, "addrtaken", json_object_new_int((unsigned int)sym->addrtaken));	/* address of the symbol was taken */
	json_object_object_add(symbolObj, "isreqv", json_object_new_int((unsigned int)sym->isreqv));			/* is the register equivalent of a symbol */
	json_object_object_add(symbolObj, "udChked", json_object_new_int((unsigned int)sym->udChked));		/* use def checking has been already done */
	json_object_object_add(symbolObj, "generated", json_object_new_int((unsigned int)sym->generated));	/* code generated (function symbols only) */
	
	json_object_object_add(symbolObj, "liveFrom", json_object_new_int((unsigned int)sym->liveFrom));		/* live from iCode sequence number */
	json_object_object_add(symbolObj, "liveTo", json_object_new_int((unsigned int)sym->liveTo));		/* live to sequence number */
    
	if (sym->type)
		json_object_object_add(symbolObj, "type", jsonDumpSymLink(sym->type, SYMBOL));
	//else if (sym->etype)
	//	json_object_object_add(symbolObj, "etype", jsonDumpSymLink(sym->etype, SYMBOL));

	return symbolObj;
}

struct json_object * jsonDumpOperand(operand * op)
{
	struct json_object * operandObj = json_object_new_object();
	struct json_object * valueObj;
	struct json_object * symbolObj;
	struct json_object * symLinkObj;
	struct json_object * specifierObj;
	struct json_object * declaratorObj;
	struct json_object * typeObj;
//	struct json_object * testObj = json_object_new_array();
//	struct json_object * objObj = json_object_new_object();
	//json_object_init();
	specifier s;
	MC_SET_DEBUG(1);

	json_object_object_add(operandObj, "structType", json_object_new_string("operand"));
	// operand type
	json_object_object_add(operandObj, "type", json_object_new_int((unsigned int)(op->type)));
	if(op->type == SYMBOL)
		json_object_object_add(operandObj, "typeValue", json_object_new_string("SYMBOL"));
	else if(op->type == VALUE)
		json_object_object_add(operandObj, "typeValue", json_object_new_string("VALUE"));
	else if(op->type ==	TYPE)
		json_object_object_add(operandObj, "typeValue", json_object_new_string("TYPE"));
	else 
		json_object_object_add(operandObj, "typeValue", json_object_new_string("N/A"));

	// operand type is VALUE => valOperand
	if (op->type == VALUE)
	{
		valueObj = json_object_new_object();

		json_object_object_add(valueObj, "structType", json_object_new_string("value"));
		json_object_object_add(valueObj, "name", json_object_new_string(OP_VALUE(op)->name));

	    json_object_object_add(valueObj, "type", jsonDumpSymLink(OP_VALUE(op)->type, op->type));

		// funcAttrs
		// next

		json_object_object_add(valueObj, "vArgs", json_object_new_int(OP_VALUE(op)->vArgs));

		// add value object to operand object
		json_object_object_add(operandObj, "valOperand", valueObj);
	}
	// operand type is TYPE => typeOperand
	else if (op->type == TYPE)
	{
		typeObj = json_object_new_object();
		json_object_object_add(typeObj, "type", jsonDumpSymLink(op->operand.typeOperand, op->type));
		// TODO

		json_object_object_add(operandObj, "typeOperand", typeObj);		
	}
	// operand type is SYMBOL => symOperand
	else if (op->type == SYMBOL)
	{
		symbol * s = OP_SYMBOL(op);
		symbolObj = jsonDumpSymbol(s);

		json_object_object_add(operandObj, "symOperand", symbolObj);
	}

	json_object_object_add(operandObj, "isLiteral", json_object_new_int((unsigned int)(op->isLiteral)));
	json_object_object_add(operandObj, "isParam", json_object_new_int((unsigned int)(op->isParm)));
	
	//json_object_put(operandObj);
	//json_object_fini();
	return operandObj;
}

/*-----------------------------------------------------------------*/
/*  my_powof2(n) - If `n' is an integaer power of 2, then the      */
/*                 exponent of 2 is returned, otherwise -1 is      */
/*                 returned.                                       */
/* note that this is similar to the function `powof2' in SDCCsymt  */
/* if(n == 2^y)                                                    */
/*   return y;                                                     */
/* return -1;                                                      */
/*-----------------------------------------------------------------*/
int picoBlaze_my_powof2 (unsigned long num)
{
  if(num) {
    if( (num & (num-1)) == 0) {
      int nshifts = -1;
      while(num) {
        num>>=1;
        nshifts++;
      }
      return nshifts;
    }
  }

  return -1;
}

void DEBUGpicoBlaze_picoBlaze_AopType(int line_no, operand *left, operand *right, operand *result)
{
  DEBUGpicoBlaze_emitcode ("; ","line = %d result %s=%s, left %s=%s, right %s=%s, size = %d",
                       line_no,
                       ((result) ? picoBlaze_AopType(AOP_TYPE(result)) : "-"),
                       ((result) ? picoBlaze_aopGet(AOP(result),0,TRUE,FALSE) : "-"),
                       ((left)   ? picoBlaze_AopType(AOP_TYPE(left)) : "-"),
                       ((left)   ? picoBlaze_aopGet(AOP(left),0,TRUE,FALSE) : "-"),
                       ((right)  ? picoBlaze_AopType(AOP_TYPE(right)) : "-"),
                       ((right)  ? picoBlaze_aopGet(AOP(right),0,FALSE,FALSE) : "-"),
                       ((result) ? AOP_SIZE(result) : 0));
}

void DEBUGpicoBlaze_picoBlaze_AopTypeSign(int line_no, operand *left, operand *right, operand *result)
{

  DEBUGpicoBlaze_emitcode ("; ","line = %d, signs: result %s=%c, left %s=%c, right %s=%c",
                       line_no,
                       ((result) ? picoBlaze_AopType(AOP_TYPE(result)) : "-"),
                       ((result) ? (SPEC_USIGN(operandType(result)) ? 'u' : 's') : '-'),
                       ((left)   ? picoBlaze_AopType(AOP_TYPE(left)) : "-"),
                       ((left)   ? (SPEC_USIGN(operandType(left))   ? 'u' : 's') : '-'),
                       ((right)  ? picoBlaze_AopType(AOP_TYPE(right)) : "-"),
                       ((right)  ? (SPEC_USIGN(operandType(right))  ? 'u' : 's') : '-'));

}

void picoBlaze_emitpcomment (char *fmt, ...)
{
    va_list ap;
    char lb[INITIAL_INLINEASM];
    unsigned char *lbp = (unsigned char *)lb;

    va_start(ap,fmt);

    lb[0] = ';';
    vsprintf(lb+1,fmt,ap);

    while (isspace(*lbp)) lbp++;

    if (lbp && *lbp)
        lineCurr = (lineCurr ?
                    connectLine(lineCurr,newLineNode(lb)) :
                    (lineHead = newLineNode(lb)));
    lineCurr->isInline = _G.inLine;
    lineCurr->isDebug  = _G.debugLine;
    lineCurr->isComment = 1;

    picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeCharP(lb));
    va_end(ap);

//      fprintf(stderr, "%s\n", lb);
}

void DEBUGpicoBlaze_emitcode (char *inst,char *fmt, ...)
{
    va_list ap;
    char lb[INITIAL_INLINEASM];
    unsigned char *lbp = (unsigned char *)lb;

    if(!picoBlaze_debug_verbose)
      return;

    va_start(ap,fmt);

    if (inst && *inst) {
        if (fmt && *fmt)
            sprintf(lb,"%s\t",inst);
        else
            sprintf(lb,"%s",inst);
        vsprintf(lb+(strlen(lb)),fmt,ap);
    }  else
        vsprintf(lb,fmt,ap);

    while (isspace(*lbp)) lbp++;

    if (lbp && *lbp)
        lineCurr = (lineCurr ?
                    connectLine(lineCurr,newLineNode(lb)) :
                    (lineHead = newLineNode(lb)));
    lineCurr->isInline = _G.inLine;
    lineCurr->isDebug  = _G.debugLine;

    picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeCharP(lb));
    va_end(ap);

//      fprintf(stderr, "%s\n", lb);
}



void picoBlaze_emitpLabel(int key)
{
  if(key>max_key)
    max_key = key;

  picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeLabel(NULL,key+100+picoBlaze_labelOffset));
}

void picoBlaze_emitpLabelFORCE(int key)
{
  if(key>max_key)
    max_key = key;

  picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeLabelFORCE(NULL,key+100+picoBlaze_labelOffset));
}

/* gen.h defines a macro picoBlaze_emitpcode that allows for debug information to be inserted on demand
 * NEVER call picoBlaze_emitpcode_real directly, please... */
void picoBlaze_emitpcode_real(PIC_OPCODE poc, pCodeOp *pcop)
{

  if(pcop)
    picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCode(poc,pcop));
  else
    DEBUGpicoBlaze_emitcode(";","%s  ignoring NULL pcop",__FUNCTION__);
}

void picoBlaze_emitpinfo(INFO_TYPE itype, pCodeOp *pcop)
{
  if(pcop)
    picoBlaze_addpCode2pBlock(pb, picoBlaze_newpCodeInfo(itype, pcop));
  else
    DEBUGpicoBlaze_emitcode(";","%s  ignoring NULL pcop",__FUNCTION__);
}

void picoBlaze_emitpcodeNULLop(PIC_OPCODE poc)
{

  picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCode(poc,NULL));

}


#if 1
#define picoBlaze_emitcode  DEBUGpicoBlaze_emitcode
#else
/*-----------------------------------------------------------------*/
/* picoBlaze_emitcode - writes the code into a file : for now it is simple    */
/*-----------------------------------------------------------------*/
void picoBlaze_emitcode (char *inst,char *fmt, ...)
{
    va_list ap;
    char lb[INITIAL_INLINEASM];
    unsigned char *lbp = lb;

    va_start(ap,fmt);

    if (inst && *inst) {
        if (fmt && *fmt)
            sprintf(lb,"%s\t",inst);
        else
            sprintf(lb,"%s",inst);
        vsprintf(lb+(strlen(lb)),fmt,ap);
    }  else
        vsprintf(lb,fmt,ap);

    while (isspace(*lbp)) lbp++;

    if (lbp && *lbp)
        lineCurr = (lineCurr ?
                    connectLine(lineCurr,newLineNode(lb)) :
                    (lineHead = newLineNode(lb)));
    lineCurr->isInline = _G.inLine;
    lineCurr->isDebug  = _G.debugLine;
    lineCurr->picoBlaze_isLabel = (lbp[strlen (lbp) - 1] == ':');
    lineCurr->isComment = (*lbp == ';');

// VR    fprintf(stderr, "lb = <%s>\n", lbp);

//    if(picoBlaze_debug_verbose)
//      picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeCharP(lb));

    va_end(ap);
}
#endif


/*-----------------------------------------------------------------*/
/* picoBlaze_emitDebuggerSymbol - associate the current code location  */
/*   with a debugger symbol                                        */
/*-----------------------------------------------------------------*/
void
picoBlaze_emitDebuggerSymbol (char * debugSym)
{
  _G.debugLine = 1;
  picoBlaze_emitcode (";", "%s ==.", debugSym);
  _G.debugLine = 0;
}

/*-----------------------------------------------------------------*/
/* newAsmop - creates a new asmOp                                  */
/*-----------------------------------------------------------------*/
static asmop *newAsmop (short type)
{
    asmop *aop;

    aop = Safe_calloc(1,sizeof(asmop));
    aop->type = type;
    return aop;
}

/*-----------------------------------------------------------------*/
/* resolveIfx - converts an iCode ifx into a form more useful for  */
/*              generating code                                    */
/*-----------------------------------------------------------------*/
static void resolveIfx(resolvedIfx *resIfx, iCode *ifx)
{
  FENTRY2;

//  DEBUGpicoBlaze_emitcode("; ***","%s %d",__FUNCTION__,__LINE__);

  if(!resIfx)
    return;


  resIfx->condition = 1;    /* assume that the ifx is true */
  resIfx->generated = 0;    /* indicate that the ifx has not been used */

  if(!ifx) {
    resIfx->lbl = newiTempLabel(NULL);  /* oops, there is no ifx. so create a label */

#if 1
    DEBUGpicoBlaze_emitcode("; ***","%s %d null ifx creating new label key =%d",
                        __FUNCTION__,__LINE__,resIfx->lbl->key);
#endif

  } else {
    if(IC_TRUE(ifx)) {
      resIfx->lbl = IC_TRUE(ifx);
    } else {
      resIfx->lbl = IC_FALSE(ifx);
      resIfx->condition = 0;
    }

#if 1
    if(IC_TRUE(ifx))
      DEBUGpicoBlaze_emitcode("; +++","ifx true is non-null");
    else
      DEBUGpicoBlaze_emitcode("; +++","ifx true is null");
    if(IC_FALSE(ifx))
      DEBUGpicoBlaze_emitcode("; +++","ifx false is non-null");
    else
      DEBUGpicoBlaze_emitcode("; +++","ifx false is null");
#endif
  }

  DEBUGpicoBlaze_emitcode("; ***","%s lbl->key=%d, (lab offset=%d)",__FUNCTION__,resIfx->lbl->key,picoBlaze_labelOffset);

}


/*-----------------------------------------------------------------*/
/* aopForSym - for a true symbol                                   */
/*-----------------------------------------------------------------*/
static asmop *aopForSym (iCode *ic, operand *op, bool result)
{
    symbol *sym=OP_SYMBOL(op);
    asmop *aop;
    memmap *space= SPEC_OCLS(sym->etype);

    FENTRY2;

    _G.resDirect = 0;   /* clear flag that instructs the result is loaded directly from aopForSym */

//    sym = OP_SYMBOL(op);

    /* if already has one */
    if (sym->aop) {
            DEBUGpicoBlaze_emitcode("; ***", "already has sym %s %d", __FUNCTION__, __LINE__);
        return sym->aop;
    }


#if 1
    /* assign depending on the storage class */
    /* if it is on the stack or indirectly addressable */
    /* space we need to assign either r0 or r1 to it   */
    if (sym->onStack)   // || sym->iaccess)
    {
      pCodeOp *pcop[4];
      int i;

        DEBUGpicoBlaze_emitcode("; ***", "%s:%d sym->onStack:%d || sym->iaccess:%d",
                __FUNCTION__, __LINE__, sym->onStack, sym->iaccess);

        /* acquire a temporary register -- it is saved in function */

        sym->aop = aop = newAsmop(AOP_STA);
        aop->aopu.stk.stk = sym->stack;
        aop->size = getSize(sym->type);


        DEBUGpicoBlaze_emitcode("; +++ ", "%s:%d\top = %s", __FILE__, __LINE__, picoBlaze_decodeOp(ic->op));
        if((ic->op == '=' /*|| ic->op == CAST*/) && IC_RESULT(ic) && AOP( IC_RESULT(ic) )
          && (AOP_TYPE(IC_RESULT(ic)) == AOP_REG)) {
//          picoBlaze_DumpAop("aopForSym", AOP( IC_RESULT(ic) ));

          for(i=0;i<aop->size;i++)
            aop->aopu.stk.pop[i] = pcop[i] = picoBlaze_popRegFromIdx( AOP(IC_RESULT(ic))->aopu.aop_reg[i]->rIdx);
            _G.resDirect = 1;   /* notify that result will be loaded directly from aopForSym */
        } else
        if(1 && ic->op == SEND) {

          /* if SEND do the send here */
          _G.resDirect = 1;
        } else {
//                debugf3("symbol `%s' level = %d / %d\n", sym->name, ic->level, ic->seq);
          for(i=0;i<aop->size;i++) {
            aop->aopu.stk.pop[i] = pcop[i] = picoBlaze_popGetTempRegCond(_G.fregsUsed, _G.sregsAlloc, 0 );
            _G.sregsAlloc = bitVectSetBit(_G.sregsAlloc, PCOR(pcop[i])->r->rIdx);
          }
        }


//        fprintf(stderr, "%s:%d\t%s\tsym size %d\n", __FILE__, __LINE__, __FUNCTION__, aop->size);

#if 1
        DEBUGpicoBlaze_emitcode(";","%d sym->rname = %s, size = %d stack = %d",__LINE__,sym->rname,aop->size, sym->stack);

        // we do not need to load the value if it is to be defined...
        if (result) return aop;


        for(i=0;i<aop->size;i++) {

          /* initialise for stack access via frame pointer */
          // operands on stack are accessible via "{FRAME POINTER} + index" with index
          // starting at 2 for arguments and growing from 0 downwards for
          // local variables (index == 0 is not assigned so we add one here)
          {
            int soffs = sym->stack;
            if (soffs <= 0) {
              assert (soffs < 0);
              soffs++;
            } // if

            if(1 && ic->op == SEND) {
              picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(soffs + aop->size - i - 1 /*+ _G.stack_lat*/));
//*//              picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(
//*//                    picoBlaze_popCopyReg( picoBlaze_frame_plusw ),
//*//                    picoBlaze_popCopyReg(picoBlaze_stack_postdec )));
            } else {
              picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(soffs + i /*+ _G.stack_lat*/));
//*//              picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(
//*//                  picoBlaze_popCopyReg( picoBlaze_frame_plusw ), pcop[i]));
            }
          }
        }

        if(_G.accInUse) {
//*//                picoBlaze_poppCodeOp( picoBlaze_popCopyReg(&picoBlaze_pc_wreg) );
        }

        return (aop);
#endif


    }
#endif

#if 1
    /* special case for a function */
    if (IS_FUNC(sym->type)) {
        sym->aop = aop = newAsmop(AOP_PCODE);
        aop->aopu.pcop = picoBlaze_popGetImmd(sym->rname, 0, 0);
        PCOI(aop->aopu.pcop)->_const = IN_CODESPACE(space);
        PCOI(aop->aopu.pcop)->index = 0;
        aop->size = FPTRSIZE;
        DEBUGpicoBlaze_emitcode(";","%d size = %d, name =%s",__LINE__,aop->size,sym->rname);
        return aop;
    }
#endif



    //DEBUGpicoBlaze_emitcode(";","%d",__LINE__);
    /* if in bit space */
    if (IN_BITSPACE(space)) {
        sym->aop = aop = newAsmop (AOP_CRY);
        aop->aopu.aop_dir = sym->rname ;
        aop->size = getSize(sym->type);
        DEBUGpicoBlaze_emitcode(";","%d sym->rname = %s, size = %d",__LINE__,sym->rname,aop->size);
        return aop;
    }
    /* if it is in direct space */
    if (IN_DIRSPACE(space)) {
                if(!strcmp(sym->rname, "_WREG")) {
                        sym->aop = aop = newAsmop (AOP_ACC);
                        aop->size = getSize(sym->type);         /* should always be 1 */
                        assert(aop->size == 1);
                        DEBUGpicoBlaze_emitcode(";","%d sym->rname (AOP_ACC) = %s, size = %d",__LINE__,sym->rname,aop->size);
                        return (aop);
                } else {
                        sym->aop = aop = newAsmop (AOP_DIR);
                aop->aopu.aop_dir = sym->rname ;
            aop->size = getSize(sym->type);
                DEBUGpicoBlaze_emitcode(";","%d sym->rname (AOP_DIR) = %s, size = %d",__LINE__,sym->rname,aop->size);
                        picoBlaze_allocDirReg( IC_LEFT(ic) );
                        return (aop);
                }
        }

    if (IN_FARSPACE(space) && !IN_CODESPACE(space)) {
        sym->aop = aop = newAsmop (AOP_DIR);
        aop->aopu.aop_dir = sym->rname ;
        aop->size = getSize(sym->type);
        DEBUGpicoBlaze_emitcode(";","%d sym->rname = %s, size = %d",__LINE__,sym->rname,aop->size);
        picoBlaze_allocDirReg( IC_LEFT(ic) );
        return aop;
    }


    /* only remaining is far space */
    sym->aop = aop = newAsmop(AOP_PCODE);

/* change the next if to 1 to revert to good old immediate code */
        if(IN_CODESPACE(space)) {
                aop->aopu.pcop = picoBlaze_popGetImmd(sym->rname, 0, 0);
                PCOI(aop->aopu.pcop)->_const = IN_CODESPACE(space);
                PCOI(aop->aopu.pcop)->index = 0;
        } else {
                /* try to allocate via direct register */
                aop->aopu.pcop = picoBlaze_popRegFromString(sym->rname, getSize(sym->type), sym->offset, op); // Patch 8
//              aop->size = getSize( sym->type );
        }

        DEBUGpicoBlaze_emitcode(";","%d: rname %s, val %d, const = %d",
                __LINE__,sym->rname, 0, PCOI(aop->aopu.pcop)->_const);


        if(IN_DIRSPACE( space ))
                aop->size = PTRSIZE;
        else if(IN_CODESPACE( space ) || IN_FARSPACE( space ))
                aop->size = FPTRSIZE;
        else if(IC_LEFT(ic) && AOP(IC_LEFT(ic))) aop->size = AOP_SIZE( IC_LEFT(ic) );
        else if(IC_RIGHT(ic) && AOP(IC_RIGHT(ic))) aop->size = AOP_SIZE( IC_RIGHT(ic) );
        else if(sym->onStack) {
                aop->size = PTRSIZE;
        } else {
          if(SPEC_SCLS(sym->etype) == S_PDATA) {
            fprintf(stderr, "%s: %d symbol in PDATA space\n", __FILE__, __LINE__);
            aop->size = FPTRSIZE;
          } else
                assert( 0 );
        }

    DEBUGpicoBlaze_emitcode(";","%d size = %d",__LINE__,aop->size);

    /* if it is in code space */
    if (IN_CODESPACE(space))
        aop->code = 1;

    return aop;
}

/*-----------------------------------------------------------------*/
/* aopForRemat - rematerialzes an object                           */
/*-----------------------------------------------------------------*/
static asmop *aopForRemat (operand *op, bool result) // x symbol *sym)
{
  symbol *sym = OP_SYMBOL(op);
  operand *refop;
  iCode *ic = NULL, *oldic;
  asmop *aop = newAsmop(AOP_PCODE);
  int val = 0;
  int offset = 0;
  int viaimmd=0;

    FENTRY2;

        ic = sym->rematiCode;

        if(IS_OP_POINTER(op)) {
                DEBUGpicoBlaze_emitcode(";","%s %d IS_OP_POINTER",__FUNCTION__,__LINE__);
        }

//    if(!result)               /* fixme-vr */
        for (;;) {
                oldic = ic;

//              chat *iLine = printILine(ic);
//              picoBlaze_emitpcomment("ic: %s\n", iLine);
//              dbuf_free(iLine);

                if (ic->op == '+') {
                        val += (int) operandLitValue(IC_RIGHT(ic));
                } else if (ic->op == '-') {
                        val -= (int) operandLitValue(IC_RIGHT(ic));
                } else
                        break;

                ic = OP_SYMBOL(IC_LEFT(ic))->rematiCode;
        }

        offset = OP_SYMBOL(IC_LEFT(ic))->offset;
        refop = IC_LEFT(ic);

        if(!op->isaddr)viaimmd++; else viaimmd=0;

/* set the following if to 1 to revert to good old immediate code */
        if(IN_CODESPACE( SPEC_OCLS( OP_SYM_ETYPE(refop)))
                || viaimmd) {

                DEBUGpicoBlaze_emitcode(";", "%s:%d immediate, size: %d", __FILE__, __LINE__, getSize( sym->type ));

                aop->aopu.pcop = picoBlaze_popGetImmd(OP_SYMBOL(IC_LEFT(ic))->rname, 0, val);

                PCOI(aop->aopu.pcop)->_const = IS_CODEPTR(operandType(op));

                PCOI(aop->aopu.pcop)->index = val;

                aop->size = getSize( sym->type );
        } else {
                DEBUGpicoBlaze_emitcode(";", "%s:%d dir size: %d", __FILE__, __LINE__,  getSize( OP_SYMBOL( IC_LEFT(ic))->type));

                aop->aopu.pcop = picoBlaze_popRegFromString(OP_SYMBOL(IC_LEFT(ic))->rname,
                                getSize( OP_SYMBOL( IC_LEFT(ic))->type), val, op);

                aop->size = getSize( OP_SYMBOL( IC_LEFT(ic))->type );
        }


        DEBUGpicoBlaze_emitcode(";","%d: rname %s, val %d, const = %d",
                __LINE__,OP_SYMBOL(IC_LEFT(ic))->rname,

                val, IS_CODEPTR(operandType(op)));


//      DEBUGpicoBlaze_emitcode(";","aop type  %s",picoBlaze_AopType(AOP_TYPE(IC_LEFT(ic))));

        picoBlaze_allocDirReg (IC_LEFT(ic));

        if(IN_CODESPACE( SPEC_OCLS( OP_SYM_ETYPE(op)) ))
                aop->code = 1;

  return aop;
}


/*-----------------------------------------------------------------*/
/* regsInCommon - two operands have some registers in common       */
/*-----------------------------------------------------------------*/
static bool regsInCommon (operand *op1, operand *op2)
{
    symbol *sym1, *sym2;
    int i;

    /* if they have registers in common */
    if (!IS_SYMOP(op1) || !IS_SYMOP(op2))
        return FALSE ;

    sym1 = OP_SYMBOL(op1);
    sym2 = OP_SYMBOL(op2);

    if (sym1->nRegs == 0 || sym2->nRegs == 0)
        return FALSE ;

    for (i = 0 ; i < sym1->nRegs ; i++) {
        int j;
        if (!sym1->regs[i])
            continue ;

        for (j = 0 ; j < sym2->nRegs ;j++ ) {
            if (!sym2->regs[j])
                continue ;

            if (sym2->regs[j] == sym1->regs[i])
                return TRUE ;
        }
    }

    return FALSE ;
}

/*-----------------------------------------------------------------*/
/* operandsEqu - equivalent                                        */
/*-----------------------------------------------------------------*/
static bool operandsEqu ( operand *op1, operand *op2)
{
    symbol *sym1, *sym2;

    /* if they not symbols */
    if (!IS_SYMOP(op1) || !IS_SYMOP(op2))
        return FALSE;

    sym1 = OP_SYMBOL(op1);
    sym2 = OP_SYMBOL(op2);

    /* if both are itemps & one is spilt
       and the other is not then false */
    if (IS_ITEMP(op1) && IS_ITEMP(op2) &&
        sym1->isspilt != sym2->isspilt )
        return FALSE ;

    /* if they are the same */
    if (sym1 == sym2)
        return TRUE ;

    if (sym1->rname[0] && sym2->rname[0]
        && strcmp (sym1->rname, sym2->rname) == 0)
        return TRUE;


    /* if left is a tmp & right is not */
    if (IS_ITEMP(op1)  &&
        !IS_ITEMP(op2) &&
        sym1->isspilt  &&
        (SYM_SPIL_LOC(sym1) == sym2))
        return TRUE;

    if (IS_ITEMP(op2)  &&
        !IS_ITEMP(op1) &&
        sym2->isspilt  &&
        sym1->level > 0 &&
        (SYM_SPIL_LOC(sym2) == sym1))
        return TRUE ;

    return FALSE ;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_sameRegs - two asmops have the same registers                   */
/*-----------------------------------------------------------------*/
bool picoBlaze_sameRegs (asmop *aop1, asmop *aop2 )
{
    int i;

    if (aop1 == aop2)
        return TRUE ;

    DEBUGpicoBlaze_emitcode(";***", "%s aop1->type = %s\taop2->type = %s\n", __FUNCTION__,
                picoBlaze_AopType(aop1->type), picoBlaze_AopType(aop2->type));

    if(aop1->type == AOP_ACC && aop2->type == AOP_ACC)return TRUE;

    if (aop1->type != AOP_REG ||
        aop2->type != AOP_REG )
        return FALSE ;

    /* This is a bit too restrictive if one is a subset of the other...
    if (aop1->size != aop2->size )
        return FALSE ;
    */

    for (i = 0 ; i < min(aop1->size, aop2->size) ; i++ ) {
//        if(aop1->aopu.aop_reg[i]->type != aop2->aopu.aop_reg[i]->type)return FALSE;

//        if(aop1->aopu.aop_reg[i]->type == AOP_REG)
        if (strcmp(aop1->aopu.aop_reg[i]->name, aop2->aopu.aop_reg[i]->name ))
            return FALSE ;
    }

    return TRUE ;
}

bool picoBlaze_sameRegsOfs(asmop *aop1, asmop *aop2, int offset)
{
    DEBUGpicoBlaze_emitcode(";***", "%s aop1->type = %s\taop2->type = %s (offset = %d)\n", __FUNCTION__,
                picoBlaze_AopType(aop1->type), picoBlaze_AopType(aop2->type), offset);

    if(aop1 == aop2)return TRUE;
    if(aop1->type != AOP_REG || aop2->type != AOP_REG)return FALSE;

      if(strcmp(aop1->aopu.aop_reg[offset]->name, aop2->aopu.aop_reg[offset]->name))return FALSE;

  return TRUE;
}


/*-----------------------------------------------------------------*/
/* picoBlaze_aopOp - allocates an asmop for an operand  :                    */
/*-----------------------------------------------------------------*/
void picoBlaze_aopOp (operand *op, iCode *ic, bool result)
{
    asmop *aop;
    symbol *sym;
    int i;

    if (!op)
        return ;

    DEBUGpicoBlaze_emitcode(";","%s %d",__FUNCTION__, __LINE__);

    /* if this a literal */
    if (IS_OP_LITERAL(op)) {
        op->aop = aop = newAsmop(AOP_LIT);
        aop->aopu.aop_lit = op->operand.valOperand;
        aop->size = getSize(operandType(op));
        return;
    }

    {
      sym_link *type = operandType(op);

      if(IS_CODEPTR(type))

        DEBUGpicoBlaze_emitcode(";","%d aop type is const pointer",__LINE__);
    }

    /* if already has a asmop then continue */
    if (op->aop)
        return ;

    /* if the underlying symbol has a aop */
    if (IS_SYMOP(op) && OP_SYMBOL(op)->aop) {
      DEBUGpicoBlaze_emitcode(";","%d has symbol",__LINE__);
        op->aop = OP_SYMBOL(op)->aop;
        return;
    }

    /* if this is a true symbol */
    if (IS_TRUE_SYMOP(op)) {
        DEBUGpicoBlaze_emitcode(";","%d - true symop",__LINE__);
      op->aop = aopForSym(ic, op, result);
      return ;
    }

    /* this is a temporary : this has
    only four choices :
    a) register
    b) spillocation
    c) rematerialize
    d) conditional
    e) can be a return use only */

    sym = OP_SYMBOL(op);

    DEBUGpicoBlaze_emitcode("; ***", "%d: symbol name = %s, regType = %d", __LINE__, sym->name, sym->regType);
    /* if the type is a conditional */
    if (sym->regType == REG_CND) {
        aop = op->aop = sym->aop = newAsmop(AOP_CRY);
        aop->size = 0;
        return;
    }

    /* if it is spilt then two situations
    a) is rematerialize
    b) has a spill location */
    if (sym->isspilt || sym->nRegs == 0) {

//      debugf3("symbol %s\tisspilt: %d\tnRegs: %d\n", sym->rname, sym->isspilt, sym->nRegs);
      DEBUGpicoBlaze_emitcode(";","%d",__LINE__);
        /* rematerialize it NOW */
        if (sym->remat) {

            sym->aop = op->aop = aop = aopForRemat (op, result);
            return;
        }

#if 1
        if (sym->accuse) {
            int i;
            aop = op->aop = sym->aop = newAsmop(AOP_ACC);
            aop->size = getSize(sym->type);
            for ( i = 0 ; i < 1 ; i++ ) {
                aop->aopu.aop_str[i] = accUse[i];
//                aop->aopu.pcop = picoBlaze_popRegFromString("WREG", aop->size, SYM_SPIL_LOC(sym)->offset);
            }
            fprintf(stderr, "%s:%d allocating AOP_ACC for sym= %s\n", __FILE__, __LINE__, sym->name);
            DEBUGpicoBlaze_emitcode(";","%d size=%d",__LINE__,aop->size);
            return;
        }
#endif

#if 1
        if (sym->ruonly) {
          /*
          sym->aop = op->aop = aop = newAsmop(AOP_PCODE);
          aop->aopu.pcop = picoBlaze_popGetImmd(SYM_SPIL_LOC(sym)->rname,0,SYM_SPIL_LOC(sym)->offset);
          //picoBlaze_allocDirReg (IC_LEFT(ic));
          aop->size = getSize(sym->type);
          */

          unsigned i;

          aop = op->aop = sym->aop = newAsmop(AOP_REG);
          aop->size = getSize(sym->type);
 /*         for ( i = 0 ; i < picoBlaze_fReturnSizePic ; i++ )
            aop->aopu.aop_reg[i] = PCOR(picoBlaze_popRegFromIdx( picoBlaze_fReturnIdx[i] ))->r;
*/
          DEBUGpicoBlaze_emitcode(";","%d",__LINE__);
          return;
        }
#endif
        /* else spill location  */
        if (SYM_SPIL_LOC(sym) && getSize(sym->type) != getSize(SYM_SPIL_LOC(sym)->type)) {
            /* force a new aop if sizes differ */
            SYM_SPIL_LOC(sym)->aop = NULL;
        }


        //aop->aopu.pcop = picoBlaze_popGetImmd(SYM_SPIL_LOC(sym)->rname,0,SYM_SPIL_LOC(sym)->offset);
        if (SYM_SPIL_LOC(sym) && SYM_SPIL_LOC(sym)->rname) {
          sym->aop = op->aop = aop = newAsmop(AOP_PCODE);
          aop->aopu.pcop = picoBlaze_popRegFromString(SYM_SPIL_LOC(sym)->rname,
                                                  getSize(sym->type),
                                                  SYM_SPIL_LOC(sym)->offset, op);
        } else if (getSize(sym->type) <= 1) {
          //fprintf (stderr, "%s:%d called for a spillLocation -- assigning WREG instead --- CHECK (size:%u)!\n", __FUNCTION__, __LINE__, getSize(sym->type));
          picoBlaze_emitpcomment (";!!! %s:%d called for a spillLocation -- assigning WREG instead --- CHECK", __FUNCTION__, __LINE__);
          assert (getSize(sym->type) <= 1);
          sym->aop = op->aop = aop = newAsmop(AOP_PCODE);
 //*//         aop->aopu.pcop = picoBlaze_popCopyReg (&picoBlaze_pc_wreg);
        } else {
          /* We need some kind of dummy area for getSize(sym->type) byte,
           * use WREG for all storage locations.
           * XXX: This only works if we are implementing a `dummy read',
           *      the stored value will not be retrievable...
           *      See #1503234 for a case requiring this. */
          sym->aop = op->aop = aop = newAsmop(AOP_REG);
          aop->size = getSize(sym->type);
 //*//         for ( i = 0 ; i < aop->size ;i++)
 //*//           aop->aopu.aop_reg[i] = picoBlaze_pc_wreg.r;
        }
        aop->size = getSize(sym->type);

        return;
    }

    {
      sym_link *type = operandType(op);

      if(IS_CODEPTR(type))

        DEBUGpicoBlaze_emitcode(";","%d aop type is const pointer",__LINE__);
    }

    /* must be in a register */
    DEBUGpicoBlaze_emitcode(";","%d register type nRegs=%d",__LINE__,sym->nRegs);
    sym->aop = op->aop = aop = newAsmop(AOP_REG);
    aop->size = sym->nRegs;
    for ( i = 0 ; i < sym->nRegs ;i++)
        aop->aopu.aop_reg[i] = sym->regs[i];
}

/*-----------------------------------------------------------------*/
/* picoBlaze_freeAsmop - free up the asmop given to an operand               */
/*----------------------------------------------------------------*/
void picoBlaze_freeAsmop (operand *op, asmop *aaop, iCode *ic, bool pop)
{
    asmop *aop ;

    if (!op)
        aop = aaop;
    else
        aop = op->aop;

    if (!aop)
        return ;

    if (aop->freed)
        goto dealloc;

    aop->freed = 1;

#if 1
    switch (aop->type) {
        case AOP_STA:
          {
            int i;

              /* we must store the result on stack */
              if((op == IC_RESULT(ic)) && RESULTONSTA(ic)) {
                // operands on stack are accessible via "FSR2 + index" with index
                // starting at 2 for arguments and growing from 0 downwards for
                // local variables (index == 0 is not assigned so we add one here)
                int soffs = OP_SYMBOL(IC_RESULT(ic))->stack;
                if (soffs <= 0) {
                  assert (soffs < 0);
                  soffs++;
                } // if
//*//                if(_G.accInUse)picoBlaze_pushpCodeOp( picoBlaze_popCopyReg(&picoBlaze_pc_wreg) );
                for(i=0;i<aop->size;i++) {
                  /* initialise for stack access via frame pointer */
                  picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(soffs + i /*+ _G.stack_lat*/));
//*//                 picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(
//*//                        aop->aopu.stk.pop[i], picoBlaze_popCopyReg(picoBlaze_frame_plusw)));
                }

//*//                if(_G.accInUse)picoBlaze_poppCodeOp( picoBlaze_popCopyReg(&picoBlaze_pc_wreg) );
              }

              if(!_G.resDirect) {
                for(i=0;i<aop->size;i++) {
                  PCOR(aop->aopu.stk.pop[i] )->r->isFree = 1;

                  if(bitVectBitValue(_G.sregsAlloc, PCOR(aop->aopu.stk.pop[i])->r->rIdx)) {
                      bitVectUnSetBit(_G.sregsAlloc, PCOR(aop->aopu.stk.pop[i])->r->rIdx);
//                      picoBlaze_popReleaseTempReg(aop->aopu.stk.pop[i], 0);
                  }
                }

                {
                  regs *sr;

                    _G.sregsAllocSet = reverseSet( _G.sregsAllocSet );
                    for(sr=setFirstItem(_G.sregsAllocSet) ; sr; sr=setFirstItem(_G.sregsAllocSet)) {
                      picoBlaze_poppCodeOp( picoBlaze_popRegFromIdx( sr->rIdx ) );
                      deleteSetItem( &_G.sregsAllocSet, sr );
                    }
                }
              }
              _G.resDirect = 0;
          }
          break;

    }
#endif

dealloc:
    /* all other cases just dealloc */
    if (op ) {
        op->aop = NULL;
        if (IS_SYMOP(op)) {
            OP_SYMBOL(op)->aop = NULL;
            /* if the symbol has a spill */
            if (SPIL_LOC(op))
                SPIL_LOC(op)->aop = NULL;
        }
    }
}

/*-----------------------------------------------------------------*/
/* picoBlaze_aopGet - for fetching value of the aop                          */
/*-----------------------------------------------------------------*/
char *picoBlaze_aopGet (asmop *aop, int offset, bool bit16, bool dname)
{
    char *s = buffer ;
    char *rs;

    //DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    /* offset is greater than size then zero */
    if (offset > (aop->size - 1) &&
        aop->type != AOP_LIT)
        return zero;

    /* depending on type */
    switch (aop->type) {
    case AOP_DIR:
      if (offset) {
        sprintf(s,"(%s + %d)",
                aop->aopu.aop_dir,
                offset);
        DEBUGpicoBlaze_emitcode(";","oops AOP_DIR did this %s\n",s);
      } else
            sprintf(s,"%s",aop->aopu.aop_dir);
        rs = Safe_calloc(1,strlen(s)+1);
        strcpy(rs,s);
        return rs;

    case AOP_REG:
		return aop->aopu.aop_reg[offset]->name; // ZK: TODO: find the problem why aopu union can be undefined

    case AOP_CRY:
      return aop->aopu.aop_dir;

    case AOP_ACC:
        DEBUGpicoBlaze_emitcode(";Warning -pic port ignoring get(AOP_ACC)","%d\toffset: %d",__LINE__, offset);
//        fprintf(stderr, "%s:%d Warning -pic port ignoring get(AOP_ACC)\n",__FILE__, __LINE__);
//        assert( 0 );
//      return aop->aopu.aop_str[offset];       //->"AOP_accumulator_bug";
        rs = Safe_strdup("WREG");
        return (rs);

    case AOP_LIT:
        sprintf(s,"0x%02x", picoBlazeaopLiteral (aop->aopu.aop_lit,offset));
        rs = Safe_calloc(1,strlen(s)+1);
        strcpy(rs,s);
        return rs;

    case AOP_STR:
        aop->coff = offset ;

//      if (strcmp(aop->aopu.aop_str[offset],"a") == 0 &&
//          dname)
//          return "acc";
        if(!strcmp(aop->aopu.aop_str[offset], "WREG")) {
          aop->type = AOP_ACC;
          return Safe_strdup("_WREG");
        }
        DEBUGpicoBlaze_emitcode(";","%d - %s",__LINE__, aop->aopu.aop_str[offset]);

        return aop->aopu.aop_str[offset];

    case AOP_PCODE:
      {
        pCodeOp *pcop = aop->aopu.pcop;
        DEBUGpicoBlaze_emitcode(";","%d: picoBlaze_aopGet AOP_PCODE type %s",__LINE__,picoBlaze_pCodeOpType(pcop));
        if(pcop->name) {
          DEBUGpicoBlaze_emitcode(";","%s offset %d",pcop->name,PCOI(pcop)->offset);
          //sprintf(s,"(%s+0x%02x)", pcop->name,PCOI(aop->aopu.pcop)->offset);
          if (offset) {
            sprintf(s,"(%s + %d)", picoBlaze_get_op (pcop, NULL, 0), offset);
          } else {
            sprintf(s,"%s", picoBlaze_get_op (pcop, NULL, 0));
          }
        } else
          sprintf(s,"0x%02x", PCOI(aop->aopu.pcop)->offset);

      }
      rs = Safe_calloc(1,strlen(s)+1);
      strcpy(rs,s);
      return rs;


    case AOP_STA:
        rs = Safe_strdup(PCOR(aop->aopu.stk.pop[offset])->r->name);
        return (rs);

    case AOP_STK:
//        pCodeOp *pcop = aop->aop
        break;

    }

    fprintf(stderr, "%s:%d unsupported aop->type: %s\n", __FILE__, __LINE__, picoBlaze_AopType(aop->type));
    werror(E_INTERNAL_ERROR,__FILE__,__LINE__,
           "aopget got unsupported aop->type");
    exit(0);
}



/* lock has the following meaning: When allocating temporary registers
 * for stack variables storage, the value of the temporary register is
 * saved on stack. Its value is restored at the end. This procedure is
 * done via calls to picoBlaze_aopOp and picoBlaze_freeAsmop functions. There is
 * a possibility that before a call to picoBlaze_aopOp, a temporary register
 * is allocated for a while and it is freed after some time, this will
 * mess the stack and values will not be restored properly. So use lock=1
 * to allocate temporary registers used internally by the programmer, and
 * lock=0 to allocate registers for stack use. lock=1 will emit a warning
 * to inform the compiler developer about a possible bug. This is an internal
 * feature for developing the compiler -- VR */

int _picoBlaze_TempReg_lock = 0;
/*-----------------------------------------------------------------*/
/* picoBlaze_popGetTempReg - create a new temporary pCodeOp                  */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popGetTempReg(int lock)
{
  pCodeOp *pcop=NULL;
  symbol *cfunc;

//    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    if(_picoBlaze_TempReg_lock) {
//      werror(W_POSSBUG2, __FILE__, __LINE__);
    }

    _picoBlaze_TempReg_lock += lock;

    cfunc = currFunc;
    currFunc = NULL;

    pcop = picoBlaze_newpCodeOp(NULL, PO_GPR_TEMP);
    if(pcop && pcop->type == PO_GPR_TEMP && PCOR(pcop)->r) {
      PCOR(pcop)->r->wasUsed=1;
      PCOR(pcop)->r->isFree=0;

      /* push value on stack */
      picoBlaze_pushpCodeOp( picoBlaze_pCodeOpCopy(pcop) );
    }

    currFunc = cfunc;

  return pcop;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_popGetTempRegCond - create a new temporary pCodeOp which  */
/*                           is not part of f, but don't save if   */
/*                           inside v                              */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popGetTempRegCond(bitVect *f, bitVect *v, int lock)
{
  pCodeOp *pcop=NULL;
  symbol *cfunc;
  int i;

//    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    if(_picoBlaze_TempReg_lock) {
//      werror(W_POSSBUG2, __FILE__, __LINE__);
    }

    _picoBlaze_TempReg_lock += lock;

    cfunc = currFunc;
    currFunc = NULL;

    i = bitVectFirstBit(f);
    while(i < 128) {

      /* bypass registers that are used by function */
      if(!bitVectBitValue(f, i)) {

        /* bypass registers that are already allocated for stack access */
        if(!bitVectBitValue(v, i))  {

//          debugf("getting register rIdx = %d\n", i);
          /* ok, get the operand */
          pcop = picoBlaze_newpCodeOpReg( i );

          /* should never by NULL */
          assert( pcop != NULL );


          /* sanity check */
          if(pcop && pcop->type == PO_GPR_TEMP && PCOR(pcop)->r) {
            int found=0;

              PCOR(pcop)->r->wasUsed=1;
              PCOR(pcop)->r->isFree=0;


              {
                regs *sr;

                  for(sr=setFirstItem(_G.sregsAllocSet);sr;sr=setNextItem(_G.sregsAllocSet)) {

                    if(sr->rIdx == PCOR(pcop)->r->rIdx) {
                      /* already used in previous steps, break */
                      found=1;
                      break;
                    }
                  }
              }

              /* caller takes care of the following */
//              bitVectSetBit(v, i);

              if(!found) {
                /* push value on stack */
                picoBlaze_pushpCodeOp( picoBlaze_pCodeOpCopy(pcop) );
                addSet(&_G.sregsAllocSet, PCOR(pcop)->r);
              }

            break;
          }
        }
      }
      i++;
    }

    currFunc = cfunc;

  return pcop;
}


/*-----------------------------------------------------------------*/
/* picoBlaze_popReleaseTempReg - create a new temporary pCodeOp                  */
/*-----------------------------------------------------------------*/
void picoBlaze_popReleaseTempReg(pCodeOp *pcop, int lock)
{
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

  _picoBlaze_TempReg_lock -= lock;

  if(pcop && pcop->type == PO_GPR_TEMP && PCOR(pcop)->r) {
    PCOR(pcop)->r->isFree = 1;

    picoBlaze_poppCodeOp( picoBlaze_pCodeOpCopy(pcop) );
  }
}
/*-----------------------------------------------------------------*/
/* picoBlaze_popGetLabel - create a new pCodeOp of type PO_LABEL             */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popGetLabel(int key)
{

  DEBUGpicoBlaze_emitcode ("; ***","%s  key=%d, label offset %d",__FUNCTION__,key, picoBlaze_labelOffset);

  if(key>max_key)
    max_key = key;

  return picoBlaze_newpCodeOpLabel(NULL,key+100+picoBlaze_labelOffset);
}

/*-----------------------------------------------------------------*/
/* picoBlaze_popCopyReg - copy a pcode operator                              */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popCopyReg(pCodeOpReg *pc)
{
  pCodeOpReg *pcor;

  pcor = Safe_calloc(1,sizeof(pCodeOpReg) );
  memcpy (pcor, pc, sizeof(pCodeOpReg) );
  pcor->r->wasUsed = 1;

  //pcor->pcop.type = pc->pcop.type;
  if(pc->pcop.name) {
    if( !(pcor->pcop.name = Safe_strdup(pc->pcop.name)) )
      fprintf(stderr,"oops %s %d",__FILE__,__LINE__);
  } else
    pcor->pcop.name = NULL;

  //pcor->r = pc->r;
  //pcor->rIdx = pc->rIdx;
  //pcor->r->wasUsed=1;
  //pcor->instance = pc->instance;

//  DEBUGpicoBlaze_emitcode ("; ***","%s  , copying %s, rIdx=%d",__FUNCTION__,pc->pcop.name,pc->rIdx);

  return PCOP(pcor);
}

/*-----------------------------------------------------------------*/
/* picoBlaze_popGetLit - asm operator to pcode operator conversion     */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popGetLit(int lit)
{
  return picoBlaze_newpCodeOpLit(lit);
}

/* Allow for 12 bit literals (LFSR x, <here!>). */
pCodeOp *picoBlaze_popGetLit12(int lit)
{
  return picoBlaze_newpCodeOpLit12(lit);
}

/*-----------------------------------------------------------------*/
/* picoBlaze_popGetLit2 - asm operator to pcode operator conversion    */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popGetLit2(int lit, pCodeOp *arg2)
{
  return picoBlaze_newpCodeOpLit2(lit, arg2);
}


/*-----------------------------------------------------------------*/
/* picoBlaze_popGetImmd - asm operator (its name, offset and index) to pCodeImmd conversion   */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popGetImmd(char *name, unsigned int offset, int index)
{
  return picoBlaze_newpCodeOpImmd(name, offset,index, 0);
}


/*-----------------------------------------------------------------*/
/* picoBlaze_popGet - name of asm operator conversion to pCode operator */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popGetWithString(char *str)
{
  pCodeOp *pcop;


  if(!str) {
    fprintf(stderr,"NULL string %s %d\n",__FILE__,__LINE__);
    exit (1);
  }

  pcop = picoBlaze_newpCodeOp(str, PO_GPR_REGISTER); // calls constructor for specific subtype of pCodeOp according to PICOBLAZE_OPTYPE type parameter

  return pcop;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_popRegFromString - asm operator to pCodeOpReg conversion */
/*-----------------------------------------------------------------*/
static pCodeOp *picoBlaze_popRegFromString(char *str, int size, int offset, operand *op)
{

  pCodeOp *pcop = Safe_calloc(1,sizeof(pCodeOpReg) );
  pcop->type = PO_DIR;

  DEBUGpicoBlaze_emitcode(";","%d %s %s %d/%d",__LINE__, __FUNCTION__, str, size, offset); // patch 14
  // fprintf(stderr, "%s:%d: register name = %s pos = %d/%d\n", __FUNCTION__, __LINE__, str, offset, size);

  if(!str)
    str = "BAD_STRING";

  pcop->name = Safe_calloc(1,strlen(str)+1);
  strcpy(pcop->name,str);

  //pcop->name = Safe_strdup( ( (str) ? str : "BAD STRING"));

  PCOR(pcop)->r = picoBlaze_dirRegWithName(pcop->name);
//  PCOR(pcop)->r->wasUsed = 1;

  /* make sure that register doesn't exist,
   * and operand isn't NULL
   * and symbol isn't in codespace (codespace symbols are handled elsewhere) */
  if((PCOR(pcop)->r == NULL)
    && (op)
    && !IN_CODESPACE(SPEC_OCLS(OP_SYM_ETYPE(op)))) {
//      fprintf(stderr, "%s:%d - couldn't find %s in allocated regsters, size= %d ofs= %d\n",
//              __FUNCTION__, __LINE__, str, size, offset);

    PCOR(pcop)->r = picoBlaze_allocRegByName (pcop->name, size, op);
    //fprintf(stderr, "%s:%d: WARNING: need to allocate new register by name -> %s\n", __FILE__, __LINE__, str);

  }
  PCOR(pcop)->instance = offset;

  return pcop;
}

static pCodeOp *picoBlaze_popRegFromIdx(int rIdx)
{
  pCodeOp *pcop;

//      DEBUGpicoBlaze_emitcode ("; ***","%s,%d\trIdx=0x%x", __FUNCTION__,__LINE__,rIdx);
//      fprintf(stderr, "%s:%d rIdx = 0x%0x\n", __FUNCTION__, __LINE__, rIdx);

        pcop = Safe_calloc(1,sizeof(pCodeOpReg) );
        PCOR(pcop)->rIdx = rIdx;
        PCOR(pcop)->r = picoBlaze_regWithIdx(rIdx);
        if(!PCOR(pcop)->r)
                PCOR(pcop)->r = picoBlaze_allocWithIdx(rIdx);

        PCOR(pcop)->r->isFree = 0;
        PCOR(pcop)->r->wasUsed = 1;

        pcop->type = PCOR(pcop)->r->pc_type;

  return pcop;
}

/*---------------------------------------------------------------------------------*/
/* picoBlaze_popGet2 - a variant of picoBlaze_popGet to handle two memory operand commands */
/*                 VR 030601                                                       */
/*---------------------------------------------------------------------------------*/
pCodeOp *picoBlaze_popGet2(asmop *aop_src, asmop *aop_dst, int offset)
{
  pCodeOp2 *pcop2 = (pCodeOp2 *)picoBlaze_newpCodeOp2(
        picoBlaze_popGet(aop_src, offset), picoBlaze_popGet(aop_dst, offset));
  return PCOP(pcop2);
}



/*--------------------------------------------------------------------------------.-*/
/* picoBlaze_popGet2p - a variant of picoBlaze_popGet to handle two memory operand commands */
/*                  VR 030601 , adapted by Hans Dorn                                */
/*--------------------------------------------------------------------------------.-*/
pCodeOp *picoBlaze_popGet2p(pCodeOp *src, pCodeOp *dst)
{
  pCodeOp2 *pcop2;
  pcop2 = (pCodeOp2 *)picoBlaze_newpCodeOp2(src, dst);
  return PCOP(pcop2);
}

/*---------------------------------------------------------------------------------*/
/* picoBlaze_popCombine2 - combine two pCodeOpReg variables into one for use with      */
/*                     movff instruction                                           */
/*---------------------------------------------------------------------------------*/
pCodeOp *picoBlaze_popCombine2(pCodeOpReg *src, pCodeOpReg *dst, int noalloc)
{
  pCodeOp2 *pcop2 = (pCodeOp2 *)picoBlaze_newpCodeOp2(
        picoBlaze_popCopyReg(src), picoBlaze_popCopyReg(dst) );

  return PCOP(pcop2);
}


/*-----------------------------------------------------------------*/
/* picoBlaze_popGet - asm operator to pcode operator conversion              */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popGet (asmop *aop, int offset) //, bool bit16, bool dname)
{
//  char *s = buffer ;
//  char *rs;
  pCodeOp *pcop;

    FENTRY2;

      /* offset is greater than size then zero */

//    if (offset > (aop->size - 1) &&
//        aop->type != AOP_LIT)
//      return NULL;  //zero;

    /* depending on type */
    switch (aop->type) {
                case AOP_STA:
                        /* pCodeOp is already allocated from aopForSym */
                        DEBUGpicoBlaze_emitcode(";---", "%d getting stack + offset %d\n", __LINE__, offset);
                        pcop = picoBlaze_pCodeOpCopy(aop->aopu.stk.pop[offset]);
                        return (pcop);

               case AOP_ACC:
                        {
 /* TODO: remove AOP_ACC                         int rIdx = IDX_WREG;          //aop->aopu.aop_reg[offset]->rIdx;

                                fprintf(stderr, "%s:%d returning register AOP_ACC %s\n", __FILE__, __LINE__, aop->aopu.aop_str[offset]);

                                DEBUGpicoBlaze_emitcode(";","%d\tAOP_ACC", __LINE__);

                                pcop = Safe_calloc(1,sizeof(pCodeOpReg) );
                                PCOR(pcop)->rIdx = rIdx;
                                PCOR(pcop)->r = picoBlaze_typeRegWithIdx(rIdx, REG_GPR, 1); // picoBlaze_regWithIdx(rIdx);
                                PCOR(pcop)->r->wasUsed=1;
                                PCOR(pcop)->r->isFree=0;

                                PCOR(pcop)->instance = offset;
                                pcop->type = PCOR(pcop)->r->pc_type;
//                              DEBUGpicoBlaze_emitcode(";","%d register idx = %d name =%s",__LINE__,rIdx,rs);
                                return pcop;


//      return picoBlaze_popRegFromString(aop->aopu.aop_str[offset], aop->size, offset);
//      return picoBlaze_newpCodeOpRegFromStr(aop->aopu.aop_str[offset]);

//      assert( 0 );
 */                       }

    case AOP_DIR:
      DEBUGpicoBlaze_emitcode(";","%d\tAOP_DIR (name = %s)", __LINE__, aop->aopu.aop_dir);
      return picoBlaze_popRegFromString(aop->aopu.aop_dir, aop->size, offset, NULL);

    case AOP_REG:
      {
        int rIdx;

//      debugf2("aop = %p\toffset = %d\n", aop, offset);
//      assert (aop && aop->aopu.aop_reg[offset] != NULL);
        rIdx = aop->aopu.aop_reg[offset]->rIdx;

        DEBUGpicoBlaze_emitcode(";","%d\tAOP_REG", __LINE__);

        pcop = Safe_calloc(1,sizeof(pCodeOpReg) );
//      pcop->type = PO_GPR_REGISTER;
        PCOR(pcop)->rIdx = rIdx;
        PCOR(pcop)->r = picoBlaze_allocWithIdx( rIdx );     //picoBlaze_regWithIdx(rIdx);
        PCOR(pcop)->r->wasUsed=1;
        PCOR(pcop)->r->isFree=0;

        PCOR(pcop)->instance = offset;
        pcop->type = PCOR(pcop)->r->pc_type;

        DEBUGpicoBlaze_emitcode(";*+*", "%d\tAOP_REG type = %s", __LINE__, picoBlaze_dumpPicOptype(pcop->type));
//      rs = aop->aopu.aop_reg[offset]->name;
//      DEBUGpicoBlaze_emitcode(";","%d register idx = %d name = %s",__LINE__,rIdx,rs);
        return pcop;
      }

    case AOP_CRY:
        DEBUGpicoBlaze_emitcode(";","%d\tAOP_CRY", __LINE__);

      pcop = picoBlaze_newpCodeOpBit(aop->aopu.aop_dir,-1,1, PO_GPR_REGISTER);
      PCOR(pcop)->instance = offset;
      PCOR(pcop)->r = picoBlaze_dirRegWithName(aop->aopu.aop_dir);
      //if(PCOR(pcop)->r == NULL)
      //fprintf(stderr,"%d - couldn't find %s in allocated registers\n",__LINE__,aop->aopu.aop_dir);
      return pcop;

    case AOP_LIT:
        DEBUGpicoBlaze_emitcode(";","%d\tAOP_LIT", __LINE__);
      return picoBlaze_newpCodeOpLit(picoBlazeaopLiteral (aop->aopu.aop_lit,offset));

    case AOP_STR:
      DEBUGpicoBlaze_emitcode(";","%d AOP_STR %s",__LINE__,aop->aopu.aop_str[offset]);
      return picoBlaze_newpCodeOpRegFromStr(aop->aopu.aop_str[offset]);

      /*
      pcop = Safe_calloc(1,sizeof(pCodeOpReg) );
      PCOR(pcop)->r = picoBlaze_allocRegByName(aop->aopu.aop_str[offset]);
      PCOR(pcop)->rIdx = PCOR(pcop)->r->rIdx;
      pcop->type = PCOR(pcop)->r->pc_type;
      pcop->name = PCOR(pcop)->r->name;

      return pcop;
      */

    case AOP_PCODE:
      DEBUGpicoBlaze_emitcode(";","picoBlaze_popGet AOP_PCODE (%s) %d %s offset %d",picoBlaze_pCodeOpType(aop->aopu.pcop),
                          __LINE__,
                          ((aop->aopu.pcop->name)? (aop->aopu.pcop->name) : "no name"), offset);
      pcop = picoBlaze_pCodeOpCopy(aop->aopu.pcop);
      switch( aop->aopu.pcop->type ) {
        case PO_DIR: PCOR(pcop)->instance += offset; break;
        default:
          fprintf (stderr, "%s: unhandled aop->aopu.pcop->type %d\n", __FUNCTION__, aop->aopu.pcop->type);
          assert( 0 );  /* should never reach here */;
      }
      return pcop;
    }

    werror(E_INTERNAL_ERROR,__FILE__,__LINE__,
           "picoBlaze_popGet got unsupported aop->type");
    exit(0);
}
/*-----------------------------------------------------------------*/
/* picoBlaze_aopPut - puts a string for a aop (return => USELESS)  */
/*-----------------------------------------------------------------*/
void picoBlaze_aopPut (asmop *aop, char *s, int offset)
{
    char *d = buffer ;
    symbol *lbl ;

    return;	/* !!! LEFT THE REST OF THE CODE NONEXECUTABLE !!! */

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    if (aop->size && offset > ( aop->size - 1)) {
        werror(E_INTERNAL_ERROR,__FILE__,__LINE__,
               "picoBlaze_aopPut got offset > aop->size");
        exit(0);
    }

    /* will assign value to value */
    /* depending on where it is ofcourse */
    switch (aop->type) {
    case AOP_DIR:
      if (offset) {
        sprintf(d,"(%s + %d)",
                aop->aopu.aop_dir,offset);
        fprintf(stderr,"oops picoBlaze_aopPut:AOP_DIR did this %s\n",s);

      } else
            sprintf(d,"%s",aop->aopu.aop_dir);

        if (strcmp(d,s)) {
          DEBUGpicoBlaze_emitcode(";","%d",__LINE__);
          if(strcmp(s,"W"))
            picoBlaze_emitcode("movf","%s,w",s);
          picoBlaze_emitcode("movwf","%s",d);

          if(strcmp(s,"W")) {
            picoBlaze_emitcode(";BUG!? should have this:movf","%s,w   %d",s,__LINE__);
            if(offset >= aop->size) {
              picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(aop,offset));
              break;
            } else
              picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetImmd(s,offset,0));
          }

          picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(aop,offset));


        }
        break;

    case AOP_REG:
      if (strcmp(aop->aopu.aop_reg[offset]->name,s) != 0) { // &&
        //strcmp(aop->aopu.aop_reg[offset]->dname,s)!= 0){
          /*
            if (*s == '@'           ||
                strcmp(s,"r0") == 0 ||
                strcmp(s,"r1") == 0 ||
                strcmp(s,"r2") == 0 ||
                strcmp(s,"r3") == 0 ||
                strcmp(s,"r4") == 0 ||
                strcmp(s,"r5") == 0 ||
                strcmp(s,"r6") == 0 ||
                strcmp(s,"r7") == 0 )
                picoBlaze_emitcode("mov","%s,%s  ; %d",
                         aop->aopu.aop_reg[offset]->dname,s,__LINE__);
            else
          */

          if(strcmp(s,"W")==0 )
            picoBlaze_emitcode("movf","%s,w  ; %d",s,__LINE__);

          picoBlaze_emitcode("movwf","%s",
                   aop->aopu.aop_reg[offset]->name);

          if(strcmp(s,zero)==0) {
            picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(aop,offset));

          } else if(strcmp(s,"W")==0) {
            pCodeOp *pcop = Safe_calloc(1,sizeof(pCodeOpReg) );
            pcop->type = PO_GPR_REGISTER;

            PCOR(pcop)->rIdx = -1;
            PCOR(pcop)->r = NULL;

            DEBUGpicoBlaze_emitcode(";","%d",__LINE__);
            pcop->name = Safe_strdup(s);
            picoBlaze_emitpcode(POC_MOVFW,pcop);
            picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(aop,offset));
          } else if(strcmp(s,one)==0) {
            picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(aop,offset));
            picoBlaze_emitpcode(POC_INCF,picoBlaze_popGet(aop,offset));
          } else {
            picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(aop,offset));
          }
        }
        break;

    case AOP_STK:
        if (strcmp(s,"a") == 0)
            picoBlaze_emitcode("push","acc");
        else
            picoBlaze_emitcode("push","%s",s);

        break;

    case AOP_CRY:
        /* if bit variable */
        if (!aop->aopu.aop_dir) {
            picoBlaze_emitcode("clr","a");
            picoBlaze_emitcode("rlc","a");
        } else {
            if (s == zero)
                picoBlaze_emitcode("clr","%s",aop->aopu.aop_dir);
            else
                if (s == one)
                    picoBlaze_emitcode("setb","%s",aop->aopu.aop_dir);
                else
                    if (!strcmp(s,"c"))
                        picoBlaze_emitcode("mov","%s,c",aop->aopu.aop_dir);
                    else {
                        lbl = newiTempLabel(NULL);

                        if (strcmp(s,"a")) {
                            MOVA(s);
                        }
                        picoBlaze_emitcode("clr","c");
                        picoBlaze_emitcode("jz","%05d_DS_",lbl->key+100);
                        picoBlaze_emitcode("cpl","c");
                        picoBlaze_emitcode("","%05d_DS_:",lbl->key+100);
                        picoBlaze_emitcode("mov","%s,c",aop->aopu.aop_dir);
                    }
        }
        break;

    case AOP_STR:
        aop->coff = offset;
        if (strcmp(aop->aopu.aop_str[offset],s))
            picoBlaze_emitcode ("mov","%s,%s ; %d",aop->aopu.aop_str[offset],s,__LINE__);
        break;

    case AOP_ACC:
        aop->coff = offset;
        if (!offset && (strcmp(s,"acc") == 0))
            break;

        if (strcmp(aop->aopu.aop_str[offset],s))
            picoBlaze_emitcode ("mov","%s,%s ; %d",aop->aopu.aop_str[offset],s, __LINE__);
        break;

    default :
        fprintf(stderr, "%s:%d: unknown aop->type = 0x%x\n", __FILE__, __LINE__, aop->type);
//      werror(E_INTERNAL_ERROR,__FILE__,__LINE__,
//             "picoBlaze_aopPut got unsupported aop->type");
//      exit(0);
    }

}

/*-----------------------------------------------------------------*/
/* picoBlaze_mov2w - generate either a MOVLW or MOVFW based operand type     */
/*-----------------------------------------------------------------*/
void picoBlaze_emulPush (asmop *aop, int offset)
{
  pCodeOp *pcop=NULL;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d  offset=%d",__FUNCTION__,__LINE__,offset);

  if(picoBlaze_isLitAop(aop))
  {
	 // pcop = picoBlaze_newpCodeOp(NULL, PO_GPR_REGISTER);
	  pcop = picoBlaze_newpCodeOp("sE",PO_GPR_REGISTER);
  //pcop = picoBlaze_popGetTempReg(0);
/*		if(pcop && pcop->type == PO_GPR_TEMP && PCOR(pcop)->r) {
		PCOR(pcop)->r->wasUsed=1;
		PCOR(pcop)->r->isFree=0;
	}
*/
	  picoBlaze_emitpcode(PBOC_LOAD_SXKK, picoBlaze_popGet2p( pcop, picoBlaze_popGet(aop, offset)));
	  picoBlaze_emitpcode(PBOC_SUB_SXKK, picoBlaze_popGet2p( picoBlaze_popCopyReg(picoBlaze_stack_stackpointer), picoBlaze_popGetLit(0x01)));
	  picoBlaze_emitpcode(PBOC_STORE_SXISY, picoBlaze_popGet2p( pcop, picoBlaze_popCopyReg(picoBlaze_stack_stackpointer)));

//	  picoBlaze_emitpcode(PBOC_LOAD_SXKK, picoBlaze_popGet2p( picoBlaze_popGetLit(0xFF), picoBlaze_popGetLit(0xFF)));
////	  picoBlaze_emitpcode(PBOC_LOAD_SXKK, picoBlaze_popGet2p( picoBlaze_popCopyReg(picoBlaze_stack_stackpointer), picoBlaze_popGet(aop, offset)));
//      picoBlaze_emitpcode(PBOC_LOAD_SXKK, picoBlaze_popGet2p( picoBlaze_popCopyReg(picoBlaze_stack_stackpointer), picoBlaze_popGet(aop, offset)));
//      picoBlaze_emitpcode(PBOC_LOAD_SXKK, picoBlaze_popGet2p( picoBlaze_popGet(aop, offset), picoBlaze_popGet(aop, offset)));
                     
 //**//   picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGet(aop,offset));
  } else {
	  picoBlaze_emitpcode(PBOC_SUB_SXKK, picoBlaze_popGet2p( picoBlaze_popCopyReg(picoBlaze_stack_stackpointer), picoBlaze_popGetLit(0x01)));
	  picoBlaze_emitpcode(PBOC_STORE_SXISY, picoBlaze_popGet2p( picoBlaze_popGet(aop, offset), picoBlaze_popCopyReg(picoBlaze_stack_stackpointer)));
	  //		picoBlaze_emitpcode(PBOC_LOAD_SXSY, picoBlaze_popGet2p( picoBlaze_popCopyReg(picoBlaze_stack_stackpointer), picoBlaze_popGet(aop, offset)));
  }
 //**//   picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(aop,offset));
}

/*-----------------------------------------------------------------*/
/* picoBlaze_mov2w - generate either a MOVLW or MOVFW based operand type     */
/*-----------------------------------------------------------------*/
void picoBlaze_mov2w (asmop *aop, int offset)
{
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d  offset=%d",__FUNCTION__,__LINE__,offset);

  if(picoBlaze_isLitAop(aop))
    picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGet(aop,offset));
  else
    picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(aop,offset));
}

void picoBlaze_mov2w_volatile (asmop *aop)
{
  int i;

  if(!picoBlaze_isLitAop(aop)) {
    // may need to protect this from the peepholer -- this is not nice but works...
    picoBlaze_addpCode2pBlock(pb, picoBlaze_newpCodeAsmDir(";", "VOLATILE READ - BEGIN"));
    for (i = 0; i < aop->size; i++) {
      if (i > 0) {
        picoBlaze_addpCode2pBlock(pb, picoBlaze_newpCodeAsmDir(";", "VOLATILE READ - MORE"));
      } // if
      picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(aop, i));
    } // for
    picoBlaze_addpCode2pBlock(pb, picoBlaze_newpCodeAsmDir(";", "VOLATILE READ - END"));
  }
}

void picoBlaze_mov2f(asmop *dst, asmop *src, int offset)
{
  if(picoBlaze_isLitAop(src)) {
    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(src, offset));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(dst, offset));
  } else {
    if(picoBlaze_sameRegsOfs(src, dst, offset))return;
    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p( picoBlaze_popGet(src, offset),
                      picoBlaze_popGet(dst, offset)));
  }
}

static void picoBlaze_movLit2f(pCodeOp *pc, int lit)
{
  if (0 == (lit & 0x00ff))
  {
    picoBlaze_emitpcode (POC_CLRF, pc);
  } else if (0xff == (lit & 0x00ff))
  {
    picoBlaze_emitpcode (POC_SETF, pc);
  } else {
    picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit (lit & 0x00ff));
//*//    if (pc->type != PO_WREG) picoBlaze_emitpcode (POC_MOVWF, pc);
  }
}

static void mov2fp(pCodeOp *dst, asmop *src, int offset)
{
  if(picoBlaze_isLitAop(src)) {
    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(src, offset));
    picoBlaze_emitpcode(POC_MOVWF, dst);
  } else {
    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popGet(src, offset), dst));
  }
}

void picoBlaze_testStackOverflow(void)
{
#define GSTACK_TEST_NAME        "_gstack_test"

  picoBlaze_emitpcode(POC_CALL, picoBlaze_popGetWithString( GSTACK_TEST_NAME ));

  {
    symbol *sym;

      sym = newSymbol( GSTACK_TEST_NAME , 0 );
      sprintf(sym->rname, "%s", /*port->fun_prefix,*/ GSTACK_TEST_NAME);
//      strcpy(sym->rname, GSTACK_TEST_NAME);
      picoBlaze_checkAddSym(&externs, sym);
  }

}

/* push pcop into stack */
void picoBlaze_pushpCodeOp(pCodeOp *pcop)
{
//      DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  if (pcop->type == PO_LITERAL) {
    picoBlaze_emitpcode(POC_MOVLW, pcop);
//*//    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg( picoBlaze_stack_postdec ));
  } else {
//*//    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(pcop, picoBlaze_popCopyReg( picoBlaze_stack_postdec )));
  }
  if(picoBlaze_options.gstack)
    picoBlaze_testStackOverflow();

}

/* pop pcop from stack */
void picoBlaze_poppCodeOp(pCodeOp *pcop)
{
//*//  picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg( picoBlaze_stack_preinc ), pcop));
  if(picoBlaze_options.gstack)
    picoBlaze_testStackOverflow();
}


/*-----------------------------------------------------------------*/
/* picoBlaze_pushw - pushes wreg to stack                                    */
/*-----------------------------------------------------------------*/
void picoBlaze_pushw(void)
{
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg( picoBlaze_stack_stackpointer ));	/* PicoBlazed - partially */
  if(picoBlaze_options.gstack)
    picoBlaze_testStackOverflow();
}


/*-----------------------------------------------------------------*/
/* picoBlaze_pushaop - pushes aop to stack                                   */
/*-----------------------------------------------------------------*/
void picoBlaze_pushaop(asmop *aop, int offset)
{
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

  if(_G.resDirect)return;

  if(picoBlaze_isLitAop(aop)) {
    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(aop, offset));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg( picoBlaze_stack_stackpointer ));
  } else {
    picoBlaze_emitpcode(POC_MOVFF,
      picoBlaze_popGet2p(picoBlaze_popGet(aop, offset), picoBlaze_popCopyReg( picoBlaze_stack_stackpointer )));
  }

  if(picoBlaze_options.gstack)
    picoBlaze_testStackOverflow();
}

/*-----------------------------------------------------------------*/
/* picoBlaze_popaop - pops aop from stack                                    */
/*-----------------------------------------------------------------*/
void picoBlaze_popaop(asmop *aop, int offset)
{
  DEBUGpicoBlaze_emitcode("; ***", "%s  %d", __FUNCTION__, __LINE__);
//*//  picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popCombine2(picoBlaze_stack_preinc, PCOR(picoBlaze_popGet(aop, offset)), 0));
  if(picoBlaze_options.gstack)
    picoBlaze_testStackOverflow();
}

void picoBlaze_popaopidx(asmop *aop, int offset, int index)
{
  int ofs=1;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    if(STACK_MODEL_LARGE)ofs++;

    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(index + ofs));
//*//    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popCombine2(picoBlaze_frame_plusw, PCOR(picoBlaze_popGet(aop, offset)), 0));
    if(picoBlaze_options.gstack)
      picoBlaze_testStackOverflow();
}

/*-----------------------------------------------------------------*/
/* picoBlaze_getDataSize - get the operand data size                         */
/*-----------------------------------------------------------------*/
int picoBlaze_getDataSize(operand *op)
{
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);


    return AOP_SIZE(op);

    // tsd- in the pic port, the genptr size is 1, so this code here
    // fails. ( in the 8051 port, the size was 4).
}

/*-----------------------------------------------------------------*/
/* picoBlaze_outAcc - output Acc                                             */
/*-----------------------------------------------------------------*/
void picoBlaze_outAcc(operand *result)
{
  int size,offset;
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d - ",__FUNCTION__,__LINE__);
  DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,NULL,NULL,result);


  size = picoBlaze_getDataSize(result);
  if(size){
    picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),0));
    size--;
    offset = 1;
    /* unsigned or positive */
    while(size--)
      picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),offset++));
  }

}

/*-----------------------------------------------------------------*/
/* picoBlaze_outBitC - output a bit C                                  */
/*                 Move to result the value of Carry flag -- VR    */
/*-----------------------------------------------------------------*/
void picoBlaze_outBitC(operand *result)
{
  int i;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    /* if the result is bit */
    if (AOP_TYPE(result) == AOP_CRY) {
        fprintf(stderr, "%s:%d: picoBlaze port warning: unsupported case\n", __FILE__, __LINE__);
        picoBlaze_aopPut(AOP(result),"c",0);
    } else {

        i = AOP_SIZE(result);
        while(i--) {
                picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result), i));
        }
        picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result), 0));
    }
}

/*-----------------------------------------------------------------*/
/* picoBlaze_outBitOp - output a bit from Op                           */
/*                 Move to result the value of set/clr op -- VR    */
/*-----------------------------------------------------------------*/
void picoBlaze_outBitOp(operand *result, pCodeOp *pcop)
{
  int i;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    /* if the result is bit */
    if (AOP_TYPE(result) == AOP_CRY) {
        fprintf(stderr, "%s:%d: picoBlaze port warning: unsupported case\n", __FILE__, __LINE__);
        picoBlaze_aopPut(AOP(result),"c",0);
    } else {

        i = AOP_SIZE(result);
        while(i--) {
                picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result), i));
        }
        picoBlaze_emitpcode(POC_RRCF, pcop);
        picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result), 0));
    }
}

/*-----------------------------------------------------------------*/
/* picoBlaze_toBoolean - emit code for orl a,operator(sizeop)                */
/*-----------------------------------------------------------------*/
void picoBlaze_toBoolean(operand *oper)
{
    int size = AOP_SIZE(oper) - 1;
    int offset = 1;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    if ( AOP_TYPE(oper) != AOP_ACC) {
      picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(oper),0));
    }
    while (size--) {
      picoBlaze_emitpcode(POC_IORFW, picoBlaze_popGet(AOP(oper),offset++));
    }
}

/*-----------------------------------------------------------------*/
/* genUminusFloat - unary minus for floating points                */
/*-----------------------------------------------------------------*/
static void genUminusFloat(operand *op,operand *result)
{
  int size ,offset =0 ;

    FENTRY;
    /* for this we just need to flip the
    first it then copy the rest in place */
    size = AOP_SIZE(op);
    assert( size == AOP_SIZE(result) );

    while(size--) {
      picoBlaze_mov2f(AOP(result), AOP(op), offset);
      offset++;
    }

    /* toggle the MSB's highest bit */
    picoBlaze_emitpcode(POC_BTG, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(result), offset-1), 7));
}

/*-----------------------------------------------------------------*/
/* genUminus - unary minus code generation                         */
/*-----------------------------------------------------------------*/
static void genUminus (iCode *ic)
{
  int lsize, rsize, i;
  sym_link *optype, *rtype;
  symbol *label;
  int needLabel=0;

    FENTRY;

    /* assign asmops */
    picoBlaze_aopOp(IC_LEFT(ic),ic,FALSE);
    picoBlaze_aopOp(IC_RESULT(ic),ic,TRUE);

    /* if both in bit space then special case */
    if (AOP_TYPE(IC_RESULT(ic)) == AOP_CRY
      && AOP_TYPE(IC_LEFT(ic)) == AOP_CRY ) {

        picoBlaze_emitpcode(POC_BCF,   picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
        picoBlaze_emitpcode(POC_BTFSS, picoBlaze_popGet(AOP(IC_LEFT(ic)),0));
        picoBlaze_emitpcode(POC_BSF,   picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
        goto release;
    }

    optype = operandType(IC_LEFT(ic));
    rtype = operandType(IC_RESULT(ic));


    /* if float then do float stuff */
    if (IS_FLOAT(optype) || IS_FIXED(optype)) {
      if(IS_FIXED(optype))
        debugf("implement fixed16x16 type\n", 0);

        genUminusFloat(IC_LEFT(ic),IC_RESULT(ic));
        goto release;
    }

    /* otherwise subtract from zero by taking the 2's complement */
    lsize = AOP_SIZE(IC_LEFT(ic));
    rsize = AOP_SIZE(IC_RESULT(ic));
    label = newiTempLabel ( NULL );

    if (picoBlaze_sameRegs (AOP(IC_LEFT(ic)), AOP(IC_RESULT(ic)))) {
      /* If the result is longer than the operand,
         store sign extension (0x00 or 0xff) in W */
      if (rsize > lsize) {
        picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit(0x00));
        picoBlaze_emitpcode (POC_BTFSS, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(IC_LEFT(ic)), lsize-1), 7));
        picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit(0xFF));
      }
      for (i = rsize - 1; i > 0; --i) {
        if (i > lsize - 1) {
          picoBlaze_emitpcode (POC_MOVWF, picoBlaze_popGet (AOP(IC_RESULT(ic)), i));
        } else {
          picoBlaze_emitpcode (POC_COMF, picoBlaze_popGet (AOP(IC_RESULT(ic)), i));
        } // if
      } // for
      picoBlaze_emitpcode (POC_NEGF, picoBlaze_popGet (AOP(IC_RESULT(ic)), 0));
      for (i = 1; i < rsize; ++i) {
        if (i == rsize - 1) {
//*//          emitSKPNZ;
        } else {
          picoBlaze_emitpcode (POC_BNZ, picoBlaze_popGetLabel (label->key)); needLabel++;
        }
        picoBlaze_emitpcode (POC_INCF, picoBlaze_popGet (AOP(IC_RESULT(ic)), i));
      } // for
    } else {
      for (i = min(rsize, lsize) - 1; i >= 0; i--) {
        picoBlaze_emitpcode (POC_COMFW, picoBlaze_popGet (AOP(IC_LEFT(ic)), i));
        picoBlaze_emitpcode (POC_MOVWF, picoBlaze_popGet (AOP(IC_RESULT(ic)), i));
      } // for
      /* Sign extend if the result is longer than the operand */
      if (rsize > lsize) {
        picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit(0x00));
        picoBlaze_emitpcode (POC_BTFSC, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(IC_RESULT(ic)), lsize - 1), 7));
        picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit(0xFF));
        for (i = rsize - 1; i > lsize - 1; --i) {
          picoBlaze_emitpcode (POC_MOVWF, picoBlaze_popGet (AOP(IC_RESULT(ic)), i));
        } // for
      } // if
      if (rsize > 1) {
        for (i = 0; i < rsize - 2; i++) {
          picoBlaze_emitpcode (POC_INCF, picoBlaze_popGet (AOP(IC_RESULT(ic)),i));
          picoBlaze_emitpcode (POC_BNZ, picoBlaze_popGetLabel (label->key));
          needLabel++;
        } // for
        picoBlaze_emitpcode (POC_INFSNZ, picoBlaze_popGet (AOP(IC_RESULT(ic)), rsize - 2));
      } // if
      picoBlaze_emitpcode (POC_INCF, picoBlaze_popGet(AOP(IC_RESULT(ic)), rsize - 1));
    }
    if (needLabel)
      picoBlaze_emitpLabel (label->key);

release:
    /* release the aops */
    picoBlaze_freeAsmop(IC_LEFT(ic), NULL, ic, (RESULTONSTACK(ic) ? 0 : 1));
    picoBlaze_freeAsmop(IC_RESULT(ic), NULL, ic, TRUE);
}

void picoBlaze_loadFromReturn(operand *op, int offset, pCodeOp *src)
{
  if((AOP(op)->type == AOP_PCODE) && (0)) {
    picoBlaze_emitpcode(POC_MOVFW, src);
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(op), offset));
  } else {
    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(
        src, picoBlaze_popGet(AOP(op), offset)));
  }
}


/*-----------------------------------------------------------------*/
/* assignResultValue - assign results to oper, rescall==1 is       */
/*                     called from genCall() or genPcall()         */
/*-----------------------------------------------------------------*/
static void assignResultValue(operand * oper, int res_size, int rescall)
{
  int size = AOP_SIZE(oper);
  int offset=0;

    FENTRY2;
//    DEBUGpicoBlaze_emitcode ("; ***","%s  %d rescall:%d size:%d",__FUNCTION__,__LINE__,rescall,size); // patch 14
    DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,oper,NULL,NULL);

    if(rescall) {
      /* assign result from a call/pcall function() */

      /* function results are stored in a special order,
       * see top of file with Function return policy, or manual */

      if(size <= 4) {
        /* 8-bits, result in WREG */
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(oper), 0));

        if(size > 1 && res_size > 1) {
          /* 16-bits, result in PRODL:WREG */
//*//          picoBlaze_loadFromReturn(oper, 1, picoBlaze_popCopyReg(&picoBlaze_pc_prodl));
        }

        if(size > 2 && res_size > 2) {
          /* 24-bits, result in PRODH:PRODL:WREG */
//*//          picoBlaze_loadFromReturn(oper, 2, picoBlaze_popCopyReg(&picoBlaze_pc_prodh)); // patch 14
        }

        if(size > 3 && res_size > 3) {
          /* 32-bits, result in FSR0L:PRODH:PRODL:WREG */
//*//          picoBlaze_loadFromReturn(oper, 3, picoBlaze_popCopyReg(&picoBlaze_pc_fsr0l)); // patch14
        }

        picoBlaze_addSign(oper, res_size, IS_UNSIGNED(operandType(oper)));

      } else {
        /* >32-bits, result on stack, and FSR0 points to beginning.
         * Fix stack when done */
        /* FIXME FIXME */
//      debugf("WARNING: Possible bug when returning more than 4-bytes\n");
        while (size--) {
//          DEBUGpicoBlaze_emitcode("; ", "POC_MOVLW %d", GpsuedoStkPtr);
//          DEBUGpicoBlaze_emitcode("; ", "POC_MOVFW PLUSW2");

          picoBlaze_popaopidx(AOP(oper), size, GpsuedoStkPtr);
          GpsuedoStkPtr++;
        }

        /* fix stack */
        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit( AOP_SIZE(oper) ));
//*//        picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popCopyReg( picoBlaze_stackpnt_lo ));      //&picoBlaze_pc_fsr1l ));
        if(STACK_MODEL_LARGE) {
//*//          emitSKPNC;
//*//          picoBlaze_emitpcode(POC_INCF, picoBlaze_popCopyReg( picoBlaze_stackpnt_hi ));     //&picoBlaze_pc_fsr1h ));
        }
      }
    } else {
      int areg = 0;             /* matching argument register */

//      debugf("_G.useWreg = %d\tGpsuedoStkPtr = %d\n", _G.useWreg, GpsuedoStkPtr);
      areg = SPEC_ARGREG( OP_SYM_ETYPE( oper ) ) - 1;


      /* its called from genReceive (probably) -- VR */
      /* I hope this code will not be called from somewhere else in the future!
       * We manually set the pseudo stack pointer in genReceive. - dw
       */
      if(!GpsuedoStkPtr && _G.useWreg) {
//        DEBUGpicoBlaze_emitcode("; ", "pop %d", GpsuedoStkPtr);

        /* The last byte in the assignment is in W */
        if(areg <= GpsuedoStkPtr) {
          size--;
          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(oper), offset /*size*/));
          offset++;
//          debugf("receive from WREG\n", 0);
        }
        GpsuedoStkPtr++; /* otherwise the calculation below fails (-_G.useWreg) */
      }
//      GpsuedoStkPtr++;
      _G.stack_lat = AOP_SIZE(oper)-1;

      while (size) {
        size--;
        GpsuedoStkPtr++;
        picoBlaze_popaopidx(AOP(oper), offset, GpsuedoStkPtr - _G.useWreg);
//        debugf("receive from STACK\n", 0);
        offset++;
      }
    }
}


/*-----------------------------------------------------------------*/
/* genIpush - generate code for pushing this gets a little complex */
/*-----------------------------------------------------------------*/
static void genIpush (iCode *ic)
{
//  int size, offset=0;

  FENTRY;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d - WARNING no code generated",__FUNCTION__,__LINE__);

  if(ic->parmPush) {
    picoBlaze_aopOp(IC_LEFT(ic), ic, FALSE );

    /* send to stack as normal */
    addSet(&_G.sendSet,ic);
//    addSetHead(&_G.sendSet,ic);
    picoBlaze_freeAsmop(IC_LEFT(ic),NULL,ic,TRUE);
  }

}

/*-----------------------------------------------------------------*/
/* genIpop - recover the registers: can happen only for spilling   */
/*-----------------------------------------------------------------*/
static void genIpop (iCode *ic)
{
  FENTRY;
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d - WARNING no code generated",__FUNCTION__,__LINE__);
}

static int wparamCmp(void *p1, void *p2)
{
  return (!strcmp((char *)p1, (char *)p2));
}

int picoBlaze_inWparamList(char *s)
{
  return isinSetWith(picoBlaze_wparamList, s, wparamCmp);
}


/*-----------------------------------------------------------------*/
/* genCall - generates a call statement                            */
/*-----------------------------------------------------------------*/
static void genCall (iCode *ic)
{
  sym_link *ftype;
  int stackParms=0;
  int use_wreg=0;
  int inwparam=0;
  char *fname;

    FENTRY;
	
    ftype = OP_SYM_TYPE(IC_LEFT(ic));
    /* if caller saves & we have not saved then */
//    if (!ic->regsSaved)
//      saveRegisters(ic);

        /* initialise stackParms for IPUSH pushes */
//      stackParms = psuedoStkPtr;
//      fprintf(stderr, "%s:%d ic parmBytes = %d\n", __FILE__, __LINE__, ic->parmBytes);

	// function name
    fname = OP_SYMBOL(IC_LEFT(ic))->rname[0]?OP_SYMBOL(IC_LEFT(ic))->rname:OP_SYMBOL(IC_LEFT(ic))->name;
    
	// has parameter in acumulator
	inwparam = (picoBlaze_inWparamList(OP_SYMBOL(IC_LEFT(ic))->name)) || (FUNC_ISWPARAM(OP_SYM_TYPE(IC_LEFT(ic))));

	// sendSet was previously filled by SEND iCode processing
    /* if send set is not empty the assign */
    if (_G.sendSet) {
      iCode *sic;
      int psuedoStkPtr=-1;
      int firstTimeThruLoop = 1;


        /* reverse sendSet if function is not reentrant */
	    // used for some aritmetic functions
        if(!IFFUNC_ISREENT(ftype))
          _G.sendSet = reverseSet(_G.sendSet);

        /* First figure how many parameters are getting passed */
        stackParms = 0;
        use_wreg = 0;

        for (sic = setFirstItem(_G.sendSet) ; sic ; sic = setNextItem(_G.sendSet)) {
          int size;
//          int offset = 0;

            picoBlaze_aopOp(IC_LEFT(sic),sic,FALSE);
            size = AOP_SIZE(IC_LEFT(sic));

            stackParms += size;

            /* pass the last byte through WREG */
            if(inwparam) {

              while (size--) {
                DEBUGpicoBlaze_emitcode ("; ","%d left %s",__LINE__,
                      picoBlaze_AopType(AOP_TYPE(IC_LEFT(sic))));
                DEBUGpicoBlaze_emitcode("; ", "push %d", psuedoStkPtr-1);

                if(!firstTimeThruLoop) {
                  /* If this is not the first time we've been through the loop
                   * then we need to save the parameter in a temporary
                   * register. The last byte of the last parameter is
                   * passed in W. */

                  picoBlaze_pushw();
//                  --psuedoStkPtr;             // sanity check
                  use_wreg = 1;
                }

                firstTimeThruLoop=0;

                picoBlaze_emulPush (AOP(IC_LEFT(sic)), size);

//                offset++;
              }
            } else {
              /* all arguments are passed via stack */
              use_wreg = 0;

              while (size--) {
                DEBUGpicoBlaze_emitcode ("; ","%d left %s",__LINE__,
                      picoBlaze_AopType(AOP_TYPE(IC_LEFT(sic))));
                DEBUGpicoBlaze_emitcode("; ", "push %d", psuedoStkPtr-1);

//                picoBlaze_pushaop(AOP(IC_LEFT(sic)), size);
//**//                                picoBlaze_mov2w( AOP(IC_LEFT(sic)), size );

				picoBlaze_emulPush (AOP(IC_LEFT(sic)), size);
                if(!_G.resDirect)
                  picoBlaze_pushw();
              }
            }

            picoBlaze_freeAsmop (IC_LEFT(sic),NULL,sic,TRUE);
          }

          if(inwparam) {
            if(IFFUNC_HASVARARGS(ftype) || IFFUNC_ISREENT(ftype)) {
              picoBlaze_pushw();  /* save last parameter to stack if functions has varargs */
              use_wreg = 0;
            } else
              use_wreg = 1;
          } else use_wreg = 0;

          _G.stackRegSet = _G.sendSet;
          _G.sendSet = NULL;
    }

    /* make the call */
    picoBlaze_emitpcode(POC_CALL,picoBlaze_popGetWithString(fname));

    GpsuedoStkPtr=0;

    /* if we need to assign a result value */
    if ((IS_ITEMP(IC_RESULT(ic))
          && (OP_SYMBOL(IC_RESULT(ic))->nRegs
              || OP_SYMBOL(IC_RESULT(ic))->spildir ))
        || IS_TRUE_SYMOP(IC_RESULT(ic)) ) {

      _G.accInUse++;
      picoBlaze_aopOp(IC_RESULT(ic),ic,FALSE);
      _G.accInUse--;

      /* Must not assign an 8-bit result to a 16-bit variable;
       * this would use (used...) the uninitialized PRODL! */
      /* FIXME: Need a proper way to obtain size of function result type,
       * OP_SYM_ETYPE does not work: it dereferences pointer types! */
      assignResultValue(IC_RESULT(ic), getSize(OP_SYM_TYPE(IC_LEFT(ic))->next), 1);

      DEBUGpicoBlaze_emitcode ("; ","%d left %s",__LINE__,
                picoBlaze_AopType(AOP_TYPE(IC_RESULT(ic))));

      picoBlaze_freeAsmop(IC_RESULT(ic),NULL, ic,TRUE);
    }

    if(!stackParms && ic->parmBytes) {
      stackParms = ic->parmBytes;
    }

    stackParms -= use_wreg;

    if(stackParms>0) {
      if(stackParms == 1) {
//*//        picoBlaze_emitpcode(POC_INCF, picoBlaze_popCopyReg(picoBlaze_stackpnt_lo ));        //&picoBlaze_pc_fsr1l));
      } else {
        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(stackParms));
//*//        picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popCopyReg( picoBlaze_stackpnt_lo ));      //&picoBlaze_pc_fsr1l ));
      }
      if(STACK_MODEL_LARGE) {
//*//        emitSKPNC;
//*//        picoBlaze_emitpcode(POC_INCF, picoBlaze_popCopyReg( picoBlaze_stackpnt_hi ));       //&picoBlaze_pc_fsr1h ));
      }
    }


    /* adjust the stack for parameters if required */
//    fprintf(stderr, "%s:%d: %s ic->parmBytes= %d\n", __FILE__, __LINE__, OP_SYMBOL(IC_LEFT(ic))->name, ic->parmBytes);

}



/*-----------------------------------------------------------------*/
/* genPcall - generates a call by pointer statement                */
/*            new version, created from genCall - HJD              */
/*-----------------------------------------------------------------*/
static void genPcall (iCode *ic)
{
  sym_link *fntype;
  int stackParms=0;
  symbol *retlbl = newiTempLabel(NULL);
  pCodeOp *pcop_lbl = picoBlaze_popGetLabel(retlbl->key);

    FENTRY;

    fntype = operandType( IC_LEFT(ic) )->next;

    /* if send set is not empty the assign */
    if (_G.sendSet) {
      iCode *sic;
      int psuedoStkPtr=-1;

      /* reverse sendSet if function is not reentrant */
      if(!IFFUNC_ISREENT(fntype))
        _G.sendSet = reverseSet(_G.sendSet);

      stackParms = 0;

      for (sic = setFirstItem(_G.sendSet) ; sic ; sic = setNextItem(_G.sendSet)) {
        int size;

          picoBlaze_aopOp(IC_LEFT(sic),sic,FALSE);
          size = AOP_SIZE(IC_LEFT(sic));
          stackParms += size;

          /* all parameters are passed via stack, since WREG is clobbered
           * by the calling sequence */
          while (size--) {
            DEBUGpicoBlaze_emitcode ("; ","%d left %s",__LINE__,
            picoBlaze_AopType(AOP_TYPE(IC_LEFT(sic))));
            DEBUGpicoBlaze_emitcode("; ", "push %d", psuedoStkPtr-1);

            picoBlaze_mov2w (AOP(IC_LEFT(sic)), size);
            picoBlaze_pushw();
          }

          picoBlaze_freeAsmop (IC_LEFT(sic),NULL,sic,TRUE);
      }

      _G.stackRegSet = _G.sendSet;
      _G.sendSet = NULL;
    }

    picoBlaze_aopOp(IC_LEFT(ic),ic,FALSE);

    // push return address
    // push $ on return stack, then replace with retlbl

    /* Thanks to Thorsten Klose for pointing out that the following
     * snippet should be interrupt safe */
//*//    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(&picoBlaze_pc_intcon), picoBlaze_popCopyReg(&picoBlaze_pc_postdec1)));
//*//    picoBlaze_emitpcode(POC_BCF, picoBlaze_popCopyGPR2Bit(picoBlaze_popCopyReg(&picoBlaze_pc_intcon), 7));

    picoBlaze_emitpcodeNULLop(POC_PUSH);

    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetImmd(pcop_lbl->name, 0, 0));
//*//    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_tosl));
    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetImmd(pcop_lbl->name, 1, 0));
//*//    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_tosh));
    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetImmd(pcop_lbl->name, 2, 0));
 //*//   picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_tosu));


    /* restore interrupt control register */
//*//    picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(&picoBlaze_pc_preinc1));
//*//    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_intcon));

    /* make the call by writing the pointer into pc */
//*//    mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_pclatu), AOP(IC_LEFT(ic)), 2);
//*//    mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_pclath), AOP(IC_LEFT(ic)), 1);

    // note: MOVFF to PCL not allowed
    picoBlaze_mov2w(AOP(IC_LEFT(ic)), 0);
//*//    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_pcl));


    /* return address is here: (X) */
    picoBlaze_emitpLabelFORCE(retlbl->key);

    picoBlaze_freeAsmop (IC_LEFT(ic),NULL,ic,TRUE);

    GpsuedoStkPtr=0;
    /* if we need assign a result value */
    if ((IS_ITEMP(IC_RESULT(ic))
          && (OP_SYMBOL(IC_RESULT(ic))->nRegs
              || OP_SYMBOL(IC_RESULT(ic))->spildir ))
        || IS_TRUE_SYMOP(IC_RESULT(ic)) ) {

      _G.accInUse++;
      picoBlaze_aopOp(IC_RESULT(ic),ic,FALSE);
      _G.accInUse--;

      /* FIXME: Need proper way to obtain the function result's type.
       * OP_SYM_TYPE(IC_LEFT(ic))->next does not work --> points to function pointer */
      assignResultValue(IC_RESULT(ic), getSize(OP_SYM_TYPE(IC_LEFT(ic))->next->next), 1);

      DEBUGpicoBlaze_emitcode ("; ","%d left %s",__LINE__,
              picoBlaze_AopType(AOP_TYPE(IC_RESULT(ic))));

      picoBlaze_freeAsmop(IC_RESULT(ic),NULL, ic,TRUE);
    }

//    stackParms -= use_wreg;

    if(stackParms>0) {
      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(stackParms));
//*//      picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popCopyReg( picoBlaze_stackpnt_lo ));
      if(STACK_MODEL_LARGE) {
//*//        emitSKPNC;
//*//        picoBlaze_emitpcode(POC_INCF, picoBlaze_popCopyReg( picoBlaze_stackpnt_hi ));
      }
    }
}

/*-----------------------------------------------------------------*/
/* resultRemat - result  is rematerializable                       */
/*-----------------------------------------------------------------*/
static int resultRemat (iCode *ic)
{
  //    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  if (SKIP_IC(ic) || ic->op == IFX)
    return 0;

  if (IC_RESULT(ic) && IS_ITEMP(IC_RESULT(ic))) {
    symbol *sym = OP_SYMBOL(IC_RESULT(ic));
    if (sym->remat && !POINTER_SET(ic))
      return 1;
  }

  return 0;
}

/*-----------------------------------------------------------------*/
/* genFunction - generated code for function entry                 */
/*-----------------------------------------------------------------*/
static void genFunction (iCode *ic)
{
  symbol *sym;
  sym_link *ftype;

    FENTRY;
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d curr label offset=%dprevious max_key=%d ",__FUNCTION__,__LINE__,picoBlaze_labelOffset,max_key);

    picoBlaze_labelOffset += (max_key+4);
    max_key=0;
    GpsuedoStkPtr=0;
    _G.nRegsSaved = 0;

    ftype = operandType(IC_LEFT(ic));
    sym = OP_SYMBOL(IC_LEFT(ic));

    if(IFFUNC_ISISR(sym->type /*ftype*/)) {
      /* create an absolute section at the interrupt vector:
       * that is 0x0008 for interrupt 1 (high), 0x0018 interrupt 2 (low) */
      symbol *asym;
      char asymname[128];
      pBlock *apb;

//        debugf("interrupt number: %hhi\n", FUNC_INTNO(sym->type));

        if(FUNC_INTNO(sym->type) == INTNO_UNSPEC)
          sprintf(asymname, "ivec_%s", sym->name);
        else
          sprintf(asymname, "ivec_0x%x_%s", FUNC_INTNO(sym->type), sym->name);

        /* when an interrupt is declared as naked, do not emit the special
         * wrapper segment at vector address. The user should take care for
         * this instead. -- VR */

        if(!IFFUNC_ISNAKED(ftype) && (FUNC_INTNO(sym->type) != INTNO_UNSPEC)) {
          asym = newSymbol(asymname, 0);
          apb = picoBlaze_newpCodeChain(NULL, 'A', picoBlaze_newpCodeCharP("; Starting pCode block for absolute section"));
          picoBlaze_addpBlock( apb );

          picoBlaze_addpCode2pBlock(apb, picoBlaze_newpCodeCharP(";-----------------------------------------"));
          picoBlaze_addpCode2pBlock(apb, picoBlaze_newpCodeFunction(moduleName, asym->name));
          //picoBlaze_addpCode2pBlock(apb, picoBlaze_newpCode(POC_GOTO, picoBlaze_popGetWithString( sym->rname )));
          //picoBlaze_addpCode2pBlock(apb, picoBlaze_newpCode(POC_GOTO, picoBlaze_newpCodeOpLabel (sym->rname, 0)));
          picoBlaze_addpCode2pBlock(apb, picoBlaze_newpCodeAsmDir ("GOTO", "%s", sym->rname)); /* this suppresses a warning in LinkFlow */

          /* mark the end of this tiny function */
          picoBlaze_addpCode2pBlock(apb,picoBlaze_newpCodeFunction(NULL,NULL));
        } else {
          sprintf(asymname, "%s", sym->rname);
        }

        {
          absSym *abSym;

            abSym = Safe_calloc(1, sizeof(absSym));
            strcpy(abSym->name, asymname);

            switch( FUNC_INTNO(sym->type) ) {
              case 0: abSym->address = 0x000000; break;
              case 1: abSym->address = 0x000008; break;
              case 2: abSym->address = 0x000018; break;

              default:
//                fprintf(stderr, "no interrupt number is given\n");
                abSym->address = -1; break;
            }

            /* relocate interrupt vectors if needed */
            if(abSym->address != -1)
              abSym->address += picoBlaze_options.ivt_loc;

            addSet(&absSymSet, abSym);
        }
    }

    /* create the function header */
    picoBlaze_emitcode(";","-----------------------------------------");
    picoBlaze_emitcode(";"," function %s",sym->name);
    picoBlaze_emitcode(";","-----------------------------------------");

    /* prevent this symbol from being emitted as 'extern' */
    picoBlaze_stringInSet(sym->rname, &picoBlaze_localFunctions, 1);

    picoBlaze_emitcode("","%s:",sym->rname);
    picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeFunction(moduleName,sym->rname));

    {
      absSym *ab;

        for(ab = setFirstItem(absSymSet); ab; ab = setNextItem(absSymSet)) {
          if(!strcmp(ab->name, sym->rname)) {
            picoBlaze_pBlockConvert2Absolute(pb);
            break;
          }
        }
    }

    if(IFFUNC_ISNAKED(ftype)) {
      DEBUGpicoBlaze_emitcode("; ***", "_naked function, no prologue");
      return;
    }

    /* if critical function then turn interrupts off */
    if (IFFUNC_ISCRITICAL(ftype)) {
      //picoBlaze_emitcode("clr","ea");
    }

    currFunc = sym;             /* update the currFunc symbol */
    _G.fregsUsed = sym->regsUsed;
    _G.sregsAlloc = newBitVect(128);	/* TODO: change to 16 - the number of registers of PicoBlaze */


    /* if this is an interrupt service routine then
     * save wreg, status, bsr, prodl, prodh, fsr0l, fsr0h */
    if (IFFUNC_ISISR(sym->type)) {
        _G.usefastretfie = 1;   /* use shadow registers by default */

        /* an ISR should save: WREG, STATUS, BSR, PRODL, PRODH, FSR0L, FSR0H */
        if(!FUNC_ISSHADOWREGS(sym->type)) {
          /* do not save WREG,STATUS,BSR for high priority interrupts
           * because they are stored in the hardware shadow registers already */
          _G.usefastretfie = 0;
//*//          picoBlaze_pushpCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_wreg ));
//*//          picoBlaze_pushpCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_status ));
//*//          picoBlaze_pushpCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_bsr ));
        }

        /* these should really be optimized somehow, because not all
         * interrupt handlers modify them */
//*//        picoBlaze_pushpCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_prodl ));
//*//        picoBlaze_pushpCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_prodh ));
//*//        picoBlaze_pushpCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_fsr0l ));
//*//        picoBlaze_pushpCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_fsr0h ));
//*//        picoBlaze_pushpCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_pclath ));
//*//        picoBlaze_pushpCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_pclatu ));

    }

    /* emit code to setup stack frame if user enabled,
     * and function is not main() */

//    debugf(stderr, "function name: %s ARGS=%p\n", sym->name, FUNC_ARGS(sym->type));
    if(strcmp(sym->name, "main")) {
      if(0
        || !options.ommitFramePtr
//        || sym->regsUsed
        || IFFUNC_ARGS(sym->type)
        || FUNC_HASSTACKPARM(sym->etype)
        ) {
        /* setup the stack frame */
//*//        if(STACK_MODEL_LARGE)
//*//          picoBlaze_pushpCodeOp(picoBlaze_popCopyReg(picoBlaze_framepnt_hi));
//*//        picoBlaze_pushpCodeOp(picoBlaze_popCopyReg(picoBlaze_framepnt_lo));

 //*//       if(STACK_MODEL_LARGE)
//*//          picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popCombine2( picoBlaze_stackpnt_hi, picoBlaze_framepnt_hi, 0));
//*//        picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popCombine2( picoBlaze_stackpnt_lo, picoBlaze_framepnt_lo, 0));
      }
    }

    if ((IFFUNC_ISREENT(sym->type) || options.stackAuto)
          && sym->stack) {

      if (sym->stack > 127)werror(W_STACK_OVERFLOW, sym->name);

      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(sym->stack));
//*//      picoBlaze_emitpcode(POC_SUBWF, picoBlaze_popCopyReg( picoBlaze_stackpnt_lo ));        //&picoBlaze_pc_fsr1l));
//*//      emitSKPC;
//*//      picoBlaze_emitpcode(POC_DECF, picoBlaze_popCopyReg( picoBlaze_stackpnt_hi ));         //&picoBlaze_pc_fsr1h));
    }

    if(picoBlaze_inWparamList(sym->name) || FUNC_ISWPARAM(sym->type)) {
      if(IFFUNC_HASVARARGS(sym->type) || IFFUNC_ISREENT(sym->type))
        _G.useWreg = 0;
      else
        _G.useWreg = 1;
    } else
      _G.useWreg = 0;

    /* if callee-save to be used for this function
     * then save the registers being used in this function */
//    if (IFFUNC_CALLEESAVES(sym->type))
    if(strcmp(sym->name, "main")) {
      int i;

        /* if any registers used */
        if (sym->regsUsed) {
                  picoBlaze_emitpinfo(INF_LOCALREGS, picoBlaze_newpCodeOpLocalRegs(LR_ENTRY_BEGIN));

          if(!picoBlaze_options.xinst) {
            /* save the registers used */
            DEBUGpicoBlaze_emitcode("; **", "Saving used registers in stack");
            for ( i = 0 ; i < sym->regsUsed->size ; i++) {
              if (bitVectBitValue(sym->regsUsed,i)) {
                picoBlaze_pushpCodeOp( picoBlaze_popRegFromIdx(i) );
                _G.nRegsSaved++;

                if(!picoBlaze_regWithIdx(i)->wasUsed) {
                  fprintf(stderr, "%s:%d register %s is used in function but was wasUsed = 0\n",
                                __FILE__, __LINE__, picoBlaze_regWithIdx(i)->name);
                  picoBlaze_regWithIdx(i)->wasUsed = 1;
                }
              }
            }
          } else {

            /* xinst */
            DEBUGpicoBlaze_emitcode("; **", "Allocate a space in stack to be used as temporary registers");
            for(i=0;i<sym->regsUsed->size;i++) {
              if(bitVectBitValue(sym->regsUsed, i)) {
                _G.nRegsSaved++;
              }
            }

//            picoBlaze_emitpcode(POC_ADDFSR, picoBlaze_popGetLit2(2, picoBlaze_popGetLit(_G.nRegsSaved)));
          }

          picoBlaze_emitpinfo(INF_LOCALREGS, picoBlaze_newpCodeOpLocalRegs(LR_ENTRY_END));

        }
    }

    DEBUGpicoBlaze_emitcode("; ", "need to adjust stack = %d", sym->stack);
//    fprintf(stderr, "Function '%s' uses %d bytes of stack\n", sym->name, sym->stack);
}

/*-----------------------------------------------------------------*/
/* genEndFunction - generates epilogue for functions               */
/*-----------------------------------------------------------------*/
static void genEndFunction (iCode *ic)
{
  symbol *sym = OP_SYMBOL(IC_LEFT(ic));

    FENTRY;

    if(IFFUNC_ISNAKED(sym->type)) {
      DEBUGpicoBlaze_emitcode("; ***", "_naked function, no epilogue");
      return;
    }

    _G.stack_lat = 0;

    /* add code for ISCRITICAL */
    if(IFFUNC_ISCRITICAL(sym->type)) {
      /* if critical function, turn on interrupts */

      /* TODO: add code here -- VR */
    }

//    sym->regsUsed = _G.fregsUsed;

    /* now we need to restore the registers */
    /* if any registers used */

    /* first restore registers that might be used for stack access */
    if(_G.sregsAllocSet) {
    regs *sr;

      _G.sregsAllocSet = reverseSet( _G.sregsAllocSet );
      for(sr=setFirstItem(_G.sregsAllocSet) ; sr; sr=setNextItem(_G.sregsAllocSet)) {
        picoBlaze_poppCodeOp( picoBlaze_popRegFromIdx( sr->rIdx ) );
      }
    }

    if (strcmp(sym->name, "main") && sym->regsUsed) {
      int i;

        picoBlaze_emitpinfo(INF_LOCALREGS, picoBlaze_newpCodeOpLocalRegs(LR_EXIT_BEGIN));
        /* restore registers used */
        DEBUGpicoBlaze_emitcode("; **", "Restoring used registers from stack");
        for ( i = sym->regsUsed->size; i >= 0; i--) {
          if (bitVectBitValue(sym->regsUsed,i)) {
            picoBlaze_poppCodeOp( picoBlaze_popRegFromIdx(i) );
            _G.nRegsSaved--;
          }
        }
        picoBlaze_emitpinfo(INF_LOCALREGS, picoBlaze_newpCodeOpLocalRegs(LR_EXIT_END));
    }



    if ((IFFUNC_ISREENT(sym->type) || options.stackAuto)
          && sym->stack) {
      if (sym->stack == 1) {
//*//        picoBlaze_emitpcode(POC_INFSNZ, picoBlaze_popCopyReg( picoBlaze_stackpnt_lo ));
//*//        picoBlaze_emitpcode(POC_INCF, picoBlaze_popCopyReg( picoBlaze_stackpnt_hi ));
      } else {
        // we have to add more than one...
//*//        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg( picoBlaze_stack_postinc ));    // this holds a return value!
        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(sym->stack-1));
//*//        picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popCopyReg( picoBlaze_stackpnt_lo ));
//*//        emitSKPNC;
//*//        picoBlaze_emitpcode(POC_INCF, picoBlaze_popCopyReg( picoBlaze_stackpnt_hi ));
//*//        picoBlaze_emitpcode(POC_COMF,  picoBlaze_popCopyReg(&picoBlaze_pc_wreg)); // WREG = -(WREG+1)!
//*//        picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(picoBlaze_stack_plusw)); // this holds a retrun value!
      }
    }

    if(strcmp(sym->name, "main")) {
      if(0
        || !options.ommitFramePtr
//        || sym->regsUsed
        || IFFUNC_ARGS(sym->type)
        || FUNC_HASSTACKPARM(sym->etype)
        ) {
        /* restore stack frame */
//*//        picoBlaze_poppCodeOp( picoBlaze_popCopyReg( picoBlaze_framepnt_lo ));
//*//        if(STACK_MODEL_LARGE)
//*//          picoBlaze_poppCodeOp( picoBlaze_popCopyReg( picoBlaze_framepnt_hi ));
      }
    }

    _G.useWreg = 0;

    if (IFFUNC_ISISR(sym->type)) {
//*//      picoBlaze_poppCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_pclatu ));
//*//      picoBlaze_poppCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_pclath ));
//*//      picoBlaze_poppCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_fsr0h ));
//*//      picoBlaze_poppCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_fsr0l));
//*//      picoBlaze_poppCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_prodh ));
//*//      picoBlaze_poppCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_prodl ));

      if(!FUNC_ISSHADOWREGS(sym->type)) {
        /* do not restore interrupt vector for WREG,STATUS,BSR
         * for high priority interrupt, see genFunction */
//*//        picoBlaze_poppCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_bsr ));
//*//        picoBlaze_poppCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_status ));
//*//        picoBlaze_poppCodeOp( picoBlaze_popCopyReg( &picoBlaze_pc_wreg ));
      }
//      _G.interruptvector = 0;         /* sanity check */


      /* if debug then send end of function */
/*      if (options.debug && currFunc)  */
      if (currFunc) {
        debugFile->writeEndFunction (currFunc, ic, 1);
      }

      if(_G.usefastretfie)
        picoBlaze_emitpcode(POC_RETFIE, picoBlaze_newpCodeOpLit(1));
      else
        picoBlaze_emitpcodeNULLop(POC_RETFIE);

      picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeFunction(NULL,NULL));

      _G.usefastretfie = 0;
      return;
    }

    if (IFFUNC_ISCRITICAL(sym->type)) {
      picoBlaze_emitcode("setb","ea");
    }

    /* if debug then send end of function */
    if (currFunc) {
      debugFile->writeEndFunction (currFunc, ic, 1);
    }

    /* insert code to restore stack frame, if user enabled it
     * and function is not main() */


    picoBlaze_emitpcodeNULLop(POC_RETURN);

    /* Mark the end of a function */
    picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeFunction(NULL,NULL));
}


void picoBlaze_storeForReturn(iCode *ic, /*operand *op,*/ int offset, pCodeOp *dest)
{
  unsigned long lit=1;
  operand *op;

    op = IC_LEFT(ic);

    // this fails for picoBlaze_isLitOp(op) (if op is an AOP_PCODE)
    if(AOP_TYPE(op) == AOP_LIT) {
      if(!IS_FLOAT(operandType( op ))) {
        lit = ulFromVal (AOP(op)->aopu.aop_lit);
      } else {
        union {
          unsigned long lit_int;
          float lit_float;
        } info;

        /* take care if literal is a float */
        info.lit_float = floatFromVal(AOP(op)->aopu.aop_lit);
        lit = info.lit_int;
      }
    }

    if (AOP_TYPE(op) == AOP_LIT) {
      /* FIXME: broken for
       *   char __at(0x456) foo;
       *   return &foo;
       * (upper byte is 0x00 (__code space) instead of 0x80 (__data) */
      picoBlaze_movLit2f(dest, (lit >> (8ul*offset)));
    } else if (AOP_TYPE(op) == AOP_PCODE
                && 0) {
      /* char *s= "aaa"; return s; */
      /* XXX: Using UPPER(__str_0) will yield 0b00XXXXXX, so
       *      that the generic pointer is interpreted correctly
       *      as referring to __code space, but this is fragile! */
      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet( AOP(op), offset ));
      /* XXX: should check that dest != WREG */
      picoBlaze_emitpcode(POC_MOVWF, dest);
    } else {
      picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popGet(AOP(op), offset), dest));
    }
}

/*-----------------------------------------------------------------*/
/* genRet - generate code for return statement                     */
/*-----------------------------------------------------------------*/
static void genRet (iCode *ic)
{
  int size;
  operand *left;

    FENTRY;
        /* if we have no return value then
         * just generate the "ret" */

        if (!IC_LEFT(ic))
                goto jumpret;

        /* we have something to return then
         * move the return value into place */
        picoBlaze_aopOp((left=IC_LEFT(ic)),ic,FALSE);
        size = AOP_SIZE(IC_LEFT(ic));

        if(size <= 4) {
//*//          if(size>3)
//*//            picoBlaze_storeForReturn(ic, /*IC_LEFT(ic),*/ 3, picoBlaze_popCopyReg(&picoBlaze_pc_fsr0l));

//*//          if(size>2)
//*//            picoBlaze_storeForReturn(ic, /*IC_LEFT(ic),*/ 2, picoBlaze_popCopyReg(&picoBlaze_pc_prodh));

 //*//        if(size>1)
//*//            picoBlaze_storeForReturn(ic, /*IC_LEFT(ic),*/ 1, picoBlaze_popCopyReg(&picoBlaze_pc_prodl));

//*//          picoBlaze_storeForReturn(ic, /*IC_LEFT(ic),*/ 0, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));

        } else {
                /* >32-bits, setup stack and FSR0 */
                while (size--) {
//                      DEBUGpicoBlaze_emitcode("; ", "POC_MOVLW %d", GpsuedoStkPtr);
//                      DEBUGpicoBlaze_emitcode("; ", "POC_MOVFW PLUSW2");

                        picoBlaze_pushpCodeOp( picoBlaze_popGet( AOP( IC_LEFT(ic) ), size) );

//                      picoBlaze_popaopidx(AOP(oper), size, GpseudoStkPtr);
                        GpsuedoStkPtr++;
                }

                /* setup FSR0 */
//*//                picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(
//*//                        picoBlaze_popCopyReg( picoBlaze_stackpnt_lo ), picoBlaze_popCopyReg(&picoBlaze_pc_fsr0l)));

                if(STACK_MODEL_LARGE) {
 //*//                       picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(
//*//                                picoBlaze_popCopyReg( picoBlaze_stackpnt_hi ), picoBlaze_popCopyReg(&picoBlaze_pc_fsr0h)));
                } else {
//*//                        picoBlaze_emitpcode(POC_CLRF, picoBlaze_popCopyReg( picoBlaze_stackpnt_hi ));
                }
        }

        picoBlaze_freeAsmop (IC_LEFT(ic),NULL,ic,TRUE);

jumpret:
        /* generate a jump to the return label
         * if the next is not the return statement */
        if (!(ic->next && ic->next->op == LABEL
                && IC_LABEL(ic->next) == returnLabel)) {

                picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(returnLabel->key));
                picoBlaze_emitcode("goto","_%05d_DS_",returnLabel->key+100 + picoBlaze_labelOffset);
        }
}

/*-----------------------------------------------------------------*/
/* genLabel - generates a label                                    */
/*-----------------------------------------------------------------*/
static void genLabel (iCode *ic)
{
  FENTRY;

  /* special case never generate */
  if (IC_LABEL(ic) == entryLabel)
    return ;

  picoBlaze_emitpLabel(IC_LABEL(ic)->key);
//  picoBlaze_emitcode("","_%05d_DS_:",(IC_LABEL(ic)->key+100 + picoBlaze_labelOffset));
}

/*-----------------------------------------------------------------*/
/* genGoto - generates a goto                                      */
/*-----------------------------------------------------------------*/
//tsd
static void genGoto (iCode *ic)
{
  FENTRY;
  picoBlaze_emitpcode(POC_GOTO, picoBlaze_popGetLabel(IC_LABEL(ic)->key) );
//  picoBlaze_emitcode ("goto","_%05d_DS_",(IC_LABEL(ic)->key+100)+picoBlaze_labelOffset);
}


/*-----------------------------------------------------------------*/
/* genMultbits :- multiplication of bits                           */
/*-----------------------------------------------------------------*/
static void genMultbits (operand *left,
                         operand *right,
                         operand *result)
{
  FENTRY;

  if(!picoBlaze_sameRegs(AOP(result),AOP(right)))
    picoBlaze_emitpcode(POC_BSF,  picoBlaze_popGet(AOP(result),0));

  picoBlaze_emitpcode(POC_BTFSC,picoBlaze_popGet(AOP(right),0));
  picoBlaze_emitpcode(POC_BTFSS,picoBlaze_popGet(AOP(left),0));
  picoBlaze_emitpcode(POC_BCF,  picoBlaze_popGet(AOP(result),0));

}


/*-----------------------------------------------------------------*/
/* genMultOneByte : 8 bit multiplication & division                */
/*-----------------------------------------------------------------*/
static void genMultOneByte (operand *left,
                            operand *right,
                            operand *result)
{

  FENTRY;
  DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,right,result);
  DEBUGpicoBlaze_picoBlaze_AopTypeSign(__LINE__,left,right,result);

  /* (if two literals, the value is computed before) */
  /* if one literal, literal on the right */
  if (AOP_TYPE(left) == AOP_LIT){
    operand *t = right;
    right = left;
    left = t;
  }

        /* size is already checked in genMult == 1 */
//      size = AOP_SIZE(result);

        if (AOP_TYPE(right) == AOP_LIT){
                picoBlaze_emitpcomment("multiply lit val:%s by variable %s and store in %s",
                                        picoBlaze_aopGet(AOP(right),0,FALSE,FALSE),
                                        picoBlaze_aopGet(AOP(left),0,FALSE,FALSE),
                                        picoBlaze_aopGet(AOP(result),0,FALSE,FALSE));
        } else {
                picoBlaze_emitpcomment("multiply variable :%s by variable %s and store in %s",
                                        picoBlaze_aopGet(AOP(right),0,FALSE,FALSE),
                                        picoBlaze_aopGet(AOP(left),0,FALSE,FALSE),
                                        picoBlaze_aopGet(AOP(result),0,FALSE,FALSE));
        }

        picoBlaze_genMult8X8_n (left, right,result);
}


/*-----------------------------------------------------------------*/
/* genMult - generates code for multiplication                     */
/*-----------------------------------------------------------------*/
static void genMult (iCode *ic)
{
  operand *left = IC_LEFT(ic);
  operand *right = IC_RIGHT(ic);
  operand *result= IC_RESULT(ic);

    FENTRY;
        /* assign the amsops */
        picoBlaze_aopOp (left,ic,FALSE);
        picoBlaze_aopOp (right,ic,FALSE);
        picoBlaze_aopOp (result,ic,TRUE);

        DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,right,result);

        /* special cases first *
        * both are bits */
        if (AOP_TYPE(left) == AOP_CRY
                && AOP_TYPE(right)== AOP_CRY) {
                genMultbits(left,right,result);
          goto release ;
        }

        /* if both are of size == 1 */
        if(AOP_SIZE(left) == 1
                && AOP_SIZE(right) == 1) {
                genMultOneByte(left,right,result);
          goto release ;
        }

        fprintf( stderr, "%s: should have been transformed into function call\n",__FUNCTION__ );
        assert( !"Multiplication should have been transformed into function call!" );

        picoBlaze_emitcode("multiply ","sizes are greater than 4 ... need to insert proper algor.");


        fprintf(stderr, "operand sizes result: %d left: %d right: %d\n", AOP_SIZE(result), AOP_SIZE(left), AOP_SIZE(right));
        /* should have been converted to function call */
        assert(0) ;

release :
        picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
        picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
        picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genDiv - generates code for division                            */
/*-----------------------------------------------------------------*/
static void genDiv (iCode *ic)
{
    operand *left = IC_LEFT(ic);
    operand *right = IC_RIGHT(ic);
    operand *result= IC_RESULT(ic);
    int negated = 0;
    int leftVal = 0, rightVal = 0;
    int signedLits = 0;
    char *functions[2][2] = { { "__divschar", "__divuchar" }, { "__modschar", "__moduchar" } };
    int op = 0;

        /* Division is a very lengthy algorithm, so it is better
         * to call support routines than inlining algorithm.
         * Division functions written here just in case someone
         * wants to inline and not use the support libraries -- VR */

    FENTRY;

    /* assign the amsops */
    picoBlaze_aopOp (left,ic,FALSE);
    picoBlaze_aopOp (right,ic,FALSE);
    picoBlaze_aopOp (result,ic,TRUE);

    if (ic->op == '/')
      op = 0;
    else if (ic->op == '%')
      op = 1;
    else
      assert( !"invalid operation requested in genDivMod" );

    /* get literal values */
    if (IS_VALOP(left)) {
      leftVal = (int) ulFromVal ( OP_VALUE(left) );
      assert( leftVal >= -128 && leftVal < 256 );
      if (leftVal < 0) { signedLits++; }
    }
    if (IS_VALOP(right)) {
      rightVal = (int) ulFromVal ( OP_VALUE(right) );
      assert( rightVal >= -128 && rightVal < 256 );
      if (rightVal < 0) { signedLits++; }
    }

    /* We should only come here to convert all
     * / : {u8_t, s8_t} x {u8_t, s8_t} -> {u8_t, s8_t}
     * with exactly one operand being s8_t into
     * u8_t x u8_t -> u8_t. All other cases should have been
     * turned into calls to support routines beforehand... */
    if ((AOP_SIZE(left) == 1 || IS_VALOP(left))
        && (AOP_SIZE(right) == 1 || IS_VALOP(right)))
    {
      if ((!IS_UNSIGNED(operandType(right)) || rightVal < 0)
          && (!IS_UNSIGNED(operandType(left)) || leftVal < 0))
      {
        /* Both operands are signed or negative, use _divschar
         * instead of _divuchar */
        picoBlaze_pushaop(AOP(right), 0);
        picoBlaze_pushaop(AOP(left), 0);

        /* call _divschar */
        picoBlaze_emitpcode(POC_CALL, picoBlaze_popGetWithString(functions[op][0]));

        {
          symbol *sym;
          sym = newSymbol( functions[op][0], 0 );
          sym->used++;
          strcpy(sym->rname, functions[op][0]);
          picoBlaze_checkAddSym(&externs, sym);
        }

        /* assign result */
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), 0));
        if (AOP_SIZE(result) > 1)
        {
//*//          picoBlaze_emitpcode(POC_MOVFF,
//*//              picoBlaze_popGet2p(picoBlaze_popCopyReg(&picoBlaze_pc_prodl),
//*//                picoBlaze_popGet(AOP(result), 1)));
          /* sign extend */
          picoBlaze_addSign(result, 2, 1);
        }

        /* clean up stack */
//*//        picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(picoBlaze_stack_preinc));
//*//        picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(picoBlaze_stack_preinc));

        goto release;
      }

      /* push right operand */
      if (IS_VALOP(right)) {
        if (rightVal < 0) {
          picoBlaze_pushpCodeOp( picoBlaze_popGetLit(-rightVal) );
          negated++;
        } else {
          picoBlaze_pushaop(AOP(right), 0);
        }
      } else if (!IS_UNSIGNED(operandType(right))) {
        picoBlaze_mov2w(AOP(right), 0);
        picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(right), 0, 7));
//*//        picoBlaze_emitpcode(POC_NEGF, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(picoBlaze_stack_postdec));
        negated++;
      } else {
        picoBlaze_pushaop(AOP(right), 0);
      }

      /* push left operand */
      if (IS_VALOP(left)) {
        if (leftVal < 0) {
          picoBlaze_pushpCodeOp(picoBlaze_popGetLit(-leftVal));
          negated++;
        } else {
          picoBlaze_pushaop(AOP(left), 0);
        }
      } else if (!IS_UNSIGNED(operandType(left))) {
        picoBlaze_mov2w(AOP(left),0);
        picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(left), 0, 7));
//*//        picoBlaze_emitpcode(POC_NEGF, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(picoBlaze_stack_postdec));
        negated++;
      } else {
        picoBlaze_pushaop(AOP(left), 0);
      }

      /* call _divuchar */
      picoBlaze_emitpcode(POC_CALL, picoBlaze_popGetWithString(functions[op][1]));

      {
        symbol *sym;
        sym = newSymbol( functions[op][1], 0 );
        sym->used++;
        strcpy(sym->rname, functions[op][1]);
        picoBlaze_checkAddSym(&externs, sym);
      }

      /* Revert negation(s) from above.
       * This is inefficient: if both operands are negative, this
       * should not touch WREG. However, determining that exactly
       * one operand was negated costs at least 3 instructions,
       * so there is nothing to be gained here, is there?
       *
       * I negate WREG because either operand might share registers with
       * result, so assigning first might destroy an operand. */

      /* For the modulus operator, (a/b)*b == a shall hold.
       * Thus: a>0, b>0 --> a/b >= 0 and a%b >= 0
       *       a>0, b<0 --> a/b <= 0 and a%b >= 0 (e.g. 128 / -5 = -25, -25*(-5) =  125 and +3 remaining)
       *       a<0, b>0 --> a/b <= 0 and a%b < 0  (e.g. -128 / 5 = -25, -25*  5  = -125 and -3 remaining)
       *       a<0, b<0 --> a/b >= 0 and a%b < 0  (e.g. -128 / -5 = 25,  25*(-5) = -125 and -3 remaining)
       * Only invert the result if the left operand is negative (sigh).
       */
      if (AOP_SIZE(result) <= 1 || !negated)
      {
        if (ic->op == '/')
        {
          if (IS_VALOP(right)) {
            if (rightVal < 0) {
              /* we negated this operand above */
//*//              picoBlaze_emitpcode(POC_NEGF, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
            }
          } else if (!IS_UNSIGNED(operandType(right))) {
            picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(right), 0, 7));
//*//            picoBlaze_emitpcode(POC_NEGF, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
          }
        }

        if (IS_VALOP(left)) {
          if (leftVal < 0) {
            /* we negated this operand above */
//*//            picoBlaze_emitpcode(POC_NEGF, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
          }
        } else if (!IS_UNSIGNED(operandType(left))) {
          picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(left), 0, 7));
//*//          picoBlaze_emitpcode(POC_NEGF, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
        }

        /* Move result to destination. */
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), 0));

        /* Zero-extend:  no operand was signed (or result is just a byte). */
        picoBlaze_addSign(result, 1, 0);
      } else {
        assert( AOP_SIZE(result) > 1 );
        picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result), 1));
        if (ic->op == '/')
        {
          if (IS_VALOP(right)) {
            if (rightVal < 0) {
              /* we negated this operand above */
              picoBlaze_emitpcode(POC_COMF, picoBlaze_popGet(AOP(result), 1));
            }
          } else if (!IS_UNSIGNED(operandType(right))) {
            picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(right), 0, 7));
            picoBlaze_emitpcode(POC_COMF, picoBlaze_popGet(AOP(result), 1));
          }
        }

        if (IS_VALOP(left)) {
          if (leftVal < 0) {
            /* we negated this operand above */
            picoBlaze_emitpcode(POC_COMF, picoBlaze_popGet(AOP(result), 1));
          }
        } else if (!IS_UNSIGNED(operandType(left))) {
          picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(left), 0, 7));
          picoBlaze_emitpcode(POC_COMF, picoBlaze_popGet(AOP(result), 1));
        }

        /* Move result to destination. */
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), 0));

        /* Negate result if required. */
        picoBlaze_emitpcode(POC_BTFSC, picoBlaze_newpCodeOpBit_simple(AOP(result), 1, 7));
        picoBlaze_emitpcode(POC_NEGF, picoBlaze_popGet(AOP(result), 0));

        /* Sign-extend. */
        picoBlaze_addSign(result, 2, 1);
      }

      /* clean up stack */
//*//      picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(picoBlaze_stack_preinc));
//*//      picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(picoBlaze_stack_preinc));
      goto release;
    }

    /* should have been converted to function call */
    assert(0);
release :
    picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genMod - generates code for division                            */
/*-----------------------------------------------------------------*/
static void genMod (iCode *ic)
{
  /* Task deferred to genDiv */
  genDiv(ic);
}

/*-----------------------------------------------------------------*/
/* genIfxJump :- will create a jump depending on the ifx           */
/*-----------------------------------------------------------------*/
/*
  note: May need to add parameter to indicate when a variable is in bit space.
*/
static void genIfxJump (iCode *ic, char *jval)
{
  FENTRY;

    /* if true label then we jump if condition
    supplied is true */
    if ( IC_TRUE(ic) ) {

 //*//       if(strcmp(jval,"a") == 0)
 //*//         emitSKPZ;
 //*//       else if (strcmp(jval,"c") == 0)
 //*//        emitSKPNC;
//*//        else {
          DEBUGpicoBlaze_emitcode ("; ***","%d - assuming %s is in bit space",__LINE__,jval);
          picoBlaze_emitpcode(POC_BTFSC,  picoBlaze_newpCodeOpBit(jval,-1,1, PO_GPR_REGISTER));
 //*//       }

        picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(IC_TRUE(ic)->key));
        picoBlaze_emitcode(" goto","_%05d_DS_",IC_TRUE(ic)->key+100 + picoBlaze_labelOffset);

    }
    else {
        /* false label is present */
        if(strcmp(jval,"a") == 0)
//*//          emitSKPNZ;
;
        else if (strcmp(jval,"c") == 0)
 //*//         emitSKPC;
 ;
        else {
          DEBUGpicoBlaze_emitcode ("; ***","%d - assuming %s is in bit space",__LINE__,jval);
          picoBlaze_emitpcode(POC_BTFSS,  picoBlaze_newpCodeOpBit(jval,-1,1, PO_GPR_REGISTER));
        }

        picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(IC_FALSE(ic)->key));
        picoBlaze_emitcode(" goto","_%05d_DS_",IC_FALSE(ic)->key+100 + picoBlaze_labelOffset);

    }


    /* mark the icode as generated */
    ic->generated = 1;
}

static void genIfxpCOpJump (iCode *ic, pCodeOp *jop)
{
  FENTRY;

    /* if true label then we jump if condition
    supplied is true */
    if ( IC_TRUE(ic) ) {
      DEBUGpicoBlaze_emitcode ("; ***","%d - assuming is in bit space",__LINE__);
      picoBlaze_emitpcode(POC_BTFSC, jop);

      picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(IC_TRUE(ic)->key));
      picoBlaze_emitcode(" goto","_%05d_DS_",IC_TRUE(ic)->key+100 + picoBlaze_labelOffset);

    } else {
      /* false label is present */
      DEBUGpicoBlaze_emitcode ("; ***","%d - assuming is in bit space",__LINE__);
      picoBlaze_emitpcode(POC_BTFSS, jop);

      picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(IC_FALSE(ic)->key));
      picoBlaze_emitcode(" goto","_%05d_DS_",IC_FALSE(ic)->key+100 + picoBlaze_labelOffset);
    }


    /* mark the icode as generated */
    ic->generated = 1;
}


/*-----------------------------------------------------------------*/
/* genSkipc                                                        */
/*-----------------------------------------------------------------*/
static void genSkipc(resolvedIfx *rifx)
{
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d rifx= %p",__FUNCTION__,__LINE__, rifx);

  if(!rifx)
    return;

//*//  if(rifx->condition)
//*//    emitSKPNC;
//*//  else
//*//    emitSKPC;

  picoBlaze_emitpcode(POC_GOTO, picoBlaze_popGetLabel(rifx->lbl->key));
  rifx->generated = 1;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_mov2w_regOrLit :- move to WREG either the offset's byte from    */
/*                  aop (if it's NOT a literal) or from lit (if    */
/*                  aop is a literal)                              */
/*-----------------------------------------------------------------*/
void picoBlaze_mov2w_regOrLit (asmop *aop, unsigned long lit, int offset) {
  if (aop->type == AOP_LIT) {
    picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit(lit >> (offset*8)));
  } else {
    picoBlaze_emitpcode (POC_MOVFW, picoBlaze_popGet (aop, offset));
  }
}

/*-----------------------------------------------------------------*/
/* genCmp :- greater or less than comparison                       */
/*-----------------------------------------------------------------*/

/* genCmp performs a left < right comparison, stores
 * the outcome in result (if != NULL) and generates
 * control flow code for the ifx (if != NULL).
 *
 * This version leaves in sequences like
 * "B[CS]F STATUS,0; BTFS[CS] STATUS,0"
 * which should be optmized by the peephole
 * optimizer - RN 2005-01-01 */
static void genCmp (operand *left,operand *right,
                    operand *result, iCode *ifx, int sign)
{
  resolvedIfx rIfx;
  int size;
  int offs;
  symbol *templbl;
  operand *dummy;
  unsigned long lit;
  unsigned long mask;
  int performedLt;

  FENTRY;

  assert (left && right);
  assert (AOP_SIZE(left) == AOP_SIZE(right));

  size = AOP_SIZE(right) - 1;
  mask = (0x100UL << (size*8)) - 1;
  // in the end CARRY holds "left < right" (performedLt == 1) or "left >= right" (performedLt == 0)
  performedLt = 1;
  templbl = NULL;
  lit = 0;

  resolveIfx (&rIfx, ifx);

  /* handle for special cases */
  if(picoBlaze_genCmp_special(left, right, result, ifx, &rIfx, sign))
      return;


  /*************************************************
   * make sure that left is register (or the like) *
   *************************************************/
  if (!isAOP_REGlike(left)) {
    DEBUGpc ("swapping arguments (AOP_TYPEs %d/%d)", AOP_TYPE(left), AOP_TYPE(right));
    assert (isAOP_LIT(left));
    assert (isAOP_REGlike(right));
    // swap left and right
    // left < right <==> right > left <==> (right >= left + 1)
    lit = ulFromVal (AOP(left)->aopu.aop_lit);

    if ( (!sign && (lit & mask) == mask) || (sign && (lit & mask) == (mask >> 1)) ) {
      // MAXVALUE < right? always false
//*//      if (performedLt) emitCLRC; else emitSETC;
      goto correct_result_in_carry;
    } // if

    // This fails for lit = 0xFF (unsigned) AND lit = 0x7F (signed),
    // that's why we handled it above.
    lit++;

    dummy = left;
    left = right;
    right = dummy;

    performedLt ^= 1; // instead of "left < right" we check for "right >= left+1, i.e. "right < left+1"
  } else if (isAOP_LIT(right)) {
    lit = ulFromVal (AOP(right)->aopu.aop_lit);
  } // if

  assert (isAOP_REGlike(left)); // left must be register or the like
  assert (isAOP_REGlike(right) || isAOP_LIT(right)); // right may be register-like or a literal

  /*************************************************
   * special cases go here                         *
   *************************************************/

  if (isAOP_LIT(right)) {
    if (!sign) {
      // unsigned comparison to a literal
      DEBUGpc ("unsigned compare: left %s lit(0x%X=%lu), size=%d", performedLt ? "<" : ">=", lit, lit, size+1);
      if (lit == 0) {
        // unsigned left < 0? always false
//*//        if (performedLt) emitCLRC; else emitSETC;
        goto correct_result_in_carry;
      }
    } else {
      // signed comparison to a literal
      DEBUGpc ("signed compare: left %s lit(0x%X=%ld), size=%d, mask=%x", performedLt ? "<" : ">=", lit, lit, size+1, mask);
      if ((lit & mask) == ((0x80 << (size*8)) & mask)) {
        // signed left < 0x80000000? always false
//*//        if (performedLt) emitCLRC; else emitSETC;
        goto correct_result_in_carry;
      } else if (lit == 0) {
        // compare left < 0; set CARRY if SIGNBIT(left) is set
//*//        if (performedLt) emitSETC; else emitCLRC;
        picoBlaze_emitpcode (POC_BTFSS, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet (AOP(left), size), 7));
//*//        if (performedLt) emitCLRC; else emitSETC;
        goto correct_result_in_carry;
      }
    } // if (!sign)
  } // right is literal

  /*************************************************
   * perform a general case comparison             *
   * make sure we get CARRY==1 <==> left >= right  *
   *************************************************/
  // compare most significant bytes
  //DEBUGpc ("comparing bytes at offset %d", size);
  if (!sign) {
    // unsigned comparison
    picoBlaze_mov2w_regOrLit (AOP(right), lit, size);
    picoBlaze_emitpcode (POC_SUBFW, picoBlaze_popGet (AOP(left), size));
  } else {
    // signed comparison
    // (add 2^n to both operands then perform an unsigned comparison)
    if (isAOP_LIT(right)) {
      // left >= LIT <-> LIT-left <= 0 <-> LIT-left == 0 OR !(LIT-left >= 0)
      unsigned char litbyte = (lit >> (8*size)) & 0xFF;

      if (litbyte == 0x80) {
        // left >= 0x80 -- always true, but more bytes to come
        picoBlaze_mov2w (AOP(left), size);
        picoBlaze_emitpcode (POC_XORLW, picoBlaze_popGetLit (0x80)); // set ZERO flag
//*//        emitSETC;
      } else {
        // left >= LIT <-> left + (-LIT) >= 0 <-> left + (0x100-LIT) >= 0x100
        picoBlaze_mov2w (AOP(left), size);
        picoBlaze_emitpcode (POC_ADDLW, picoBlaze_popGetLit (0x80));
        picoBlaze_emitpcode (POC_ADDLW, picoBlaze_popGetLit ((0x100 - (litbyte + 0x80)) & 0x00FF));
      } // if
    } else {
      /* using PRODL as a temporary register here */
//*//      pCodeOp *pctemp = picoBlaze_popCopyReg(&picoBlaze_pc_prodl);
      //pCodeOp *pctemp = picoBlaze_popGetTempReg(1);
      picoBlaze_mov2w (AOP(left), size);
      picoBlaze_emitpcode (POC_ADDLW, picoBlaze_popGetLit (0x80));
//*//      picoBlaze_emitpcode (POC_MOVWF, pctemp);
      picoBlaze_mov2w (AOP(right), size);
      picoBlaze_emitpcode (POC_ADDLW, picoBlaze_popGetLit (0x80));
//*//      picoBlaze_emitpcode (POC_SUBFW, pctemp);
      //picoBlaze_popReleaseTempReg(pctemp, 1);
    }
  } // if (!sign)

  // compare remaining bytes (treat as unsigned case from above)
  templbl = newiTempLabel ( NULL );
  offs = size;
  while (offs--) {
    //DEBUGpc ("comparing bytes at offset %d", offs);
    picoBlaze_emitpcode (POC_BNZ, picoBlaze_popGetLabel (templbl->key));
    picoBlaze_mov2w_regOrLit (AOP(right), lit, offs);
    picoBlaze_emitpcode (POC_SUBFW, picoBlaze_popGet (AOP(left), offs));
  } // while (offs)
  picoBlaze_emitpLabel (templbl->key);
  goto result_in_carry;

result_in_carry:

  /****************************************************
   * now CARRY contains the result of the comparison: *
   * SUBWF sets CARRY iff                             *
   * F-W >= 0 <==> F >= W <==> !(F < W)               *
   * (F=left, W=right)                                *
   ****************************************************/

  if (performedLt) {
    if (result && AOP_TYPE(result) != AOP_CRY) {
      // value will be stored
//*//      emitTOGC;
    } else {
      // value wil only be used in the following genSkipc()
      rIfx.condition ^= 1;
    }
  } // if

correct_result_in_carry:

  // assign result to variable (if neccessary)
  if (result && AOP_TYPE(result) != AOP_CRY) {
    //DEBUGpc ("assign result");
    size = AOP_SIZE(result);
    while (size--) {
      picoBlaze_emitpcode (POC_CLRF, picoBlaze_popGet (AOP(result), size));
    } // while
    picoBlaze_emitpcode (POC_RLCF, picoBlaze_popGet (AOP(result), 0));
  } // if (result)

  // perform conditional jump
  if (ifx) {
    //DEBUGpc ("generate control flow");
    genSkipc (&rIfx);
    ifx->generated = 1;
  } // if
}

/*-----------------------------------------------------------------*/
/* genCmpGt :- greater than comparison                             */
/*-----------------------------------------------------------------*/
static void genCmpGt (iCode *ic, iCode *ifx)
{
  operand *left, *right, *result;
  sym_link *letype , *retype;
  int sign ;

    FENTRY;

    left = IC_LEFT(ic);
    right= IC_RIGHT(ic);
    result = IC_RESULT(ic);

    letype = getSpec(operandType(left));
    retype =getSpec(operandType(right));
    sign =  !(SPEC_USIGN(letype) | SPEC_USIGN(retype));
    /* assign the amsops */
    picoBlaze_aopOp (left,ic,FALSE);
    picoBlaze_aopOp (right,ic,FALSE);
    picoBlaze_aopOp (result,ic,TRUE);

    genCmp(right, left, result, ifx, sign);

    picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genCmpLt - less than comparisons                                */
/*-----------------------------------------------------------------*/
static void genCmpLt (iCode *ic, iCode *ifx)
{
  operand *left, *right, *result;
  sym_link *letype , *retype;
  int sign ;

    FENTRY;

    left = IC_LEFT(ic);
    right= IC_RIGHT(ic);
    result = IC_RESULT(ic);

    letype = getSpec(operandType(left));
    retype =getSpec(operandType(right));
    sign =  !(SPEC_USIGN(letype) | SPEC_USIGN(retype));

    /* assign the amsops */
    picoBlaze_aopOp (left,ic,FALSE);
    picoBlaze_aopOp (right,ic,FALSE);
    picoBlaze_aopOp (result,ic,TRUE);

    genCmp(left, right, result, ifx, sign);

    picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* picoBlaze_isLitOp - check if operand has to be treated as literal   */
/*-----------------------------------------------------------------*/
bool picoBlaze_isLitOp(operand *op)
{
  return ((AOP_TYPE(op) == AOP_LIT)
      || ( (AOP_TYPE(op) == AOP_PCODE)
          && ( (AOP(op)->aopu.pcop->type == PO_LITERAL)
              || (0) )));
}

/*-----------------------------------------------------------------*/
/* picoBlaze_isLitAop - check if operand has to be treated as literal  */
/*-----------------------------------------------------------------*/
bool picoBlaze_isLitAop(asmop *aop)
{
  return ((aop->type == AOP_LIT)
      || ( (aop->type == AOP_PCODE)
          && ( (aop->aopu.pcop->type == PO_LITERAL)
              || (0) )));
}



/*-----------------------------------------------------------------*/
/* genCmpEq - generates code for equal to                          */
/*-----------------------------------------------------------------*/
static void genCmpEq (iCode *ic, iCode *ifx)
{
  operand *left, *right, *result;
  symbol *falselbl = newiTempLabel(NULL);
  symbol *donelbl = newiTempLabel(NULL);

  int preserve_result = 0;
  int generate_result = 0;
  int i=0;
  unsigned long lit = -1;

  FENTRY;

  picoBlaze_aopOp((left=IC_LEFT(ic)),ic,FALSE);
  picoBlaze_aopOp((right=IC_RIGHT(ic)),ic,FALSE);
  picoBlaze_aopOp((result=IC_RESULT(ic)),ic,TRUE);

  DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,right,result);

  if( (AOP_TYPE(right) == AOP_CRY) || (AOP_TYPE(left) == AOP_CRY) )
    {
      werror(W_POSSBUG2, __FILE__, __LINE__);
      DEBUGpicoBlaze_emitcode ("; ***","%s  %d -- ERROR",__FUNCTION__,__LINE__);
      fprintf(stderr, "%s  %d error - left/right CRY operands not supported\n",__FUNCTION__,__LINE__);
      goto release;
    }

  if (picoBlaze_isLitOp(left) || (AOP_TYPE(right) == AOP_ACC))
    {
      operand *tmp = right ;
      right = left;
      left = tmp;
    }

  if (AOP_TYPE(right) == AOP_LIT) {
    lit = ulFromVal (AOP(right)->aopu.aop_lit);
  }

  if ( regsInCommon(left, result) || regsInCommon(right, result) )
    preserve_result = 1;

  if(result && AOP_SIZE(result))
    generate_result = 1;

  if(generate_result && !preserve_result)
    {
      for(i = 0; i < AOP_SIZE(result); i++)
        picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),i));
    }

  assert( AOP_SIZE(left) == AOP_SIZE(right) );
  for(i=0; i < AOP_SIZE(left); i++)
    {
      if(AOP_TYPE(left) != AOP_ACC)
        {
          if(picoBlaze_isLitOp(left))
            picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(left), i));
          else
            picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(left), i));
        }
      if(picoBlaze_isLitOp(right)) {
        if (picoBlaze_isLitOp(left) || (0 != ((lit >> (8*i))&0x00FF))) {
          picoBlaze_emitpcode(POC_XORLW, picoBlaze_popGet(AOP(right), i));
        }
      } else
        picoBlaze_emitpcode(POC_XORFW, picoBlaze_popGet(AOP(right), i));

      picoBlaze_emitpcode(POC_BNZ,picoBlaze_popGetLabel(falselbl->key));
    }

  // result == true

  if(generate_result && preserve_result)
    {
      for(i = 0; i < AOP_SIZE(result); i++)
        picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),i));
    }

  if(generate_result)
    picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result), 0)); // result = true

  if(generate_result && preserve_result)
    picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(donelbl->key));

  if(ifx && IC_TRUE(ifx))
    picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(IC_TRUE(ifx)->key));

  if(ifx && IC_FALSE(ifx))
    picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(donelbl->key));

  picoBlaze_emitpLabel(falselbl->key);

  // result == false

  if(ifx && IC_FALSE(ifx))
    picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(IC_FALSE(ifx)->key));

  if(generate_result && preserve_result)
    {
      for(i = 0; i < AOP_SIZE(result); i++)
        picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),i));
    }

  picoBlaze_emitpLabel(donelbl->key);

  if(ifx)
    ifx->generated = 1;

release:
  picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(result,NULL,ic,TRUE);

}


/*-----------------------------------------------------------------*/
/* ifxForOp - returns the icode containing the ifx for operand     */
/*-----------------------------------------------------------------*/
static iCode *ifxForOp ( operand *op, iCode *ic )
{
  FENTRY2;

    /* if true symbol then needs to be assigned */
    if (IS_TRUE_SYMOP(op))
        return NULL ;

    /* if this has register type condition and
    the next instruction is ifx with the same operand
    and live to of the operand is upto the ifx only then */
    if (ic->next
        && ic->next->op == IFX
        && IC_COND(ic->next)->key == op->key
        && OP_SYMBOL(op)->liveTo <= ic->next->seq
        ) {
                DEBUGpicoBlaze_emitcode(";", "%d %s", __LINE__, __FUNCTION__);
          return ic->next;
    }

    /*
    if (ic->next &&
        ic->next->op == IFX &&
        IC_COND(ic->next)->key == op->key) {
      DEBUGpicoBlaze_emitcode ("; WARNING ","%d IGNORING liveTo range in %s",__LINE__,__FUNCTION__);
      return ic->next;
    }
    */

    DEBUGpicoBlaze_emitcode ("; NULL :(","%d",__LINE__);
    if (ic->next &&
        ic->next->op == IFX)
      DEBUGpicoBlaze_emitcode ("; ic-next"," is an IFX");

    if (ic->next &&
        ic->next->op == IFX &&
        IC_COND(ic->next)->key == op->key) {
      DEBUGpicoBlaze_emitcode ("; "," key is okay");
      DEBUGpicoBlaze_emitcode ("; "," key liveTo %d, next->seq = %d",
                           OP_SYMBOL(op)->liveTo,
                           ic->next->seq);
    }


    return NULL;
}
/*-----------------------------------------------------------------*/
/* genAndOp - for && operation                                     */
/*-----------------------------------------------------------------*/
static void genAndOp (iCode *ic)
{
  operand *left,*right, *result;
/*     symbol *tlbl; */

    FENTRY;

    /* note here that && operations that are in an
    if statement are taken away by backPatchLabels
    only those used in arthmetic operations remain */
    picoBlaze_aopOp((left=IC_LEFT(ic)),ic,FALSE);
    picoBlaze_aopOp((right=IC_RIGHT(ic)),ic,FALSE);
    picoBlaze_aopOp((result=IC_RESULT(ic)),ic,TRUE);

    DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,right,result);

    picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(left),0));
    picoBlaze_emitpcode(POC_ANDFW,picoBlaze_popGet(AOP(right),0));
    picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),0));

    /* if both are bit variables */
/*     if (AOP_TYPE(left) == AOP_CRY && */
/*         AOP_TYPE(right) == AOP_CRY ) { */
/*         picoBlaze_emitcode("mov","c,%s",AOP(left)->aopu.aop_dir); */
/*         picoBlaze_emitcode("anl","c,%s",AOP(right)->aopu.aop_dir); */
/*         picoBlaze_outBitC(result); */
/*     } else { */
/*         tlbl = newiTempLabel(NULL); */
/*         picoBlaze_toBoolean(left);     */
/*         picoBlaze_emitcode("jz","%05d_DS_",tlbl->key+100); */
/*         picoBlaze_toBoolean(right); */
/*         picoBlaze_emitcode("","%05d_DS_:",tlbl->key+100); */
/*         picoBlaze_outBitAcc(result); */
/*     } */

    picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}


/*-----------------------------------------------------------------*/
/* genOrOp - for || operation                                      */
/*-----------------------------------------------------------------*/
/*
  tsd pic port -
  modified this code, but it doesn't appear to ever get called
*/

static void genOrOp (iCode *ic)
{
  operand *left,*right, *result;
  symbol *tlbl;

    FENTRY;

  /* note here that || operations that are in an
    if statement are taken away by backPatchLabels
    only those used in arthmetic operations remain */
    picoBlaze_aopOp((left=IC_LEFT(ic)),ic,FALSE);
    picoBlaze_aopOp((right=IC_RIGHT(ic)),ic,FALSE);
    picoBlaze_aopOp((result=IC_RESULT(ic)),ic,TRUE);

    DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,right,result);

    /* if both are bit variables */
    if (AOP_TYPE(left) == AOP_CRY &&
        AOP_TYPE(right) == AOP_CRY ) {
      picoBlaze_emitcode("clrc","");
      picoBlaze_emitcode("btfss","(%s >> 3), (%s & 7)",
               AOP(left)->aopu.aop_dir,
               AOP(left)->aopu.aop_dir);
      picoBlaze_emitcode("btfsc","(%s >> 3), (%s & 7)",
               AOP(right)->aopu.aop_dir,
               AOP(right)->aopu.aop_dir);
      picoBlaze_emitcode("setc","");

    } else {
        tlbl = newiTempLabel(NULL);
        picoBlaze_toBoolean(left);
//*//        emitSKPZ;
        picoBlaze_emitcode("goto","%05d_DS_",tlbl->key+100+picoBlaze_labelOffset);
        picoBlaze_toBoolean(right);
        picoBlaze_emitcode("","%05d_DS_:",tlbl->key+100+picoBlaze_labelOffset);

        picoBlaze_outBitAcc(result);
    }

    picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* isLiteralBit - test if lit == 2^n                               */
/*-----------------------------------------------------------------*/
static int isLiteralBit(unsigned long lit)
{
    unsigned long pw[32] = {1L,2L,4L,8L,16L,32L,64L,128L,
    0x100L,0x200L,0x400L,0x800L,
    0x1000L,0x2000L,0x4000L,0x8000L,
    0x10000L,0x20000L,0x40000L,0x80000L,
    0x100000L,0x200000L,0x400000L,0x800000L,
    0x1000000L,0x2000000L,0x4000000L,0x8000000L,
    0x10000000L,0x20000000L,0x40000000L,0x80000000L};
    int idx;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    for(idx = 0; idx < 32; idx++)
        if(lit == pw[idx])
            return idx+1;
    return 0;
}

/*-----------------------------------------------------------------*/
/* continueIfTrue -                                                */
/*-----------------------------------------------------------------*/
static void continueIfTrue (iCode *ic)
{
  FENTRY;
  if(IC_TRUE(ic))
    picoBlaze_emitcode("ljmp","%05d_DS_",IC_TRUE(ic)->key+100);
  ic->generated = 1;
}

/*-----------------------------------------------------------------*/
/* jmpIfTrue -                                                     */
/*-----------------------------------------------------------------*/
static void jumpIfTrue (iCode *ic)
{
  FENTRY;
  if(!IC_TRUE(ic))
    picoBlaze_emitcode("ljmp","%05d_DS_",IC_FALSE(ic)->key+100);
  ic->generated = 1;
}

/*-----------------------------------------------------------------*/
/* jmpTrueOrFalse -                                                */
/*-----------------------------------------------------------------*/
static void jmpTrueOrFalse (iCode *ic, symbol *tlbl)
{
  // ugly but optimized by peephole
  FENTRY;
  if(IC_TRUE(ic)){
    symbol *nlbl = newiTempLabel(NULL);
      picoBlaze_emitcode("sjmp","%05d_DS_",nlbl->key+100);
      picoBlaze_emitcode("","%05d_DS_:",tlbl->key+100);
      picoBlaze_emitcode("ljmp","%05d_DS_",IC_TRUE(ic)->key+100);
      picoBlaze_emitcode("","%05d_DS_:",nlbl->key+100);
  } else {
    picoBlaze_emitcode("ljmp","%05d_DS_",IC_FALSE(ic)->key+100);
    picoBlaze_emitcode("","%05d_DS_:",tlbl->key+100);
  }
  ic->generated = 1;
}

/*-----------------------------------------------------------------*/
/* genAnd  - code for and                                          */
/*-----------------------------------------------------------------*/
static void genAnd (iCode *ic, iCode *ifx)
{
  operand *left, *right, *result;
  int size, offset = 0;
  unsigned long lit = 0L;
  resolvedIfx rIfx;

  FENTRY;

  picoBlaze_aopOp ((left = IC_LEFT (ic)), ic, FALSE);
  picoBlaze_aopOp ((right = IC_RIGHT (ic)), ic, FALSE);
  picoBlaze_aopOp ((result = IC_RESULT (ic)), ic, TRUE);

  resolveIfx (&rIfx, ifx);

  /* if left is a literal & right is not then exchange them */
  if ((AOP_TYPE (left) == AOP_LIT && AOP_TYPE (right) != AOP_LIT) ||
      AOP_NEEDSACC (left))
    {
      operand *tmp = right;
      right = left;
      left = tmp;
    }

  /* if result = right then exchange them */
  if (picoBlaze_sameRegs (AOP (result), AOP (right)))
    {
      operand *tmp = right;
      right = left;
      left = tmp;
    }

  /* if right is bit then exchange them */
  if (AOP_TYPE (right) == AOP_CRY &&
      AOP_TYPE (left) != AOP_CRY)
    {
      operand *tmp = right;
      right = left;
      left = tmp;
    }

  if (AOP_TYPE (right) == AOP_LIT)
    lit = ulFromVal (AOP (right)->aopu.aop_lit);

  size = AOP_SIZE (result);

  DEBUGpicoBlaze_picoBlaze_AopType (__LINE__, left, right, result);

  // if(bit & yy)
  // result = bit & yy;
  if (AOP_TYPE(left) == AOP_CRY){
    // c = bit & literal;
    if(AOP_TYPE(right) == AOP_LIT){
      if(lit & 1) {
        if(size && picoBlaze_sameRegs(AOP(result),AOP(left)))
          // no change
          goto release;
        picoBlaze_emitcode("mov","c,%s",AOP(left)->aopu.aop_dir);
      } else {
        // bit(result) = 0;
        if(size && (AOP_TYPE(result) == AOP_CRY)){
          picoBlaze_emitcode("clr","%s",AOP(result)->aopu.aop_dir);
          goto release;
        }
        if((AOP_TYPE(result) == AOP_CRY) && ifx){
          jumpIfTrue(ifx);
          goto release;
        }
        picoBlaze_emitcode("clr","c");
      }
    } else {
      if (AOP_TYPE(right) == AOP_CRY){
        // c = bit & bit;
        picoBlaze_emitcode("mov","c,%s",AOP(right)->aopu.aop_dir);
        picoBlaze_emitcode("anl","c,%s",AOP(left)->aopu.aop_dir);
      } else {
        // c = bit & val;
        MOVA(picoBlaze_aopGet(AOP(right),0,FALSE,FALSE));
        // c = lsb
        picoBlaze_emitcode("rrc","a");
        picoBlaze_emitcode("anl","c,%s",AOP(left)->aopu.aop_dir);
      }
    }
    // bit = c
    // val = c
    if(size)
      picoBlaze_outBitC(result);
    // if(bit & ...)
    else if((AOP_TYPE(result) == AOP_CRY) && ifx)
      genIfxJump(ifx, "c");
    goto release ;
  }

  // if (val & 0xZZ)      - size = 0, ifx != FALSE -
  // bit = val & 0xZZ     - size = 1, ifx = FALSE -
  if ((AOP_TYPE (right) == AOP_LIT) &&
     (AOP_TYPE (result) == AOP_CRY) &&
     (AOP_TYPE (left) != AOP_CRY))
    {
      symbol *tlbl = newiTempLabel (NULL);
      int sizel = AOP_SIZE (left);
      int nonnull = 0;
      char emitBra;

      if (size)
//*//        emitSETC;

      /* get number of non null bytes in literal */
      while (sizel--)
        {
          if (lit & (0xff << (sizel * 8)))
            ++nonnull;
        }

      emitBra = nonnull || rIfx.condition;

      for (sizel = AOP_SIZE (left); sizel--; ++offset, lit >>= 8)
        {
          unsigned char bytelit = lit;

          if (bytelit != 0)
            {
              int posbit;

              --nonnull;

              /* patch provided by Aaron Colwell */
              if ((posbit = isLiteralBit (bytelit)) != 0)
                {
                  if (nonnull)
                    {
                      picoBlaze_emitpcode (POC_BTFSC, picoBlaze_newpCodeOpBit(picoBlaze_aopGet (AOP (left), offset, FALSE, FALSE), posbit - 1, 0, PO_GPR_REGISTER));
                      picoBlaze_emitpcode (POC_GOTO, picoBlaze_popGetLabel (rIfx.condition ? rIfx.lbl->key : tlbl->key));
                    }
                  else
                    {
                      picoBlaze_emitpcode (rIfx.condition ? POC_BTFSC :POC_BTFSS, picoBlaze_newpCodeOpBit(picoBlaze_aopGet (AOP (left), offset, FALSE, FALSE), posbit - 1, 0, PO_GPR_REGISTER));
                    }
                }
              else
                {
                  if (bytelit == 0xff)
                    {
                      /* Aaron had a MOVF instruction here, changed to MOVFW cause
                       * a peephole could optimize it out -- VR */
                      picoBlaze_emitpcode (POC_MOVFW, picoBlaze_popGet (AOP (left), offset));
                    }
                  else
                    {
                      picoBlaze_emitpcode (POC_MOVFW, picoBlaze_popGet (AOP (left), offset));
                      picoBlaze_emitpcode (POC_ANDLW, picoBlaze_popGetLit (bytelit));
                    }
                  if (nonnull)
                    {
                      if (rIfx.condition)
                        {
//*//                          emitSKPZ;
                          picoBlaze_emitpcode (POC_GOTO, picoBlaze_popGetLabel (rIfx.lbl->key)); /* to false */
                        }
                      else
                        {
                          picoBlaze_emitpcode (POC_BNZ, picoBlaze_popGetLabel (tlbl->key)); /* to true */
                        }
                    }
                  else
                    {
                      /* last non null byte */
//*//                      if (rIfx.condition)
//*//                        emitSKPZ;
//*//                      else
//*//                        emitSKPNZ;
                    }
                }
            }
        }

      // bit = left & literal
      if (size)
        {
//*//          emitCLRC;
          picoBlaze_emitpLabel (tlbl->key);
        }

      // if(left & literal)
      else
        {
          if (ifx)
            {
              if (emitBra)
                picoBlaze_emitpcode (POC_GOTO, picoBlaze_popGetLabel (rIfx.lbl->key));
              ifx->generated = 1;
            }
          picoBlaze_emitpLabel (tlbl->key);
          goto release;
        }
      picoBlaze_outBitC (result);
      goto release;
    }

  /* if left is same as result */
  if(picoBlaze_sameRegs(AOP(result),AOP(left))){
    int know_W = -1;
    for(;size--; offset++,lit>>=8) {
      if(AOP_TYPE(right) == AOP_LIT){
        switch(lit & 0xff) {
        case 0x00:
          /*  and'ing with 0 has clears the result */
//        picoBlaze_emitcode("clrf","%s",picoBlaze_aopGet(AOP(result),offset,FALSE,FALSE));
          picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),offset));
          break;
        case 0xff:
          /* and'ing with 0xff is a nop when the result and left are the same */
          break;

        default:
          {
            int p = picoBlaze_my_powof2( (~lit) & 0xff );
            if(p>=0) {
              /* only one bit is set in the literal, so use a bcf instruction */
//            picoBlaze_emitcode("bcf","%s,%d",picoBlaze_aopGet(AOP(left),offset,FALSE,TRUE),p);
              picoBlaze_emitpcode(POC_BCF,picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(left),offset,FALSE,FALSE),p,0, PO_GPR_REGISTER));

            } else {
              picoBlaze_emitcode("movlw","0x%x", (lit & 0xff));
              picoBlaze_emitcode("andwf","%s,f",picoBlaze_aopGet(AOP(left),offset,FALSE,TRUE));
              if(know_W != (lit&0xff))
                picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
              know_W = lit &0xff;
              picoBlaze_emitpcode(POC_ANDWF,picoBlaze_popGet(AOP(left),offset));
            }
          }
        }
      } else {
        if (AOP_TYPE(left) == AOP_ACC) {
          picoBlaze_emitpcode(POC_ANDFW,picoBlaze_popGet(AOP(right),offset));
        } else {
          picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(right),offset));
          picoBlaze_emitpcode(POC_ANDWF,picoBlaze_popGet(AOP(left),offset));

        }
      }
    }

  } else {
    // left & result in different registers
    if(AOP_TYPE(result) == AOP_CRY){
      // result = bit
      // if(size), result in bit
      // if(!size && ifx), conditional oper: if(left & right)
      symbol *tlbl = newiTempLabel(NULL);
      int sizer = min(AOP_SIZE(left),AOP_SIZE(right));
      if(size)
        picoBlaze_emitcode("setb","c");
      while(sizer--){
        MOVA(picoBlaze_aopGet(AOP(right),offset,FALSE,FALSE));
        picoBlaze_emitcode("anl","a,%s",
                       picoBlaze_aopGet(AOP(left),offset,FALSE,FALSE));
        picoBlaze_emitcode("jnz","%05d_DS_",tlbl->key+100);
        offset++;
      }
      if(size){
        CLRC;
        picoBlaze_emitcode("","%05d_DS_:",tlbl->key+100);
        picoBlaze_outBitC(result);
      } else if(ifx)
        jmpTrueOrFalse(ifx, tlbl);
    } else {
      for(;(size--);offset++) {
        // normal case
        // result = left & right
        if(AOP_TYPE(right) == AOP_LIT){
          int t = (lit >> (offset*8)) & 0x0FFL;
          switch(t) {
          case 0x00:
            picoBlaze_emitcode("clrf","%s",
                           picoBlaze_aopGet(AOP(result),offset,FALSE,FALSE));
            picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),offset));
            break;
          case 0xff:
            picoBlaze_emitcode("movf","%s,w",
                           picoBlaze_aopGet(AOP(left),offset,FALSE,FALSE));
            picoBlaze_emitcode("movwf","%s",
                           picoBlaze_aopGet(AOP(result),offset,FALSE,FALSE));
            picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(left),offset));
            picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offset));
            break;
          default:
            picoBlaze_emitcode("movlw","0x%x",t);
            picoBlaze_emitcode("andwf","%s,w",
                           picoBlaze_aopGet(AOP(left),offset,FALSE,FALSE));
            picoBlaze_emitcode("movwf","%s",
                           picoBlaze_aopGet(AOP(result),offset,FALSE,FALSE));

            picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(t));
            picoBlaze_emitpcode(POC_ANDFW,picoBlaze_popGet(AOP(left),offset));
            picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offset));
          }
          continue;
        }

        if (AOP_TYPE(left) == AOP_ACC) {
          picoBlaze_emitcode("andwf","%s,w",picoBlaze_aopGet(AOP(right),offset,FALSE,FALSE));
          picoBlaze_emitpcode(POC_ANDFW,picoBlaze_popGet(AOP(right),offset));
        } else {
          picoBlaze_emitcode("movf","%s,w",picoBlaze_aopGet(AOP(right),offset,FALSE,FALSE));
          picoBlaze_emitcode("andwf","%s,w",
                         picoBlaze_aopGet(AOP(left),offset,FALSE,FALSE));
          picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(right),offset));
          picoBlaze_emitpcode(POC_ANDFW,picoBlaze_popGet(AOP(left),offset));
        }
        picoBlaze_emitcode("movwf","%s",picoBlaze_aopGet(AOP(result),offset,FALSE,FALSE));
        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offset));
      }
    }
  }

release :
  picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genOr  - code for or                                            */
/*-----------------------------------------------------------------*/
static void genOr (iCode *ic, iCode *ifx)
{
  operand *left, *right, *result;
  int size, offset = 0;
  unsigned long lit = 0L;
  resolvedIfx rIfx;

  FENTRY;

  picoBlaze_aopOp ((left = IC_LEFT (ic)), ic, FALSE);
  picoBlaze_aopOp ((right= IC_RIGHT (ic)), ic, FALSE);
  picoBlaze_aopOp ((result=IC_RESULT (ic)), ic, TRUE);

  resolveIfx (&rIfx, ifx);

  /* if left is a literal & right is not then exchange them */
  if ((AOP_TYPE (left) == AOP_LIT && AOP_TYPE (right) != AOP_LIT) ||
      AOP_NEEDSACC (left))
    {
      operand *tmp = right;
      right = left;
      left = tmp;
    }

  /* if result = right then exchange them */
  if (picoBlaze_sameRegs (AOP (result), AOP (right)))
    {
      operand *tmp = right;
      right = left;
      left = tmp;
    }

  /* if right is bit then exchange them */
  if (AOP_TYPE (right) == AOP_CRY &&
      AOP_TYPE (left) != AOP_CRY)
    {
      operand *tmp = right;
      right = left;
      left = tmp;
    }

  DEBUGpicoBlaze_picoBlaze_AopType (__LINE__, left, right, result);

  if (AOP_TYPE (right) == AOP_LIT)
      lit = ulFromVal (AOP (right)->aopu.aop_lit);

  size = AOP_SIZE (result);

  // if(bit | yy)
  // xx = bit | yy;
  if (AOP_TYPE(left) == AOP_CRY){
      if(AOP_TYPE(right) == AOP_LIT){
          // c = bit & literal;
          if(lit){
              // lit != 0 => result = 1
              if(AOP_TYPE(result) == AOP_CRY){
                if(size)
                  picoBlaze_emitpcode(POC_BSF, picoBlaze_popGet(AOP(result),0));
                //picoBlaze_emitcode("bsf","(%s >> 3), (%s & 7)",
                //     AOP(result)->aopu.aop_dir,
                //     AOP(result)->aopu.aop_dir);
                  else if(ifx)
                      continueIfTrue(ifx);
                  goto release;
              }
          } else {
              // lit == 0 => result = left
              if(size && picoBlaze_sameRegs(AOP(result),AOP(left)))
                  goto release;
              picoBlaze_emitcode(";XXX mov","c,%s  %s,%d",AOP(left)->aopu.aop_dir,__FILE__,__LINE__);
          }
      } else {
          if (AOP_TYPE(right) == AOP_CRY){
            if(picoBlaze_sameRegs(AOP(result),AOP(left))){
              // c = bit | bit;
              picoBlaze_emitpcode(POC_BCF,   picoBlaze_popGet(AOP(result),0));
              picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(right),0));
              picoBlaze_emitpcode(POC_BSF,   picoBlaze_popGet(AOP(result),0));

            } else {
              if( AOP_TYPE(result) == AOP_ACC) {
                picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0));
                picoBlaze_emitpcode(POC_BTFSS, picoBlaze_popGet(AOP(right),0));
                picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(left),0));
                picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(1));

              } else {

                picoBlaze_emitpcode(POC_BCF,   picoBlaze_popGet(AOP(result),0));
                picoBlaze_emitpcode(POC_BTFSS, picoBlaze_popGet(AOP(right),0));
                picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(left),0));
                picoBlaze_emitpcode(POC_BSF,   picoBlaze_popGet(AOP(result),0));

              }
            }
          } else {
              // c = bit | val;
              symbol *tlbl = newiTempLabel(NULL);
              picoBlaze_emitcode(";XXX "," %s,%d",__FILE__,__LINE__);


              picoBlaze_emitpcode(POC_BCF,   picoBlaze_popGet(AOP(result),0));
              if( AOP_TYPE(right) == AOP_ACC) {
                picoBlaze_emitpcode(POC_IORLW, picoBlaze_popGetLit(0));
//*//                emitSKPNZ;
                picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(left),0));
                picoBlaze_emitpcode(POC_BSF,   picoBlaze_popGet(AOP(result),0));
              }



              if(!((AOP_TYPE(result) == AOP_CRY) && ifx))
                  picoBlaze_emitcode(";XXX setb","c");
              picoBlaze_emitcode(";XXX jb","%s,%05d_DS_",
                       AOP(left)->aopu.aop_dir,tlbl->key+100);
              picoBlaze_toBoolean(right);
              picoBlaze_emitcode(";XXX jnz","%05d_DS_",tlbl->key+100);
              if((AOP_TYPE(result) == AOP_CRY) && ifx){
                  jmpTrueOrFalse(ifx, tlbl);
                  goto release;
              } else {
                  CLRC;
                  picoBlaze_emitcode("","%05d_DS_:",tlbl->key+100);
              }
          }
      }
      // bit = c
      // val = c
      if(size)
          picoBlaze_outBitC(result);
      // if(bit | ...)
      else if((AOP_TYPE(result) == AOP_CRY) && ifx)
          genIfxJump(ifx, "c");
      goto release ;
  }

  // if(val | 0xZZ)       - size = 0, ifx != FALSE  -
  // bit = val | 0xZZ     - size = 1, ifx = FALSE -
  if ((AOP_TYPE (right) == AOP_LIT) &&
     (AOP_TYPE (result) == AOP_CRY) &&
     (AOP_TYPE (left) != AOP_CRY))
    {
      if (IS_OP_VOLATILE(left)) {
          picoBlaze_mov2w_volatile(AOP(left));
      } // if
      if (lit)
        {
          if (rIfx.condition)
            picoBlaze_emitpcode (POC_GOTO, picoBlaze_popGetLabel (rIfx.lbl->key)); /* to false */
          ifx->generated = 1;
        }
      else
        wassert (0);

      goto release;
  }

  /* if left is same as result */
  if(picoBlaze_sameRegs(AOP(result),AOP(left))){
    int know_W = -1;
    for(;size--; offset++,lit>>=8) {
      if(AOP_TYPE(right) == AOP_LIT){
        if(((lit & 0xff) == 0) && !IS_OP_VOLATILE(left)) {
          /*  or'ing with 0 has no effect */
          continue;
        } else {
          int p = picoBlaze_my_powof2(lit & 0xff);
          if(p>=0) {
            /* only one bit is set in the literal, so use a bsf instruction */
            picoBlaze_emitpcode(POC_BSF,
                      picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(left),offset,FALSE,FALSE),p,0, PO_GPR_REGISTER));
          } else {
            if(know_W != (lit & 0xff))
              picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(lit & 0xff));
            know_W = lit & 0xff;
            picoBlaze_emitpcode(POC_IORWF, picoBlaze_popGet(AOP(left),offset));
          }

        }
      } else {
        if (AOP_TYPE(left) == AOP_ACC) {
          picoBlaze_emitpcode(POC_IORFW,  picoBlaze_popGet(AOP(right),offset));
        } else {
          picoBlaze_emitpcode(POC_MOVFW,  picoBlaze_popGet(AOP(right),offset));
          picoBlaze_emitpcode(POC_IORWF,  picoBlaze_popGet(AOP(left),offset));
        }
      }
    }
  } else {
      // left & result in different registers
      if(AOP_TYPE(result) == AOP_CRY){
          // result = bit
          // if(size), result in bit
          // if(!size && ifx), conditional oper: if(left | right)
          symbol *tlbl = newiTempLabel(NULL);
          int sizer = max(AOP_SIZE(left),AOP_SIZE(right));
          picoBlaze_emitcode(";XXX "," %s,%d",__FILE__,__LINE__);


          if(size)
              picoBlaze_emitcode(";XXX setb","c");
          while(sizer--){
              MOVA(picoBlaze_aopGet(AOP(right),offset,FALSE,FALSE));
              picoBlaze_emitcode(";XXX orl","a,%s",
                       picoBlaze_aopGet(AOP(left),offset,FALSE,FALSE));
              picoBlaze_emitcode(";XXX jnz","%05d_DS_",tlbl->key+100);
              offset++;
          }
          if(size){
              CLRC;
              picoBlaze_emitcode("","%05d_DS_:",tlbl->key+100);
              picoBlaze_outBitC(result);
          } else if(ifx)
              jmpTrueOrFalse(ifx, tlbl);
      } else for(;(size--);offset++){
        // normal case
        // result = left & right
        if(AOP_TYPE(right) == AOP_LIT){
          int t = (lit >> (offset*8)) & 0x0FFL;
          switch(t) {
          case 0x00:
            picoBlaze_emitpcode(POC_MOVFW,  picoBlaze_popGet(AOP(left),offset));
            picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(result),offset));
            break;
          default:
            picoBlaze_emitpcode(POC_MOVLW,  picoBlaze_popGetLit(t));
            picoBlaze_emitpcode(POC_IORFW,  picoBlaze_popGet(AOP(left),offset));
            picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(result),offset));
          }
          continue;
        }

        // faster than result <- left, anl result,right
        // and better if result is SFR
        if (AOP_TYPE(left) == AOP_ACC) {
          picoBlaze_emitpcode(POC_IORWF,  picoBlaze_popGet(AOP(right),offset));
        } else {
          picoBlaze_emitpcode(POC_MOVFW,  picoBlaze_popGet(AOP(right),offset));
          picoBlaze_emitpcode(POC_IORFW,  picoBlaze_popGet(AOP(left),offset));
        }
        picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(result),offset));
      }
  }

release :
  picoBlaze_freeAsmop(left,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(right,NULL,ic,(RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genXor - code for xclusive or                                   */
/*-----------------------------------------------------------------*/
static void genXor (iCode *ic, iCode *ifx)
{
  operand *left, *right, *result;
  int size, offset = 0;
  unsigned long lit = 0L;
  resolvedIfx rIfx;

  FENTRY;

  picoBlaze_aopOp ((left = IC_LEFT (ic)), ic, FALSE);
  picoBlaze_aopOp ((right = IC_RIGHT (ic)), ic, FALSE);
  picoBlaze_aopOp ((result = IC_RESULT (ic)), ic, TRUE);

  resolveIfx (&rIfx,ifx);

  /* if left is a literal & right is not ||
     if left needs acc & right does not */
  if ((AOP_TYPE (left) == AOP_LIT && AOP_TYPE (right) != AOP_LIT) ||
      (AOP_NEEDSACC (left) && !AOP_NEEDSACC (right)))
    {
      operand *tmp = right;
      right = left;
      left = tmp;
    }

  /* if result = right then exchange them */
  if (picoBlaze_sameRegs (AOP (result), AOP (right)))
    {
      operand *tmp = right ;
      right = left;
      left = tmp;
    }

  /* if right is bit then exchange them */
  if (AOP_TYPE (right) == AOP_CRY &&
      AOP_TYPE (left) != AOP_CRY)
    {
      operand *tmp = right ;
      right = left;
      left = tmp;
    }

  if (AOP_TYPE (right) == AOP_LIT)
    lit = ulFromVal (AOP (right)->aopu.aop_lit);

  size = AOP_SIZE (result);

  // if(bit ^ yy)
  // xx = bit ^ yy;
  if (AOP_TYPE(left) == AOP_CRY)
    {
      if (AOP_TYPE(right) == AOP_LIT)
        {
          // c = bit & literal;
          if (lit >> 1)
            {
              // lit>>1  != 0 => result = 1
              if (AOP_TYPE(result) == AOP_CRY)
                {
                  if (size)
                    {
                      picoBlaze_emitpcode(POC_BSF, picoBlaze_popGet(AOP(result), offset));
                    }
                  else if (ifx)
                    continueIfTrue(ifx);
                  goto release;
                }
              picoBlaze_emitcode("setb", "c");
            }
          else
            {
              // lit == (0 or 1)
              if (lit == 0)
                {
                  // lit == 0, result = left
                  if (size && picoBlaze_sameRegs(AOP(result), AOP(left)))
                    goto release;
                  picoBlaze_emitcode("mov", "c,%s", AOP(left)->aopu.aop_dir);
                }
              else
                {
                  // lit == 1, result = not(left)
                  if (size && picoBlaze_sameRegs(AOP(result), AOP(left)))
                    {
                      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(result), offset));
                      picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(result), offset));
                      picoBlaze_emitcode("cpl", "%s", AOP(result)->aopu.aop_dir);
                      goto release;
                    }
                  else
                    {
                      picoBlaze_emitcode("mov", "c,%s", AOP(left)->aopu.aop_dir);
                      picoBlaze_emitcode("cpl", "c");
                    }
                }
            }
        }
      else
        {
          // right != literal
          symbol *tlbl = newiTempLabel(NULL);
          if (AOP_TYPE(right) == AOP_CRY)
            {
              // c = bit ^ bit;
              picoBlaze_emitcode("mov", "c,%s", AOP(right)->aopu.aop_dir);
            }
          else
            {
              int sizer = AOP_SIZE(right);
              // c = bit ^ val
              // if val>>1 != 0, result = 1
              picoBlaze_emitcode("setb", "c");
              while (sizer)
                {
                  MOVA(picoBlaze_aopGet(AOP(right), sizer - 1, FALSE, FALSE));
                  if (sizer == 1)
                    // test the msb of the lsb
                    picoBlaze_emitcode("anl", "a,#0xfe");
                  picoBlaze_emitcode("jnz", "%05d_DS_", tlbl->key+100);
                  sizer--;
                }
              // val = (0,1)
              picoBlaze_emitcode("rrc", "a");
            }
          picoBlaze_emitcode("jnb", "%s,%05d_DS_", AOP(left)->aopu.aop_dir, (tlbl->key + 100));
          picoBlaze_emitcode("cpl", "c");
          picoBlaze_emitcode("", "%05d_DS_:", (tlbl->key + 100));
        }
      // bit = c
      // val = c
      if (size)
        picoBlaze_outBitC(result);
      // if(bit | ...)
      else if ((AOP_TYPE(result) == AOP_CRY) && ifx)
        genIfxJump(ifx, "c");
      goto release;
    }

  // if(val ^ 0xZZ)       - size = 0, ifx != FALSE  -
  // bit = val ^ 0xZZ     - size = 1, ifx = FALSE -
  if ((AOP_TYPE (right) == AOP_LIT) &&
     (AOP_TYPE (result) == AOP_CRY) &&
     (AOP_TYPE (left) != AOP_CRY))
    {
      symbol *tlbl = newiTempLabel (NULL);
      int sizel;

 //*//     if (size)
//*//        emitSETC;

      for (sizel = AOP_SIZE(left); sizel--; ++offset, lit >>= 8)
        {
          unsigned char bytelit = lit;

          switch (bytelit)
            {
            case 0xff:
              picoBlaze_emitpcode (POC_COMFW, picoBlaze_popGet (AOP (left), offset));
              break;

            case 0x00:
              picoBlaze_emitpcode (POC_MOVFW, picoBlaze_popGet (AOP (left), offset));
              break;

            default:
              picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit (bytelit));
              picoBlaze_emitpcode (POC_XORFW, picoBlaze_popGet (AOP (left), offset));
              break;
            }
          if (sizel)
            {
              if (rIfx.condition)
                {
                  /* rIfx.lbl might be far away... */
//*//                  emitSKPZ;
                  picoBlaze_emitpcode (POC_GOTO, picoBlaze_popGetLabel (rIfx.lbl->key)); /* to false */
                }
              else
                {
                  picoBlaze_emitpcode (POC_BNZ, picoBlaze_popGetLabel (tlbl->key)); /* to true */
                }
            }
          else
            {
              /* last non null byte */
//*//              if (rIfx.condition)
//*//                emitSKPZ;
//*//              else
//*//                emitSKPNZ;
            }
        }

      // bit = left ^ literal
      if (size)
        {
//*//          emitCLRC;
          picoBlaze_emitpLabel (tlbl->key);
        }
      // if (left ^ literal)
      else
        {
          if (ifx)
            {
              picoBlaze_emitpcode (POC_GOTO, picoBlaze_popGetLabel (rIfx.lbl->key));
              ifx->generated = 1;
            }
          picoBlaze_emitpLabel (tlbl->key);
          goto release;
        }

      picoBlaze_outBitC (result);
      goto release;
  }

  if (picoBlaze_sameRegs(AOP(result), AOP(left)))
    {
      /* if left is same as result */
      for (; size--; offset++)
        {
          if (AOP_TYPE(right) == AOP_LIT)
            {
              int t  = (lit >> (offset * 8)) & 0x0FFL;
              if  (t == 0x00L)
                continue;
              else
                {
                  picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(t));
                  picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(left), offset));
                }
            }
          else
            {
              if (AOP_TYPE(left) == AOP_ACC)
                picoBlaze_emitcode("xrl", "a,%s", picoBlaze_aopGet(AOP(right), offset, FALSE, FALSE));
              else
                {
                  picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(right), offset));
                  picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(left), offset));
                }
            }
        }
    }
  else
    {
    // left ^ result in different registers
    if (AOP_TYPE(result) == AOP_CRY)
      {
        // result = bit
        // if(size), result in bit
        // if(!size && ifx), conditional oper: if(left ^ right)
        symbol *tlbl = newiTempLabel(NULL);
        int sizer = max(AOP_SIZE(left), AOP_SIZE(right));
        if (size)
          picoBlaze_emitcode("setb", "c");
        while (sizer--)
          {
            if ((AOP_TYPE(right) == AOP_LIT) &&
              (((lit >> (offset*8)) & 0x0FFL) == 0x00L))
              {
                MOVA(picoBlaze_aopGet(AOP(left), offset, FALSE, FALSE));
              }
            else
              {
                MOVA(picoBlaze_aopGet(AOP(right), offset, FALSE, FALSE));
                picoBlaze_emitcode("xrl", "a,%s",
                               picoBlaze_aopGet(AOP(left), offset, FALSE, FALSE));
              }
            picoBlaze_emitcode("jnz", "%05d_DS_", tlbl->key + 100);
            offset++;
          }
        if (size)
          {
            CLRC;
            picoBlaze_emitcode("", "%05d_DS_:", tlbl->key + 100);
            picoBlaze_outBitC(result);
          }
        else if (ifx)
          jmpTrueOrFalse(ifx, tlbl);
      }
    else
      {
        for (; (size--); offset++)
          {
            // normal case
            // result = left ^ right
            if (AOP_TYPE(right) == AOP_LIT)
              {
                int t = (lit >> (offset * 8)) & 0x0FFL;
                switch(t)
                  {
                  case 0x00:
                    picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(left), offset));
                    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offset));
                    break;

                  case 0xff:
                    picoBlaze_emitpcode(POC_COMFW, picoBlaze_popGet(AOP(left), offset));
                    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offset));
                    break;

                  default:
                    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(t));
                    picoBlaze_emitpcode(POC_XORFW, picoBlaze_popGet(AOP(left), offset));
                    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offset));
                  }
                continue;
              }

            // faster than result <- left, anl result,right
            // and better if result is SFR
            if (AOP_TYPE(left) == AOP_ACC)
              {
                picoBlaze_emitpcode(POC_XORFW, picoBlaze_popGet(AOP(right), offset));
              }
            else
              {
                picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(right), offset));
                picoBlaze_emitpcode(POC_XORFW, picoBlaze_popGet(AOP(left), offset));
              }
            if ( AOP_TYPE(result) != AOP_ACC)
              {
                picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offset));
              }
          }
      }
  }

release :
  picoBlaze_freeAsmop(left, NULL, ic, (RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(right, NULL, ic, (RESULTONSTACK(ic) ? FALSE : TRUE));
  picoBlaze_freeAsmop(result, NULL, ic, TRUE);
}

/*-----------------------------------------------------------------*/
/* genInline - write the inline code out                           */
/*-----------------------------------------------------------------*/
static void genInline (iCode *ic)
{
  char *buffer, *bp, *bp1;
  bool inComment = FALSE;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

  _G.inLine += (!options.asmpeep);

  buffer = bp = bp1 = Safe_strdup (IC_INLINE (ic));

  while((bp1=strstr(bp, "\\n"))) {
    *bp1++ = '\n';
    *bp1++ = ' ';
    bp = bp1;
  }
  bp = bp1 = buffer;


  /* emit each line as a code */
  while (*bp)
    {
      switch (*bp)
        {
        case ';':
          inComment = TRUE;
          ++bp;
          break;

        case '\n':
          inComment = FALSE;
          *bp++ = '\0';
          if (*bp1)
            picoBlaze_addpCode2pBlock(pb, picoBlaze_newpCodeAsmDir(bp1, NULL)); // inline directly, no process
          bp1 = bp;
          break;

        default:
          /* Add \n for labels, not dirs such as c:\mydir */
          if (!inComment && (*bp == ':') && (isspace((unsigned char)bp[1])))
            {
              ++bp;
              *bp = '\0';
              ++bp;
              /* print label, use this special format with NULL directive
               * to denote that the argument should not be indented with tab */
              picoBlaze_addpCode2pBlock(pb, picoBlaze_newpCodeAsmDir(NULL, bp1)); // inline directly, no process
              bp1 = bp;
            }
          else
            ++bp;
          break;
        }
    }

  if ((bp1 != bp) && *bp1)
    picoBlaze_addpCode2pBlock(pb, picoBlaze_newpCodeAsmDir(bp1, NULL)); // inline directly, no process

  Safe_free (buffer);

  _G.inLine -= (!options.asmpeep);
}

/*-----------------------------------------------------------------*/
/* genRRC - rotate right with carry                                */
/*-----------------------------------------------------------------*/
static void genRRC (iCode *ic)
{
  operand *left , *result ;
  int size, same;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

  /* rotate right with carry */
  left = IC_LEFT(ic);
  result=IC_RESULT(ic);
  picoBlaze_aopOp (left,ic,FALSE);
  picoBlaze_aopOp (result,ic,TRUE);

  DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,NULL,result);

  same = picoBlaze_sameRegs(AOP(result),AOP(left));

  size = AOP_SIZE(result);

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d size:%d same:%d",__FUNCTION__,__LINE__,size,same);

  /* get the lsb and put it into the carry */
  picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),0));

  while(size--) {

    if(same) {
      picoBlaze_emitpcode(POC_RRCF, picoBlaze_popGet(AOP(left),size));
    } else {
      picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),size));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),size));
    }
  }

  picoBlaze_freeAsmop(left,NULL,ic,TRUE);
  picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genRLC - generate code for rotate left with carry               */
/*-----------------------------------------------------------------*/
static void genRLC (iCode *ic)
{
  operand *left , *result ;
  int size, offset = 0;
  int same;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  /* rotate right with carry */
  left = IC_LEFT(ic);
  result=IC_RESULT(ic);
  picoBlaze_aopOp (left,ic,FALSE);
  picoBlaze_aopOp (result,ic,TRUE);

  DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,NULL,result);

  same = picoBlaze_sameRegs(AOP(result),AOP(left));

  /* move it to the result */
  size = AOP_SIZE(result);

  /* get the msb and put it into the carry */
  picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left),size-1));

  offset = 0 ;

  while(size--) {

    if(same) {
      picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(left),offset));
    } else {
      picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left),offset));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offset));
    }

    offset++;
  }


  picoBlaze_freeAsmop(left,NULL,ic,TRUE);
  picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}


/* gpasm can get the highest order bit with HIGH/UPPER
 * so the following probably is not needed -- VR */

/*-----------------------------------------------------------------*/
/* genGetHbit - generates code get highest order bit               */
/*-----------------------------------------------------------------*/
static void genGetHbit (iCode *ic)
{
    operand *left, *result;
    left = IC_LEFT(ic);
    result=IC_RESULT(ic);
    picoBlaze_aopOp (left,ic,FALSE);
    picoBlaze_aopOp (result,ic,FALSE);

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    /* get the highest order byte into a */
    MOVA(picoBlaze_aopGet(AOP(left),AOP_SIZE(left) - 1,FALSE,FALSE));
    if(AOP_TYPE(result) == AOP_CRY){
        picoBlaze_emitcode("rlc","a");
        picoBlaze_outBitC(result);
    }
    else{
        picoBlaze_emitcode("rl","a");
        picoBlaze_emitcode("anl","a,#0x01");
        picoBlaze_outAcc(result);
    }


    picoBlaze_freeAsmop(left,NULL,ic,TRUE);
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* AccLsh - left shift accumulator by known count                  */
/*-----------------------------------------------------------------*/
static void AccLsh (int shCount, int doMask)
{
        DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
        switch(shCount){
                case 0 :
                        return;
                        break;
                case 1 :
//*//                        picoBlaze_emitpcode(POC_RLNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 2 :
//*//                        picoBlaze_emitpcode(POC_RLNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//                        picoBlaze_emitpcode(POC_RLNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 3 :
//*//                        picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//                        picoBlaze_emitpcode(POC_RRNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 4 :
//*//                        picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 5 :
//*//                        picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//                        picoBlaze_emitpcode(POC_RLNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 6 :
//*//                        picoBlaze_emitpcode(POC_RRNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//                        picoBlaze_emitpcode(POC_RRNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 7 :
//*//                        picoBlaze_emitpcode(POC_RRNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
        }
        if (doMask) {
                /* no masking is required in genPackBits */
                picoBlaze_emitpcode(POC_ANDLW,picoBlaze_popGetLit(SLMask[shCount]));
        }
}

/*-----------------------------------------------------------------*/
/* AccRsh - right shift accumulator by known count                 */
/*-----------------------------------------------------------------*/
static void AccRsh (int shCount, int andmask)
{
        DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
        assert ((shCount >= 0) && (shCount <= 8));
        switch (shCount) {
                case 0 :
                        return; break;
                case 1 :
//*//                        picoBlaze_emitpcode(POC_RRNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 2 :
//*//                        picoBlaze_emitpcode(POC_RRNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//                        picoBlaze_emitpcode(POC_RRNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 3 :
//*//                        picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//                        picoBlaze_emitpcode(POC_RLNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 4 :
//*//                        picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 5 :
//*//                        picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//                        picoBlaze_emitpcode(POC_RRNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 6 :
//*//                        picoBlaze_emitpcode(POC_RLNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
//*//                        picoBlaze_emitpcode(POC_RLNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                case 7 :
//*//                        picoBlaze_emitpcode(POC_RLNCFW,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
                        break;
                default:
                        // Rotating by 8 is a NOP.
                        break;
        }

        if (andmask)
                picoBlaze_emitpcode(POC_ANDLW,picoBlaze_popGetLit(SRMask[shCount]));
        else
                DEBUGpicoBlaze_emitcode("; ***", "%s omitting masking the result", __FUNCTION__);
}

/*-----------------------------------------------------------------*/
/* shiftR1Left2Result - shift right one byte from left to result   */
/*-----------------------------------------------------------------*/
static void shiftR1Left2ResultSigned (operand *left, int offl,
                                operand *result, int offr,
                                int shCount)
{
  int same;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  assert ((shCount >= 0) && (shCount <= 8));

  same = ((left == result) || (AOP(left) == AOP(result))) && (offl == offr);

  /* Do NOT use result for intermediate results, it might be an SFR!. */
  switch (shCount) {
  case 0:
    if (!same) {
      picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(left), offl));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    }
    break;

  case 1:
    picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left), offl));
    if (same)
      picoBlaze_emitpcode(POC_RRCF, picoBlaze_popGet(AOP(result), offr));
    else {
      picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left), offl));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    }
    break;

  case 2:
    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x3f)); // keep sign bit in W<5>
//*//    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popCopyGPR2Bit(PCOP(&picoBlaze_pc_wreg), 5));
    picoBlaze_emitpcode(POC_IORLW, picoBlaze_popGetLit(0xc0)); // sign-extend
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 3:
    picoBlaze_emitpcode(POC_SWAPFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x1f)); // keep sign in W<4>
//*//    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popCopyGPR2Bit(PCOP(&picoBlaze_pc_wreg), 4));
    picoBlaze_emitpcode(POC_IORLW, picoBlaze_popGetLit(0xe0)); // sign-extend
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 4:
    picoBlaze_emitpcode(POC_SWAPFW, picoBlaze_popGet(AOP(left), offl));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x0f)); // keep sign in W<3>
//*//    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popCopyGPR2Bit(PCOP(&picoBlaze_pc_wreg), 3));
    picoBlaze_emitpcode(POC_IORLW, picoBlaze_popGetLit(0xf0)); // sign-extend
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 5:
    picoBlaze_emitpcode(POC_SWAPFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x07)); // keep sign in W<2>
//*//    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popCopyGPR2Bit(PCOP(&picoBlaze_pc_wreg), 2));
    picoBlaze_emitpcode(POC_IORLW, picoBlaze_popGetLit(0xf8)); // sign-extend
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 6:
    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x03)); // keep sign bit in W<1>
//*//    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popCopyGPR2Bit(PCOP(&picoBlaze_pc_wreg), 1));
    picoBlaze_emitpcode(POC_IORLW, picoBlaze_popGetLit(0xfc)); // sign-extend
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 7:
    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0x00));
    picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(left), offl), 7));
    picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0xff));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  default:
    picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result), offr));
    break;
  }
}

/*-----------------------------------------------------------------*/
/* shiftR1Left2Result - shift right one byte from left to result   */
/*-----------------------------------------------------------------*/
static void shiftR1Left2Result (operand *left, int offl,
                                operand *result, int offr,
                                int shCount, int sign)
{
  int same;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  assert ((shCount >= 0) && (shCount <= 8));

  same = ((left == result) || (AOP(left) == AOP(result))) && (offl == offr);

  /* Copy the msb into the carry if signed. */
  if (sign) {
    shiftR1Left2ResultSigned(left, offl, result, offr, shCount);
    return;
  }

  /* Do NOT use result for intermediate results, it might be an SFR!. */
  switch (shCount) {
  case 0:
    if (!same) {
      picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(left), offl));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    }
    break;

  case 1:
    if (same) {
//*//      emitCLRC;
      picoBlaze_emitpcode(POC_RRCF, picoBlaze_popGet(AOP(result), offr));
    } else {
      picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popGet(AOP(left), offl));
      picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x7f));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    }
    break;

  case 2:
    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x3f));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 3:
    picoBlaze_emitpcode(POC_SWAPFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x1f));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 4:
    picoBlaze_emitpcode(POC_SWAPFW, picoBlaze_popGet(AOP(left), offl));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x0f));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 5:
    picoBlaze_emitpcode(POC_SWAPFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x07));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 6:
    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x03));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 7:
    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popGet(AOP(left), offl));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x01));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  default:
    picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result), offr));
    break;
  }
}

/*-----------------------------------------------------------------*/
/* shiftL1Left2Result - shift left one byte from left to result    */
/*-----------------------------------------------------------------*/
static void shiftL1Left2Result (operand *left, int offl,
                                operand *result, int offr, int shCount)
{
  int same;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  assert ((shCount >= 0) && (shCount <= 8));

  same = ((left == result) || (AOP(left) == AOP(result))) && (offl==offr);

  /* Do NOT use result for intermediate results, it might be an SFR!. */
  switch (shCount) {
  case 0:
    if (!same) {
      picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(left), offl));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    }
    break;

  case 1:
    if (same) {
//*//      emitCLRC;
      picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(left), offl));
    } else {
      picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popGet(AOP(left), offl));
      picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0xfe));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    }
    break;

  case 2:
    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0xfc));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 3:
    picoBlaze_emitpcode(POC_SWAPFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0xf8));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 4:
    picoBlaze_emitpcode(POC_SWAPFW, picoBlaze_popGet(AOP(left), offl));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0xf0));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 5:
    picoBlaze_emitpcode(POC_SWAPFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RLNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0xe0));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 6:
    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popGet(AOP(left), offl));
//*//    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0xc0));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  case 7:
    picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popGet(AOP(left), offl));
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x80));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offr));
    break;

  default:
    picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result), offr));
    break;
  }
}

/*-----------------------------------------------------------------*/
/* movLeft2Result - move byte from left to result                  */
/*-----------------------------------------------------------------*/
static void movLeft2Result (operand *left, int offl,
                            operand *result, int offr)
{
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  if (!picoBlaze_sameRegs(AOP(left),AOP(result)) || (offl != offr)) {
    picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(left),offl));
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offr));
  }
}

/*-----------------------------------------------------------------*/
/* shiftL2Left2Result - shift left two bytes from left to result   */
/*-----------------------------------------------------------------*/
static void shiftL2Left2Result (operand *left, int offl,
                                operand *result, int offr, int shCount)
{
  int same = picoBlaze_sameRegs(AOP(result), AOP(left));
  int i;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d shCount:%d same:%d offl:%d offr:%d",__FUNCTION__,__LINE__,shCount,same,offl,offr);

  if (same && (offl != offr)) { // shift bytes
    if (offr > offl) {
       for(i=1;i>-1;i--) {
         picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(result),offl+i));
         picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr+i));
       }
    } else { // just treat as different later on
                same = 0;
    }
  }

  if(same) {
    switch(shCount) {
    case 0:
      break;
    case 1:
    case 2:
    case 3:

      picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RLCF,  picoBlaze_popGet(AOP(result),offr+MSB16));

      while(--shCount) {
//*//                emitCLRC;
                picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),offr));
                picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),offr+MSB16));
      }

      break;
    case 4:
    case 5:
      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0x0f));
      picoBlaze_emitpcode(POC_ANDWF, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_SWAPF, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_SWAPF, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_ANDFW, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),offr+MSB16));
      if(shCount >=5) {
                picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),offr));
                picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),offr+MSB16));
      }
      break;
    case 6:
      picoBlaze_emitpcode(POC_RRCF,  picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RRCF,  picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RRCF,  picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RRCF,  picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_ANDLW,picoBlaze_popGetLit(0xc0));
      picoBlaze_emitpcode(POC_XORFW,picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_XORWF,picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_XORFW,picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr+MSB16));
      break;
    case 7:
      picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RRCF,  picoBlaze_popGet(AOP(result),offr));
    }

  } else {
    switch(shCount) {
    case 0:
      break;
    case 1:
    case 2:
    case 3:
      /* note, use a mov/add for the shift since the mov has a
         chance of getting optimized out */
      picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(left),offl));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RLCFW,  picoBlaze_popGet(AOP(left),offl+MSB16));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offr+MSB16));

      while(--shCount) {
//*//                emitCLRC;
                picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),offr));
                picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),offr+MSB16));
      }
      break;

    case 4:
    case 5:
      picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popGet(AOP(left),offl+MSB16));
      picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0xF0));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popGet(AOP(left),offl));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x0F));
      picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),offr+MSB16));


      if(shCount == 5) {
                picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),offr));
                picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(result),offr+MSB16));
      }
      break;
    case 6:
      picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popGet(AOP(left),offl));
      picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RRNCF,  picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RRNCFW, picoBlaze_popGet(AOP(left),offl+MSB16));
      picoBlaze_emitpcode(POC_MOVWF,  picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RRNCF,  picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_MOVLW,  picoBlaze_popGetLit(0xc0));
      picoBlaze_emitpcode(POC_ANDWF,  picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_ANDFW,  picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_XORFW,  picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_IORWF,  picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_XORWF,  picoBlaze_popGet(AOP(result),offr));
      break;
    case 7:
      picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),offl+MSB16));
      picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),offl));
      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RRCF,  picoBlaze_popGet(AOP(result),offr));
    }
  }

}
/*-----------------------------------------------------------------*/
/* shiftR2Left2Result - shift right two bytes from left to result  */
/*-----------------------------------------------------------------*/
static void shiftR2Left2Result (operand *left, int offl,
                                operand *result, int offr,
                                int shCount, int sign)
{
  int same = picoBlaze_sameRegs(AOP(result), AOP(left));
  int i;
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d shCount:%d same:%d sign:%d",__FUNCTION__,__LINE__,shCount,same,sign);

  if (same && (offl != offr)) { // shift right bytes
    if (offr < offl) {
       for(i=0;i<2;i++) {
         picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(result),offl+i));
         picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr+i));
       }
    } else { // just treat as different later on
                same = 0;
    }
  }

  switch(shCount) {
  case 0:
    break;
  case 1:
  case 2:
  case 3:
    /* obtain sign from left operand */
    if(sign)
      picoBlaze_emitpcode(POC_RLCFW,picoBlaze_popGet(AOP(left),offr+MSB16));
 //*//   else
//*//      emitCLRC;

    if(same) {
      picoBlaze_emitpcode(POC_RRCF,picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RRCF,picoBlaze_popGet(AOP(result),offr));
    } else {
      picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),offl+MSB16));
      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),offl));
      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr));
    }

    while(--shCount) {
      if(sign)
        /* now get sign from already assigned result (avoid BANKSEL) */
        picoBlaze_emitpcode(POC_RLCFW,picoBlaze_popGet(AOP(result),offr+MSB16));
      else
//*//        emitCLRC;
      picoBlaze_emitpcode(POC_RRCF,picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RRCF,picoBlaze_popGet(AOP(result),offr));
    }
    break;
  case 4:
  case 5:
    if(same) {

      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0xf0));
      picoBlaze_emitpcode(POC_ANDWF, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_SWAPF, picoBlaze_popGet(AOP(result),offr));

      picoBlaze_emitpcode(POC_SWAPF, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_ANDFW, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),offr));
    } else {
      picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popGet(AOP(left),offl));
      picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0x0f));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offr));

      picoBlaze_emitpcode(POC_SWAPFW,picoBlaze_popGet(AOP(left),offl+MSB16));
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(0xf0));
      picoBlaze_emitpcode(POC_XORWF, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),offr));
    }

    if(shCount >=5) {
      picoBlaze_emitpcode(POC_RRCF, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RRCF, picoBlaze_popGet(AOP(result),offr));
    }

    if(sign) {
      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0xf0 + (shCount-4)*8 ));
      picoBlaze_emitpcode(POC_BTFSC,
                picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(result),offr+MSB16,FALSE,FALSE),7-shCount,0, PO_GPR_REGISTER));
      picoBlaze_emitpcode(POC_ADDWF, picoBlaze_popGet(AOP(result),offr+MSB16));
    }

    break;

  case 6:
    if(same) {

      picoBlaze_emitpcode(POC_RLCF,  picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RLCF,  picoBlaze_popGet(AOP(result),offr+MSB16));

      picoBlaze_emitpcode(POC_RLCF,  picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RLCF,  picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_ANDLW,picoBlaze_popGetLit(0x03));
      if(sign) {
        picoBlaze_emitpcode(POC_BTFSC,
                  picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(result),offr,FALSE,FALSE),0,0, PO_GPR_REGISTER));
        picoBlaze_emitpcode(POC_IORLW,picoBlaze_popGetLit(0xfc));
      }
      picoBlaze_emitpcode(POC_XORFW,picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_XORWF,picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_XORFW,picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr));
    } else {
      picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left),offl));
      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left),offl+MSB16));
      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RLCF,  picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_RLCF,  picoBlaze_popGet(AOP(result),offr));
      picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(result),offr+MSB16));
      picoBlaze_emitpcode(POC_ANDLW,picoBlaze_popGetLit(0x03));
      if(sign) {
        picoBlaze_emitpcode(POC_BTFSC,
                  picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(result),offr+MSB16,FALSE,FALSE),0,0, PO_GPR_REGISTER));
        picoBlaze_emitpcode(POC_IORLW,picoBlaze_popGetLit(0xfc));
      }
      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr+MSB16));
      //picoBlaze_emitpcode(POC_RLCF,  picoBlaze_popGet(AOP(result),offr));


    }

    break;
  case 7:
    picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left),offl));
    picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left),offl+MSB16));
    picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),offr));
    picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result),offr+MSB16));
    if(sign) {
//*//      emitSKPNC;
      picoBlaze_emitpcode(POC_DECF, picoBlaze_popGet(AOP(result),offr+MSB16));
    } else
      picoBlaze_emitpcode(POC_RLCF,  picoBlaze_popGet(AOP(result),offr+MSB16));
  }
}


/*-----------------------------------------------------------------*/
/* shiftLLeftOrResult - shift left one byte from left, or to result*/
/*-----------------------------------------------------------------*/
static void shiftLLeftOrResult (operand *left, int offl,
                                operand *result, int offr, int shCount)
{
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(left),offl));
    /* shift left accumulator */
    AccLsh(shCount, 1);
    /* or with result */
    /* back to result */
    picoBlaze_emitpcode(POC_IORWF,picoBlaze_popGet(AOP(result),offr));
}

/*-----------------------------------------------------------------*/
/* shiftRLeftOrResult - shift right one byte from left,or to result*/
/*-----------------------------------------------------------------*/
static void shiftRLeftOrResult (operand *left, int offl,
                                operand *result, int offr, int shCount)
{
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(left),offl));
    /* shift right accumulator */
    AccRsh(shCount, 1);
    /* or with result */
    /* back to result */
    picoBlaze_emitpcode(POC_IORWF,picoBlaze_popGet(AOP(result),offr));
}

/*-----------------------------------------------------------------*/
/* genlshOne - left shift a one byte quantity by known count       */
/*-----------------------------------------------------------------*/
static void genlshOne (operand *result, operand *left, int shCount)
{
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    shiftL1Left2Result(left, LSB, result, LSB, shCount);
}

/*-----------------------------------------------------------------*/
/* genlshTwo - left shift two bytes by known amount != 0           */
/*-----------------------------------------------------------------*/
static void genlshTwo (operand *result,operand *left, int shCount)
{
    int size;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d shCount:%d",__FUNCTION__,__LINE__,shCount);
    size = picoBlaze_getDataSize(result);

    /* if shCount >= 8 */
    if (shCount >= 8) {
        shCount -= 8 ;

        if (size > 1){
            if (shCount)
                shiftL1Left2Result(left, LSB, result, MSB16, shCount);
            else
                movLeft2Result(left, LSB, result, MSB16);
        }
        picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),LSB));
    }

    /*  1 <= shCount <= 7 */
    else {
        if(size == 1)
            shiftL1Left2Result(left, LSB, result, LSB, shCount);
        else
            shiftL2Left2Result(left, LSB, result, LSB, shCount);
    }
}

/*-----------------------------------------------------------------*/
/* shiftLLong - shift left one long from left to result            */
/* offr = LSB or MSB16                                             */
/*-----------------------------------------------------------------*/
static void shiftLLong (operand *left, operand *result, int offr )
{
    int size = AOP_SIZE(result);
    int same = picoBlaze_sameRegs(AOP(left),AOP(result));
        int i;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d  offr:%d size:%d",__FUNCTION__,__LINE__,offr,size);

        if (same && (offr == MSB16)) { //shift one byte
                for(i=size-1;i>=MSB16;i--) {
                        picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(left),i-1));
                        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(left),i));
                }
        } else {
                picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(left),LSB));
        }

    if (size > LSB+offr ){
                if (same) {
                        picoBlaze_emitpcode(POC_ADDWF,picoBlaze_popGet(AOP(left),LSB+offr));
                } else {
                        picoBlaze_emitpcode(POC_ADDFW,picoBlaze_popGet(AOP(left),LSB));
                        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),LSB+offr));
                }
         }

    if(size > MSB16+offr){
                if (same) {
                        picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(left),MSB16+offr));
                } else {
                        picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left),MSB16));
                        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),MSB16+offr));
                }
    }

    if(size > MSB24+offr){
                if (same) {
                        picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(left),MSB24+offr));
                } else {
                        picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left),MSB24));
                        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),MSB24+offr));
                }
    }

    if(size > MSB32+offr){
                if (same) {
                        picoBlaze_emitpcode(POC_RLCF, picoBlaze_popGet(AOP(left),MSB32+offr));
                } else {
                        picoBlaze_emitpcode(POC_RLCFW, picoBlaze_popGet(AOP(left),MSB32));
                        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(result),MSB32+offr));
                }
    }
    if(offr != LSB)
                picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),LSB));

}

/*-----------------------------------------------------------------*/
/* genlshFour - shift four byte by a known amount != 0             */
/*-----------------------------------------------------------------*/
static void genlshFour (operand *result, operand *left, int shCount)
{
    int size;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    size = AOP_SIZE(result);

    /* if shifting more that 3 bytes */
    if (shCount >= 24 ) {
        shCount -= 24;
        if (shCount)
            /* lowest order of left goes to the highest
            order of the destination */
            shiftL1Left2Result(left, LSB, result, MSB32, shCount);
        else
            movLeft2Result(left, LSB, result, MSB32);

                picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),LSB));
                picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),MSB16));
                picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),MSB24));

        return;
    }

    /* more than two bytes */
    else if ( shCount >= 16 ) {
        /* lower order two bytes goes to higher order two bytes */
        shCount -= 16;
        /* if some more remaining */
        if (shCount)
            shiftL2Left2Result(left, LSB, result, MSB24, shCount);
        else {
            movLeft2Result(left, MSB16, result, MSB32);
            movLeft2Result(left, LSB, result, MSB24);
        }
                picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),LSB));
                picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),MSB16));
        return;
    }

    /* if more than 1 byte */
    else if ( shCount >= 8 ) {
        /* lower order three bytes goes to higher order  three bytes */
        shCount -= 8;
        if(size == 2){
            if(shCount)
                shiftL1Left2Result(left, LSB, result, MSB16, shCount);
            else
                movLeft2Result(left, LSB, result, MSB16);
        }
        else{   /* size = 4 */
            if(shCount == 0){
                movLeft2Result(left, MSB24, result, MSB32);
                movLeft2Result(left, MSB16, result, MSB24);
                movLeft2Result(left, LSB, result, MSB16);
                                picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),LSB));
            }
            else if(shCount == 1)
                shiftLLong(left, result, MSB16);
            else{
                shiftL2Left2Result(left, MSB16, result, MSB24, shCount);
                shiftL1Left2Result(left, LSB, result, MSB16, shCount);
                shiftRLeftOrResult(left, LSB, result, MSB24, 8 - shCount);
                                picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),LSB));
            }
        }
    }

    /* 1 <= shCount <= 7 */
    else if(shCount <= 3)
    {
        shiftLLong(left, result, LSB);
        while(--shCount >= 1)
            shiftLLong(result, result, LSB);
    }
    /* 3 <= shCount <= 7, optimize */
    else{
        shiftL2Left2Result(left, MSB24, result, MSB24, shCount);
        shiftRLeftOrResult(left, MSB16, result, MSB24, 8 - shCount);
        shiftL2Left2Result(left, LSB, result, LSB, shCount);
    }
}

/*-----------------------------------------------------------------*/
/* genLeftShiftLiteral - left shifting by known count              */
/*-----------------------------------------------------------------*/
void picoBlaze_genLeftShiftLiteral (operand *left,
                                 operand *right,
                                 operand *result,
                                 iCode *ic)
{
    int shCount = abs((int) ulFromVal (AOP(right)->aopu.aop_lit));
    int size;

    FENTRY;
    DEBUGpicoBlaze_emitcode ("; ***","shCount:%d", shCount);
    picoBlaze_freeAsmop(right,NULL,ic,TRUE);

    picoBlaze_aopOp(left,ic,FALSE);
    picoBlaze_aopOp(result,ic,TRUE);

    size = getSize(operandType(result));

#if VIEW_SIZE
    picoBlaze_emitcode("; shift left ","result %d, left %d",size,
             AOP_SIZE(left));
#endif

    /* I suppose that the left size >= result size */
    if(shCount == 0){
        while(size--){
            movLeft2Result(left, size, result, size);
        }
    }

    else if(shCount >= (size * 8))
        while(size--)
            picoBlaze_aopPut(AOP(result),zero,size);
    else{
        switch (size) {
            case 1:
                genlshOne (result,left,shCount);
                break;

            case 2:
            case 3:
                genlshTwo (result,left,shCount);
                break;

            case 4:
                genlshFour (result,left,shCount);
                break;
        }
    }
    picoBlaze_freeAsmop(left,NULL,ic,TRUE);
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*
 * genMultiAsm - repeat assembly instruction for size of register.
 * if endian == 1, then the high byte (i.e base address + size of
 * register) is used first else the low byte is used first;
 *-----------------------------------------------------------------*/
static void genMultiAsm( PIC_OPCODE poc, operand *reg, int size, int endian)
{

  int offset = 0;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

  if(!reg)
    return;

  if(!endian) {
    endian = 1;
  } else {
    endian = -1;
    offset = size-1;
  }

  while(size--) {
    picoBlaze_emitpcode(poc,    picoBlaze_popGet(AOP(reg),offset));
    offset += endian;
  }

}

/*-----------------------------------------------------------------*/
/* genrshOne - right shift a one byte quantity by known count      */
/*-----------------------------------------------------------------*/
static void genrshOne (operand *result, operand *left,
                       int shCount, int sign)
{
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    shiftR1Left2Result(left, LSB, result, LSB, shCount, sign);
}

/*-----------------------------------------------------------------*/
/* genrshTwo - right shift two bytes by known amount != 0          */
/*-----------------------------------------------------------------*/
static void genrshTwo (operand *result,operand *left,
                       int shCount, int sign)
{
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d shCount:%d",__FUNCTION__,__LINE__,shCount);
  /* if shCount >= 8 */
  if (shCount >= 8) {
    shCount -= 8 ;
    if (shCount)
      shiftR1Left2Result(left, MSB16, result, LSB,
                         shCount, sign);
    else
      movLeft2Result(left, MSB16, result, LSB);

    picoBlaze_addSign (result, 1, sign);
  }

  /*  1 <= shCount <= 7 */
  else
    shiftR2Left2Result(left, LSB, result, LSB, shCount, sign);
}

/*-----------------------------------------------------------------*/
/* shiftRLong - shift right one long from left to result           */
/* offl = LSB or MSB16                                             */
/*-----------------------------------------------------------------*/
static void shiftRLong (operand *left, int offl,
                        operand *result, int sign)
{
    int size = AOP_SIZE(result);
    int same = picoBlaze_sameRegs(AOP(left),AOP(result));
    int i;
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d  offl:%d size:%d",__FUNCTION__,__LINE__,offl,size);

        if (same && (offl == MSB16)) { //shift one byte right
                for(i=MSB16;i<size;i++) {
                        picoBlaze_emitpcode(POC_MOVFW,picoBlaze_popGet(AOP(left),i));
                        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popGet(AOP(left),i-1));
                }
        }

    if(sign)
                picoBlaze_emitpcode(POC_RLCFW,picoBlaze_popGet(AOP(left),MSB32));
        else
//*//                emitCLRC;

        if (same) {
                if (offl == LSB)
                picoBlaze_emitpcode(POC_RRCF, picoBlaze_popGet(AOP(left),MSB32));
        } else {
        picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),MSB32));
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),MSB32-offl));
        }

    if(offl == MSB16) {
        /* add sign of "a" */
        picoBlaze_addSign(result, MSB32, sign);
        }

        if (same) {
        picoBlaze_emitpcode(POC_RRCF, picoBlaze_popGet(AOP(left),MSB24));
        } else {
        picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),MSB24));
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),MSB24-offl));
        }

        if (same) {
        picoBlaze_emitpcode(POC_RRCF, picoBlaze_popGet(AOP(left),MSB16));
        } else {
        picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),MSB16));
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),MSB16-offl));
        }

        if (same) {
        picoBlaze_emitpcode(POC_RRCF, picoBlaze_popGet(AOP(left),LSB));
        } else {
        if(offl == LSB){
                picoBlaze_emitpcode(POC_RRCFW, picoBlaze_popGet(AOP(left),LSB));
                picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),LSB));
        }
        }
}

/*-----------------------------------------------------------------*/
/* genrshFour - shift four byte by a known amount != 0             */
/*-----------------------------------------------------------------*/
static void genrshFour (operand *result, operand *left,
                        int shCount, int sign)
{
  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  /* if shifting more that 3 bytes */
  if(shCount >= 24 ) {
    shCount -= 24;
    if(shCount)
      shiftR1Left2Result(left, MSB32, result, LSB, shCount, sign);
    else
      movLeft2Result(left, MSB32, result, LSB);

    picoBlaze_addSign(result, MSB16, sign);
  }
  else if(shCount >= 16){
    shCount -= 16;
    if(shCount)
      shiftR2Left2Result(left, MSB24, result, LSB, shCount, sign);
    else{
      movLeft2Result(left, MSB24, result, LSB);
      movLeft2Result(left, MSB32, result, MSB16);
    }
    picoBlaze_addSign(result, MSB24, sign);
  }
  else if(shCount >= 8){
    shCount -= 8;
    if(shCount == 1)
      shiftRLong(left, MSB16, result, sign);
    else if(shCount == 0){
      movLeft2Result(left, MSB16, result, LSB);
      movLeft2Result(left, MSB24, result, MSB16);
      movLeft2Result(left, MSB32, result, MSB24);
      picoBlaze_addSign(result, MSB32, sign);
    }
    else{ //shcount >= 2
      shiftR2Left2Result(left, MSB16, result, LSB, shCount, 0);
      shiftLLeftOrResult(left, MSB32, result, MSB16, 8 - shCount);
      /* the last shift is signed */
      shiftR1Left2Result(left, MSB32, result, MSB24, shCount, sign);
      picoBlaze_addSign(result, MSB32, sign);
    }
  }
  else{   /* 1 <= shCount <= 7 */
    if(shCount <= 2){
      shiftRLong(left, LSB, result, sign);
      if(shCount == 2)
        shiftRLong(result, LSB, result, sign);
    }
    else{
      shiftR2Left2Result(left, LSB, result, LSB, shCount, 0);
      shiftLLeftOrResult(left, MSB24, result, MSB16, 8 - shCount);
      shiftR2Left2Result(left, MSB24, result, MSB24, shCount, sign);
    }
  }
}

/*-----------------------------------------------------------------*/
/* genRightShiftLiteral - right shifting by known count            */
/*-----------------------------------------------------------------*/
static void genRightShiftLiteral (operand *left,
                                  operand *right,
                                  operand *result,
                                  iCode *ic,
                                  int sign)
{
  int shCount = abs((int) ulFromVal (AOP(right)->aopu.aop_lit));
  int lsize,res_size;

  picoBlaze_freeAsmop(right,NULL,ic,TRUE);

  picoBlaze_aopOp(left,ic,FALSE);
  picoBlaze_aopOp(result,ic,TRUE);

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d shCount:%d result:%d left:%d",__FUNCTION__,__LINE__,shCount,AOP_SIZE(result),AOP_SIZE(left));

#if VIEW_SIZE
  picoBlaze_emitcode("; shift right ","result %d, left %d",AOP_SIZE(result),
                 AOP_SIZE(left));
#endif

  lsize = picoBlaze_getDataSize(left);
  res_size = picoBlaze_getDataSize(result);
  /* test the LEFT size !!! */

  /* I suppose that the left size >= result size */
  if (shCount == 0) {
    assert (res_size <= lsize);
    while (res_size--) {
      picoBlaze_mov2f (AOP(result), AOP(left), res_size);
    } // for
  } else if (shCount >= (lsize * 8)) {
    if (sign) {
      /*
       * Do NOT use
       *    CLRF    result
       *    BTFSC   left, 7
       *    SETF    result
       * even for 8-bit operands; result might be an SFR.
       */
      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0x00));
      picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(left), lsize-1), 7));
      picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit(0xff));
      while (res_size--) {
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), res_size));
      }
    } else { // unsigned
      while (res_size--) {
        picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result), res_size));
      }
    }
  } else { // 0 < shCount < 8*lsize
    switch (res_size) {
    case 1:
      genrshOne (result,left,shCount,sign);
      break;

    case 2:
      genrshTwo (result,left,shCount,sign);
      break;

    case 4:
      genrshFour (result,left,shCount,sign);
      break;
    default :
      break;
    }
  }

  picoBlaze_freeAsmop(left,NULL,ic,TRUE);
  picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genGenericShift - generates code for left or right shifting     */
/*-----------------------------------------------------------------*/
static void genGenericShift (iCode *ic, int isShiftLeft)
{
  operand *left,*right, *result;
  int offset;
  int sign, signedCount;
  symbol *label_complete, *label_loop_pos, *label_loop_neg, *label_negative;
  PIC_OPCODE pos_shift, neg_shift;

  FENTRY;

  right = IC_RIGHT(ic);
  left  = IC_LEFT(ic);
  result = IC_RESULT(ic);

  picoBlaze_aopOp(right,ic,FALSE);
  picoBlaze_aopOp(left,ic,FALSE);
  picoBlaze_aopOp(result,ic,TRUE);

  sign = !SPEC_USIGN(operandType (left));
  signedCount = !SPEC_USIGN(operandType (right));

  /* if the shift count is known then do it
     as efficiently as possible */
  if (AOP_TYPE(right) == AOP_LIT) {
    long lit = (long) ulFromVal (AOP(right)->aopu.aop_lit);
    if (signedCount && lit < 0) { lit = -lit; isShiftLeft = !isShiftLeft; }
    // we should modify right->aopu.aop_lit here!
    // Instead we use abs(shCount) in genXXXShiftLiteral()...
    // lit > 8*size is handled in picoBlaze_genXXXShiftLiteral()
    if (isShiftLeft)
      picoBlaze_genLeftShiftLiteral (left,right,result,ic);
    else
      genRightShiftLiteral (left,right,result,ic, sign);

    goto release;
  } // if (right is literal)

  /* shift count is unknown then we have to form a loop.
   * Note: we take only the lower order byte since shifting
   * more than 32 bits make no sense anyway, ( the
   * largest size of an object can be only 32 bits )
   * Note: we perform arithmetic shifts if the left operand is
   * signed and we do an (effective) right shift, i. e. we
   * shift in the sign bit from the left. */

  label_complete = newiTempLabel ( NULL );
  label_loop_pos = newiTempLabel ( NULL );
  label_loop_neg = NULL;
  label_negative = NULL;
  pos_shift = isShiftLeft ? POC_RLCF : POC_RRCF;
  neg_shift = isShiftLeft ? POC_RRCF : POC_RLCF;

  if (signedCount) {
    // additional labels needed
    label_loop_neg = newiTempLabel ( NULL );
    label_negative = newiTempLabel ( NULL );
  } // if

  // copy source to result -- this will effectively truncate the left operand to the size of result!
  // (e.g. char c = 0x100 << -3 will become c = 0x00 >> 3 == 0x00 instad of 0x20)
  // This is fine, as it only occurs for left shifting with negative count which is not standardized!
  for (offset=0; offset < min(AOP_SIZE(left), AOP_SIZE(result)); offset++) {
    picoBlaze_mov2f (AOP(result),AOP(left), offset);
  } // for

  // if result is longer than left, fill with zeros (or sign)
  if (AOP_SIZE(left) < AOP_SIZE(result)) {
    if (sign && AOP_SIZE(left) > 0) {
      // shift signed operand -- fill with sign
//*//      picoBlaze_emitpcode (POC_CLRF, picoBlaze_popCopyReg (&picoBlaze_pc_wreg));
      picoBlaze_emitpcode (POC_BTFSC, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(result), AOP_SIZE(left)-1), 7));
      picoBlaze_emitpcode (POC_MOVLW, picoBlaze_popGetLit (0xFF));
      for (offset=AOP_SIZE(left); offset < AOP_SIZE(result); offset++) {
        picoBlaze_emitpcode (POC_MOVWF, picoBlaze_popGet (AOP(result), offset));
      } // for
    } else {
      // shift unsigned operand -- fill result with zeros
      for (offset=AOP_SIZE(left); offset < AOP_SIZE(result); offset++) {
        picoBlaze_emitpcode (POC_CLRF, picoBlaze_popGet (AOP(result), offset));
      } // for
    }
  } // if (size mismatch)

  picoBlaze_mov2w (AOP(right), 0);
  picoBlaze_emitpcode (POC_BZ, picoBlaze_popGetLabel (label_complete->key));
  if (signedCount) picoBlaze_emitpcode (POC_BN, picoBlaze_popGetLabel (label_negative->key));


  // perform a shift by one (shift count is positive)
  // cycles used for shifting {unsigned,signed} values on n bytes by [unsigned,signed] shift count c>0:
  // 2n+[2,3]+2+({0,2}+n+3)c-1+[0,2]=({3,5}+n)c+2n+[3,6]        ({4,6}c+[5,8] / {5,7}c+[7,10] / {7, 9}c+[11,14])
  // This variant is slower for 0<c<3, equally fast for c==3, and faster for 3<c.
//*//  picoBlaze_emitpcode (POC_NEGF, picoBlaze_popCopyReg (&picoBlaze_pc_wreg));
//*//  emitCLRC;
  picoBlaze_emitpLabel (label_loop_pos->key);
  if (sign && (pos_shift == POC_RRCF)) {
    picoBlaze_emitpcode (POC_BTFSC, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(result), AOP_SIZE(result)-1), 7));
//*//    emitSETC;
  } // if
  genMultiAsm (pos_shift, result, AOP_SIZE(result), pos_shift == POC_RRCF);
  //picoBlaze_emitpcode (POC_INCF, picoBlaze_popCopyReg (&picoBlaze_pc_wreg)); // gpsim does not like this...
  picoBlaze_emitpcode (POC_ADDLW, picoBlaze_popGetLit (0x01));
  picoBlaze_emitpcode (POC_BNC, picoBlaze_popGetLabel (label_loop_pos->key));

  if (signedCount) {
    picoBlaze_emitpcode (POC_BRA, picoBlaze_popGetLabel (label_complete->key));

    picoBlaze_emitpLabel (label_negative->key);
    // perform a shift by -1 (shift count is negative)
    // 2n+4+1+({0,2}+n+3)*c-1=({3,5}+n)c+2n+4                   ({4,6}c+6 / {5,7}c+8 / {7,9}c+12)
//*//    emitCLRC;
    picoBlaze_emitpLabel (label_loop_neg->key);
    if (sign && (neg_shift == POC_RRCF)) {
      picoBlaze_emitpcode (POC_BTFSC, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(result), AOP_SIZE(result)-1), 7));
//*//      emitSETC;
    } // if
    genMultiAsm (neg_shift, result, AOP_SIZE(result), neg_shift == POC_RRCF);
    //picoBlaze_emitpcode (POC_INCF, picoBlaze_popCopyReg (&picoBlaze_pc_wreg)); // gpsim does not like this...
    picoBlaze_emitpcode (POC_ADDLW, picoBlaze_popGetLit (0x01));
    picoBlaze_emitpcode (POC_BNC, picoBlaze_popGetLabel (label_loop_neg->key));
  } // if (signedCount)

  picoBlaze_emitpLabel (label_complete->key);

release:
  picoBlaze_freeAsmop (right,NULL,ic,TRUE);
  picoBlaze_freeAsmop(left,NULL,ic,TRUE);
  picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

static void genLeftShift (iCode *ic) {
  genGenericShift (ic, 1);
}

static void genRightShift (iCode *ic) {
  genGenericShift (ic, 0);
}


/* load FSR0 with address of/from op according to picoBlaze_isLitOp() or if lit is 1 */
void picoBlaze_loadFSR0(operand *op, int lit)
{
  if((IS_SYMOP(op) && OP_SYMBOL(op)->remat) || picoBlaze_isLitOp( op )) {
    if (AOP_TYPE(op) == AOP_LIT) {
      /* handle 12 bit integers correctly */
      unsigned int val = (unsigned int) ulFromVal (AOP(op)->aopu.aop_lit);
      if ((val & 0x0fff) != val) {
        fprintf (stderr, "WARNING: Accessing memory at 0x%x truncated to 0x%x.\n",
                val, (val & 0x0fff) );
        val &= 0x0fff;
      }
      picoBlaze_emitpcode(POC_LFSR, picoBlaze_popGetLit2(0, picoBlaze_popGetLit12(val)));
    } else {
      picoBlaze_emitpcode(POC_LFSR, picoBlaze_popGetLit2(0, picoBlaze_popGet(AOP(op), 0)));
    }
  } else {
    assert (!IS_SYMOP(op) || !OP_SYMBOL(op)->remat);
    // set up FSR0 with address of result
//*//    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popGet(AOP(op),0), picoBlaze_popCopyReg(&picoBlaze_pc_fsr0l)));
//*//    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popGet(AOP(op),1), picoBlaze_popCopyReg(&picoBlaze_pc_fsr0h)));
  }
}

/*----------------------------------------------------------------*/
/* picoBlaze_derefPtr - move one byte from the location ptr points to */
/*                  to WREG (doWrite == 0) or one byte from WREG   */
/*                  to the location ptr points to (doWrite != 0)   */
/*----------------------------------------------------------------*/
static void picoBlaze_derefPtr (operand *ptr, int p_type, int doWrite, int *fsr0_setup)
{
  if (!IS_PTR(operandType(ptr)))
  {
    if (doWrite) picoBlaze_emitpcode (POC_MOVWF, picoBlaze_popGet (AOP(ptr), 0));
    else picoBlaze_mov2w (AOP(ptr), 0);
    return;
  }

  //assert (IS_DECL(operandType(ptr)) && (p_type == DCL_TYPE(operandType(ptr))));
  /* We might determine pointer type right here: */
  p_type = DCL_TYPE(operandType(ptr));

  switch (p_type) {
    case POINTER:
    case FPOINTER:
    case IPOINTER:
    case PPOINTER:
      if (!fsr0_setup || !*fsr0_setup)
      {
        picoBlaze_loadFSR0( ptr, 0 );
        if (fsr0_setup) *fsr0_setup = 1;
      }
 //*//     if (doWrite)
//*//        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_indf0));
 //*//     else
//*//        picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(&picoBlaze_pc_indf0));
      break;

    case GPOINTER:
      if (AOP(ptr)->aopu.aop_reg[2]) {
//*//        if (doWrite) picoBlaze_emitpcode (POC_MOVWF, picoBlaze_popCopyReg(picoBlaze_stack_postdec));
        // prepare call to __gptrget1, this is actually genGenPointerGet(result, WREG, ?ic?)
//*//        mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_fsr0l), AOP(ptr), 0);
//*//        mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_prodl), AOP(ptr), 1);
        picoBlaze_mov2w(AOP(ptr), 2);
        picoBlaze_callGenericPointerRW(doWrite, 1);
      } else {
        // data pointer (just 2 byte given)
        if (!fsr0_setup || !*fsr0_setup)
        {
          picoBlaze_loadFSR0( ptr, 0 );
          if (fsr0_setup) *fsr0_setup = 1;
        }
//*//        if (doWrite)
//*//          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_indf0));
//*//        else
 //*//         picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(&picoBlaze_pc_indf0));
      }
      break;

    case CPOINTER:
      /* XXX: Writing to CPOINTERs not (yet) implemented. */
      assert ( !doWrite && "Cannot write into __code space!" );
      if( (AOP_TYPE(ptr) == AOP_PCODE)
              && ((0)
                  || (AOP(ptr)->aopu.pcop->type == PO_DIR)))
      {
          picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet     (AOP (ptr), 0));
//*//          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg (&picoBlaze_pc_tblptrl));
          picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet     (AOP (ptr), 1));
//*//          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg (&picoBlaze_pc_tblptrh));
          picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet     (AOP (ptr), 2));
//*//          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg (&picoBlaze_pc_tblptru));
      } else {
//*//          mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_tblptrl), AOP(ptr), 0);
//*//          mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_tblptrh), AOP(ptr), 1);
//*//          mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_tblptru), AOP(ptr), 2);
      } // if

      picoBlaze_emitpcodeNULLop (POC_TBLRD_POSTINC);
//*//      picoBlaze_emitpcode (POC_MOVFW, picoBlaze_popCopyReg (&picoBlaze_pc_tablat));
      break;

    default:
      assert (0 && "invalid pointer type specified");
      break;
  }
}

/*-----------------------------------------------------------------*/
/* genUnpackBits - generates code for unpacking bits               */
/*-----------------------------------------------------------------*/
static void genUnpackBits (operand *result, operand *left, char *rname, int ptype)
{
  int shCnt ;
  sym_link *etype, *letype;
  int blen=0, bstr=0;
  int lbstr;
  int same;
  pCodeOp *op;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  etype = getSpec(operandType(result));
  letype = getSpec(operandType(left));

  //    if(IS_BITFIELD(etype)) {
  blen = SPEC_BLEN(etype);
  bstr = SPEC_BSTR(etype);
  //    }

  lbstr = SPEC_BSTR( letype );

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d - reading %s bitfield int %s destination",__FUNCTION__,__LINE__,
      SPEC_USIGN(OP_SYM_ETYPE(left)) ? "an unsigned" : "a signed", SPEC_USIGN(OP_SYM_TYPE(result)) ? "an unsigned" : "a signed");

#if 1
  if((blen == 1) && (bstr < 8)
      && (!IS_PTR(operandType(left)) || IS_DIRECT(left) || PIC_IS_DATA_PTR(operandType(left)))) {
    /* it is a single bit, so use the appropriate bit instructions */
    DEBUGpicoBlaze_emitcode (";","%s %d optimize bit read",__FUNCTION__,__LINE__);

    same = picoBlaze_sameRegs(AOP(left),AOP(result));
//*//    op = (same ? picoBlaze_popCopyReg(&picoBlaze_pc_wreg) : picoBlaze_popGet (AOP(result),0));
//*//    picoBlaze_emitpcode(POC_CLRF, op);

    if(!IS_PTR(operandType(left)) || IS_DIRECT(left)) {
      /* workaround to reduce the extra lfsr instruction */
      picoBlaze_emitpcode(POC_BTFSC,
          picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(left), 0), bstr));
    } else {
      assert (PIC_IS_DATA_PTR (operandType(left)));
      picoBlaze_loadFSR0 (left, 0);
 //*//     picoBlaze_emitpcode(POC_BTFSC,
 //*//         picoBlaze_popCopyGPR2Bit(picoBlaze_popCopyReg(&picoBlaze_pc_indf0), bstr));
    }

    if (SPEC_USIGN(OP_SYM_ETYPE(left))) {
      /* unsigned bitfields result in either 0 or 1 */
//*//      picoBlaze_emitpcode(POC_INCF, op);
    } else {
      /* signed bitfields result in either 0 or -1 */
//*//      picoBlaze_emitpcode(POC_DECF, op);
    }
    if (same) {
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet( AOP(result), 0 ));
    }

    picoBlaze_addSign (result, 1, !SPEC_USIGN(OP_SYM_TYPE(result)));
    return;
  }

#endif

  if (!IS_PTR(operandType(left)) || IS_DIRECT(left)) {
    // access symbol directly
    picoBlaze_mov2w (AOP(left), 0);
  } else {
    picoBlaze_derefPtr (left, ptype, 0, NULL);
  }

  /* if we have bitdisplacement then it fits   */
  /* into this byte completely or if length is */
  /* less than a byte                          */
  if ((shCnt = SPEC_BSTR(etype)) || (SPEC_BLEN(etype) <= 8))  {

    /* shift right acc */
    AccRsh(shCnt, 0);

    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(
          (((unsigned char) -1)>>(8 - SPEC_BLEN(etype))) & SRMask[ shCnt ]));

    /* VR -- normally I would use the following, but since we use the hack,
     * to avoid the masking from AccRsh, why not mask it right now? */

    /*
       picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(((unsigned char) -1)>>(8 - SPEC_BLEN(etype))));
     */

    /* extend signed bitfields to 8 bits */
    if (!SPEC_USIGN(OP_SYM_ETYPE(left)) && (bstr + blen < 8))
    {
      assert (blen + bstr > 0);
//*//      picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popCopyGPR2Bit(picoBlaze_popCopyReg(&picoBlaze_pc_wreg), bstr + blen - 1));
      picoBlaze_emitpcode(POC_IORLW, picoBlaze_popGetLit(0xFF << (bstr + blen)));
    }

    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), 0));

    picoBlaze_addSign (result, 1, !SPEC_USIGN(OP_SYM_TYPE(result)));
    return ;
  }

  fprintf(stderr, "SDCC picoBlaze port error: the port currently does not support *reading*\n");
  fprintf(stderr, "bitfields of size >=8. Instead of generating wrong code, bailling out...\n");
  exit(EXIT_FAILURE);

  return ;
}


static void genDataPointerGet(operand *left, operand *result, iCode *ic)
{
  int size, offset = 0, leoffset=0 ;

        DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
        picoBlaze_aopOp(result, ic, TRUE);

        FENTRY;

        size = AOP_SIZE(result);
//      fprintf(stderr, "%s:%d size= %d\n", __FILE__, __LINE__, size);


#if 1
        if(!strcmp(picoBlaze_aopGet(AOP(result), 0, TRUE, FALSE),
                picoBlaze_aopGet(AOP(left), 0, TRUE, FALSE))) {
                DEBUGpicoBlaze_emitcode("; ***", "left and result names are same, skipping moving");
                goto release;
        }
#endif

        if(AOP(left)->aopu.pcop->type == PO_DIR)
                leoffset=PCOR(AOP(left)->aopu.pcop)->instance;

        DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,NULL,result);

        while (size--) {
                DEBUGpicoBlaze_emitcode("; ***", "%s loop offset=%d leoffset=%d", __FUNCTION__, offset, leoffset);

//              picoBlaze_DumpOp("(result)",result);
                if(picoBlaze_isLitAop(AOP(result))) {
                        picoBlaze_mov2w(AOP(left), offset); // patch 8
                        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offset));
                } else {
                        picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(
                                picoBlaze_popGet(AOP(left), offset), //patch 8
                                picoBlaze_popGet(AOP(result), offset)));
                }

                offset++;
                leoffset++;
        }

release:
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}



/*-----------------------------------------------------------------*/
/* genNearPointerGet - picoBlaze_emitcode for near pointer fetch             */
/*-----------------------------------------------------------------*/
static void genNearPointerGet (operand *left,
                               operand *result,
                               iCode *ic)
{
//  asmop *aop = NULL;
  //regs *preg = NULL ;
  sym_link *rtype, *retype;
  sym_link *ltype, *letype;

    FENTRY;

    rtype = operandType(result);
    retype= getSpec(rtype);
    ltype = operandType(left);
    letype= getSpec(ltype);

    picoBlaze_aopOp(left,ic,FALSE);

//    picoBlaze_DumpOp("(left)",left);
//    picoBlaze_DumpOp("(result)",result);

    /* if left is rematerialisable and
     * result is not bit variable type and
     * the left is pointer to data space i.e
     * lower 128 bytes of space */

    if (AOP_TYPE(left) == AOP_PCODE
      && !IS_BITFIELD(retype)
      && DCL_TYPE(ltype) == POINTER) {

        genDataPointerGet (left,result,ic);
        picoBlaze_freeAsmop(left, NULL, ic, TRUE);
        return ;
    }

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    picoBlaze_aopOp (result,ic,TRUE);

    DEBUGpicoBlaze_picoBlaze_AopType(__LINE__, left, NULL, result);

#if 1
    if(IS_BITFIELD( retype )
      && (SPEC_BLEN(operandType(result))==1)
    ) {
      iCode *nextic;
      pCodeOp *jop;
      int bitstrt, bytestrt;

        /* if this is bitfield of size 1, see if we are checking the value
         * of a single bit in an if-statement,
         * if yes, then don't generate usual code, but execute the
         * genIfx directly -- VR */

        nextic = ic->next;

        /* CHECK: if next iCode is IFX
         * and current result operand is nextic's conditional operand
         * and current result operand live ranges ends at nextic's key number
         */
        if((nextic->op == IFX)
          && (result == IC_COND(nextic))
          && (OP_LIVETO(result) == nextic->seq)
          && (OP_SYMBOL(left)->remat)   // below fails for "if (p->bitfield)"
          ) {
            /* everything is ok then */
            /* find a way to optimize the genIfx iCode */

            bytestrt = SPEC_BSTR(operandType(result))/8;
            bitstrt = SPEC_BSTR(operandType(result))%8;

            jop = picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(left), 0), bitstrt);

            genIfxpCOpJump(nextic, jop);

            picoBlaze_freeAsmop(left, NULL, ic, TRUE);
            picoBlaze_freeAsmop(result, NULL, ic, TRUE);
            return;
        }
    }
#endif

    /* if bitfield then unpack the bits */
    if (IS_BITFIELD(letype))
      genUnpackBits (result, left, NULL, POINTER);
    else {
      /* we have can just get the values */
      int size = AOP_SIZE(result);
      int offset = 0;

      DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

      picoBlaze_loadFSR0( left, 0 );

      while(size--) {
        if(size) {
//*//          picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(&picoBlaze_pc_postinc0),
//*//                picoBlaze_popGet(AOP(result), offset++)));
        } else {
//*//          picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(&picoBlaze_pc_indf0),
//*//                picoBlaze_popGet(AOP(result), offset++)));
        }
      }
    }

    /* done */
    picoBlaze_freeAsmop(left,NULL,ic,TRUE);
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genGenPointerGet - gget value from generic pointer space        */
/*-----------------------------------------------------------------*/
static void genGenPointerGet (operand *left,
                              operand *result, iCode *ic)
{
  int size;
  sym_link *letype = getSpec(operandType(left));

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  picoBlaze_aopOp(left,ic,FALSE);
  picoBlaze_aopOp(result,ic,TRUE);
  size = AOP_SIZE(result);

  DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,NULL,result);

  /* if bit then unpack */
  if (IS_BITFIELD(letype)) {
    genUnpackBits(result,left,"BAD",GPOINTER);
    goto release;
  }

  /* set up WREG:PRODL:FSR0L with address from left */
//*//  mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_fsr0l), AOP(left), 0);
//*//  mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_prodl), AOP(left), 1);
  picoBlaze_mov2w(AOP(left), 2);
  picoBlaze_callGenericPointerRW(0, size);

  assignResultValue(result, size, 1);

release:
  picoBlaze_freeAsmop(left,NULL,ic,TRUE);
  picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genConstPointerGet - get value from const generic pointer space */
/*-----------------------------------------------------------------*/
static void genConstPointerGet (operand *left,
                                operand *result, iCode *ic)
{
  //sym_link *retype = getSpec(operandType(result));
  // symbol *albl = newiTempLabel(NULL);        // patch 15
  // symbol *blbl = newiTempLabel(NULL);        //
  // PIC_OPCODE poc;                            // patch 15
  int size;
  int offset = 0;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  picoBlaze_aopOp(left,ic,FALSE);
  picoBlaze_aopOp(result,ic,TRUE);
  size = AOP_SIZE(result);

  /* if bit then unpack */
  if (IS_BITFIELD(getSpec (operandType (left)))) {
    genUnpackBits(result,left,"BAD",GPOINTER);
    goto release;
  } // if

  DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,left,NULL,result);

  DEBUGpicoBlaze_emitcode ("; "," %d getting const pointer",__LINE__);

  // set up table pointer
  if( (AOP_TYPE(left) == AOP_PCODE)
      && ((0)
          || (AOP(left)->aopu.pcop->type == PO_DIR)))
    {
      picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGet(AOP(left),0));
//*//      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popCopyReg(&picoBlaze_pc_tblptrl));
      picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGet(AOP(left),1));
//*//      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popCopyReg(&picoBlaze_pc_tblptrh));
      picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGet(AOP(left),2));
//*//      picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popCopyReg(&picoBlaze_pc_tblptru));
  } else {
//*//    mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_tblptrl), AOP(left), 0);
//*//    mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_tblptrh), AOP(left), 1);
//**    mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_tblptru), AOP(left), 2);
  }

  while(size--) {
    picoBlaze_emitpcodeNULLop(POC_TBLRD_POSTINC);
//*//    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(&picoBlaze_pc_tablat), picoBlaze_popGet(AOP(result),offset)));
    offset++;
  }

release:
  picoBlaze_freeAsmop(left,NULL,ic,TRUE);
  picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}


/*-----------------------------------------------------------------*/
/* genPointerGet - generate code for pointer get                   */
/*-----------------------------------------------------------------*/
static void genPointerGet (iCode *ic)
{
  operand *left, *result ;
  sym_link *type, *etype;
  int p_type;

    FENTRY;

    left = IC_LEFT(ic);
    result = IC_RESULT(ic) ;

    /* depending on the type of pointer we need to
    move it to the correct pointer register */
    type = operandType(left);
    etype = getSpec(type);

    if (IS_CODEPTR(type))

      DEBUGpicoBlaze_emitcode ("; ***","%d - const pointer",__LINE__);

    /* if left is of type of pointer then it is simple */
    if (IS_PTR(type) && !IS_FUNC(type->next))
      p_type = DCL_TYPE(type);
    else {
      /* we have to go by the storage class */
      p_type = PTR_TYPE(SPEC_OCLS(etype));

      DEBUGpicoBlaze_emitcode ("; ***","%d - resolve pointer by storage class",__LINE__);

      if (SPEC_OCLS(etype)->codesp ) {
        DEBUGpicoBlaze_emitcode ("; ***","%d - cpointer",__LINE__);
        //p_type = CPOINTER ;
      } else
      if (SPEC_OCLS(etype)->fmap && !SPEC_OCLS(etype)->paged) {
        DEBUGpicoBlaze_emitcode ("; ***","%d - fpointer",__LINE__);
        /*p_type = FPOINTER ;*/
      } else
      if (SPEC_OCLS(etype)->fmap && SPEC_OCLS(etype)->paged) {
        DEBUGpicoBlaze_emitcode ("; ***","%d - ppointer",__LINE__);
        /* p_type = PPOINTER; */
      } else
      if (SPEC_OCLS(etype) == idata ) {
        DEBUGpicoBlaze_emitcode ("; ***","%d - ipointer",__LINE__);
        /* p_type = IPOINTER; */
      } else {
        DEBUGpicoBlaze_emitcode ("; ***","%d - pointer",__LINE__);
        /* p_type = POINTER ; */
      }
    }

    /* now that we have the pointer type we assign
    the pointer values */
    switch (p_type) {
      case POINTER:
      case FPOINTER:
      case IPOINTER:
      case PPOINTER:
        genNearPointerGet (left,result,ic);
        break;

      case CPOINTER:
        genConstPointerGet (left,result,ic);
        //picoBlaze_emitcodePointerGet (left,result,ic);
        break;

      case GPOINTER:

        genGenPointerGet (left,result,ic);
      break;

    default:
      werror (E_INTERNAL_ERROR, __FILE__, __LINE__,
              "genPointerGet: illegal pointer type");

    }
}

/*-----------------------------------------------------------------*/
/* genPackBits - generates code for packed bit storage             */
/*-----------------------------------------------------------------*/
static void genPackBits (sym_link    *etype , operand *result,
                         operand *right ,
                         char *rname, int p_type)
{
  int shCnt = 0 ;
  int offset = 0  ;
  int rLen = 0 ;
  int blen, bstr ;
  int shifted_and_masked = 0;
  unsigned long lit = (unsigned long)-1;
  sym_link *retype;

  DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
  blen = SPEC_BLEN(etype);
  bstr = SPEC_BSTR(etype);

  retype = getSpec(operandType(right));

  if(AOP_TYPE(right) == AOP_LIT) {
    lit = ulFromVal (AOP(right)->aopu.aop_lit);

    if((blen == 1) && (bstr < 8)) {
      /* it is a single bit, so use the appropriate bit instructions */

      DEBUGpicoBlaze_emitcode (";","%s %d optimize bit assignment",__FUNCTION__,__LINE__);

      if(!IS_PTR(operandType(result)) || IS_DIRECT(result)) {
        /* workaround to reduce the extra lfsr instruction */
        if(lit) {
          picoBlaze_emitpcode(POC_BSF,
              picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(result), 0), bstr));
        } else {
          picoBlaze_emitpcode(POC_BCF,
              picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(result), 0), bstr));
        }
      } else {
        if (PIC_IS_DATA_PTR(operandType(result))) {
          picoBlaze_loadFSR0(result, 0);
//*//          picoBlaze_emitpcode(lit ? POC_BSF : POC_BCF,
//*//              picoBlaze_popCopyGPR2Bit(picoBlaze_popCopyReg(&picoBlaze_pc_indf0), bstr));
        } else {
          /* get old value */
          picoBlaze_derefPtr (result, p_type, 0, NULL);
//*//          picoBlaze_emitpcode(lit ? POC_BSF : POC_BCF,
//*//              picoBlaze_popCopyGPR2Bit(picoBlaze_popCopyReg(&picoBlaze_pc_wreg), bstr));
          /* write back new value */
          picoBlaze_derefPtr (result, p_type, 1, NULL);
        }
      }

      return;
    }
    /* IORLW below is more efficient */
    //picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGetLit((lit & ((1UL << blen) - 1)) << bstr));
    lit = (lit & ((1UL << blen) - 1)) << bstr;
    shifted_and_masked = 1;
    offset++;
  } else
    if (IS_DIRECT(result) && !IS_PTR(operandType(result))
        && IS_BITFIELD(retype)
        && (AOP_TYPE(right) == AOP_REG || AOP_TYPE(right) == AOP_DIR)
        && (blen == 1)) {
      int rblen, rbstr;

      rblen = SPEC_BLEN( retype );
      rbstr = SPEC_BSTR( retype );

      if(IS_BITFIELD(etype)) {
        picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(result), 0));
//*//        picoBlaze_emitpcode(POC_BCF, picoBlaze_popCopyGPR2Bit(picoBlaze_popCopyReg(&picoBlaze_pc_wreg), bstr));
      } else {
//*//        picoBlaze_emitpcode(POC_CLRF, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
      }

      picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popCopyGPR2Bit(picoBlaze_popGet(AOP(right), 0), rbstr));

      if(IS_BITFIELD(etype)) {
//*//        picoBlaze_emitpcode(POC_BSF, picoBlaze_popCopyGPR2Bit(picoBlaze_popCopyReg(&picoBlaze_pc_wreg), bstr));
      } else {
//*//        picoBlaze_emitpcode(POC_INCF, picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
      }

      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet( AOP(result), 0));

      return;
    } else {
      /* move right to W */
      picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(right), offset++));
    }

  /* if the bit length is less than or   */
  /* it exactly fits a byte then         */
  if((shCnt=SPEC_BSTR(etype))
      || SPEC_BLEN(etype) <= 8 )  {
    int fsr0_setup = 0;

    if (blen != 8 || (bstr % 8) != 0) {
      // we need to combine the value with the old value
      if(!shifted_and_masked)
      {
        picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit((1U << blen)-1));

        DEBUGpicoBlaze_emitcode(";", "shCnt = %d SPEC_BSTR(etype) = %d:%d", shCnt,
            SPEC_BSTR(etype), SPEC_BLEN(etype));

        /* shift left acc, do NOT mask the result again */
        AccLsh(shCnt, 0);

        /* using PRODH as a temporary register here */
//*//        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_prodh));
      }

      if ((IS_SYMOP(result) && !IS_PTR(operandType (result)))
        || IS_DIRECT(result)) {
        /* access symbol directly */
        picoBlaze_mov2w (AOP(result), 0);
      } else {
        /* get old value */
        picoBlaze_derefPtr (result, p_type, 0, &fsr0_setup);
      }
#if 1
      picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit(
            (unsigned char)((unsigned char)(0xff << (blen+bstr)) |
                            (unsigned char)(0xff >> (8-bstr))) ));
      if (!shifted_and_masked) {
//*//        picoBlaze_emitpcode(POC_IORFW, picoBlaze_popCopyReg(&picoBlaze_pc_prodh));
      } else {
        /* We have the shifted and masked (literal) right value in `lit' */
        if (lit != 0)
          picoBlaze_emitpcode(POC_IORLW, picoBlaze_popGetLit(lit));
      }
    } else { // if (blen == 8 && (bstr % 8) == 0)
        if (shifted_and_masked) {
            // move right (literal) to WREG (only case where right is not yet in WREG)
            picoBlaze_mov2w(AOP(right), (bstr / 8));
        }
    }

    /* write new value back */
    if ((IS_SYMOP(result) && !IS_PTR(operandType(result)))
        || IS_DIRECT(result)) {
      picoBlaze_emitpcode (POC_MOVWF, picoBlaze_popGet(AOP(result),0));
    } else {
      picoBlaze_derefPtr (result, p_type, 1, &fsr0_setup);
    }
#endif

    return;
  }


  picoBlaze_loadFSR0(result, 0);                    // load FSR0 with address of result
  rLen = SPEC_BLEN(etype)-8;

  /* now generate for lengths greater than one byte */
  while (1) {
    rLen -= 8 ;
    if (rLen <= 0 ) {
//*//      mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_prodh), AOP(right), offset);
      break ;
    }

    switch (p_type) {
      case POINTER:
//*//        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_postinc0));
        break;

        /*
           case FPOINTER:
           MOVA(l);
           picoBlaze_emitcode("movx","@dptr,a");
           break;

           case GPOINTER:
           MOVA(l);
           DEBUGpicoBlaze_emitcode(";lcall","__gptrput");
           break;
         */
      default:
        assert(0);
    }


    picoBlaze_mov2w(AOP(right), offset++);
  }

  /* last last was not complete */
  if (rLen)   {
    /* save the byte & read byte */
    switch (p_type) {
      case POINTER:
        //                picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_prodl));
//*//        picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popCopyReg(&picoBlaze_pc_indf0));
        break;

        /*
           case FPOINTER:
           picoBlaze_emitcode ("mov","b,a");
           picoBlaze_emitcode("movx","a,@dptr");
           break;

           case GPOINTER:
           picoBlaze_emitcode ("push","b");
           picoBlaze_emitcode ("push","acc");
           picoBlaze_emitcode ("lcall","__gptrget");
           picoBlaze_emitcode ("pop","b");
           break;
         */
      default:
        assert(0);
    }
    DEBUGpicoBlaze_emitcode(";", "rLen = %i", rLen);
    picoBlaze_emitpcode(POC_ANDLW, picoBlaze_popGetLit((unsigned char)-1 << -rLen));
//*//    picoBlaze_emitpcode(POC_IORFW, picoBlaze_popCopyReg(&picoBlaze_pc_prodh));
    //        picoBlaze_emitcode ("anl","a,#0x%02x",((unsigned char)-1 << -rLen) );
    //        picoBlaze_emitcode ("orl","a,b");
  }

  //    if (p_type == GPOINTER)
  //        picoBlaze_emitcode("pop","b");

  switch (p_type) {

    case POINTER:
//*//      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popCopyReg(&picoBlaze_pc_indf0));
      //        picoBlaze_emitcode("mov","@%s,a",rname);
      break;
      /*
         case FPOINTER:
         picoBlaze_emitcode("movx","@dptr,a");
         break;

         case GPOINTER:
         DEBUGpicoBlaze_emitcode(";lcall","__gptrput");
         break;
       */
    default:
      assert(0);
  }

  //    picoBlaze_freeAsmop(right, NULL, ic, TRUE);
}

/*-----------------------------------------------------------------*/
/* genDataPointerSet - remat pointer to data space                 */
/*-----------------------------------------------------------------*/
static void genDataPointerSet(operand *right,
                              operand *result,
                              iCode *ic)
{
  int size, offset = 0, resoffset=0 ;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    picoBlaze_aopOp(right,ic,FALSE);

    size = AOP_SIZE(right);

//      fprintf(stderr, "%s:%d size= %d\n", __FILE__, __LINE__, size);


    if(AOP(result)->aopu.pcop->type == PO_DIR)
      resoffset=PCOR(AOP(result)->aopu.pcop)->instance;

    while (size--) {
      if (AOP_TYPE(right) == AOP_LIT) {
        unsigned int lit = picoBlazeaopLiteral(AOP(IC_RIGHT(ic))->aopu.aop_lit, offset);
        picoBlaze_movLit2f(picoBlaze_popGet(AOP(result), offset), lit);
      } else {
        picoBlaze_mov2w(AOP(right), offset);
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offset)); // patch 8
      }
      offset++;
      resoffset++;
    }

    picoBlaze_freeAsmop(right,NULL,ic,TRUE);
}



/*-----------------------------------------------------------------*/
/* genNearPointerSet - picoBlaze_emitcode for near pointer put         */
/*-----------------------------------------------------------------*/
static void genNearPointerSet (operand *right,
                               operand *result,
                               iCode *ic)
{
  asmop *aop = NULL;
  sym_link *retype;
  sym_link *ptype = operandType(result);
  sym_link *resetype;

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    retype= getSpec(operandType(right));
    resetype = getSpec(operandType(result));

    picoBlaze_aopOp(result,ic,FALSE);

    /* if the result is rematerializable &
     * in data space & not a bit variable */

    /* and result is not a bit variable */
    if (AOP_TYPE(result) == AOP_PCODE
      && DCL_TYPE(ptype) == POINTER
      && !IS_BITFIELD(retype)
      && !IS_BITFIELD(resetype)) {

        genDataPointerSet (right,result,ic);
        picoBlaze_freeAsmop(result,NULL,ic,TRUE);
      return;
    }

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    picoBlaze_aopOp(right,ic,FALSE);
    DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,NULL,right,result);

    /* if bitfield then unpack the bits */
    if (IS_BITFIELD(resetype)) {
      genPackBits (resetype, result, right, NULL, POINTER);
    } else {
      /* we have can just get the values */
      int size = AOP_SIZE(right);
      int offset = 0 ;

        picoBlaze_loadFSR0(result, 0);

        DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
        while (size--) {
          if (picoBlaze_isLitOp(right)) {
            picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(right),offset));
            if (size) {
//*//              picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popCopyReg(&picoBlaze_pc_postinc0));
            } else {
//*//              picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popCopyReg(&picoBlaze_pc_indf0));
            }
          } else { // no literal
            if(size) {
//*//              picoBlaze_emitpcode(POC_MOVFF,
//*//                  picoBlaze_popGet2p(picoBlaze_popGet(AOP(right),offset),
//*//                  picoBlaze_popCopyReg(&picoBlaze_pc_postinc0)));
            } else {
//*//              picoBlaze_emitpcode(POC_MOVFF,
//*//                  picoBlaze_popGet2p(picoBlaze_popGet(AOP(right),offset),
//*//                  picoBlaze_popCopyReg(&picoBlaze_pc_indf0)));
            }
          }

          offset++;
        }
    }

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    /* now some housekeeping stuff */
    if (aop) {
      /* we had to allocate for this iCode */
      picoBlaze_freeAsmop(NULL,aop,ic,TRUE);
    } else {
      /* we did not allocate which means left
       * already in a pointer register, then
       * if size > 0 && this could be used again
       * we have to point it back to where it
       * belongs */
      DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
      if (AOP_SIZE(right) > 1
        && !OP_SYMBOL(result)->remat
        && ( OP_SYMBOL(result)->liveTo > ic->seq
        || ic->depth )) {

          int size = AOP_SIZE(right) - 1;

            while (size--)
              picoBlaze_emitcode("decf","fsr0,f");
              //picoBlaze_emitcode("dec","%s",rname);
      }
    }

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);
    /* done */
//release:
    picoBlaze_freeAsmop(right,NULL,ic,TRUE);
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genGenPointerSet - set value from generic pointer space         */
/*-----------------------------------------------------------------*/
static void genGenPointerSet (operand *right,
                              operand *result, iCode *ic)
{
  int size;
  sym_link *retype = getSpec(operandType(result));

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    picoBlaze_aopOp(result,ic,FALSE);
    picoBlaze_aopOp(right,ic,FALSE);
    size = AOP_SIZE(right);

    DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,NULL,right,result);


    /* if bit then unpack */
    if (IS_BITFIELD(retype)) {
//      picoBlaze_emitpcode(POC_LFSR,picoBlaze_popGetLit2(0,picoBlaze_popGetLit(lit)));
      genPackBits(retype,result,right,"dptr",GPOINTER);
      goto release;
    }

    size = AOP_SIZE(right);

    DEBUGpicoBlaze_emitcode ("; ***","%s  %d size=%d",__FUNCTION__,__LINE__,size);


    /* load value to write in TBLPTRH:TBLPTRL:PRODH:[stack] */

    /* value of right+0 is placed on stack, which will be retrieved
     * by the support function thus restoring the stack. The important
     * thing is that there is no need to manually restore stack pointer
     * here */
    picoBlaze_pushaop(AOP(right), 0);
//    mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_postdec1), AOP(right), 0);
//*//    if(size>1)mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_prodh), AOP(right), 1);
//*//    if(size>2)mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_tblptrl), AOP(right), 2);
//*//    if(size>3)mov2fp(picoBlaze_popCopyReg(&picoBlaze_pc_tblptrh), AOP(right), 3);

    /* load address to write to in WREG:FSR0H:FSR0L */
//*//    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popGet(AOP(result), 0),
//*//                                picoBlaze_popCopyReg(&picoBlaze_pc_fsr0l)));
//*//    picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popGet(AOP(result), 1),
//*//                                picoBlaze_popCopyReg(&picoBlaze_pc_prodl)));
    picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(result), 2));

    picoBlaze_callGenericPointerRW(1, size);

release:
    picoBlaze_freeAsmop(right,NULL,ic,TRUE);
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genPointerSet - stores the value into a pointer location        */
/*-----------------------------------------------------------------*/
static void genPointerSet (iCode *ic)
{
  operand *right, *result ;
  sym_link *type, *etype;
  int p_type;

    FENTRY;

    right = IC_RIGHT(ic);
    result = IC_RESULT(ic) ;

    /* depending on the type of pointer we need to
    move it to the correct pointer register */
    type = operandType(result);
    etype = getSpec(type);

    /* if left is of type of pointer then it is simple */
    if (IS_PTR(type) && !IS_FUNC(type->next)) {
        p_type = DCL_TYPE(type);
    }
    else {
        /* we have to go by the storage class */
        p_type = PTR_TYPE(SPEC_OCLS(etype));

/*      if (SPEC_OCLS(etype)->codesp ) { */
/*          p_type = CPOINTER ;  */
/*      } */
/*      else */
/*          if (SPEC_OCLS(etype)->fmap && !SPEC_OCLS(etype)->paged) */
/*              p_type = FPOINTER ; */
/*          else */
/*              if (SPEC_OCLS(etype)->fmap && SPEC_OCLS(etype)->paged) */
/*                  p_type = PPOINTER ; */
/*              else */
/*                  if (SPEC_OCLS(etype) == idata ) */
/*                      p_type = IPOINTER ; */
/*                  else */
/*                      p_type = POINTER ; */
    }

    /* now that we have the pointer type we assign
    the pointer values */
    switch (p_type) {
      case POINTER:
      case FPOINTER:
      case IPOINTER:
      case PPOINTER:
        genNearPointerSet (right,result,ic);
        break;

      case GPOINTER:
        genGenPointerSet (right,result,ic);
        break;

      default:
        werror (E_INTERNAL_ERROR, __FILE__, __LINE__,
          "genPointerSet: illegal pointer type");
    }
}

/*-----------------------------------------------------------------*/
/* genIfx - generate code for Ifx statement                        */
/*-----------------------------------------------------------------*/
static void genIfx (iCode *ic, iCode *popIc)
{
  operand *cond = IC_COND(ic);
  int isbit =0;

    FENTRY;

    picoBlaze_aopOp(cond,ic,FALSE);

    /* get the value into acc */
    if (AOP_TYPE(cond) != AOP_CRY)
      picoBlaze_toBoolean(cond);
    else
      isbit = 1;
    /* the result is now in the accumulator */
    picoBlaze_freeAsmop(cond,NULL,ic,TRUE);

    /* if there was something to be popped then do it */
    if (popIc)
      genIpop(popIc);

    /* if the condition is  a bit variable */
    if (isbit && IS_ITEMP(cond) &&
        SPIL_LOC(cond)) {
      genIfxJump(ic,"c");
      DEBUGpicoBlaze_emitcode ("; isbit  SPIL_LOC","%s",SPIL_LOC(cond)->rname);
    } else {
      if (isbit && !IS_ITEMP(cond))
        genIfxJump(ic,OP_SYMBOL(cond)->rname);
        else
        genIfxJump(ic,"a");
    }
    ic->generated = 1;
}

/*-----------------------------------------------------------------*/
/* genAddrOf - generates code for address of                       */
/*-----------------------------------------------------------------*/
static void genAddrOf (iCode *ic)
{
  operand *result, *left;
  int size;
  symbol *sym;  // = OP_SYMBOL(IC_LEFT(ic));
  pCodeOp *pcop0, *pcop1, *pcop2;

    FENTRY;

    picoBlaze_aopOp((result=IC_RESULT(ic)),ic,TRUE);

    sym = OP_SYMBOL( IC_LEFT(ic) );

    if(sym->onStack) {
      /* get address of symbol on stack */
      DEBUGpicoBlaze_emitcode(";    ", "%s symbol %s on stack", __FUNCTION__, sym->name);



      // operands on stack are accessible via "FSR2 + index" with index
      // starting at 2 for arguments and growing from 0 downwards for
      // local variables (index == 0 is not assigned so we add one here)
      {
        int soffs = OP_SYMBOL( IC_LEFT(ic))->stack;

          if (soffs <= 0) {
            assert (soffs < 0);
            soffs++;
          } // if

          DEBUGpicoBlaze_emitcode("*!*", "accessing stack symbol at offset=%d", soffs);
          picoBlaze_emitpcode(POC_MOVLW , picoBlaze_popGetLit( soffs & 0x00FF ));
//*//          picoBlaze_emitpcode(POC_ADDFW , picoBlaze_popCopyReg(picoBlaze_framepnt_lo));
          picoBlaze_emitpcode(POC_MOVWF , picoBlaze_popGet(AOP(result), 0));
          picoBlaze_emitpcode(POC_MOVLW , picoBlaze_popGetLit( (soffs >> 8) & 0x00FF ));
//*//          picoBlaze_emitpcode(POC_ADDFWC, picoBlaze_popCopyReg(picoBlaze_framepnt_hi));
          picoBlaze_emitpcode(POC_MOVWF , picoBlaze_popGet(AOP(result), 1));
      }

      goto release;
    }

//      if(picoBlaze_debug_verbose) {
//              fprintf(stderr, "%s:%d %s symbol %s , codespace=%d\n",
//                      __FILE__, __LINE__, __FUNCTION__, sym->name, IN_CODESPACE( SPEC_OCLS(sym->etype)));
//      }

    picoBlaze_aopOp((left=IC_LEFT(ic)), ic, FALSE);
    size = AOP_SIZE(IC_RESULT(ic));

    pcop0 = PCOP(picoBlaze_newpCodeOpImmd(sym->rname, 0, 0, IN_CODESPACE( SPEC_OCLS(sym->etype))));
    pcop1 = PCOP(picoBlaze_newpCodeOpImmd(sym->rname, 1, 0, IN_CODESPACE( SPEC_OCLS(sym->etype))));
    pcop2 = PCOP(picoBlaze_newpCodeOpImmd(sym->rname, 2, 0, IN_CODESPACE( SPEC_OCLS(sym->etype))));

    if (size == 3) {
      picoBlaze_emitpcode(POC_MOVLW, pcop0);
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), 0));
      picoBlaze_emitpcode(POC_MOVLW, pcop1);
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), 1));
      picoBlaze_emitpcode(POC_MOVLW, pcop2);
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), 2));
    } else
    if (size == 2) {
      picoBlaze_emitpcode(POC_MOVLW, pcop0);
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0));
      picoBlaze_emitpcode(POC_MOVLW, pcop1);
    picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),1));
    } else {
      picoBlaze_emitpcode(POC_MOVLW, pcop0);
      picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0));
    }

    picoBlaze_freeAsmop(left, NULL, ic, FALSE);
release:
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);
}


/*-----------------------------------------------------------------*/
/* genAssign - generate code for assignment                        */
/*-----------------------------------------------------------------*/
static void genAssign (iCode *ic)
{
  operand *result, *right;
  sym_link *restype, *rtype;
  int size, offset,know_W;
  unsigned long lit = 0L;

    result = IC_RESULT(ic);
    right  = IC_RIGHT(ic) ;

    FENTRY;

    /* if they are the same */
    if (operandsEqu (IC_RESULT(ic),IC_RIGHT(ic)))
      return ;

    /* reversed order operands are aopOp'ed so that result operand
     * is effective in case right is a stack symbol. This maneauver
     * allows to use the _G.resDirect flag later */
     picoBlaze_aopOp(result,ic,TRUE);
    picoBlaze_aopOp(right,ic,FALSE);

    DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,NULL,right,result);

    /* if they are the same registers */
    if (picoBlaze_sameRegs(AOP(right),AOP(result)))
      goto release;

    /* if the result is a bit */
    if (AOP_TYPE(result) == AOP_CRY) {
      /* if the right size is a literal then
         we know what the value is */
      if (AOP_TYPE(right) == AOP_LIT) {

        picoBlaze_emitpcode(  ( ((int) operandLitValue(right)) ? POC_BSF : POC_BCF),
            picoBlaze_popGet(AOP(result),0));

        if (((int) operandLitValue(right)))
          picoBlaze_emitcode("bsf","(%s >> 3),(%s & 7)",
              AOP(result)->aopu.aop_dir,
              AOP(result)->aopu.aop_dir);
        else
          picoBlaze_emitcode("bcf","(%s >> 3),(%s & 7)",
              AOP(result)->aopu.aop_dir,
              AOP(result)->aopu.aop_dir);

        goto release;
      }

      /* the right is also a bit variable */
      if (AOP_TYPE(right) == AOP_CRY) {
        picoBlaze_emitpcode(POC_BCF,    picoBlaze_popGet(AOP(result),0));
        picoBlaze_emitpcode(POC_BTFSC,  picoBlaze_popGet(AOP(right),0));
        picoBlaze_emitpcode(POC_BSF,    picoBlaze_popGet(AOP(result),0));

        goto release ;
      }

      /* we need to or */
      picoBlaze_emitpcode(POC_BCF,    picoBlaze_popGet(AOP(result),0));
      picoBlaze_toBoolean(right);
//*//      emitSKPZ;
      picoBlaze_emitpcode(POC_BSF,    picoBlaze_popGet(AOP(result),0));
      //picoBlaze_aopPut(AOP(result),"a",0);
      goto release ;
    }

    /* bit variables done */
    /* general case */
    size = AOP_SIZE(result);
    offset = 0 ;

  /* bit variables done */
  /* general case */
  size = AOP_SIZE(result);
  restype = operandType(result);
  rtype = operandType(right);
  offset = 0 ;

  if(AOP_TYPE(right) == AOP_LIT) {
    if(!(IS_FLOAT(operandType( right )) || IS_FIXED(operandType(right))))
    {
      lit = ulFromVal (AOP(right)->aopu.aop_lit);

      /* patch tag for literals that are cast to pointers */
      if (IS_CODEPTR(restype)) {
        //fprintf (stderr, "%s:%u: INFO: `(__code*)literal'\n", ic->filename, ic->lineno);
        lit = (lit & 0x00ffff) | (GPTR_TAG_CODE << 16);
      } else {
        if (IS_GENPTR(restype))
        {
          if (IS_CODEPTR(rtype)) {
            //fprintf (stderr, "%s:%u: INFO: `(generic*)(literal __code*)'\n", ic->filename, ic->lineno);
            lit = (lit & 0x00ffff) | (GPTR_TAG_CODE << 16);
          } else if (PIC_IS_DATA_PTR(rtype)) {
            //fprintf (stderr, "%s:%u: INFO: `(generic*)(literal __data*)'\n", ic->filename, ic->lineno);
            lit = (lit & 0x00ffff) | (GPTR_TAG_DATA << 16);
          } else if (!IS_PTR(rtype) || IS_GENPTR(rtype)) {
            //fprintf (stderr, "%s:%u: INFO: `(generic*)literal' -- accepting specified tag %02x\n", ic->filename, ic->lineno, (unsigned char)(lit >> 16));
          } else if (IS_PTR(rtype)) {
            fprintf (stderr, "%s:%u: WARNING: `(generic*)literal' -- assuming __data space\n", ic->filename, ic->lineno);
            lit = (lit & 0x00ffff) | (GPTR_TAG_DATA << 16);
          }
        }
      }
    } else {
      union {
        unsigned long lit_int;
        float lit_float;
      } info;


      if(IS_FIXED16X16(operandType(right))) {
        lit = (unsigned long)fixed16x16FromDouble( floatFromVal( AOP(right)->aopu.aop_lit));
      } else {
        /* take care if literal is a float */
        info.lit_float = floatFromVal(AOP(right)->aopu.aop_lit);
        lit = info.lit_int;
      }
    }
  }

//  fprintf(stderr, "%s:%d: assigning value 0x%04lx (%d:%d)\n", __FUNCTION__, __LINE__, lit,
//                      sizeof(unsigned long int), sizeof(float));


    if (AOP_TYPE(right) == AOP_REG) {
      DEBUGpicoBlaze_emitcode(";   ", "%s:%d assign from register\n", __FUNCTION__, __LINE__);
      while (size--) {
        picoBlaze_emitpcode (POC_MOVFF, picoBlaze_popGet2(AOP(right), AOP(result), offset++));
      } // while
      goto release;
    }

    /* when do we have to read the program memory?
     * - if right itself is a symbol in code space
     *   (we don't care what it points to if it's a pointer)
     * - AND right is not a function (we would want its address)
     */
    if(AOP_TYPE(right) != AOP_LIT
      && IN_CODESPACE(SPEC_OCLS(OP_SYM_ETYPE(right)))
      && !IS_FUNC(OP_SYM_TYPE(right))
      && !IS_ITEMP(right)) {

      DEBUGpicoBlaze_emitcode(";   ", "%s:%d symbol in code space, take special care\n", __FUNCTION__, __LINE__);
      //fprintf(stderr, "%s:%d symbol %s = [ %s ] is in code space\n", __FILE__, __LINE__, OP_SYMBOL(result)->name, OP_SYMBOL(right)->name);

      // set up table pointer
      if(picoBlaze_isLitOp(right)) {
//      fprintf(stderr, "%s:%d inside block 1\n", __FILE__, __LINE__);
        picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGet(AOP(right),0));
//*//        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popCopyReg(&picoBlaze_pc_tblptrl));
        picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGet(AOP(right),1));
//*//        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popCopyReg(&picoBlaze_pc_tblptrh));
        picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGet(AOP(right),2));
//*//        picoBlaze_emitpcode(POC_MOVWF,picoBlaze_popCopyReg(&picoBlaze_pc_tblptru));
      } else {
//      fprintf(stderr, "%s:%d inside block 2\n", __FILE__, __LINE__);
//*//        picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popGet(AOP(right),0),
//*//            picoBlaze_popCopyReg(&picoBlaze_pc_tblptrl)));
 //*//       picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popGet(AOP(right),1),
//**//            picoBlaze_popCopyReg(&picoBlaze_pc_tblptrh)));
 //*//       picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popGet(AOP(right),2),
//**//            picoBlaze_popCopyReg(&picoBlaze_pc_tblptru)));
      }

      /* must fetch 3 bytes for pointers (was OP_SYM_ETYPE before) */
      size = min(getSize(OP_SYM_TYPE(right)), AOP_SIZE(result));
      while(size--) {
        picoBlaze_emitpcodeNULLop(POC_TBLRD_POSTINC);
//*//        picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2p(picoBlaze_popCopyReg(&picoBlaze_pc_tablat),
//*//            picoBlaze_popGet(AOP(result),offset)));
        offset++;
      }

      /* FIXME: for pointers we need to extend differently (according
       * to pointer type DATA/CODE/EEPROM/... :*/
      size = getSize(OP_SYM_TYPE(right));
      if(AOP_SIZE(result) > size) {
        size = AOP_SIZE(result) - size;
        while(size--) {
          picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result), offset));
          offset++;
        }
      }
      goto release;
    }

    size = AOP_SIZE(right);
    if (size > AOP_SIZE(result)) size = AOP_SIZE(result);
    know_W=-1;
    while (size--) {
      DEBUGpicoBlaze_emitcode ("; ***","%s  %d size %d",__FUNCTION__,__LINE__, size);
      if(AOP_TYPE(right) == AOP_LIT) {
        if(lit&0xff) {
          if(know_W != (lit&0xff))
            picoBlaze_emitpcode(POC_MOVLW,picoBlaze_popGetLit(lit&0xff));
          know_W = lit&0xff;
          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offset));
        } else
          picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result),offset));

        lit >>= 8;

      } else if (AOP_TYPE(right) == AOP_CRY) {
        picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result),offset));
        if(offset == 0) {
          //debugf("%s: BTFSS offset == 0\n", __FUNCTION__);
          picoBlaze_emitpcode(POC_BTFSC, picoBlaze_popGet(AOP(right),0));
          picoBlaze_emitpcode(POC_INCF, picoBlaze_popGet(AOP(result),0));
        }
      } else if ( (AOP_TYPE(right) == AOP_PCODE) && (0) ) {
        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(right),offset));
        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offset));
      } else {
        DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

        if(!_G.resDirect) {                                             /* use this aopForSym feature */
          if(AOP_TYPE(result) == AOP_ACC) {
            picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(right), offset));
          } else
            if(AOP_TYPE(right) == AOP_ACC) {
              picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result), offset));
            } else {
              picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2(AOP(right), AOP(result), offset));
            }
        }
      }

      offset++;
    }
    picoBlaze_addSign(result, AOP_SIZE(right), !IS_UNSIGNED(operandType(right)));

release:
  picoBlaze_freeAsmop (right,NULL,ic,FALSE);
  picoBlaze_freeAsmop (result,NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genJumpTab - generates code for jump table                       */
/*-----------------------------------------------------------------*/
static void genJumpTab (iCode *ic)
{
  symbol *jtab;
  char *l;
  pCodeOp *jt_offs;
  pCodeOp *jt_offs_hi;
  pCodeOp *jt_label;

    FENTRY;

    picoBlaze_aopOp(IC_JTCOND(ic),ic,FALSE);
    /* get the condition into accumulator */
    l = picoBlaze_aopGet(AOP(IC_JTCOND(ic)),0,FALSE,FALSE);
    MOVA(l);
    /* multiply by three */
    picoBlaze_emitcode("add","a,acc");
    picoBlaze_emitcode("add","a,%s",picoBlaze_aopGet(AOP(IC_JTCOND(ic)),0,FALSE,FALSE));

    jtab = newiTempLabel(NULL);
    picoBlaze_emitcode("mov","dptr,#%05d_DS_",jtab->key+100);
    picoBlaze_emitcode("jmp","@a+dptr");
    picoBlaze_emitcode("","%05d_DS_:",jtab->key+100);



    jt_offs = picoBlaze_popGetTempReg(0);
    jt_offs_hi = picoBlaze_popGetTempReg(1);
    jt_label = picoBlaze_popGetLabel (jtab->key);
    //fprintf (stderr, "Creating jump table...\n");

    // calculate offset into jump table (idx * sizeof (GOTO))
    picoBlaze_emitpcode(POC_CLRF  , jt_offs_hi);
    picoBlaze_emitpcode(POC_RLCFW , picoBlaze_popGet(AOP(IC_JTCOND(ic)),0));
    picoBlaze_emitpcode(POC_RLCF  , jt_offs_hi);
//*//    picoBlaze_emitpcode(POC_RLCFW , picoBlaze_popCopyReg(&picoBlaze_pc_wreg));
    picoBlaze_emitpcode(POC_RLCF  , jt_offs_hi);
    picoBlaze_emitpcode(POC_ANDLW , picoBlaze_popGetLit (0xFC));
    picoBlaze_emitpcode(POC_MOVWF , jt_offs);

    // prepare PCLATx (set to first entry in jump table)
    picoBlaze_emitpcode(POC_MOVLW , picoBlaze_popGetImmd(jt_label->name, 2, 0));
//*//    picoBlaze_emitpcode(POC_MOVWF , picoBlaze_popCopyReg(&picoBlaze_pc_pclatu));
    picoBlaze_emitpcode(POC_MOVLW , picoBlaze_popGetImmd(jt_label->name, 1, 0));
//*//    picoBlaze_emitpcode(POC_MOVWF , picoBlaze_popCopyReg(&picoBlaze_pc_pclath));
    picoBlaze_emitpcode(POC_MOVLW , picoBlaze_popGetImmd(jt_label->name, 0, 0));

    // set PCLATx to selected entry (new PCL is stored in jt_offs)
    picoBlaze_emitpcode(POC_ADDWF , jt_offs);
    picoBlaze_emitpcode(POC_MOVFW , jt_offs_hi);
//*//    picoBlaze_emitpcode(POC_ADDWFC, picoBlaze_popCopyReg(&picoBlaze_pc_pclath));
//*//    emitSKPNC;
//*//    picoBlaze_emitpcode(POC_INCF  , picoBlaze_popCopyReg(&picoBlaze_pc_pclatu));

    // release temporaries and prepare jump into table (new PCL --> WREG)
    picoBlaze_emitpcode(POC_MOVFW , jt_offs);
    picoBlaze_popReleaseTempReg (jt_offs_hi, 1);
    picoBlaze_popReleaseTempReg (jt_offs, 0);

    // jump into the table
//*//    picoBlaze_emitpcode(POC_MOVWF , picoBlaze_popCopyReg(&picoBlaze_pc_pcl));

    picoBlaze_emitpLabelFORCE(jtab->key);


    picoBlaze_freeAsmop(IC_JTCOND(ic),NULL,ic,TRUE);
//          picoBlaze_emitpinfo(INF_LOCALREGS, picoBlaze_newpCodeOpLocalRegs(LR_ENTRY_BEGIN));

    picoBlaze_emitpinfo (INF_OPTIMIZATION, picoBlaze_newpCodeOpOpt (OPT_JUMPTABLE_BEGIN, ""));
    /* now generate the jump labels */
    for (jtab = setFirstItem(IC_JTLABELS(ic)) ; jtab;
         jtab = setNextItem(IC_JTLABELS(ic))) {
//        picoBlaze_emitcode("ljmp","%05d_DS_",jtab->key+100);
        picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(jtab->key));

    }
    picoBlaze_emitpinfo (INF_OPTIMIZATION, picoBlaze_newpCodeOpOpt (OPT_JUMPTABLE_END, ""));

}

/*-----------------------------------------------------------------*/
/* genMixedOperation - gen code for operators between mixed types  */
/*-----------------------------------------------------------------*/
/*
  TSD - Written for the PIC port - but this unfortunately is buggy.
  This routine is good in that it is able to efficiently promote
  types to different (larger) sizes. Unfortunately, the temporary
  variables that are optimized out by this routine are sometimes
  used in other places. So until I know how to really parse the
  iCode tree, I'm going to not be using this routine :(.
*/
static int genMixedOperation (iCode *ic)
{

  return 0;

}
/*-----------------------------------------------------------------*/
/* genCast - gen code for casting                                  */
/*-----------------------------------------------------------------*/
static void genCast (iCode *ic)
{
  operand *result = IC_RESULT(ic);
  sym_link *ctype = operandType(IC_LEFT(ic));
  sym_link *rtype = operandType(IC_RIGHT(ic));
  sym_link *restype = operandType(IC_RESULT(ic));
  operand *right = IC_RIGHT(ic);
  int size, offset ;


    FENTRY;

        /* if they are equivalent then do nothing */
//      if (operandsEqu(IC_RESULT(ic),IC_RIGHT(ic)))
//              return ;

        picoBlaze_aopOp(result,ic,FALSE);
        picoBlaze_aopOp(right,ic,FALSE) ;

        DEBUGpicoBlaze_picoBlaze_AopType(__LINE__,NULL,right,result);


        /* if the result is a bit */
        if (AOP_TYPE(result) == AOP_CRY) {

                /* if the right size is a literal then
                 * we know what the value is */
                DEBUGpicoBlaze_emitcode("; ***","%s  %d",__FUNCTION__,__LINE__);

                if (AOP_TYPE(right) == AOP_LIT) {
                        picoBlaze_emitpcode(  ( ((int) operandLitValue(right)) ? POC_BSF : POC_BCF),
                                picoBlaze_popGet(AOP(result),0));

                        if (((int) operandLitValue(right)))
                                picoBlaze_emitcode("bsf","(%s >> 3), (%s & 7)",
                                        AOP(result)->aopu.aop_dir,
                                        AOP(result)->aopu.aop_dir);
                        else
                                picoBlaze_emitcode("bcf","(%s >> 3), (%s & 7)",
                                        AOP(result)->aopu.aop_dir,
                                        AOP(result)->aopu.aop_dir);
                        goto release;
                }

                /* the right is also a bit variable */
                if (AOP_TYPE(right) == AOP_CRY) {
//*//                        emitCLRC;
                        picoBlaze_emitpcode(POC_BTFSC,  picoBlaze_popGet(AOP(right),0));

                        picoBlaze_emitcode("clrc","");
                        picoBlaze_emitcode("btfsc","(%s >> 3), (%s & 7)",
                                AOP(right)->aopu.aop_dir,
                                AOP(right)->aopu.aop_dir);
                        picoBlaze_aopPut(AOP(result),"c",0);
                        goto release ;
                }

                /* we need to or */
                if (AOP_TYPE(right) == AOP_REG) {
                        picoBlaze_emitpcode(POC_BCF,    picoBlaze_popGet(AOP(result),0));
                        picoBlaze_emitpcode(POC_BTFSC,  picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(right),0,FALSE,FALSE),0,0, PO_GPR_REGISTER));
                        picoBlaze_emitpcode(POC_BSF,    picoBlaze_popGet(AOP(result),0));
                }
                picoBlaze_toBoolean(right);
                picoBlaze_aopPut(AOP(result),"a",0);
                goto release ;
        }

        if ((AOP_TYPE(right) == AOP_CRY) && (AOP_TYPE(result) == AOP_REG)) {
          int offset = 1;

                size = AOP_SIZE(result);

                DEBUGpicoBlaze_emitcode("; ***","%s  %d",__FUNCTION__,__LINE__);

                picoBlaze_emitpcode(POC_CLRF,   picoBlaze_popGet(AOP(result),0));
                picoBlaze_emitpcode(POC_BTFSC,  picoBlaze_popGet(AOP(right),0));
                picoBlaze_emitpcode(POC_INCF,   picoBlaze_popGet(AOP(result),0));

                while (size--)
                        picoBlaze_emitpcode(POC_CLRF,   picoBlaze_popGet(AOP(result),offset++));

                goto release;
        }

        if(IS_BITFIELD(getSpec(restype))
          && IS_BITFIELD(getSpec(rtype))) {
          DEBUGpicoBlaze_emitcode("***", "%d casting a bit to another bit", __LINE__);
        }

        /* port from pic14 to cope with generic pointers */
        if (PIC_IS_TAGGED(restype))
        {
          operand *result = IC_RESULT(ic);
          //operand *left = IC_LEFT(ic);
          operand *right = IC_RIGHT(ic);
          int tag = 0xff;

          /* copy common part */
          int max, size = AOP_SIZE(result);
          if (size > AOP_SIZE(right)) size = AOP_SIZE(right);
          DEBUGpicoBlaze_emitcode("; ***","%s  %d",__FUNCTION__,__LINE__);

          max = size;
          while (size--)
          {
            picoBlaze_mov2w (AOP(right), size);
            picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet (AOP(result), size));
          } // while

          /* upcast into generic pointer type? */
          if (IS_GENPTR(restype)
              && !PIC_IS_TAGGED(rtype)
              && (AOP_SIZE(result) > max))
          {
            /* determine appropriate tag for right */
            if (PIC_IS_DATA_PTR(rtype))
              tag = GPTR_TAG_DATA;
            else if (IS_CODEPTR(rtype))
              tag = GPTR_TAG_CODE;
            else if (PIC_IS_DATA_PTR(ctype)) {
              //fprintf (stderr, "%s:%u: WARNING: casting `(generic*)(__data*)(non-pointer)'\n", ic->filename, ic->lineno);
              tag = GPTR_TAG_DATA;
            } else if (IS_CODEPTR(ctype)) {
              //fprintf (stderr, "%s:%u: WARNING: casting `(generic*)(__code*)(non-pointer)'\n", ic->filename, ic->lineno);
              tag = GPTR_TAG_CODE;
            } else if (IS_PTR(rtype)) {
              PERFORM_ONCE(weirdcast,
              fprintf (stderr, "%s:%u: WARNING: casting `(generic*)(unknown*)' -- assuming __data space\n", ic->filename, ic->lineno);
              );
              tag = GPTR_TAG_DATA;
            } else {
              PERFORM_ONCE(weirdcast,
              fprintf (stderr, "%s:%u: WARNING: casting `(generic*)(non-pointer)' -- assuming __data space\n", ic->filename, ic->lineno);
              );
              tag = GPTR_TAG_DATA;
            }

            assert (AOP_SIZE(result) == 3);
            /* zero-extend address... */
            for (size = max; size < AOP_SIZE(result)-1; size++)
              picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result),size));
            /* ...and add tag */
            picoBlaze_movLit2f(picoBlaze_popGet(AOP(result), AOP_SIZE(result)-1), tag);
          } else if (IS_CODEPTR(restype) && AOP_SIZE(result) > max) {
            //fprintf (stderr, "%s:%u: INFO: code pointer\n", ic->filename, ic->lineno);
            for (size = max; size < AOP_SIZE(result)-1; size++)
              picoBlaze_emitpcode(POC_CLRF, picoBlaze_popGet(AOP(result), size));
            /* add __code tag */
            picoBlaze_movLit2f (picoBlaze_popGet(AOP(result), AOP_SIZE(result)-1), GPTR_TAG_CODE);
          } else if (AOP_SIZE(result) > max) {
            /* extend non-pointers */
            //fprintf (stderr, "%s:%u: zero-extending value cast to pointer\n", ic->filename, ic->lineno);
            picoBlaze_addSign(result, max, 0);
          } // if
          goto release;
        }

        /* if they are the same size : or less */
        if (AOP_SIZE(result) <= AOP_SIZE(right)) {

                /* if they are in the same place */
                if (picoBlaze_sameRegs(AOP(right),AOP(result)))
                        goto release;

                DEBUGpicoBlaze_emitcode("; ***","%s  %d",__FUNCTION__,__LINE__);

                if (IS_CODEPTR(rtype))

                        DEBUGpicoBlaze_emitcode ("; ***","%d - right is const pointer",__LINE__);


                if (IS_CODEPTR(operandType(IC_RESULT(ic))))

                        DEBUGpicoBlaze_emitcode ("; ***","%d - result is const pointer",__LINE__);

                if ((AOP_TYPE(right) == AOP_PCODE) && 0) {
                        picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(right),0));
                        picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),0));

                        if(AOP_SIZE(result) < 2) {
                          fprintf(stderr,"%d -- casting a ptr to a char\n",__LINE__);
                        } else {
                          picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(right),1));
                          picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),1));
                        }
                } else {
                        /* if they in different places then copy */
                        size = AOP_SIZE(result);
                        offset = 0 ;
                        while (size--) {
                                picoBlaze_emitpcode(POC_MOVFW, picoBlaze_popGet(AOP(right),offset));
                                picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offset));
                                offset++;
                        }
                }
                goto release;
        }

        /* if the result is of type pointer */
        if (IS_PTR(ctype)) {
          int p_type;
          sym_link *type = operandType(right);
          sym_link *etype = getSpec(type);

                DEBUGpicoBlaze_emitcode("; ***","%s  %d - pointer cast",__FUNCTION__,__LINE__);

                /* pointer to generic pointer */
                if (IS_GENPTR(ctype)) {

                        if (IS_PTR(type))
                                p_type = DCL_TYPE(type);
                        else {
                /* we have to go by the storage class */
                p_type = PTR_TYPE(SPEC_OCLS(etype));

/*              if (SPEC_OCLS(etype)->codesp )  */
/*                  p_type = CPOINTER ;  */
/*              else */
/*                  if (SPEC_OCLS(etype)->fmap && !SPEC_OCLS(etype)->paged) */
/*                      p_type = FPOINTER ; */
/*                  else */
/*                      if (SPEC_OCLS(etype)->fmap && SPEC_OCLS(etype)->paged) */
/*                          p_type = PPOINTER; */
/*                      else */
/*                          if (SPEC_OCLS(etype) == idata ) */
/*                              p_type = IPOINTER ; */
/*                          else */
/*                              p_type = POINTER ; */
            }

            /* the first two bytes are known */
      DEBUGpicoBlaze_emitcode("; ***","%s  %d - pointer cast2",__FUNCTION__,__LINE__);
            size = GPTRSIZE - 1;
            offset = 0 ;
            while (size--) {
              if(offset < AOP_SIZE(right)) {
                DEBUGpicoBlaze_emitcode("; ***","%s  %d - pointer cast3 ptype = 0x%x",__FUNCTION__,__LINE__, p_type);
                picoBlaze_mov2f(AOP(result), AOP(right), offset);
/*
                if ((AOP_TYPE(right) == AOP_PCODE) &&
                    AOP(right)->aopu.pcop->type == PO_IMMEDIATE) {
                  picoBlaze_emitpcode(POC_MOVLW, picoBlaze_popGet(AOP(right),offset));
                  picoBlaze_emitpcode(POC_MOVWF, picoBlaze_popGet(AOP(result),offset));
                } else {

                  picoBlaze_aopPut(AOP(result),
                         picoBlaze_aopGet(AOP(right),offset,FALSE,FALSE),
                         offset);
                }
*/
              } else
                picoBlaze_emitpcode(POC_CLRF,picoBlaze_popGet(AOP(result),offset));
              offset++;
            }
            /* the last byte depending on type */
            switch (p_type) {
            case POINTER:
            case FPOINTER:
            case IPOINTER:
            case PPOINTER:
                picoBlaze_movLit2f(picoBlaze_popGet(AOP(result), GPTRSIZE-1), GPTR_TAG_DATA);
                break;

            case CPOINTER:
                picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2(AOP(right), AOP(result), GPTRSIZE-1));
                break;

            case GPOINTER:
                if (GPTRSIZE > AOP_SIZE(right)) {
                  // assume __data pointer... THIS MIGHT BE WRONG!
                  picoBlaze_movLit2f(picoBlaze_popGet(AOP(result), GPTRSIZE-1), GPTR_TAG_DATA);
                } else {
                  picoBlaze_emitpcode(POC_MOVFF, picoBlaze_popGet2(AOP(right), AOP(result), GPTRSIZE-1));
                }
              break;

            default:
                /* this should never happen */
                werror(E_INTERNAL_ERROR,__FILE__,__LINE__,
                       "got unknown pointer type");
                exit(1);
            }
            //picoBlaze_aopPut(AOP(result),l, GPTRSIZE - 1);
            goto release ;
        }


        assert( 0 );
        /* just copy the pointers */
        size = AOP_SIZE(result);
        offset = 0 ;
        while (size--) {
            picoBlaze_aopPut(AOP(result),
                   picoBlaze_aopGet(AOP(right),offset,FALSE,FALSE),
                   offset);
            offset++;
        }
        goto release ;
    }



    /* so we now know that the size of destination is greater
    than the size of the source.
    Now, if the next iCode is an operator then we might be
    able to optimize the operation without performing a cast.
    */
    if(genMixedOperation(ic))
      goto release;

    DEBUGpicoBlaze_emitcode("; ***","%s  %d",__FUNCTION__,__LINE__);

    /* we move to result for the size of source */
    size = AOP_SIZE(right);
    offset = 0 ;

    while (size--) {
      if(!_G.resDirect)
        picoBlaze_mov2f(AOP(result), AOP(right), offset);
      offset++;
    }

    /* now depending on the sign of the destination */
    size = AOP_SIZE(result) - AOP_SIZE(right);
    /* if unsigned or not an integral type */
    if (SPEC_USIGN( getSpec(rtype) ) || !IS_SPEC(rtype)) {
      while (size--)
        picoBlaze_emitpcode(POC_CLRF,   picoBlaze_popGet(AOP(result),offset++));
    } else {
      /* we need to extend the sign :( */

      if(size == 1) {
        /* Save one instruction of casting char to int */
        picoBlaze_emitpcode(POC_CLRF,   picoBlaze_popGet(AOP(result),offset));
        picoBlaze_emitpcode(POC_BTFSC,  picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(right),offset-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
        picoBlaze_emitpcode(POC_SETF,   picoBlaze_popGet(AOP(result),offset));
      } else {
//*//        picoBlaze_emitpcode(POC_CLRF,picoBlaze_popCopyReg(&picoBlaze_pc_wreg));

        if(offset)
          picoBlaze_emitpcode(POC_BTFSC,   picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(right),offset-1,FALSE,FALSE),7,0, PO_GPR_REGISTER));
        else
          picoBlaze_emitpcode(POC_BTFSC,   picoBlaze_newpCodeOpBit(picoBlaze_aopGet(AOP(right),offset,FALSE,FALSE),7,0, PO_GPR_REGISTER));

        picoBlaze_emitpcode(POC_MOVLW,   picoBlaze_popGetLit(0xff));

        while (size--)
          picoBlaze_emitpcode(POC_MOVWF,   picoBlaze_popGet(AOP(result),offset++));
      }
    }

release:
    picoBlaze_freeAsmop(right,NULL,ic,TRUE);
    picoBlaze_freeAsmop(result,NULL,ic,TRUE);

}

/*-----------------------------------------------------------------*/
/* genDjnz - generate decrement & jump if not zero instrucion      */
/*-----------------------------------------------------------------*/
static int genDjnz (iCode *ic, iCode *ifx)
{
    symbol *lbl, *lbl1;
    DEBUGpicoBlaze_emitcode ("; ***","%s  %d",__FUNCTION__,__LINE__);

    if (!ifx)
        return 0;

    /* if the if condition has a false label
       then we cannot save */
    if (IC_FALSE(ifx))
        return 0;

    /* if the minus is not of the form
       a = a - 1 */
    if (!isOperandEqual(IC_RESULT(ic),IC_LEFT(ic)) ||
        !IS_OP_LITERAL(IC_RIGHT(ic)))
        return 0;

    if (operandLitValue(IC_RIGHT(ic)) != 1)
        return 0;

    /* if the size of this greater than one then no
       saving */
    if (getSize(operandType(IC_RESULT(ic))) > 1)
        return 0;

    /* otherwise we can save BIG */
    lbl = newiTempLabel(NULL);
    lbl1= newiTempLabel(NULL);

    picoBlaze_aopOp(IC_RESULT(ic),ic,FALSE);

    picoBlaze_emitpcode(POC_DECFSZ,picoBlaze_popGet(AOP(IC_RESULT(ic)),0));
    picoBlaze_emitpcode(POC_GOTO,picoBlaze_popGetLabel(IC_TRUE(ifx)->key));

    picoBlaze_freeAsmop(IC_RESULT(ic),NULL,ic,TRUE);
    ifx->generated = 1;
    return 1;
}

/*-----------------------------------------------------------------*/
/* genReceive - generate code for a receive iCode                  */
/*-----------------------------------------------------------------*/
static void genReceive (iCode *ic)
{

  FENTRY;

//  picoBlaze_DumpOp(__FUNCTION__, IC_RESULT(ic));

  if (isOperandInFarSpace(IC_RESULT(ic))
      && ( OP_SYMBOL(IC_RESULT(ic))->isspilt
          || IS_TRUE_SYMOP(IC_RESULT(ic))) ) {

    int size = getSize(operandType(IC_RESULT(ic)));
    int offset =  picoBlaze_fReturnSizePic - size;

      assert( 0 );
      while (size--) {
        picoBlaze_emitcode ("push","%s", (strcmp(fReturn[picoBlaze_fReturnSizePic - offset - 1],"a") ?
                      fReturn[picoBlaze_fReturnSizePic - offset - 1] : "acc"));
                      offset++;
        }

      DEBUGpicoBlaze_emitcode ("; ***","1 %s  %d",__FUNCTION__,__LINE__);

      picoBlaze_aopOp(IC_RESULT(ic),ic,FALSE);
      size = AOP_SIZE(IC_RESULT(ic));
      offset = 0;
      while (size--) {
        picoBlaze_emitcode ("pop","acc");
        picoBlaze_aopPut (AOP(IC_RESULT(ic)),"a",offset++);
      }
  } else {
    DEBUGpicoBlaze_emitcode ("; ***","2 %s  %d argreg = %d",__FUNCTION__,__LINE__, SPEC_ARGREG(OP_SYM_ETYPE(IC_RESULT(ic)) ));
    _G.accInUse++;
    picoBlaze_aopOp(IC_RESULT(ic),ic,FALSE);
    _G.accInUse--;

    /* set pseudo stack pointer to where it should be - dw*/
    GpsuedoStkPtr = ic->parmBytes;

    /* setting GpsuedoStkPtr has side effects here: */
    /* FIXME: What's the correct size of the return(ed) value?
     *        For now, assuming '4' as before... */
    assignResultValue(IC_RESULT(ic), 4, 0);
  }

  picoBlaze_freeAsmop(IC_RESULT(ic),NULL,ic,TRUE);
}

/*-----------------------------------------------------------------*/
/* genDummyRead - generate code for dummy read of volatiles        */
/*-----------------------------------------------------------------*/
static void
genDummyRead (iCode * ic)
{
  operand *op;

  op = IC_RIGHT(ic);
  if (op && IS_SYMOP(op)) {
    if (IN_CODESPACE(SPEC_OCLS(OP_SYM_ETYPE(op)))) {
      fprintf (stderr, "%s: volatile symbols in codespace?!? -- might go wrong...\n", __FUNCTION__);
      return;
    }
    picoBlaze_aopOp (op, ic, FALSE);
    picoBlaze_mov2w_volatile(AOP(op));
    picoBlaze_freeAsmop (op, NULL, ic, TRUE);
  } else if (op) {
    fprintf (stderr, "%s: not implemented for non-symbols (volatile operand might not be read)\n", __FUNCTION__);
  } // if
}

/*-----------------------------------------------------------------*/
/* genpicoBlazeCode - generate code for picoBlaze based controllers        */
/*-----------------------------------------------------------------*/
/*
 * At this point, ralloc.c has gone through the iCode and attempted
 * to optimize in a way suitable for a PIC. Now we've got to generate
 * PIC instructions that correspond to the iCode.
 *
 * Once the instructions are generated, we'll pass through both the
 * peep hole optimizer and the pCode optimizer.
 *-----------------------------------------------------------------*/

void genpicoBlazeCode (iCode *lic)
{
  iCode *ic;
  int cln = 0;
  symbol *jtab;

  struct json_object * jo;	// json_object for iCode
  struct json_object * jo_temp; // temporary json_object





    for (ic = lic ; ic ; ic = ic->next ) {

      if (ic->generated )
        continue ;

    // JSON code generation - iCode dump
	jo = json_object_new_object();
	jo_temp = json_object_new_object();

	if(firstiCode)
	{
		//indentDeep++;
		firstiCode = FALSE;
	}
	else
	{
		// insert dash before next iCode json object
		dumpICode(",\n");
	}

	//iDumpStruct("{", 0);
	//iDumpS("structType", "iCode");
	json_object_object_add(jo, "structType", json_object_new_string("iCode"));
	
	// ID of iCode
	//iDumpU("uid",  ic);
	json_object_object_add(jo, "uid", json_object_new_int((unsigned int)ic));
	
	// double-linked list of iCodes
	//iDumpU("next",  ic->next);
	//iDumpU("prev",  ic->prev);
	json_object_object_add(jo, "next", json_object_new_int((unsigned int)ic->next));
 	json_object_object_add(jo, "prev", json_object_new_int((unsigned int)ic->prev));

	// operator/operand?
	//iDumpU("opIntValue", ic->op); // ZK: DEBUG
	json_object_object_add(jo, "opIntValue", json_object_new_int((unsigned int)ic->op));
	json_object_object_add(jo, "opConverted", json_object_new_string(picoBlaze_decodeOp(ic->op)));
/*
	iDumpU("uid",  lic);
	iDumpI("key",  ic->key);
	iDumpI("seq",  ic->seq);
	iDumpI("seqPoint",  ic->seqPoint);
	iDumpI("level",  ic->level);
	iDumpI("block",  ic->block);
	iDumpU("nosupdate",  ic->nosupdate);
	iDumpU("generated",  ic->generated);
	iDumpU("parmPush",  ic->parmPush);
	iDumpU("supportRtn",  ic->supportRtn);
	iDumpU("regsSaved",  ic->regsSaved);
	iDumpU("bankSaved",  ic->bankSaved);
	iDumpU("builtinSEND",  ic->builtinSEND);

	iDumpU("next",  ic->next);
	iDumpU("prev",  ic->prev);

	iDumpI("defKey",  ic->defKey);

	iDumpStruct("left");
	iDumpI("type",  ic->ulrrcnd.lrr.left->type);
	iDumpI("symbol",  ic->ulrrcnd.lrr.left->operand.symOperand->name);
	iDumpStruct("right");
	iDumpI("type",  ic->ulrrcnd.lrr.right->type);
	//iDumpI("symbol",  ic->ulrrcnd.lrr.right->symbol->name);
	iDumpStruct("result");
	iDumpI("type",  ic->ulrrcnd.lrr.result->type);
	//iDumpI("symbol",  ic->ulrrcnd.lrr.result->symbol->name);

	iDumpU("\tbuiltinSEND",  ic->builtinSEND);
	iDumpU("builtinSEND",  ic->builtinSEND);


	iDumpS("label",  ic->label->name);
	iDumpS("inlineAsm",  ic->inlineAsm);
*/


      /* depending on the operation */
      switch (ic->op) {
        case '!' :  // IC_RESULT = !IC_LEFT
		  json_object_object_add(jo, "op", json_object_new_string("NOT_OP"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

//          picoBlaze_genNot(ic);
          break;

        case '~' :  // IC_RESULT = ~IC_LEFT
		  json_object_object_add(jo, "op", json_object_new_string("BITWISECOMPLEMENT"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

//          picoBlaze_genCpl(ic);
          break;

        case UNARYMINUS:  // IC_RESULT = -IC_LEFT
		  json_object_object_add(jo, "op", json_object_new_string("UNARYMINUS"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

 //         genUminus (ic);
          break;

        case IPUSH:
		  json_object_object_add(jo, "op", json_object_new_string("PUSH"));

		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
 //         genIpush (ic);
          break;

        case IPOP:
          /* IPOP happens only when trying to restore a
           * spilt live range, if there is an ifx statement
           * following this pop then the if statement might
           * be using some of the registers being popped which
           * would destroy the contents of the register so
           * we need to check for this condition and handle it */
		  json_object_object_add(jo, "op", json_object_new_string("POP"));

		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
/*
          if (ic->next
             && ic->next->op == IFX
             && regsInCommon(IC_LEFT(ic),IC_COND(ic->next)))
               genIfx (ic->next,ic);
          else
            genIpop (ic);
   */       break;

        case CALL:
		  json_object_object_add(jo, "op", json_object_new_string("CALL"));
		  json_object_object_add(jo, "fname", json_object_new_string(OP_SYMBOL(IC_LEFT(ic))->rname[0]?OP_SYMBOL(IC_LEFT(ic))->rname:OP_SYMBOL(IC_LEFT(ic))->name));

		  if(IC_RESULT(ic))
			  json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));	// return value from the function call

/*		  directEmitComment("iCode CALL");
		   directEmitCode("iCode CALL");
		    directEmitCodeFormated("MOV %s, %s2", "r1", "r2");

          genCall (ic);
  */        break;

        case PCALL:
		  json_object_object_add(jo, "op", json_object_new_string("PCALL"));	// function call by pointer, probably not supported
		  json_object_object_add(jo, "opComment", json_object_new_string("Function call by pointer, probably not supported."));

 //         genPcall (ic);
          break;

        case FUNCTION:
		  json_object_object_add(jo, "op", json_object_new_string("FUNCTION"));
		  json_object_object_add(jo, "name", json_object_new_string(OP_SYMBOL(IC_LEFT(ic))->name));
		  json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic))); // test it!
//          genFunction (ic);
          break;

        case ENDFUNCTION:
		  json_object_object_add(jo, "op", json_object_new_string("ENDFUNCTION"));
		  if(IC_LEFT(ic))
		  {
			json_object_object_add(jo, "name", json_object_new_string(OP_SYMBOL(IC_LEFT(ic))->name));
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));		// we need information about parameters (if used or not)
		  }
  //        genEndFunction (ic);
          break;

        case RETURN:
		  json_object_object_add(jo, "op", json_object_new_string("RETURN"));
		  if(IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));

   //       genRet (ic);
          break;

        case LABEL:
		  json_object_object_add(jo, "op", json_object_new_string("LABEL"));
		  if (IC_LABEL(ic))
		  {
			json_object_object_add(jo, "key", json_object_new_int((unsigned int)(IC_LABEL(ic)->key)));
			json_object_object_add(jo, "name", json_object_new_string(IC_LABEL(ic)->name));
		  }
 //         genLabel (ic);
          break;

        case GOTO:
		  json_object_object_add(jo, "op", json_object_new_string("GOTO"));
		  if (IC_LABEL(ic))
		  {
			json_object_object_add(jo, "key", json_object_new_int((unsigned int)(IC_LABEL(ic)->key)));
			json_object_object_add(jo, "name", json_object_new_string(IC_LABEL(ic)->name));
		  }

 //         genGoto (ic);
          break;

        case '+' :	// + and ++
		  json_object_object_add(jo, "op", json_object_new_string("PLUS"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

 //         picoBlaze_genPlus (ic) ;
          break;

        case '-' :
      //    if ( ! genDjnz (ic,ifxForOp(IC_RESULT(ic),ic)))
		  {
			  json_object_object_add(jo, "op", json_object_new_string("MINUS"));
			
			  if (IC_LEFT(ic))
				json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
			  if (IC_RIGHT(ic))
				json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
			  if (IC_RESULT(ic))
				json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

//			  picoBlaze_genMinus (ic);
		  }
          break;

        case '*' :
		  json_object_object_add(jo, "op", json_object_new_string("MULT"));	
			
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

  //        genMult (ic);
          break;

        case '/' :
		  json_object_object_add(jo, "op", json_object_new_string("DIV"));
			
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genDiv (ic) ;
          break;

        case '%' :
		  json_object_object_add(jo, "op", json_object_new_string("MOD"));
			
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

     //     genMod (ic);
          break;

        case '>' :  // IC_RESULT = IC_LEFT > IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("GT_OP"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

	//	  genCmpGt (ic,ifxForOp(IC_RESULT(ic),ic));
          break;

        case '<' :  // IC_RESULT = IC_LEFT < IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("LT_OP"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genCmpLt (ic,ifxForOp(IC_RESULT(ic),ic));
          break;

        case LE_OP:
        case GE_OP:
        case NE_OP:
          /* note these two are xlated by algebraic equivalence
           * during parsing SDCC.y */
          werror(E_INTERNAL_ERROR,__FILE__,__LINE__,
            "got '>=' or '<=' shouldn't have come here");
          break;

        case EQ_OP:  // IC_RESULT = IC_LEFT == IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("EQ_OP"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

  //        genCmpEq (ic,ifxForOp(IC_RESULT(ic),ic));
          break;

        case AND_OP:  // IC_RESULT = IC_LEFT && IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("AND_OP"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genAndOp (ic);
          break;

        case OR_OP:  // IC_RESULT = IC_LEFT || IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("OR_OP"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genOrOp (ic);
          break;

        case '^' :  // IC_RESULT = IC_LEFT ^ IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("EXCLUSIVEOR"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genXor (ic,ifxForOp(IC_RESULT(ic),ic));
          break;

        case '|' :  // IC_RESULT = IC_LEFT | IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("BITWISEOR"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genOr (ic,ifxForOp(IC_RESULT(ic),ic));
          break;

        case BITWISEAND:  // IC_RESULT = IC_LEFT & IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("BITWISEAND"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

 //         genAnd (ic,ifxForOp(IC_RESULT(ic),ic));
          break;

        case INLINEASM:
		  json_object_object_add(jo, "op", json_object_new_string("INLINEASM"));

		  if(IC_INLINE(ic))
			  json_object_object_add(jo, "inlineAsm", json_object_new_string(IC_INLINE(ic))); /* pointer to inline assembler code */

  //        genInline (ic);
          break;

        case RRC:  // IC_RESULT = (IC_LEFT << 1) | (IC_LEFT >> (sizeof(IC_LEFT)*8-1))
		  json_object_object_add(jo, "op", json_object_new_string("RRC"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

//			genRRC (ic);
          break;

        case RLC:  // IC_RESULT = (IC_LEFT << (sizeof(IC_LEFT)*8-1)) | (IC_LEFT >> 1)
		  json_object_object_add(jo, "op", json_object_new_string("RLC"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

//		  genRLC (ic);
          break;

        case GETHBIT:  // Get the highest order bit of IC_LEFT: IC_RESULT = (IC_LEFT >> (sizeof(IC_LEFT)*8-1))
		  json_object_object_add(jo, "op", json_object_new_string("GETHBIT"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genGetHbit (ic);
          break;

        case LEFT_OP:  // IC_RESULT = IC_LEFT << IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("LEFT_OP"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

     //     genLeftShift (ic);
          break;

        case RIGHT_OP:  // IC_RESULT = IC_LEFT >> IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("RIGHT_OP"));
		
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genRightShift (ic);
          break;

        case GET_VALUE_AT_ADDRESS:	// IC_RESULT = (*IC_LEFT)
		  json_object_object_add(jo, "op", json_object_new_string("GET_VALUE_AT_ADDRESS"));
			  
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genPointerGet(ic);
          break;

        case '=' :
          if (POINTER_SET(ic))  // Indirest set: (*IC_RESULT) = IC_RIGHT
		  {
			json_object_object_add(jo, "op", json_object_new_string("POINTER_SET"));

			if (IC_RIGHT(ic))
			  json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
			if (IC_RESULT(ic))
			  json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));


 //           genPointerSet(ic);
		  }
          else	// Assignment: IC_RESULT = IC_RIGHT
		  {
			json_object_object_add(jo, "op", json_object_new_string("ASSIGN"));

			if (IC_RIGHT(ic))
				json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
			if (IC_RESULT(ic))
				json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

            // genAssign(ic); // ZK: nefunguje
		  }
          break;

        case IFX:  // if (IC_COND) goto IC_TRUE; "or" if (!IC_COND) goto IC_FALSE
		  json_object_object_add(jo, "op", json_object_new_string("IFX"));
		  json_object_object_add(jo, "condition", jsonDumpOperand(IC_COND(ic)));

		  if (IC_TRUE(ic))
			json_object_object_add(jo, "true", jsonDumpSymbol(IC_TRUE(ic)));
		  if (IC_FALSE(ic))
			json_object_object_add(jo, "false", jsonDumpSymbol(IC_FALSE(ic)));

   //       genIfx (ic,NULL);
          break;

        case ADDRESS_OF:	// IC_RESULT = & IC_LEFT
		  json_object_object_add(jo, "op", json_object_new_string("ADDRESS_OF"));

		  json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

   //       genAddrOf (ic);
          break;

        case JUMPTABLE:  // switch statement
		  json_object_object_add(jo, "op", json_object_new_string("JUMPTABLE"));

		  // jo_temp = json_object_new_object();
		  if (IC_JTCOND(ic))
			json_object_object_add(jo, "condition", jsonDumpOperand(IC_JTCOND(ic)));

		  if (IC_JTLABELS(ic)) 
		  {
			  jo_temp = json_object_new_array();

		      for (jtab = setFirstItem (IC_JTLABELS (ic)); jtab; jtab = setNextItem (IC_JTLABELS (ic)))
			  {
				  json_object_array_add(jo_temp, jsonDumpSymbol(jtab));
			  }
			  json_object_object_add(jo, "labels", jo_temp);
		  }
  //        genJumpTab (ic);
          break;

        case CAST:  // IC_RESULT = (typeof IC_LEFT) IC_RIGHT
		  json_object_object_add(jo, "op", json_object_new_string("CAST"));
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));
  //        genCast (ic);
          break;

        case RECEIVE:
		  json_object_object_add(jo, "op", json_object_new_string("RECEIVE"));

		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));

 //         genReceive(ic);
          break;

        case SEND:
		  json_object_object_add(jo, "op", json_object_new_string("SEND"));

		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));	

   //       addSet(&_G.sendSet,ic);
          break;

        case DUMMY_READ_VOLATILE:
		  // TODO: explore other implementation for inspiration what is this for!
		  json_object_object_add(jo, "op", json_object_new_string("DUMMY_READ_VOLATILE"));
		  if (IC_LEFT(ic))
			json_object_object_add(jo, "left", jsonDumpOperand(IC_LEFT(ic)));
		  if (IC_RIGHT(ic))
			json_object_object_add(jo, "right", jsonDumpOperand(IC_RIGHT(ic)));
		  if (IC_RESULT(ic))
			json_object_object_add(jo, "result", jsonDumpOperand(IC_RESULT(ic)));
  //        genDummyRead (ic);
          break;

        default :
          ic = ic;
      }

	  dumpICode("%s", json_object_to_json_string(jo));
	  //json_object_put(jo);

	  //indentDeep--;
	  //iDumpStruct("},", 1);	// end of iCode structure in JSON format


    }	// end of for loop for all iCodes

	return;
}
