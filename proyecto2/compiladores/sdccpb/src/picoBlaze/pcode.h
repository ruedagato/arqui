/*-------------------------------------------------------------------------

   pcode.h - post code generation
   Written By -  Scott Dattalo scott@dattalo.com
   Ported to PICOBLAZE By -  Martin Dubuc m.dubuc@rogers.com

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

//#include "ralloc.h"
struct regs;

/*
   Post code generation

   The post code generation is an assembler optimizer. The assembly code
   produced by all of the previous steps is fully functional. This step
   will attempt to analyze the flow of the assembly code and agressively
   optimize it. The peep hole optimizer attempts to do the same thing.
   As you may recall, the peep hole optimizer replaces blocks of assembly
   with more optimal blocks (e.g. removing redundant register loads).
   However, the peep hole optimizer has to be somewhat conservative since
   an assembly program has implicit state information that's unavailable
   when only a few instructions are examined.
     Consider this example:

   example1:
     movwf  t1
     movf   t1,w

   The movf seems redundant since we know that the W register already
   contains the same value of t1. So a peep hole optimizer is tempted to
   remove the "movf". However, this is dangerous since the movf affects
   the flags in the status register (specifically the Z flag) and subsequent
   code may depend upon this. Look at these two examples:

   example2:
     movwf  t1
     movf   t1,w     ; Can't remove this movf
     skpz
      return

   example3:
     movwf  t1
     movf   t1,w     ; This  movf can be removed
     xorwf  t2,w     ; since xorwf will over write Z
     skpz
      return

*/


#ifndef __PCODE_H__
#define __PCODE_H__

/***********************************************************************
 * debug stuff
 *
 * The DFPRINTF macro will call fprintf if PCODE_DEBUG is defined.
 * The macro is used like:
 *
 * DPRINTF(("%s #%d\n","test", 1));
 *
 * The double parenthesis (()) are necessary
 *
 ***********************************************************************/
#define PCODE_DEBUG

#ifdef PCODE_DEBUG
#define DFPRINTF(args) (fprintf args)
#else
#define DFPRINTF(args) ;
#endif


#ifdef WORDS_BIGENDIAN
  #define _ENDIAN(x)  (3-x)
#else
  #define _ENDIAN(x)  (x)
#endif


#define BYTE_IN_LONG(x,b) ((x>>(8*_ENDIAN(b)))&0xff)


/***********************************************************************
 * Extended Instruction Set/Indexed Literal Offset Mode                *
 * Set this macro to enable code generation with the extended          *
 * instruction set and the new Indexed Literal Offset Mode             *
 ***********************************************************************/
#define XINST   1

/***********************************************************************
 *  PicoBlaze status bits
 ***********************************************************************/
#define PIC_C_BIT    0
#define PIC_Z_BIT    2


/***********************************************************************
 *  Operand types
 ***********************************************************************/
#define POT_RESULT  0
#define POT_LEFT    1
#define POT_RIGHT   2

/***********************************************************************
 *
 *  PICOBLAZE_OPTYPE - Operand types that are specific to the PIC architecture
 *
 *  If a PIC assembly instruction has an operand then here is where we
 *  associate a type to it. For example,
 *
 *     movf    reg,W
 *
 *  The movf has two operands: 'reg' and the W register. 'reg' is some
 *  arbitrary general purpose register, hence it has the type PO_GPR_REGISTER.
 *  The W register, which is the PIC's accumulator, has the type PO_W.
 *
 ***********************************************************************/



typedef enum
{
  PO_NONE=0,         // No operand e.g. NOP
  PO_GPR_REGISTER,   // A general purpose register
  PO_GPR_BIT,        // A bit of a general purpose register
  PO_GPR_TEMP,       // A general purpose temporary register
  PO_LITERAL,        // A constant
  PO_DIR,            // Direct memory (8051 legacy)
  PO_LABEL,
  PO_GPR_SP		     // A stack pointer register (sF) /* PicoBlazed */
} PICOBLAZE_OPTYPE;


/***********************************************************************
 *
 *  PIC_OPCODE
 *
 *  This is not a list of the PIC's opcodes per se, but instead
 *  an enumeration of all of the different types of pic opcodes.
 *
 ***********************************************************************/
