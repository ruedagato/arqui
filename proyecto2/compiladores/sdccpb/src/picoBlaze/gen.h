/*-------------------------------------------------------------------------
  gen.h - header file for code generation for PICOBLAZE

             Written By -  Sandeep Dutta . sandeep.dutta@usa.net (1998)
	     PIC port   - T. Scott Dattalo scott@dattalo.com (2000)
	     PICOBLAZE port   - Martin Dubuc m.dubuc@rogers.com (2000)

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

#ifndef SDCCGENPICOBLAZE_H
#define SDCCGENPICOBLAZE_H

/* If you change these, you also have to update the library files
 * device/lib/picoBlaze/libsdcc/gptr{get,put}{1,2,3,4}.c */
#define GPTR_TAG_DATA   0x80
#define GPTR_TAG_EEPROM 0x40
#define GPTR_TAG_CODE   0x00    /* must be 0 becaue of UPPER(sym)==0 */

struct pCodeOp;

enum
  {
    AOP_LIT = 1,
    AOP_REG,
    AOP_DIR,
    AOP_STK,
    AOP_STR,
    AOP_CRY,
    AOP_ACC,
    AOP_PCODE,
    AOP_STA		// asmop on stack
  };

/* type asmop : a homogenised type for 
   all the different spaces an operand can be
   in */
typedef struct asmop
  {

    short type;			/* can have values
				   AOP_LIT    -  operand is a literal value
				   AOP_REG    -  is in registers
				   AOP_DIR    -  direct just a name
				   AOP_STK    -  should be pushed on stack this
				   can happen only for the result
				   AOP_CRY    -  carry contains the value of this
				   AOP_STR    -  array of strings
				   AOP_ACC    -  result is in the acc:b pair
				   AOP_STA    -  asmop on the stack (What is the difference from AOP_STK?)
				 */
    short coff;			/* current offset */
    short size;			/* total size */
    unsigned code:1;		/* is in Code space */
    unsigned paged:1;		/* in paged memory  */
    unsigned freed:1;		/* already freed    */
    union
      {
	value *aop_lit;		/* if literal */
	regs *aop_reg[4];	/* array of registers */
	char *aop_dir;		/* if direct  */
	regs *aop_ptr;		/* either -> to r0 or r1 */
	int aop_stk;		/* stack offset when AOP_STK */
	char *aop_str[4];	/* just a string array containing the location */
/*	regs *aop_alloc_reg;     * points to a dynamically allocated register */
	pCodeOp *pcop;
	struct {
	  int stk;
	  pCodeOp *pop[4];
        } stk;
      }
    aopu;
  }
asmop;

void genpicoBlazeCode (iCode *);

extern unsigned picoBlaze_fReturnSizePic;


#define AOP(op) op->aop
#define AOP_TYPE(op) AOP(op)->type
#define AOP_SIZE(op) AOP(op)->size

#define AOP_NEEDSACC(x) (AOP(x) && (AOP_TYPE(x) == AOP_CRY ||  \
                         AOP(x)->paged)) 

#define RESULTONSTACK(x) \
                         (IC_RESULT(x) && IC_RESULT(x)->aop && \
                         IC_RESULT(x)->aop->type == AOP_STK )
#define RESULTONSTA(x)	(IC_RESULT(x) && IC_RESULT(x)->aop && IC_RESULT(x)->aop->type == AOP_STA)


#define MOVA(x) if (strcmp(x,"a") && strcmp(x,"acc")) picoBlaze_emitcode(";XXX mov","a,%s  %s,%d",x,__FILE__,__LINE__);
#define CLRC    picoBlaze_emitcode(";XXX clr","c %s,%d",__FILE__,__LINE__);


#define BIT_NUMBER(x) (x & 7)
#define BIT_REGISTER(x) (x>>3)


#define LSB     0
#define MSB16   1
#define MSB24   2
#define MSB32   3


#define FUNCTION_LABEL_INC  40

int picoBlaze_getDataSize(operand *op);
void picoBlaze_emitpcode_real(PIC_OPCODE poc, pCodeOp *pcop);
#define picoBlaze_emitpcode(poc,pcop)	do { if (picoBlaze_pcode_verbose) picoBlaze_emitpcomment ("%s:%u(%s):", __FILE__, __LINE__, __FUNCTION__); picoBlaze_emitpcode_real(poc,pcop); } while(0)
void picoBlaze_emitpLabel(int key);
void picoBlaze_emitcode (char *inst,char *fmt, ...);
void DEBUGpicoBlaze_emitcode (char *inst,char *fmt, ...);
void picoBlaze_emitDebuggerSymbol (char *);
bool picoBlaze_sameRegs (asmop *aop1, asmop *aop2 );
char *picoBlaze_aopGet (asmop *aop, int offset, bool bit16, bool dname);
void DEBUGpicoBlaze_picoBlaze_AopType(int line_no, operand *left, operand *right, operand *result);
void DEBUGpicoBlaze_picoBlaze_AopTypeSign(int line_no, operand *left, operand *right, operand *result);


