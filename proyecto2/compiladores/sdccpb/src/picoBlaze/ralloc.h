/*-------------------------------------------------------------------------

  ralloc.h - header file register allocation

	Written By -  Sandeep Dutta . sandeep.dutta@usa.net (1998)
	PIC port   - T. Scott Dattalo scott@dattalo.com (2000)
	PICOBLAZE port   - Martin Dubuc m.dubuc@rogers.com (2002)

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
#include "SDCCicode.h"
#include "SDCCBBlock.h"
#ifndef SDCCRALLOC_H
#define SDCCRALLOC_H 1

#include "pcoderegs.h"

#include "rallocdbg.h"

/* Enumeration of PicoBlaze general purpose registers */
enum
  {
	s0_IDX,
	s1_IDX,
	s2_IDX,
	s3_IDX,
	s4_IDX,
	s5_IDX,
	s6_IDX,
	s7_IDX,
	s8_IDX,
	s9_IDX,
	sA_IDX,
	sB_IDX,
	sC_IDX,
	sD_IDX,
	sE_IDX,
	sF_IDX,
  };

enum {
 REG_PTR=1,		// pointer register *)
 REG_GPR,		// general purpose register *) 
 REG_CND,		// conditional register *)
};

/* definition for the registers */
typedef struct regs
  {
    short type;			/* can have value 
				 * REG_GPR, REG_PTR or REG_CND 
				 * This like the "meta-type" */
    short pc_type;              /* pcode type */
    short rIdx;			/* index into register table */
    //    short otype;        
    char *name;			/* name */

    unsigned isFree:1;		/* is currently unassigned  */

	// pic16 specific (not in z80 port):

    unsigned wasUsed:1;		/* becomes true if register has been used */
    unsigned isFixed:1;         /* True if address can't change */
//    unsigned isMapped:1;        /* The Register's address has been mapped to physical RAM */
    unsigned isBitField:1;      /* True if reg is type bit OR is holder for several bits */
    unsigned isEmitted:1;       /* True if the reg has been written to a .asm file */
    unsigned accessBank:1;	/* True if the reg is explicit placed in access bank */
    unsigned isLocal:1;		/* True if the reg is allocated in function's local frame */
    unsigned address;           /* reg's address if isFixed | isMapped is true */
    unsigned size;              /* 0 for byte, 1 for int, 4 for long */
    unsigned alias;             /* Alias mask if register appears in multiple banks */
    struct regs *reg_alias;     /* If more than one register share the same address 
				 * then they'll point to each other. (primarily for bits)*/
    operand *regop;		/* reference to the operand used to create the register */
    pCodeRegLives reglives; /* live range mapping */
  }
regs;
extern regs regspicoBlaze[];	/* TODO: looks like not used */
extern int picoBlaze_nRegs;		
extern int picoBlaze_Gstack_base_addr;	/* TODO: looks like not used */

/*
  As registers are created, they're added to a set (based on the
  register type). Here are the sets of registers that are supported
  in the PIC port:
*/
extern set *picoBlaze_dynAllocRegs;
extern set *picoBlaze_dynDirectRegs;
extern set *picoBlaze_dynDirectBitRegs;

extern set *picoBlaze_builtin_functions;

extern set *picoBlaze_rel_udata;
extern set *picoBlaze_fix_udata;
extern set *picoBlaze_equ_data;
extern set *picoBlaze_int_regs;
extern set *picoBlaze_acs_udata;

extern int picoBlaze_ptrRegReq;

regs *picoBlaze_allocProcessorRegister(int rIdx, char * name, short po_type, int alias);

regs *picoBlaze_regWithIdx (int);
regs *picoBlaze_typeRegWithIdx(int, int, int);
regs *picoBlaze_dirRegWithName (char *name );
regs *picoBlaze_allocRegWithName(char *name);
regs *picoBlaze_regWithName(char *name);
void  picoBlaze_freeAllRegs ();
void  picoBlaze_deallocateAllRegs ();
regs *picoBlaze_findFreeReg(short type);
regs *picoBlaze_findFreeRegNext(short type, regs *creg);
regs *picoBlaze_allocWithIdx (int idx);

regs *picoBlaze_allocDirReg (operand *op );
regs *picoBlaze_allocRegByName (char *name, int size, operand *op);
extern char *picoBlaze_decodeOp(unsigned int op);

regs* picoBlaze_newReg(int type, short pc_type, int rIdx, char *name, unsigned size, int alias, operand *refop);

#define IDX_s0		0x0
#define IDX_s1		0x1
#define IDX_s2		0x2
#define IDX_s3		0x3
#define IDX_s4		0x4
#define IDX_s5		0x5
#define IDX_SP		0xf


#endif