/* TODO: rename to PicoBlaze_OPCODE, abbrev. PBOC_... */
typedef enum
{
  POC_WILD=-1,   /* Wild card - used in the pCode peep hole optimizer
                  * to represent ANY pic opcode */
  POC_ADDLW=0,
  POC_ADDWF,
  POC_ADDFW,
  POC_ADDFWC,
  POC_ADDWFC,
  POC_ANDLW,
  POC_ANDWF,
  POC_ANDFW,
  POC_BC,
  POC_BCF,
  POC_BN,
  POC_BNC,
  POC_BNN,
  POC_BNOV,
  POC_BNZ,
  POC_BOV,
  POC_BRA,
  POC_BSF,
  POC_BTFSC,
  POC_BTFSS,
  POC_BTG,
  POC_BZ,
  POC_CALL,
  POC_CLRF,
  POC_CLRWDT,
  POC_COMF,
  POC_COMFW,
  POC_CPFSEQ,
  POC_CPFSGT,
  POC_CPFSLT,
  POC_DAW,
  POC_DCFSNZ,
  POC_DCFSNZW,
  POC_DECF,
  POC_DECFW,
  POC_DECFSZ,
  POC_DECFSZW,
  POC_GOTO,
  POC_INCF,
  POC_INCFW,
  POC_INCFSZ,
  POC_INCFSZW,
  POC_INFSNZ,
  POC_INFSNZW,
  POC_IORWF,
  POC_IORFW,
  POC_IORLW,
  POC_LFSR,
  POC_MOVF,
  POC_MOVFW,
  POC_MOVFF,
  POC_MOVLB,
  POC_MOVLW,
  POC_MOVWF,
  POC_MULLW,
  POC_MULWF,
  POC_NEGF,
  POC_NOP,
  POC_POP,
  POC_PUSH,
  POC_RCALL,
  POC_RETFIE,
  POC_RETLW,
  POC_RETURN,
  POC_RLCF,
  POC_RLCFW,
  POC_RLNCF,
  POC_RLNCFW,
  POC_RRCF,
  POC_RRCFW,
  POC_RRNCF,
  POC_RRNCFW,
  POC_SETF,
  POC_SUBLW,
  POC_SUBFWB,
  POC_SUBWF,
  POC_SUBFW,
  POC_SUBWFB_D0,
  POC_SUBWFB_D1,
  POC_SUBFWB_D0,
  POC_SUBFWB_D1,
  POC_SWAPF,
  POC_SWAPFW,
  POC_TBLRD,
  POC_TBLRD_POSTINC,
  POC_TBLRD_POSTDEC,
  POC_TBLRD_PREINC,
  POC_TBLWT,
  POC_TBLWT_POSTINC,
  POC_TBLWT_POSTDEC,
  POC_TBLWT_PREINC,
  POC_TSTFSZ,
  POC_XORLW,
  POC_XORWF,
  POC_XORFW,

  POC_BANKSEL,

  /* PicoBlaze real instructions PBOC = PicoBlaze OpCodes */
  PBOC_NOP,

  PBOC_ADD_SXKK,
  PBOC_ADD_SXSY,
  PBOC_ADDCY_SXKK,
  PBOC_ADDCY_SXSY,
  PBOC_AND_SXKK,
  PBOC_AND_SXSY,
  PBOC_CALL,
  PBOC_CALLC,
  PBOC_CALLNC,
  PBOC_CALLNZ,
  PBOC_CALLZ,
  PBOC_COMPARE_SXKK,
  PBOC_COMPARE_SXSY,
  PBOC_DISABLE_INTERRUPT,
  PBOC_ENABLE_INTERRUPT,
  PBOC_FETCH_SXSS,
  PBOC_FETCH_SXISY,
  PBOC_INPUT_SXISY,	/* sX, (sY) */
  PBOC_INPUT_SXPP,
  PBOC_JUMP,
  PBOC_JUMPC,
  PBOC_JUMPNC,
  PBOC_JUMPNZ,
  PBOC_JUMPZ,
  PBOC_LOAD_SXKK,
  PBOC_LOAD_SXSY,
  PBOC_OR_SXKK,
  PBOC_OR_SXSY,
  PBOC_OUTPUT_SXISY,
  PBOC_OUTPUT_SXPP,
  PBOC_RETURN,
  PBOC_RETURNC,
  PBOC_RETURNNC,
  PBOC_RETURNNZ,
  PBOC_RETURNZ,
  PBOC_RETURNI_DISABLE,
  PBOC_RETURNI_ENABLE,
  PBOC_RL_SX,
  PBOC_RR_SX,
  PBOC_SL0_SX,
  PBOC_SL1_SX,
  PBOC_SLA_SX,
  PBOC_SLX_SX,
  PBOC_SR0_SX,
  PBOC_SR1_SX,
  PBOC_SRA_SX,
  PBOC_SRX_SX,
  PBOC_STORE_SXSS,
  PBOC_STORE_SXISY,
  PBOC_SUB_SXKK,
  PBOC_SUB_SXSY,
  PBOC_SUBCY_SXKK,
  PBOC_SUBCY_SXSY,
  PBOC_TEST_SXKK,
  PBOC_TEST_SXSY,
  PBOC_XOR_SXKK,
  PBOC_XOR_SXSY,

  /* pseudo-instructions */
} PIC_OPCODE;


