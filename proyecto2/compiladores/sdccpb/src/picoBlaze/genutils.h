
/*
** $Id: genutils.h 4051 2006-03-06 08:27:52Z vrokas $
*/

#ifndef __GENUTILS_H__
#define __GENUTILS_H__


#include "common.h"


#if !defined(__BORLANDC__) && !defined(_MSC_VER)
#define DEBUGpc(fmt,...)  DEBUGpicoBlaze_emitcode("; =:=", "%s:%s:%d: " fmt, __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DEBUGpc           1 ? (void)0 : printf
#endif
#define isAOP_LIT(x)      (AOP_TYPE(x) == AOP_LIT)
#define isAOP_REGlike(x)  (AOP_TYPE(x) == AOP_REG || AOP_TYPE(x) == AOP_DIR || AOP_TYPE(x) == AOP_PCODE || AOP_TYPE(x) == AOP_STA)


/* Resolved ifx structure. This structure stores information
 * about an iCode ifx that makes it easier to generate code.
 */
typedef struct resolvedIfx {
  symbol *lbl;     /* pointer to a label */
  int condition;   /* true or false ifx */
  int generated;   /* set true when the code associated with the ifx
		    * is generated */
} resolvedIfx;


/*
 * The various GEN_xxxxx macros handle which functions
 * should be included in the gen.c source. We are going to use
 * our own functions here so, they must be commented out from
 * gen.c
 */

#define GEN_Not
void picoBlaze_genNot(iCode *ic);

#define GEN_Cpl
void picoBlaze_genCpl(iCode *ic);


/*
 * global function definitions
 */
void picoBlaze_DumpValue(char *prefix, value *val);
void picoBlaze_DumpPcodeOp(char *prefix, pCodeOp *pcop);
void picoBlaze_DumpAop(char *prefix, asmop *aop);
void picoBlaze_DumpSymbol(char *prefix, symbol *sym);
void picoBlaze_DumpOp(char *prefix, operand *op);
void picoBlaze_DumpOpX(FILE *fp, char *prefix, operand *op);

pCodeOp *picoBlaze_popGetWithString(char *str);
void picoBlaze_callGenericPointerRW(int rw, int size);



void picoBlaze_gpsimio2_pcop(pCodeOp *pcop);
void picoBlaze_gpsimio2_lit(unsigned char lit);

void picoBlaze_gpsimDebug_StackDump(char *fname, int line, char *info);

int picoBlaze_genCmp_special(operand *left, operand *right, operand *result,
                    iCode *ifx, resolvedIfx *rIfx, int sign);

#ifndef debugf
#define debugf(frm, rest)       _picoBlaze_debugf(__FILE__, __LINE__, frm, rest)
#endif
void _picoBlaze_debugf(char *f, int l, char *frm, ...);

#endif	/* __GENUTILS_H__ */