bool picoBlaze_genPlusIncr (iCode *ic);
void picoBlaze_outBitAcc(operand *result);
void picoBlaze_genPlusBits (iCode *ic);
void picoBlaze_genPlus (iCode *ic);
bool picoBlaze_genMinusDec (iCode *ic);
void picoBlaze_addSign(operand *result, int offset, int sign);
void picoBlaze_genMinusBits (iCode *ic);
void picoBlaze_genMinus (iCode *ic);
void picoBlaze_genLeftShiftLiteral (operand *left, operand *right, operand *result, iCode *ic);

pCodeOp *picoBlaze_popGet2p(pCodeOp *src, pCodeOp *dst);
void picoBlaze_emitpcomment (char *fmt, ...);

pCodeOp *picoBlaze_popGetLabel(int key);
pCodeOp *picoBlaze_popCopyReg(pCodeOpReg *pc);
pCodeOp *picoBlaze_popCopyGPR2Bit(pCodeOp *pc, int bitval);
pCodeOp *picoBlaze_popGetLit(int lit);
pCodeOp *picoBlaze_popGetLit2(int lit, pCodeOp *arg2);
pCodeOp *popGetWithString(char *str);
pCodeOp *picoBlaze_popGet (asmop *aop, int offset);//, bool bit16, bool dname);
pCodeOp *picoBlaze_popGetTempReg(int lock);
pCodeOp *picoBlaze_popGetTempRegCond(bitVect *, bitVect *, int lock);
void picoBlaze_popReleaseTempReg(pCodeOp *pcop, int lock);

pCodeOp *picoBlaze_popCombine2(pCodeOpReg *src, pCodeOpReg *dst, int noalloc);

void picoBlaze_aopPut (asmop *aop, char *s, int offset);
void picoBlaze_outAcc(operand *result);
void picoBlaze_aopOp (operand *op, iCode *ic, bool result);
void picoBlaze_outBitC(operand *result);
void picoBlaze_toBoolean(operand *oper);
void picoBlaze_freeAsmop (operand *op, asmop *aaop, iCode *ic, bool pop);
const char *picoBlaze_pCodeOpType(  pCodeOp *pcop);
int picoBlaze_my_powof2 (unsigned long num);

void picoBlaze_mov2w (asmop *aop, int offset);
void picoBlaze_mov2f(asmop *dst, asmop *src, int offset);

bool picoBlaze_isLitOp(operand *op);
bool picoBlaze_isLitAop(asmop *aop);

void dumpiCode(iCode *lic);

int picoBlaze_inWparamList(char *s);

/* JSON code generation - helpers */
extern 	FILE *iCodeDumpFile;
extern int iCodeDumpFileDeep;
void dumpICode(char * format, ...);
#define iDumpU(name, val) dumpICode("\"%s\": %u,\n", (name), (val));
#define iDumpI(name, val) dumpICode("\"%s\": %I,\n", (name), (val));
void iDumpStruct(char * aString, int isEnd);
void iDumpS(char * name, char * val);
/* End of JSON code generation - helpers */

#include "device.h"

#define DUMP_FUNCTION_ENTRY	1
#define DUMP_FUNCTION_EXIT	0

#if DUMP_FUNCTION_ENTRY
#define FENTRY	if(picoBlaze_options.debgen&2)picoBlaze_emitpcomment("**{\t%d %s", __LINE__, __FUNCTION__)
#define FENTRY2 if(picoBlaze_options.debgen&2)picoBlaze_emitpcomment("**{\t%d %s", __LINE__, __FUNCTION__)
#else
#define FENTRY
#define FENTRY2
#endif

#if DUMP_FUNCTION_EXIT
#define FEXIT	if(picoBlaze_options.debgen&2)picoBlaze_emitpcomment("; **}", "%d %s", __LINE__, __FUNCTION__)
#define FEXIT2	if(picoBlaze_options.debgen&2)picoBlaze_emitpcomment("**{\t%d %s", __LINE__, __FUNCTION__)
#else
#define FEXIT
#define FEXIT2
#endif

#define ERROR	werror(W_POSSBUG2, __FILE__, __LINE__)
#endif