/***********************************************************************
 *  PC_TYPE  - pCode Types
 ***********************************************************************/

typedef enum
{
  PC_COMMENT=0,   /* pCode is a comment     */
  PC_INLINE,      /* user's inline code     */
  PC_OPCODE,      /* PORT dependent opcode  */
  PC_LABEL,       /* assembly label         */
  PC_FLOW,        /* flow analysis          */
  PC_FUNCTION,    /* Function start or end  */
  PC_WILD,        /* wildcard - an opcode place holder used
                   * in the pCode peep hole optimizer */
  PC_CSOURCE,     /* C-Source Line  */
  PC_ASMDIR,      /* Assembler directive */
  PC_BAD,         /* Mark the pCode object as being bad */
  PC_INFO         /* pCode information node, used primarily in optimizing */
} PC_TYPE;


/***********************************************************************
 *  INFO_TYPE  - information node types
 ***********************************************************************/

typedef enum
{
  INF_OPTIMIZATION,      /* structure contains optimization information */
  INF_LOCALREGS          /* structure contains local register information */
} INFO_TYPE;



/***********************************************************************
 *  OPT_TYPE  - optimization node types
 ***********************************************************************/

typedef enum
{
  OPT_BEGIN,             /* mark beginning of optimization block */
  OPT_END,               /* mark ending of optimization block */
  OPT_JUMPTABLE_BEGIN,   /* mark beginning of a jumptable */
  OPT_JUMPTABLE_END      /* mark end of jumptable */
} OPT_TYPE;

/***********************************************************************
 *  LR_TYPE  - optimization node types
 ***********************************************************************/

typedef enum
{
  LR_ENTRY_BEGIN,             /* mark beginning of optimization block */
  LR_ENTRY_END,               /* mark ending of optimization block */
  LR_EXIT_BEGIN,
  LR_EXIT_END
} LR_TYPE;


/************************************************/
/***************  Structures ********************/
/************************************************/
/* These are here as forward references - the
 * full definition of these are below           */
struct pCode;
struct pCodeWildBlock;
struct pCodeRegLives;

/*************************************************
  pBranch

  The first step in optimizing pCode is determining
 the program flow. This information is stored in
 single-linked lists in the for of 'from' and 'to'
 objects with in a pcode. For example, most instructions
 don't involve any branching. So their from branch
 points to the pCode immediately preceding them and
 their 'to' branch points to the pcode immediately
 following them. A skip instruction is an example of
 a pcode that has multiple (in this case two) elements
 in the 'to' branch. A 'label' pcode is an where there
 may be multiple 'from' branches.
 *************************************************/

typedef struct pBranch
{
  struct pCode   *pc;    // Next pCode in a branch
  struct pBranch *next;  /* If more than one branch
                          * the next one is here */

} pBranch;

/*************************************************
  pCodeOp

  pCode Operand structure.
  For those assembly instructions that have arguments,
  the pCode will have a pCodeOp in which the argument
  can be stored. For example

    movf   some_register,w

  'some_register' will be stored/referenced in a pCodeOp

 *************************************************/

typedef struct pCodeOp
{
  PICOBLAZE_OPTYPE type;
  char *name;

} pCodeOp;

typedef struct pCodeOpLit
{
  pCodeOp pcop;
  int lit;
  pCodeOp *arg2;        /* needed as pCodeOpLit and pCodeOpLit2 are not separable via their type (PO_LITERAL) */
} pCodeOpLit;

typedef struct pCodeOpLit2
{
  pCodeOp pcop;
  int lit;
  pCodeOp *arg2;
} pCodeOpLit2;


typedef struct pCodeOpImmd
{
  pCodeOp pcop;
  int offset;           /* low,high or upper byte of immediate value */
  int index;            /* add this to the immediate value */
  unsigned _const:1;    /* is in code space    */

  int rIdx;             /* If this immd points to a register */
  struct regs *r;       /* then this is the reg. */

} pCodeOpImmd;

typedef struct pCodeOpLabel
{
  pCodeOp pcop;
  int key;
} pCodeOpLabel;

typedef struct pCodeOpReg
{
  pCodeOp pcop;    // Can be either GPR or SFR
  int rIdx;        // Index into the register table
  struct regs *r;
  int instance;    // byte # of Multi-byte registers
  struct pBlock *pb;
} pCodeOpReg;

typedef struct pCodeOp2
{
  pCodeOp pcop;         // describes this pCodeOp
  pCodeOp *pcopL;       // reference to left pCodeOp (src)
  pCodeOp *pcopR;       // reference to right pCodeOp (dest)
} pCodeOp2;

typedef struct pCodeOpRegBit
{
  pCodeOpReg  pcor;       // The Register containing this bit
  int bit;                // 0-7 bit number.
  PICOBLAZE_OPTYPE subtype;     // The type of this register.
  unsigned int inBitSpace: 1; /* True if in bit space, else
                                 just a bit of a register */
} pCodeOpRegBit;


typedef struct pCodeOpWild
{
  pCodeOp pcop;

  struct pCodeWildBlock *pcwb;

  int id;                 /* index into an array of char *'s that will match
                           * the wild card. The array is in *pcp. */
  pCodeOp *subtype;       /* Pointer to the Operand type into which this wild
                           * card will be expanded */
  pCodeOp *matched;       /* When a wild matches, we'll store a pointer to the
                           * opcode we matched */

  pCodeOp *pcop2;         /* second operand if exists */

} pCodeOpWild;


typedef struct pCodeOpOpt
{
  pCodeOp pcop;

  OPT_TYPE type;          /* optimization node type */

  char *key;              /* key by which a block is identified */
} pCodeOpOpt;

typedef struct pCodeOpLocalReg
{
  pCodeOp pcop;

  LR_TYPE type;
} pCodeOpLocalReg;

/*************************************************
    pCode

    Here is the basic build block of a PIC instruction.
    Each pic instruction will get allocated a pCode.
    A linked list of pCodes makes a program.

**************************************************/

typedef struct pCode
{
  PC_TYPE    type;

  struct pCode *prev;  // The pCode objects are linked together
  struct pCode *next;  // in doubly linked lists.

  int seq;             // sequence number

  struct pBlock *pb;   // The pBlock that contains this pCode.

  /* "virtual functions"
   *  The pCode structure is like a base class
   * in C++. The subsequent structures that "inherit"
   * the pCode structure will initialize these function
   * pointers to something useful */
  //  void (*analyze) (struct pCode *_this);
  void (*destruct)(struct pCode *_this);
  void (*print)  (FILE *of,struct pCode *_this);
} pCode;


/*************************************************
    pCodeComment
**************************************************/

typedef struct pCodeComment
{

  pCode  pc;

  char *comment;

} pCodeComment;


/*************************************************
    pCodeCSource
**************************************************/

typedef struct pCodeCSource
{

  pCode  pc;

  int  line_number;
  char *line;
  char *file_name;

} pCodeCSource;


/*************************************************
    pCodeAsmDir
**************************************************/

/*************************************************
    pCodeFlow

  The Flow object is used as marker to separate
 the assembly code into contiguous chunks. In other
 words, everytime an instruction cause or potentially
 causes a branch, a Flow object will be inserted into
 the pCode chain to mark the beginning of the next
 contiguous chunk.

**************************************************/
struct defmap_s; // defined in pcode.c

typedef struct pCodeFlow
{

  pCode  pc;

  pCode *end;   /* Last pCode in this flow. Note that
                   the first pCode is pc.next */

  /*  set **uses;   * map the pCode instruction inCond and outCond conditions
                 * in this array of set's. The reason we allocate an
                 * array of pointers instead of declaring each type of
                 * usage is because there are port dependent usage definitions */
  //int nuses;    /* number of uses sets */

  set *from;    /* flow blocks that can send control to this flow block */
  set *to;      /* flow blocks to which this one can send control */
  struct pCodeFlow *ancestor; /* The most immediate "single" pCodeFlow object that
                               * executes prior to this one. In many cases, this
                               * will be just the previous */

  int inCond;   /* Input conditions - stuff assumed defined at entry */
  int outCond;  /* Output conditions - stuff modified by flow block */

  int firstBank; /* The first and last bank flags are the first and last */
  int lastBank;  /* register banks used within one flow object */

  int FromConflicts;
  int ToConflicts;

  set *registers;/* Registers used in this flow */

  struct defmap_s *defmap;      /* chronologically ordered list of definitions performed
                           in this flow (most recent at the front) */
  struct defmap_s *in_vals;     /* definitions of all symbols reaching this flow
                                 * symbols with multiple different definitions are stored
                                 * with an assigned value of 0. */
  struct defmap_s *out_vals;    /* definitions valid AFTER thie flow */

} pCodeFlow;

/*************************************************
  pCodeFlowLink

  The Flow Link object is used to record information
 about how consecutive excutive Flow objects are related.
 The pCodeFlow objects demarcate the pCodeInstructions
 into contiguous chunks. The FlowLink records conflicts
 in the discontinuities. For example, if one Flow object
 references a register in bank 0 and the next Flow object
 references a register in bank 1, then there is a discontinuity
 in the banking registers.

*/
typedef struct pCodeFlowLink
{
  pCodeFlow  *pcflow;   /* pointer to linked pCodeFlow object */

  int bank_conflict;    /* records bank conflicts */

} pCodeFlowLink;

/*************************************************
    pCodeInstruction

    Here we describe all the facets of a PIC instruction
    (expansion for the 18cxxx is also provided).

**************************************************/

typedef struct pCodeInstruction
{

  pCode  pc;

  PIC_OPCODE op;        // The opcode of the instruction.

  char const * const mnemonic;       // Pointer to mnemonic string

  char isize;          // pCode instruction size

  pBranch *from;       // pCodes that execute before this one
  pBranch *to;         // pCodes that execute after
  pBranch *label;      // pCode instructions that have labels

  pCodeOp *pcop;               /* Operand, if this instruction has one */
  pCodeFlow *pcflow;           /* flow block to which this instruction belongs */
  pCodeCSource *cline;         /* C Source from which this instruction was derived */

  unsigned int num_ops;        /* Number of operands (0,1,2 for mid range pics) */
  unsigned int isModReg:  1;   /* If destination is W or F, then 1==F */
  unsigned int isBitInst: 1;   /* e.g. BCF = clear given bit in a register */
  unsigned int isBranch:  1;   /* True if this is a branching instruction */
  unsigned int isSkip:    1;   /* True if this is a skip instruction */
  unsigned int isLit:     1;   /* True if this instruction has an literal operand */
  unsigned int isAccess:   1;   /* True if this instruction has an access RAM operand */
  unsigned int isFastCall: 1;   /* True if this instruction has a fast call/return mode select operand */
  unsigned int is2MemOp: 1;     /* True is second operand is a memory operand VR - support for MOVFF */
  unsigned int is2LitOp: 1;     /* True if instruction takes 2 literal operands VR - support for LFSR */

  PIC_OPCODE inverted_op;      /* Opcode of instruction that's the opposite of this one */
  unsigned int inCond;   // Input conditions for this instruction
  unsigned int outCond;  // Output conditions for this instruction

#define PCI_MAGIC       0x6e12
  unsigned int pci_magic;       // sanity check for pci initialization
} pCodeInstruction;



/*************************************************
    pCodeAsmDir
**************************************************/

typedef struct pCodeAsmDir
{
  pCodeInstruction pci;

  char *directive;
  char *arg;
} pCodeAsmDir;


/*************************************************
    pCodeLabel
**************************************************/

typedef struct pCodeLabel
{

  pCode  pc;

  char *label;
  int key;
  int force;            /* label cannot be optimized out */

} pCodeLabel;

/*************************************************
    pCodeFunction
**************************************************/

typedef struct pCodeFunction
{

  pCode  pc;

  char *modname;
  char *fname;     /* If NULL, then this is the end of
                      a function. Otherwise, it's the
                      start and the name is contained
                      here */

  pBranch *from;       // pCodes that execute before this one
  pBranch *to;         // pCodes that execute after
  pBranch *label;      // pCode instructions that have labels

  int  ncalled;    /* Number of times function is called */

  int absblock;    /* hack to emulate a block pCodes in absolute position
                      but not inside a function */
  int stackusage;  /* stack positions used in function */

} pCodeFunction;


/*************************************************
    pCodeWild
**************************************************/

typedef struct pCodeWild
{

  pCodeInstruction  pci;

  int    id;     /* Index into the wild card array of a peepBlock
                  * - this wild card will get expanded into that pCode
                  *   that is stored at this index */

  /* Conditions on wild pcode instruction */
  int    mustBeBitSkipInst:1;
  int    mustNotBeBitSkipInst:1;
  int    invertBitSkipInst:1;

  pCodeOp *operand;  // Optional operand
  pCodeOp *label;    // Optional label

} pCodeWild;


/*************************************************
    pInfo

    Here are stored generic informaton
*************************************************/
typedef struct pCodeInfo
{
  pCodeInstruction pci;

  INFO_TYPE type;       /* info node type */

  pCodeOp *oper1;       /* info node arguments */
} pCodeInfo;


/*************************************************
    pBlock

    Here are program snippets (blocks). There's a strong
    correlation between the eBBlocks and pBlocks.
    SDCC subdivides a C program into managable chunks.
    Each chunk becomes a eBBlock and ultimately in this
    port a pBlock.

**************************************************/

typedef struct pBlock
{
  memmap *cmemmap;   /* The snippet is from this memmap */
  char   dbName;     /* if cmemmap is NULL, then dbName will identify the block */
  pCode *pcHead;     /* A pointer to the first pCode in a link list of pCodes */
  pCode *pcTail;     /* A pointer to the last pCode in a link list of pCodes */

  struct pBlock *next;      /* The pBlocks will form a doubly linked list */
  struct pBlock *prev;

  set *function_entries;    /* dll of functions in this pblock */
  set *function_exits;
  set *function_calls;
  set *tregisters;

  set *FlowTree;
  unsigned visited:1;       /* set true if traversed in call tree */

  unsigned seq;             /* sequence number of this pBlock */

} pBlock;

/*************************************************
    pFile

    The collection of pBlock program snippets are
    placed into a linked list that is implemented
    in the pFile structure.

    The pcode optimizer will parse the pFile.

**************************************************/

typedef struct pFile
{
  pBlock *pbHead;     /* A pointer to the first pBlock */
  pBlock *pbTail;     /* A pointer to the last pBlock */

  pBranch *functions; /* A SLL of functions in this pFile */

} pFile;



/*************************************************
  pCodeWildBlock

  The pCodeWildBlock object keeps track of the wild
  variables, operands, and opcodes that exist in
  a pBlock.
**************************************************/
typedef struct pCodeWildBlock {
  pBlock    *pb;
  struct pCodePeep *pcp;    // pointer back to ... I don't like this...

  int       nvars;          // Number of wildcard registers in target.
  char    **vars;           // array of pointers to them

  int       nops;           // Number of wildcard operands in target.
  pCodeOp **wildpCodeOps;   // array of pointers to the pCodeOp's.

  int       nwildpCodes;    // Number of wildcard pCodes in target/replace
  pCode   **wildpCodes;     // array of pointers to the pCode's.

} pCodeWildBlock;

/*************************************************
  pCodePeep

  The pCodePeep object mimics the peep hole optimizer
  in the main SDCC src (e.g. SDCCpeeph.c). Essentially
  there is a target pCode chain and a replacement
  pCode chain. The target chain is compared to the
  pCode that is generated by gen.c. If a match is
  found then the pCode is replaced by the replacement
  pCode chain.
**************************************************/
typedef struct pCodePeep {
  pCodeWildBlock target;     // code we'd like to optimize
  pCodeWildBlock replace;    // and this is what we'll optimize it with.

  //pBlock *target;
  //pBlock replace;            // and this is what we'll optimize it with.



  /* (Note: a wildcard register is a place holder. Any register
   * can be replaced by the wildcard when the pcode is being
   * compared to the target. */

  /* Post Conditions. A post condition is a condition that
   * must be either true or false before the peep rule is
   * accepted. For example, a certain rule may be accepted
   * if and only if the Z-bit is not used as an input to
   * the subsequent instructions in a pCode chain.
   */
  unsigned int postFalseCond;
  unsigned int postTrueCond;

} pCodePeep;

/*************************************************

  pCode peep command definitions

 Here are some special commands that control the
way the peep hole optimizer behaves

**************************************************/

enum peepCommandTypes{
  NOTBITSKIP = 0,
  BITSKIP,
  INVERTBITSKIP,
  _LAST_PEEP_COMMAND_
};

/*************************************************
    peepCommand structure stores the peep commands.

**************************************************/

typedef struct peepCommand {
  int id;
  char *cmd;
} peepCommand;

/*************************************************
    pCode Macros

**************************************************/
#define PCODE(x)  ((pCode *)(x))
#define PCI(x)    ((pCodeInstruction *)(x))
#define PCL(x)    ((pCodeLabel *)(x))
#define PCF(x)    ((pCodeFunction *)(x))
#define PCFL(x)   ((pCodeFlow *)(x))
#define PCFLINK(x)((pCodeFlowLink *)(x))
#define PCW(x)    ((pCodeWild *)(x))
#define PCCS(x)   ((pCodeCSource *)(x))
#define PCAD(x)   ((pCodeAsmDir *)(x))
#define PCINF(x)  ((pCodeInfo *)(x))

#define PCOP(x)   ((pCodeOp *)(x))
#define PCOP2(x)  ((pCodeOp2 *)(x))
//#define PCOB(x)   ((pCodeOpBit *)(x))
#define PCOL(x)   ((pCodeOpLit *)(x))
#define PCOI(x)   ((pCodeOpImmd *)(x))
#define PCOLAB(x) ((pCodeOpLabel *)(x))
#define PCOR(x)   ((pCodeOpReg *)(x))
//#define PCOR2(x)  ((pCodeOpReg2 *)(x))
#define PCORB(x)  ((pCodeOpRegBit *)(x))
#define PCOO(x)   ((pCodeOpOpt *)(x))
#define PCOLR(x)  ((pCodeOpLocalReg *)(x))
#define PCOW(x)   ((pCodeOpWild *)(x))
#define PCOW2(x)  (PCOW(PCOW(x)->pcop2))
#define PBR(x)    ((pBranch *)(x))

#define PCWB(x)   ((pCodeWildBlock *)(x))


/*
  macros for checking pCode types
*/
#define isPCI(x)        ((PCODE(x)->type == PC_OPCODE))
#define isPCI_BRANCH(x) ((PCODE(x)->type == PC_OPCODE) &&  PCI(x)->isBranch)
#define isPCI_SKIP(x)   ((PCODE(x)->type == PC_OPCODE) &&  PCI(x)->isSkip)
#define isPCI_LIT(x)    ((PCODE(x)->type == PC_OPCODE) &&  PCI(x)->isLit)
#define isPCI_BITSKIP(x)((PCODE(x)->type == PC_OPCODE) &&  PCI(x)->isSkip && PCI(x)->isBitInst)
#define isPCFL(x)       ((PCODE(x)->type == PC_FLOW))
#define isPCF(x)        ((PCODE(x)->type == PC_FUNCTION))
#define isPCL(x)        ((PCODE(x)->type == PC_LABEL))
#define isPCW(x)        ((PCODE(x)->type == PC_WILD))
#define isPCCS(x)       ((PCODE(x)->type == PC_CSOURCE))
#define isPCAD(x)       ((PCODE(x)->type == PC_ASMDIR))
#define isPCINFO(x)     ((PCODE(x)->type == PC_INFO))

#define isCALL(x)       ((isPCI(x)) && (PCI(x)->op == PBOC_CALL))
#define isACCESS_BANK(r)        (r->accessBank)



#define isPCOLAB(x)     ((PCOP(x)->type) == PO_LABEL)

/*-----------------------------------------------------------------*
 * pCode functions.
 *-----------------------------------------------------------------*/

pCode *picoBlaze_newpCode (PIC_OPCODE op, pCodeOp *pcop); // Create a new pCode given an operand
pCode *picoBlaze_newpCodeCharP(char *cP);              // Create a new pCode given a char *
pCode *picoBlaze_newpCodeInlineP(char *cP);            // Create a new pCode given a char *
pCode *picoBlaze_newpCodeFunction(char *g, char *f);   // Create a new function
pCode *picoBlaze_newpCodeLabel(char *name,int key);    // Create a new label given a key
pCode *picoBlaze_newpCodeLabelFORCE(char *name, int key); // Same as newpCodeLabel but label cannot be optimized out
pCode *picoBlaze_newpCodeCSource(int ln, const char *f, const char *l); // Create a new symbol line
pBlock *picoBlaze_newpCodeChain(memmap *cm,char c, pCode *pc); // Create a new pBlock
void picoBlaze_printpBlock(FILE *of, pBlock *pb);      // Write a pBlock to a file
void picoBlaze_addpCode2pBlock(pBlock *pb, pCode *pc); // Add a pCode to a pBlock
void picoBlaze_addpBlock(pBlock *pb);                  // Add a pBlock to a pFile
void picoBlaze_copypCode(FILE *of, char dbName);       // Write all pBlocks with dbName to *of
void picoBlaze_movepBlock2Head(char dbName);           // move pBlocks around
void picoBlaze_AnalyzepCode(char dbName);
void picoBlaze_AssignRegBanks(void);
void pCodePeepInit(void);
void picoBlaze_pBlockConvert2Absolute(pBlock *pb);
void picoBlaze_initDB(void);
void picoBlaze_emitDB(int c, char ptype, void *p);            // Add DB directives to a pBlock
void picoBlaze_emitDS(char *s, char ptype, void *p);
void picoBlaze_flushDB(char ptype, void *p);                          // Add pending DB data to a pBlock

pCode *picoBlaze_newpCodeAsmDir(char *asdir, char *argfmt, ...);

pCodeOp *picoBlaze_newpCodeOpLabel(char *name, int key);
pCodeOp *picoBlaze_newpCodeOpImmd(char *name, int offset, int index, int code_space);
pCodeOp *picoBlaze_newpCodeOpLit(int lit);
pCodeOp *picoBlaze_newpCodeOpLit12(int lit);
pCodeOp *picoBlaze_newpCodeOpLit2(int lit, pCodeOp *arg2);
pCodeOp *picoBlaze_newpCodeOpBit(char *name, int bit,int inBitSpace, PICOBLAZE_OPTYPE subt);
pCodeOp *picoBlaze_newpCodeOpBit_simple (struct asmop *op, int offs, int bit);
pCodeOp *picoBlaze_newpCodeOpRegFromStr(char *name);
pCodeOp *picoBlaze_newpCodeOpReg(int rIdx);
pCodeOp *picoBlaze_newpCodeOp(char *name, PICOBLAZE_OPTYPE p);
pCodeOp *picoBlaze_newpCodeOp2(pCodeOp *src, pCodeOp *dst);

pCodeOp *picoBlaze_pCodeOpCopy(pCodeOp *pcop);

pCode *picoBlaze_newpCodeInfo(INFO_TYPE type, pCodeOp *pcop);
pCodeOp *picoBlaze_newpCodeOpOpt(OPT_TYPE type, char *key);
pCodeOp *picoBlaze_newpCodeOpLocalRegs(LR_TYPE type);
pCodeOp *picoBlaze_newpCodeOpReg(int rIdx);

pCode * picoBlaze_findNextInstruction(pCode *pci);
pCode * picoBlaze_findNextpCode(pCode *pc, PC_TYPE pct);
int picoBlaze_isPCinFlow(pCode *pc, pCode *pcflow);
struct regs * picoBlaze_getRegFromInstruction(pCode *pc);
struct regs * picoBlaze_getRegFromInstruction2(pCode *pc);
char *picoBlaze_get_op(pCodeOp *pcop,char *buffer, size_t size);
char *picoBlaze_get_op2(pCodeOp *pcop,char *buffer, size_t size);
char *picoBlaze_dumpPicOptype(PICOBLAZE_OPTYPE type);

extern void picoBlaze_pcode_test(void);
extern int picoBlaze_debug_verbose;
extern int picoBlaze_pcode_verbose;

extern char *picoBlaze_LR_TYPE_STR[];


#ifndef debugf
//#define debugf(frm, rest...)       _picoBlaze_debugf(__FILE__, __LINE__, frm, rest)
#define debugf(frm, rest)       _picoBlaze_debugf(__FILE__, __LINE__, frm, rest)
#define debugf2(frm, arg1, arg2)        _picoBlaze_debugf(__FILE__, __LINE__, frm, arg1, arg2)
#define debugf3(frm, arg1, arg2, arg3)  _picoBlaze_debugf(__FILE__, __LINE__, frm, arg1, arg2, arg3)

#endif

extern void _picoBlaze_debugf(char *f, int l, char *frm, ...);


/*-----------------------------------------------------------------*
 * pCode objects (registers).
 *-----------------------------------------------------------------*/
extern pCodeOpReg *picoBlaze_stack_stackpointer;

#endif // __PCODE_H__
