/*-------------------------------------------------------------------------

  pcode.c - post code generation

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

#include <stdio.h>

#include "common.h"   // Include everything in the SDCC src directory
#include "newalloc.h"


#include "main.h"
#include "pcode.h"
#include "pcodeflow.h"
#include "ralloc.h"
#include "device.h"

extern char *picoBlaze_aopGet (struct asmop *aop, int offset, bool bit16, bool dname);

#if defined(__BORLANDC__) || defined(_MSC_VER)
#define inline
#endif

#define DUMP_DF_GRAPHS 0

/****************************************************************/
/****************************************************************/

static peepCommand peepCommands[] = {

  {NOTBITSKIP, "_NOTBITSKIP_"},
  {BITSKIP, "_BITSKIP_"},
  {INVERTBITSKIP, "_INVERTBITSKIP_"},

  {-1, NULL}
};



// Eventually this will go into device dependent files:
pCodeOpReg picoBlaze_pc_stackpointer    = {{PO_GPR_SP,   "SP"}, -1, NULL, 0, NULL};

//**// pCodeOpReg *picoBlaze_stackpnt_lo;
//**// pCodeOpReg *picoBlaze_stackpnt_hi;
//**// pCodeOpReg *picoBlaze_stack_postinc;
pCodeOpReg *picoBlaze_stack_stackpointer;
//**// pCodeOpReg *picoBlaze_stack_preinc;
//**// pCodeOpReg *picoBlaze_stack_plusw;

pCodeOpReg *picoBlaze_framepnt_lo;
pCodeOpReg *picoBlaze_framepnt_hi;
pCodeOpReg *picoBlaze_frame_postinc;
pCodeOpReg *picoBlaze_frame_postdec;
pCodeOpReg *picoBlaze_frame_preinc;
pCodeOpReg *picoBlaze_frame_plusw;

pCodeOpReg picoBlaze_pc_gpsimio   = {{PO_GPR_REGISTER, "GPSIMIO"}, -1, NULL, 0, NULL};
pCodeOpReg picoBlaze_pc_gpsimio2  = {{PO_GPR_REGISTER, "GPSIMIO2"}, -1, NULL, 0, NULL};

char *picoBlaze_OPT_TYPE_STR[] = { "begin", "end", "jumptable_begin", "jumptable_end" };
char *picoBlaze_LR_TYPE_STR[] = { "entry begin", "entry end", "exit begin", "exit end" };


static int mnemonics_initialized = 0;


static hTab *picoBlazeMnemonicsHash = NULL;
static hTab *picoBlazepCodePeepCommandsHash = NULL;

static pFile *the_pFile = NULL;
static pBlock *pb_dead_pcodes = NULL;

/* Hardcoded flags to change the behavior of the PIC port */
static int peepOptimizing = 1;        /* run the peephole optimizer if nonzero */
static int functionInlining = 1;      /* inline functions if nonzero */
int picoBlaze_debug_verbose = 0;      /* Set true to inundate .asm file */

int picoBlaze_pcode_verbose = 0;

//static int GpCodeSequenceNumber = 1;
static int GpcFlowSeq = 1;

extern void picoBlaze_RegsUnMapLiveRanges(void);
extern void picoBlaze_BuildFlowTree(pBlock *pb);

/****************************************************************/
/*                      Forward declarations                    */
/****************************************************************/

void picoBlaze_unlinkpCode(pCode *pc);


static void genericDestruct(pCode *pc);
static void genericPrint(FILE *of,pCode *pc);

static void pCodePrintLabel(FILE *of, pCode *pc);
static void pCodePrintFunction(FILE *of, pCode *pc);
static void pCodeOpPrint(FILE *of, pCodeOp *pcop);
static char *picoBlaze_get_op_from_instruction( pCodeInstruction *pcc);
char *picoBlaze_get_op(pCodeOp *pcop,char *buff,size_t buf_size);
int pCodePeepMatchLine(pCodePeep *peepBlock, pCode *pcs, pCode *pcd);
int picoBlaze_pCodePeepMatchRule(pCode *pc);
static void pBlockStats(FILE *of, pBlock *pb);
static pBlock *newpBlock(void);
extern void picoBlaze_pCodeInsertAfter(pCode *pc1, pCode *pc2);
extern pCodeOp *picoBlaze_popCopyReg(pCodeOpReg *pc);
pCodeOp *picoBlaze_popCopyGPR2Bit(pCodeOp *pc, int bitval);
void picoBlaze_pCodeRegMapLiveRanges(pBlock *pb);
void OptimizeLocalRegs(void);
pCodeOp *picoBlaze_popGet2p(pCodeOp *src, pCodeOp *dst);

char *picoBlaze_dumpPicOptype(PICOBLAZE_OPTYPE type);

pCodeOp *picoBlaze_popGetLit2(int, pCodeOp *);
pCodeOp *picoBlaze_popGetLit(int);
pCodeOp *picoBlaze_popGetWithString(char *);
extern int picoBlaze_inWparamList(char *s);

/** data flow optimization helpers **/
#if defined (DUMP_DF_GRAPHS) && DUMP_DF_GRAPHS > 0
static void picoBlaze_vcg_dump (FILE *of, pBlock *pb);
static void picoBlaze_vcg_dump_default (pBlock *pb);
#endif


static void picoBlaze_createDF (pBlock *pb);

#include "instructions.inc.h"

#define MAX_PICOBLAZEMNEMONICS 200
pCodeInstruction *picoBlazeMnemonics[MAX_PICOBLAZEMNEMONICS];

extern set *externs;

/* picoBlaze_pCodeInitRegisters - only sets up the flag of initialization and initializes pb_dead_pcodes */
void  picoBlaze_pCodeInitRegisters(void)
{
	static int initialized = 0;	// global flag of registers initialization (initialized only once)

	if(initialized)
			return;

	initialized = 1;

	/* TODO: initialize other instances of registers */
	picoBlaze_pc_stackpointer.r = picoBlaze_allocProcessorRegister(IDX_SP, "SP", PO_GPR_SP, 0);
	picoBlaze_stack_stackpointer = &picoBlaze_pc_stackpointer;
	picoBlaze_pc_stackpointer.rIdx = IDX_SP;

	/* probably should put this in a separate initialization routine */
	pb_dead_pcodes = newpBlock();

}

/*-----------------------------------------------------------------*/
/*  mnem2key - convert a pic mnemonic into a hash key              */
/*   (BTW - this spreads the mnemonics quite well)                 */
/*                                                                 */
/*-----------------------------------------------------------------*/

static int mnem2key(unsigned char const *mnem)
{
  int key = 0;

  if(!mnem)
    return 0;

  while(*mnem) {
    key += toupper(*mnem++) +1;
  }

  return (key & 0x1f);
}

/* picoBlazeinitMnemonics - initialize picoBlazeMnemonics array and picoBlazeMnemonicsHash table with the list of available instructions */
void picoBlazeinitMnemonics(void)
{
  int i = 0;
  int key;
  //  char *str;
  pCodeInstruction *pci;

  if(mnemonics_initialized)
    return;

  // NULL out the array before making the assignments
  // since we check the array contents below this initialization.

  for (i = 0; i < MAX_PICOBLAZEMNEMONICS; i++) {
    picoBlazeMnemonics[i] = NULL;
  }

  // TODO: smazat a nahradit instrukcemi PicoBlaze!
  picoBlazeMnemonics[POC_ADDLW] = &picoBlaze_pciADDLW;
  picoBlazeMnemonics[POC_ADDWF] = &picoBlaze_pciADDWF;
  picoBlazeMnemonics[POC_ADDFW] = &picoBlaze_pciADDFW;
  picoBlazeMnemonics[POC_ADDWFC] = &picoBlaze_pciADDWFC;
  picoBlazeMnemonics[POC_ADDFWC] = &picoBlaze_pciADDFWC;
  picoBlazeMnemonics[POC_ANDLW] = &picoBlaze_pciANDLW;
  picoBlazeMnemonics[POC_ANDWF] = &picoBlaze_pciANDWF;
  picoBlazeMnemonics[POC_ANDFW] = &picoBlaze_pciANDFW;
  picoBlazeMnemonics[POC_BC] = &picoBlaze_pciBC;
  picoBlazeMnemonics[POC_BCF] = &picoBlaze_pciBCF;
  picoBlazeMnemonics[POC_BN] = &picoBlaze_pciBN;
  picoBlazeMnemonics[POC_BNC] = &picoBlaze_pciBNC;
  picoBlazeMnemonics[POC_BNN] = &picoBlaze_pciBNN;
  picoBlazeMnemonics[POC_BNOV] = &picoBlaze_pciBNOV;
  picoBlazeMnemonics[POC_BNZ] = &picoBlaze_pciBNZ;
  picoBlazeMnemonics[POC_BOV] = &picoBlaze_pciBOV;
  picoBlazeMnemonics[POC_BRA] = &picoBlaze_pciBRA;
  picoBlazeMnemonics[POC_BSF] = &picoBlaze_pciBSF;
  picoBlazeMnemonics[POC_BTFSC] = &picoBlaze_pciBTFSC;
  picoBlazeMnemonics[POC_BTFSS] = &picoBlaze_pciBTFSS;
  picoBlazeMnemonics[POC_BTG] = &picoBlaze_pciBTG;
  picoBlazeMnemonics[POC_BZ] = &picoBlaze_pciBZ;
  picoBlazeMnemonics[POC_CALL] = &picoBlaze_pciCALL;
  picoBlazeMnemonics[POC_CLRF] = &picoBlaze_pciCLRF;
  picoBlazeMnemonics[POC_CLRWDT] = &picoBlaze_pciCLRWDT;
  picoBlazeMnemonics[POC_COMF] = &picoBlaze_pciCOMF;
  picoBlazeMnemonics[POC_COMFW] = &picoBlaze_pciCOMFW;
  picoBlazeMnemonics[POC_CPFSEQ] = &picoBlaze_pciCPFSEQ;
  picoBlazeMnemonics[POC_CPFSGT] = &picoBlaze_pciCPFSGT;
  picoBlazeMnemonics[POC_CPFSLT] = &picoBlaze_pciCPFSLT;
  picoBlazeMnemonics[POC_DAW] = &picoBlaze_pciDAW;
  picoBlazeMnemonics[POC_DCFSNZ] = &picoBlaze_pciDCFSNZ;
  picoBlazeMnemonics[POC_DECF] = &picoBlaze_pciDECF;
  picoBlazeMnemonics[POC_DECFW] = &picoBlaze_pciDECFW;
  picoBlazeMnemonics[POC_DECFSZ] = &picoBlaze_pciDECFSZ;
  picoBlazeMnemonics[POC_DECFSZW] = &picoBlaze_pciDECFSZW;
  picoBlazeMnemonics[POC_GOTO] = &picoBlaze_pciGOTO;
  picoBlazeMnemonics[POC_INCF] = &picoBlaze_pciINCF;
  picoBlazeMnemonics[POC_INCFW] = &picoBlaze_pciINCFW;
  picoBlazeMnemonics[POC_INCFSZ] = &picoBlaze_pciINCFSZ;
  picoBlazeMnemonics[POC_INCFSZW] = &picoBlaze_pciINCFSZW;
  picoBlazeMnemonics[POC_INFSNZ] = &picoBlaze_pciINFSNZ;
  picoBlazeMnemonics[POC_INFSNZW] = &picoBlaze_pciINFSNZW;
  picoBlazeMnemonics[POC_IORWF] = &picoBlaze_pciIORWF;
  picoBlazeMnemonics[POC_IORFW] = &picoBlaze_pciIORFW;
  picoBlazeMnemonics[POC_IORLW] = &picoBlaze_pciIORLW;
  picoBlazeMnemonics[POC_LFSR] = &picoBlaze_pciLFSR;
  picoBlazeMnemonics[POC_MOVF] = &picoBlaze_pciMOVF;
  picoBlazeMnemonics[POC_MOVFW] = &picoBlaze_pciMOVFW;
  picoBlazeMnemonics[POC_MOVFF] = &picoBlaze_pciMOVFF;
  picoBlazeMnemonics[POC_MOVLB] = &picoBlaze_pciMOVLB;
  picoBlazeMnemonics[POC_MOVLW] = &picoBlaze_pciMOVLW;
  picoBlazeMnemonics[POC_MOVWF] = &picoBlaze_pciMOVWF;
  picoBlazeMnemonics[POC_MULLW] = &picoBlaze_pciMULLW;
  picoBlazeMnemonics[POC_MULWF] = &picoBlaze_pciMULWF;
  picoBlazeMnemonics[POC_NEGF] = &picoBlaze_pciNEGF;
  picoBlazeMnemonics[POC_NOP] = &picoBlaze_pciNOP;
  picoBlazeMnemonics[POC_POP] = &picoBlaze_pciPOP;
  picoBlazeMnemonics[POC_PUSH] = &picoBlaze_pciPUSH;
  picoBlazeMnemonics[POC_RCALL] = &picoBlaze_pciRCALL;
  picoBlazeMnemonics[POC_RETFIE] = &picoBlaze_pciRETFIE;
  picoBlazeMnemonics[POC_RETLW] = &picoBlaze_pciRETLW;
  picoBlazeMnemonics[POC_RETURN] = &picoBlaze_pciRETURN;
  picoBlazeMnemonics[POC_RLCF] = &picoBlaze_pciRLCF;
  picoBlazeMnemonics[POC_RLCFW] = &picoBlaze_pciRLCFW;
  picoBlazeMnemonics[POC_RLNCF] = &picoBlaze_pciRLNCF;
  picoBlazeMnemonics[POC_RLNCFW] = &picoBlaze_pciRLNCFW;
  picoBlazeMnemonics[POC_RRCF] = &picoBlaze_pciRRCF;
  picoBlazeMnemonics[POC_RRCFW] = &picoBlaze_pciRRCFW;
  picoBlazeMnemonics[POC_RRNCF] = &picoBlaze_pciRRNCF;
  picoBlazeMnemonics[POC_RRNCFW] = &picoBlaze_pciRRNCFW;
  picoBlazeMnemonics[POC_SETF] = &picoBlaze_pciSETF;
  picoBlazeMnemonics[POC_SUBLW] = &picoBlaze_pciSUBLW;
  picoBlazeMnemonics[POC_SUBWF] = &picoBlaze_pciSUBWF;
  picoBlazeMnemonics[POC_SUBFW] = &picoBlaze_pciSUBFW;
  picoBlazeMnemonics[POC_SUBWFB_D0] = &picoBlaze_pciSUBWFB_D0;
  picoBlazeMnemonics[POC_SUBWFB_D1] = &picoBlaze_pciSUBWFB_D1;
  picoBlazeMnemonics[POC_SUBFWB_D0] = &picoBlaze_pciSUBFWB_D0;
  picoBlazeMnemonics[POC_SUBFWB_D1] = &picoBlaze_pciSUBFWB_D1;
  picoBlazeMnemonics[POC_SWAPF] = &picoBlaze_pciSWAPF;
  picoBlazeMnemonics[POC_SWAPFW] = &picoBlaze_pciSWAPFW;
  picoBlazeMnemonics[POC_TBLRD] = &picoBlaze_pciTBLRD;
  picoBlazeMnemonics[POC_TBLRD_POSTINC] = &picoBlaze_pciTBLRD_POSTINC;
  picoBlazeMnemonics[POC_TBLRD_POSTDEC] = &picoBlaze_pciTBLRD_POSTDEC;
  picoBlazeMnemonics[POC_TBLRD_PREINC] = &picoBlaze_pciTBLRD_PREINC;
  picoBlazeMnemonics[POC_TBLWT] = &picoBlaze_pciTBLWT;
  picoBlazeMnemonics[POC_TBLWT_POSTINC] = &picoBlaze_pciTBLWT_POSTINC;
  picoBlazeMnemonics[POC_TBLWT_POSTDEC] = &picoBlaze_pciTBLWT_POSTDEC;
  picoBlazeMnemonics[POC_TBLWT_PREINC] = &picoBlaze_pciTBLWT_PREINC;
  picoBlazeMnemonics[POC_TSTFSZ] = &picoBlaze_pciTSTFSZ;
  picoBlazeMnemonics[POC_XORLW] = &picoBlaze_pciXORLW;
  picoBlazeMnemonics[POC_XORWF] = &picoBlaze_pciXORWF;
  picoBlazeMnemonics[POC_XORFW] = &picoBlaze_pciXORFW;
  picoBlazeMnemonics[POC_BANKSEL] = &picoBlaze_pciBANKSEL;

// real picoblaze instructions

   picoBlazeMnemonics[PBOC_ADD_SXKK] = &picoBlaze_pciADD_SXKK;
   picoBlazeMnemonics[PBOC_ADD_SXSY] = &picoBlaze_pciADD_SXSY;
   picoBlazeMnemonics[PBOC_ADDCY_SXKK] = &picoBlaze_pciADDCY_SXKK;
   picoBlazeMnemonics[PBOC_ADDCY_SXSY] = &picoBlaze_pciADDCY_SXSY;
   picoBlazeMnemonics[PBOC_AND_SXKK] = &picoBlaze_pciAND_SXKK;
   picoBlazeMnemonics[PBOC_AND_SXSY] = &picoBlaze_pciAND_SXSY;
   picoBlazeMnemonics[PBOC_CALL] = &picoBlaze_pciCALL_PICOBLAZE;
   picoBlazeMnemonics[PBOC_CALLC] = &picoBlaze_pciCALLC;
   picoBlazeMnemonics[PBOC_CALLNC] = &picoBlaze_pciCALLNC;
   picoBlazeMnemonics[PBOC_CALLZ] = &picoBlaze_pciCALLZ;
   picoBlazeMnemonics[PBOC_CALLZ] = &picoBlaze_pciCALLNZ;
   picoBlazeMnemonics[PBOC_COMPARE_SXKK] = &picoBlaze_pciCOMPARE_SXKK;
   picoBlazeMnemonics[PBOC_COMPARE_SXSY] = &picoBlaze_pciCOMPARE_SXSY;
   picoBlazeMnemonics[PBOC_DISABLE_INTERRUPT] = &picoBlaze_pciDISABLE_INTERRUPT;
   picoBlazeMnemonics[PBOC_ENABLE_INTERRUPT] = &picoBlaze_pciENABLE_INTERRUPT;
   picoBlazeMnemonics[PBOC_FETCH_SXSS] = &picoBlaze_pciFETCH_SXSS;
   picoBlazeMnemonics[PBOC_FETCH_SXISY] = &picoBlaze_pciFETCH_SXISY;
   picoBlazeMnemonics[PBOC_INPUT_SXISY] = &picoBlaze_pciINPUT_SXISY;
   picoBlazeMnemonics[PBOC_INPUT_SXPP] = &picoBlaze_pciINPUT_SXPP;
   picoBlazeMnemonics[PBOC_JUMP] = &picoBlaze_pciJUMP;
   picoBlazeMnemonics[PBOC_JUMPC] = &picoBlaze_pciJUMPC;
   picoBlazeMnemonics[PBOC_JUMPNC] = &picoBlaze_pciJUMPNC;
   picoBlazeMnemonics[PBOC_JUMPNZ] = &picoBlaze_pciJUMPNZ;
   picoBlazeMnemonics[PBOC_JUMPZ] = &picoBlaze_pciJUMPZ;
   picoBlazeMnemonics[PBOC_LOAD_SXKK] = &picoBlaze_pciLOAD_SXKK;
   picoBlazeMnemonics[PBOC_LOAD_SXSY] = &picoBlaze_pciLOAD_SXSY;
   picoBlazeMnemonics[PBOC_OR_SXKK] = &picoBlaze_pciOR_SXKK;
   picoBlazeMnemonics[PBOC_OR_SXSY] = &picoBlaze_pciOR_SXSY;
   picoBlazeMnemonics[PBOC_OUTPUT_SXISY] = &picoBlaze_pciOUTPUT_SXISY;
   picoBlazeMnemonics[PBOC_OUTPUT_SXPP] = &picoBlaze_pciOUTPUT_SXPP;
   picoBlazeMnemonics[PBOC_RETURN] = &picoBlaze_pciRETURN_PICOBLAZE;
   picoBlazeMnemonics[PBOC_RETURNC] = &picoBlaze_pciRETURNC;
   picoBlazeMnemonics[PBOC_RETURNNC] = &picoBlaze_pciRETURNNC;
   picoBlazeMnemonics[PBOC_RETURNNZ] = &picoBlaze_pciRETURNNZ;
   picoBlazeMnemonics[PBOC_RETURNZ] = &picoBlaze_pciRETURNZ;
   picoBlazeMnemonics[PBOC_RETURNI_DISABLE] = &picoBlaze_pciRETURNI_DISABLE;
   picoBlazeMnemonics[PBOC_RETURNI_ENABLE] = &picoBlaze_pciRETURNI_ENABLE;
   picoBlazeMnemonics[PBOC_RL_SX] = &picoBlaze_pciRL_SX;
   picoBlazeMnemonics[PBOC_RR_SX] = &picoBlaze_pciRR_SX;
   picoBlazeMnemonics[PBOC_SL0_SX] = &picoBlaze_pciSL0_SX;
   picoBlazeMnemonics[PBOC_SL1_SX] = &picoBlaze_pciSL1_SX;
   picoBlazeMnemonics[PBOC_SLA_SX] = &picoBlaze_pciSLA_SX;
   picoBlazeMnemonics[PBOC_SLX_SX] = &picoBlaze_pciSLX_SX;
   picoBlazeMnemonics[PBOC_SR0_SX] = &picoBlaze_pciSR0_SX;
   picoBlazeMnemonics[PBOC_SR1_SX] = &picoBlaze_pciSR1_SX;
   picoBlazeMnemonics[PBOC_SRA_SX] = &picoBlaze_pciSRA_SX;
   picoBlazeMnemonics[PBOC_SRX_SX] = &picoBlaze_pciSRX_SX;
   picoBlazeMnemonics[PBOC_STORE_SXSS] = &picoBlaze_STORE_SXSS;
   picoBlazeMnemonics[PBOC_STORE_SXISY] = &picoBlaze_STORE_SXISY;
   picoBlazeMnemonics[PBOC_SUB_SXKK] = &picoBlaze_pciSUB_SXKK;
   picoBlazeMnemonics[PBOC_SUB_SXSY] = &picoBlaze_pciSUB_SXSY;
   picoBlazeMnemonics[PBOC_SUBCY_SXKK] = &picoBlaze_pciSUBCY_SXKK;
   picoBlazeMnemonics[PBOC_SUBCY_SXSY] = &picoBlaze_pciSUBCY_SXSY;
   picoBlazeMnemonics[PBOC_TEST_SXKK] = &picoBlaze_pciTEST_SXKK;
   picoBlazeMnemonics[PBOC_TEST_SXSY] = &picoBlaze_pciTEST_SXSY;
   picoBlazeMnemonics[PBOC_XOR_SXKK] = &picoBlaze_pciXOR_SXKK;
   picoBlazeMnemonics[PBOC_XOR_SXSY] = &picoBlaze_pciXOR_SXSY;

  /* conversion of the array to a hash table */
  for(i=0; i<MAX_PICOBLAZEMNEMONICS; i++)
    if(picoBlazeMnemonics[i])
      hTabAddItem(&picoBlazeMnemonicsHash, mnem2key((const unsigned char *)picoBlazeMnemonics[i]->mnemonic), picoBlazeMnemonics[i]);
  
  /* debugging output of the list of instructions */
  pci = hTabFirstItem(picoBlazeMnemonicsHash, &key);
  while(pci) {
    DFPRINTF((stderr, "element %d key %d, mnem %s\n",i++,key,pci->mnemonic));
    pci = hTabNextItem(picoBlazeMnemonicsHash, &key);
  }

  mnemonics_initialized = 1;
}

int picoBlaze_getpCodePeepCommand(char *cmd);

/* picoBlaze_getpCode - returns PIC_OPCODE of the pCode given by mnem and pCodes's ModReg is dest */
int picoBlaze_getpCode(char *mnem, unsigned dest)
{
  pCodeInstruction *pci;
  int key = mnem2key((unsigned char *)mnem);

  if(!mnemonics_initialized)
    picoBlazeinitMnemonics();

  pci = hTabFirstItemWK(picoBlazeMnemonicsHash, key);

  while(pci) {

    if(STRCASECMP(pci->mnemonic, mnem) == 0) {
      if((pci->num_ops <= 1)
        || (pci->isModReg == dest)
        || (pci->isBitInst)
        || (pci->num_ops <= 2 && pci->isAccess)
        || (pci->num_ops <= 2 && pci->isFastCall)
        || (pci->num_ops <= 2 && pci->is2MemOp)
        || (pci->num_ops <= 2 && pci->is2LitOp) )
        return(pci->op);
    }

    pci = hTabNextItemWK (picoBlazeMnemonicsHash);
  }

  return -1;
}

/*-----------------------------------------------------------------
 * picoBlaze_getpCodePeepCommand - TODO
 *
 *-----------------------------------------------------------------*/
int picoBlaze_getpCodePeepCommand(char *cmd)
{

  peepCommand *pcmd;
  int key = mnem2key((unsigned char *)cmd);


  pcmd = hTabFirstItemWK(picoBlazepCodePeepCommandsHash, key);

  while(pcmd) {
    // fprintf(stderr," comparing %s to %s\n",pcmd->cmd,cmd);
    if(STRCASECMP(pcmd->cmd, cmd) == 0) {
      return pcmd->id;
    }

    pcmd = hTabNextItemWK (picoBlazepCodePeepCommandsHash);

  }

  return -1;
}

/*-----------------------------------------------------------------*
 * picoBlazeinitpCodePeepCommands
 *
 *-----------------------------------------------------------------*/
void picoBlazeinitpCodePeepCommands(void)
{

  int key, i;
  peepCommand *pcmd;

  i = 0;
  do {
    hTabAddItem(&picoBlazepCodePeepCommandsHash,
                mnem2key((const unsigned char *)peepCommands[i].cmd), &peepCommands[i]);
    i++;
  } while (peepCommands[i].cmd);

  pcmd = hTabFirstItem(picoBlazepCodePeepCommandsHash, &key);

  while(pcmd) {
    //fprintf(stderr, "peep command %s  key %d\n",pcmd->cmd,pcmd->id);
    pcmd = hTabNextItem(picoBlazepCodePeepCommandsHash, &key);
  }

}

static char getpBlock_dbName(pBlock *pb)
{
  if(!pb)
    return 0;

  if(pb->cmemmap)
    return pb->cmemmap->dbName;

  return pb->dbName;
}

void picoBlaze_pBlockConvert2Absolute(pBlock *pb)
{
        if(!pb)return;
        if(pb->cmemmap)pb->cmemmap = NULL;

        pb->dbName = 'A';

        if(picoBlaze_pcode_verbose)
                fprintf(stderr, "%s:%d converting to 'A'bsolute pBlock\n", __FILE__, __LINE__);
}

/*-----------------------------------------------------------------*/
/* picoBlaze_movepBlock2Head - given the dbname of a pBlock, move all  */
/*                   instances to the front of the doubly linked   */
/*                   list of pBlocks                               */
/*-----------------------------------------------------------------*/
void picoBlaze_movepBlock2Head(char dbName)
{
  pBlock *pb;


  /* this can happen in sources without code,
   * only variable definitions */
  if(!the_pFile)return;

  pb = the_pFile->pbHead;

  while(pb) {

    if(getpBlock_dbName(pb) == dbName) {
      pBlock *pbn = pb->next;
      pb->next = the_pFile->pbHead;
      the_pFile->pbHead->prev = pb;
      the_pFile->pbHead = pb;

      if(pb->prev)
        pb->prev->next = pbn;

      // If the pBlock that we just moved was the last
      // one in the link of all of the pBlocks, then we
      // need to point the tail to the block just before
      // the one we moved.
      // Note: if pb->next is NULL, then pb must have
      // been the last pBlock in the chain.

      if(pbn)
        pbn->prev = pb->prev;
      else
        the_pFile->pbTail = pb->prev;	

	  // Q: why pb->prev is not set to NULL?

      pb = pbn;			// next block to iterate
    } else
      pb = pb->next;	// next block to iterate

  }	// while(pb)
}

/* picoBlaze_copypCode - prints all block of given dbName (including some stats) */
void picoBlaze_copypCode(FILE *of, char dbName)
/* used by glue */
{
  pBlock *pb;

        if(!of || !the_pFile)
                return;

        for(pb = the_pFile->pbHead; pb; pb = pb->next) {
                if(getpBlock_dbName(pb) == dbName) {
//                      fprintf(stderr, "%s:%d: output of pb= 0x%p\n", __FILE__, __LINE__, pb);
                        pBlockStats(of,pb);
                        picoBlaze_printpBlock(of,pb);
                }
        }
}

/* picoBlaze_pcode_test - print debug_verbose info to new dstFileName.p */
void picoBlaze_pcode_test(void)
{
  DFPRINTF((stderr, "pcode is alive!\n"));

  //initMnemonics();

  if(the_pFile) {

    pBlock *pb;
    FILE *pFile;
    char buffer[100];

    /* create the file name */
    strcpy(buffer, dstFileName);
    strcat(buffer, ".p");

    if( !(pFile = fopen(buffer, "w" ))) {
      werror(E_FILE_OPEN_ERR, buffer);
      exit(1);
    }

    fprintf(pFile,"pcode dump\n\n");

    for(pb = the_pFile->pbHead; pb; pb = pb->next) {
      fprintf(pFile, "\n\tNew pBlock\n\n");
      if(pb->cmemmap)
        fprintf(pFile, "%s", pb->cmemmap->sname);
      else
        fprintf(pFile,"internal pblock");

      fprintf(pFile, ", dbName =%c\n", getpBlock_dbName(pb));
      picoBlaze_printpBlock(pFile, pb);
    }
  }
}


unsigned long picoBlaze_countInstructions(void)
{
  pBlock *pb;
  pCode *pc;
  unsigned long isize=0;

    if(!the_pFile)return -1;

    for(pb = the_pFile->pbHead; pb; pb = pb->next) {
      for(pc = pb->pcHead; pc; pc = pc->next) {
        if(isPCI(pc) || isPCAD(pc))isize += PCI(pc)->isize;
      }
    }
  return (isize);
}


/*-----------------------------------------------------------------*/
/* int RegCond(pCodeOp *pcop) - if pcop points to the STATUS reg-  */
/*      ister, RegCond will return the bit being referenced.       */
/*                                                                 */
/* fixme - why not just OR in the pcop bit field                   */
/*-----------------------------------------------------------------*/

static int RegCond(pCodeOp *pcop)
{
  if(!pcop)
	  return 0;

  if(!pcop->name) 
	  return 0;

  if(pcop->type == PO_GPR_BIT ) {
    switch(PCORB(pcop)->bit) {
    case PIC_C_BIT:
      return PCC_C;
    case PIC_Z_BIT:
      return PCC_Z;
    }
  }

  return 0;
}


/*-----------------------------------------------------------------*/
/* picoBlaze_newpCode - create and return a newly initialized pCode          */
/*                                                                 */
/*  fixme - rename this                                            */
/*                                                                 */
/* The purpose of this routine is to create a new Instruction      */
/* pCode. This is called by gen.c while the assembly code is being */
/* generated.                                                      */
/*                                                                 */
/* Inouts:                                                         */
/*  PIC_OPCODE op - the assembly instruction we wish to create.    */
/*                  (note that the op is analogous to but not the  */
/*                  same thing as the opcode of the instruction.)  */
/*  pCodeOp *pcop - pointer to the operand of the instruction.     */
/*                                                                 */
/* Outputs:                                                        */
/*  a pointer to the new malloc'd pCode is returned.               */
/*-----------------------------------------------------------------*/
pCode *picoBlaze_newpCode (PIC_OPCODE op, pCodeOp *pcop)
{
  pCodeInstruction *pci;

  if(!mnemonics_initialized)
    picoBlazeinitMnemonics();

  pci = Safe_calloc(1, sizeof(pCodeInstruction));	// alloc memory

  if((op>=0) && (op < MAX_PICOBLAZEMNEMONICS) && picoBlazeMnemonics[op]) {
    memcpy(pci, picoBlazeMnemonics[op], sizeof(pCodeInstruction));	// initialize by cloning the instruction
    pci->pcop = pcop;		// binding the pcop operand to the new instruction

    if(pci->inCond & PCC_EXAMINE_PCOP)	// check the zerro and carry flag
      pci->inCond  |= RegCond(pcop);

    if(pci->outCond & PCC_EXAMINE_PCOP)
      pci->outCond  |= RegCond(pcop);

    pci->pc.prev = pci->pc.next = NULL;	// no binding to other pCodes (not yet)
    
	return (pCode *)pci;
  }

  fprintf(stderr, "pCode mnemonic error %s,%d\n",__FUNCTION__,__LINE__);
  exit(1);

  return NULL;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeWild - create a "wild" as in wild card pCode            */
/*                                                                 */
/* Wild pcodes are used during the peep hole optimizer to serve    */
/* as place holders for any instruction. When a snippet of code is */
/* compared to a peep hole rule, the wild card opcode will match   */
/* any instruction. However, the optional operand and label are    */
/* additional qualifiers that must also be matched before the      */
/* line (of assembly code) is declared matched. Note that the      */
/* operand may be wild too.                                        */
/*                                                                 */
/*   Note, a wild instruction is specified just like a wild var:   */
/*      %4     ; A wild instruction,                               */
/*  See the peeph.def file for additional examples                 */
/*                                                                 */
/*-----------------------------------------------------------------*/

pCode *picoBlaze_newpCodeWild(int pCodeID, pCodeOp *optional_operand, pCodeOp *optional_label)
{

  pCodeWild *pcw;

  pcw = Safe_calloc(1,sizeof(pCodeWild));

  pcw->pci.pc.type = PC_WILD;
  pcw->pci.pc.prev = pcw->pci.pc.next = NULL;
  pcw->pci.from = pcw->pci.to = pcw->pci.label = NULL;
  pcw->pci.pc.pb = NULL;

  //  pcw->pci.pc.analyze = genericAnalyze;
  pcw->pci.pc.destruct = genericDestruct;
  pcw->pci.pc.print = genericPrint;

  pcw->id = pCodeID;              // this is the 'n' in %n
  pcw->operand = optional_operand;
  pcw->label   = optional_label;

  pcw->mustBeBitSkipInst = 0;
  pcw->mustNotBeBitSkipInst = 0;
  pcw->invertBitSkipInst = 0;

  return ( (pCode *)pcw);

}

 /*-----------------------------------------------------------------*/
/* newPcodeInlineP - create a new pCode from a char string           */
/*-----------------------------------------------------------------*/


pCode *picoBlaze_newpCodeInlineP(char *cP)
{

  pCodeComment *pcc ;

  pcc = Safe_calloc(1,sizeof(pCodeComment));

  pcc->pc.type = PC_INLINE;
  pcc->pc.prev = pcc->pc.next = NULL;
  //pcc->pc.from = pcc->pc.to = pcc->pc.label = NULL;
  pcc->pc.pb = NULL;

  //  pcc->pc.analyze = genericAnalyze;
  pcc->pc.destruct = genericDestruct;
  pcc->pc.print = genericPrint;

  if(cP)
    pcc->comment = Safe_strdup(cP);
  else
    pcc->comment = NULL;

  return ( (pCode *)pcc);

}

/*-----------------------------------------------------------------*/
/* newPcodeCharP - create a new pCode from a char string           */
/*-----------------------------------------------------------------*/

pCode *picoBlaze_newpCodeCharP(char *cP)
{

  pCodeComment *pcc ;

  pcc = Safe_calloc(1,sizeof(pCodeComment));

  pcc->pc.type = PC_COMMENT;
  pcc->pc.prev = pcc->pc.next = NULL;
  //pcc->pc.from = pcc->pc.to = pcc->pc.label = NULL;
  pcc->pc.pb = NULL;

  //  pcc->pc.analyze = genericAnalyze;
  pcc->pc.destruct = genericDestruct;
  pcc->pc.print = genericPrint;

  if(cP)
    pcc->comment = Safe_strdup(cP);
  else
    pcc->comment = NULL;

  return ( (pCode *)pcc);

}

/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeFunction -                                              */
/*-----------------------------------------------------------------*/


pCode *picoBlaze_newpCodeFunction(char *mod,char *f)
{
  pCodeFunction *pcf;

  pcf = Safe_calloc(1,sizeof(pCodeFunction));

  pcf->pc.type = PC_FUNCTION;
  pcf->pc.prev = pcf->pc.next = NULL;
  //pcf->pc.from = pcf->pc.to = pcf->pc.label = NULL;
  pcf->pc.pb = NULL;

  //  pcf->pc.analyze = genericAnalyze;
  pcf->pc.destruct = genericDestruct;
  pcf->pc.print = pCodePrintFunction;

  pcf->ncalled = 0;
  pcf->absblock = 0;

  if(mod) {
    pcf->modname = Safe_calloc(1,strlen(mod)+1);
    strcpy(pcf->modname,mod);
  } else
    pcf->modname = NULL;

  if(f) {
    pcf->fname = Safe_calloc(1,strlen(f)+1);
    strcpy(pcf->fname,f);
  } else
    pcf->fname = NULL;

  pcf->stackusage = 0;

  return ( (pCode *)pcf);
}

/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeFlow                                                    */
/*-----------------------------------------------------------------*/
static void destructpCodeFlow(pCode *pc)
{
  if(!pc || !isPCFL(pc))
    return;

/*
  if(PCFL(pc)->from)
  if(PCFL(pc)->to)
*/
  picoBlaze_unlinkpCode(pc);

  deleteSet(&PCFL(pc)->registers);
  deleteSet(&PCFL(pc)->from);
  deleteSet(&PCFL(pc)->to);

  /* Instead of deleting the memory used by this pCode, mark
   * the object as bad so that if there's a pointer to this pCode
   * dangling around somewhere then (hopefully) when the type is
   * checked we'll catch it.
   */

  pc->type = PC_BAD;
  picoBlaze_addpCode2pBlock(pb_dead_pcodes, pc);

//  Safe_free(pc);

}

pCode *picoBlaze_newpCodeFlow(void )
{
  pCodeFlow *pcflow;

  //_ALLOC(pcflow,sizeof(pCodeFlow));
  pcflow = Safe_calloc(1,sizeof(pCodeFlow));

  pcflow->pc.type = PC_FLOW;
  pcflow->pc.prev = pcflow->pc.next = NULL;
  pcflow->pc.pb = NULL;

  //  pcflow->pc.analyze = genericAnalyze;
  pcflow->pc.destruct = destructpCodeFlow;
  pcflow->pc.print = genericPrint;

  pcflow->pc.seq = GpcFlowSeq++;

  pcflow->from = pcflow->to = NULL;

  pcflow->inCond = PCC_NONE;
  pcflow->outCond = PCC_NONE;

  pcflow->firstBank = -1;
  pcflow->lastBank = -1;

  pcflow->FromConflicts = 0;
  pcflow->ToConflicts = 0;

  pcflow->end = NULL;

  pcflow->registers = newSet();

  return ( (pCode *)pcflow);

}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
pCodeFlowLink *picoBlaze_newpCodeFlowLink(pCodeFlow *pcflow)
{
  pCodeFlowLink *pcflowLink;

  pcflowLink = Safe_calloc(1,sizeof(pCodeFlowLink));

  pcflowLink->pcflow = pcflow;
  pcflowLink->bank_conflict = 0;

  return pcflowLink;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeCSource - create a new pCode Source Symbol        */
/*-----------------------------------------------------------------*/

pCode *picoBlaze_newpCodeCSource(int ln, const char *f, const char *l)
{

  pCodeCSource *pccs;

  pccs = Safe_calloc(1,sizeof(pCodeCSource));

  pccs->pc.type = PC_CSOURCE;
  pccs->pc.prev = pccs->pc.next = NULL;
  pccs->pc.pb = NULL;

  pccs->pc.destruct = genericDestruct;
  pccs->pc.print = genericPrint;

  pccs->line_number = ln;
  if(l)
    pccs->line = Safe_strdup(l);
  else
    pccs->line = NULL;

  if(f)
    pccs->file_name = Safe_strdup(f);
  else
    pccs->file_name = NULL;

  return ( (pCode *)pccs);

}


/*******************************************************************/
/* picoBlaze_newpCodeAsmDir - create a new pCode Assembler Directive   */
/*                      added by VR 6-Jun-2003                     */
/*******************************************************************/

pCode *picoBlaze_newpCodeAsmDir(char *asdir, char *argfmt, ...)
{
  pCodeAsmDir *pcad;
  va_list ap;
  char buffer[512];
  char *lbp=buffer;

        pcad = Safe_calloc(1, sizeof(pCodeAsmDir));
        pcad->pci.pc.type = PC_ASMDIR;
        pcad->pci.pc.prev = pcad->pci.pc.next = NULL;
        pcad->pci.pc.pb = NULL;
        pcad->pci.isize = 2;
        pcad->pci.pc.destruct = genericDestruct;
        pcad->pci.pc.print = genericPrint;

        if(asdir && *asdir) {

                while(isspace((unsigned char)*asdir))asdir++;   // strip any white space from the beginning

                pcad->directive = Safe_strdup( asdir );
        }

        va_start(ap, argfmt);

        memset(buffer, 0, sizeof(buffer));
        if(argfmt && *argfmt)
                vsprintf(buffer, argfmt, ap);

        va_end(ap);

        while(isspace((unsigned char)*lbp))lbp++;

        if(lbp && *lbp)
                pcad->arg = Safe_strdup( lbp );

  return ((pCode *)pcad);
}

/*-----------------------------------------------------------------*/
/* pCodeLabelDestruct - free memory used by a label.               */
/*-----------------------------------------------------------------*/
static void pCodeLabelDestruct(pCode *pc)
{

  if(!pc)
    return;

  picoBlaze_unlinkpCode(pc);

//  if((pc->type == PC_LABEL) && PCL(pc)->label)
//    Safe_free(PCL(pc)->label);

  /* Instead of deleting the memory used by this pCode, mark
   * the object as bad so that if there's a pointer to this pCode
   * dangling around somewhere then (hopefully) when the type is
   * checked we'll catch it.
   */

  pc->type = PC_BAD;
  picoBlaze_addpCode2pBlock(pb_dead_pcodes, pc);

//  Safe_free(pc);

}

pCode *picoBlaze_newpCodeLabel(char *name, int key)
{

  char *s = buffer;
  pCodeLabel *pcl;

  pcl = Safe_calloc(1,sizeof(pCodeLabel) );

  pcl->pc.type = PC_LABEL;
  pcl->pc.prev = pcl->pc.next = NULL;
  //pcl->pc.from = pcl->pc.to = pcl->pc.label = NULL;
  pcl->pc.pb = NULL;

  //  pcl->pc.analyze = genericAnalyze;
  pcl->pc.destruct = pCodeLabelDestruct;
  pcl->pc.print = pCodePrintLabel;

  pcl->key = key;
  pcl->force = 0;

  pcl->label = NULL;
  if(key>0) {
    sprintf(s,"_%05d_DS_",key);
  } else
    s = name;

  if(s)
    pcl->label = Safe_strdup(s);

//  if(picoBlaze_pcode_verbose)
//      fprintf(stderr, "%s:%d label name: %s\n", __FILE__, __LINE__, pcl->label);


  return ( (pCode *)pcl);

}

pCode *picoBlaze_newpCodeLabelFORCE(char *name, int key)
{
  pCodeLabel *pcl = (pCodeLabel *)picoBlaze_newpCodeLabel(name, key);

        pcl->force = 1;

  return ( (pCode *)pcl );
}

pCode *picoBlaze_newpCodeInfo(INFO_TYPE type, pCodeOp *pcop)
{
  pCodeInfo *pci;

    pci = Safe_calloc(1, sizeof(pCodeInfo));
    pci->pci.pc.type = PC_INFO;
    pci->pci.pc.prev = pci->pci.pc.next = NULL;
    pci->pci.pc.pb = NULL;
    pci->pci.label = NULL;

    pci->pci.pc.destruct = genericDestruct;
    pci->pci.pc.print = genericPrint;

    pci->type = type;
    pci->oper1 = pcop;

  return ((pCode *)pci);
}


/*-----------------------------------------------------------------*/
/* newpBlock - create and return a pointer to a new pBlock         */
/*-----------------------------------------------------------------*/
static pBlock *newpBlock(void)
{

  pBlock *PpB;

  PpB = Safe_calloc(1,sizeof(pBlock) );
  PpB->next = PpB->prev = NULL;

  PpB->function_entries = PpB->function_exits = PpB->function_calls = NULL;
  PpB->tregisters = NULL;
  PpB->visited = 0;
  PpB->FlowTree = NULL;

  return PpB;

}

/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeChain - create a new chain of pCodes                    */
/*-----------------------------------------------------------------*
 *
 *  This function will create a new pBlock and the pointer to the
 *  pCode that is passed in will be the first pCode in the block.
 *-----------------------------------------------------------------*/


pBlock *picoBlaze_newpCodeChain(memmap *cm, char c, pCode *pc)
{

  pBlock *pB  = newpBlock();

  pB->pcHead  = pB->pcTail = pc;
  pB->cmemmap = cm;
  pB->dbName  = c;

  return pB;
}



/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeOpLabel - Create a new label given the key              */
/*  Note, a negative key means that the label is part of wild card */
/*  (and hence a wild card label) used in the pCodePeep            */
/*   optimizations).                                               */
/*-----------------------------------------------------------------*/

pCodeOp *picoBlaze_newpCodeOpLabel(char *name, int key)
{
  char *s=NULL;
  static int label_key=-1;

  pCodeOp *pcop;

  pcop = Safe_calloc(1,sizeof(pCodeOpLabel) );
  pcop->type = PO_LABEL;

  pcop->name = NULL;

  if(key>0)
    sprintf(s=buffer,"_%05d_DS_",key);
  else
    s = name, key = label_key--;

  if(s)
    pcop->name = Safe_strdup(s);

  ((pCodeOpLabel *)pcop)->key = key;

  //fprintf(stderr,"picoBlaze_newpCodeOpLabel: key=%d, name=%s\n",key,((s)?s:""));
  return pcop;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeOpLit - constructor of pCodeOpLit structure   */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_newpCodeOpLit(int lit)
{
  char *s = buffer;
  pCodeOp *pcop;


  pcop = Safe_calloc(1,sizeof(pCodeOpLit) );
  pcop->type = PO_LITERAL;

  pcop->name = NULL;
  //if(lit>=0)
    sprintf(s,"0x%02hhx", (unsigned char)lit);
  //else
  //  sprintf(s, "%i", lit);

  if(s)
    pcop->name = Safe_strdup(s);

  ((pCodeOpLit *)pcop)->lit = lit;

  return pcop;
}

/* picoBlaze_newpCodeOpLit12 - constructor of pCodeOpLit structure with 12-bit literal */
/* Allow for 12 bit literals, required for LFSR */
pCodeOp *picoBlaze_newpCodeOpLit12(int lit)
{
  char *s = buffer;
  pCodeOp *pcop;


  pcop = Safe_calloc(1,sizeof(pCodeOpLit) );
  pcop->type = PO_LITERAL;

  pcop->name = NULL;
  //if(lit>=0)
    sprintf(s,"0x%03x", ((unsigned int)lit) & 0x0fff);
  //else
  //  sprintf(s, "%i", lit);

  if(s)
    pcop->name = Safe_strdup(s);

  ((pCodeOpLit *)pcop)->lit = lit;

  return pcop;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeOpLit2 - constructor of pCodeOpLit2 structure */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_newpCodeOpLit2(int lit, pCodeOp *arg2)
{
  char *s = buffer, picoBlaze_tbuf[256], *tb=picoBlaze_tbuf;
  pCodeOp *pcop;


  tb = picoBlaze_get_op(arg2, NULL, 0);
  pcop = Safe_calloc(1,sizeof(pCodeOpLit2) );
  pcop->type = PO_LITERAL;

  pcop->name = NULL;
  //if(lit>=0) {
    sprintf(s,"0x%02x, %s", (unsigned char)lit, tb);
    if(s)
      pcop->name = Safe_strdup(s);
  //}

  ((pCodeOpLit2 *)pcop)->lit = lit;
  ((pCodeOpLit2 *)pcop)->arg2 = arg2;

  return pcop;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeOpImmd - constructor of pCodeOpImmd structure */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_newpCodeOpImmd(char *name, int offset, int index, int code_space)
{
  pCodeOp *pcop;

        pcop = Safe_calloc(1,sizeof(pCodeOpImmd) );
        pcop->type = PO_GPR_REGISTER;
        if(name) {
                regs *r = picoBlaze_dirRegWithName(name);  // search register in table dynDirectRegNames
                pcop->name = Safe_strdup(name);
                PCOI(pcop)->r = r;

                if(r) {
//                      fprintf(stderr, "%s:%d %s reg %s exists (r: %p)\n",__FILE__, __LINE__, __FUNCTION__, name, r);
                        PCOI(pcop)->rIdx = r->rIdx;
                } else {
//                      fprintf(stderr, "%s:%d %s reg %s doesn't exist\n", __FILE__, __LINE__, __FUNCTION__, name);
                        PCOI(pcop)->rIdx = -1;
                }
//                      fprintf(stderr,"%s %s %d\n",__FUNCTION__,name,offset);
        } else {
                pcop->name = NULL;
                PCOI(pcop)->rIdx = -1;
        }

        PCOI(pcop)->index = index;
        PCOI(pcop)->offset = offset;
        PCOI(pcop)->_const = code_space;

  return pcop;
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_newpCodeOpWild(int id, pCodeWildBlock *pcwb, pCodeOp *subtype)
{
  char *s = buffer;
  pCodeOp *pcop;


  if(!pcwb || !subtype) {
    fprintf(stderr, "Wild opcode declaration error: %s-%d\n",__FILE__,__LINE__);
    exit(1);
  }

  pcop = Safe_calloc(1,sizeof(pCodeOpWild));
  pcop->type = PO_GPR_REGISTER;
  sprintf(s,"%%%d",id);
  pcop->name = Safe_strdup(s);

  PCOW(pcop)->id = id;
  PCOW(pcop)->pcwb = pcwb;
  PCOW(pcop)->subtype = subtype;
  PCOW(pcop)->matched = NULL;

  PCOW(pcop)->pcop2 = NULL;

  return pcop;
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_newpCodeOpWild2(int id, int id2, pCodeWildBlock *pcwb, pCodeOp *subtype, pCodeOp *subtype2)
{
  char *s = buffer;
  pCodeOp *pcop;


        if(!pcwb || !subtype || !subtype2) {
                fprintf(stderr, "Wild opcode declaration error: %s-%d\n",__FILE__,__LINE__);
                exit(1);
        }

        pcop = Safe_calloc(1,sizeof(pCodeOpWild));
        pcop->type = PO_GPR_REGISTER;
        sprintf(s,"%%%d",id);
        pcop->name = Safe_strdup(s);

        PCOW(pcop)->id = id;
        PCOW(pcop)->pcwb = pcwb;
        PCOW(pcop)->subtype = subtype;
        PCOW(pcop)->matched = NULL;

        PCOW(pcop)->pcop2 = Safe_calloc(1, sizeof(pCodeOpWild));

        if(!subtype2->name) {
                PCOW(pcop)->pcop2 = Safe_calloc(1, sizeof(pCodeOpWild));
                PCOW2(pcop)->pcop.type = PO_GPR_REGISTER;
                sprintf(s, "%%%d", id2);
                PCOW2(pcop)->pcop.name = Safe_strdup(s);
                PCOW2(pcop)->id = id2;
                PCOW2(pcop)->subtype = subtype2;

//              fprintf(stderr, "%s:%d %s [wild,wild] for name: %s (%d)\tname2: %s (%d)\n", __FILE__, __LINE__, __FUNCTION__,
//                              pcop->name, id, PCOW2(pcop)->pcop.name, id2);
        } else {
                PCOW2(pcop)->pcop2 = picoBlaze_pCodeOpCopy( subtype2 );

//              fprintf(stderr, "%s:%d %s [wild,str] for name: %s (%d)\tname2: %s (%d)\n", __FILE__, __LINE__, __FUNCTION__,
//                              pcop->name, id, PCOW2(pcop)->pcop.name, id2);
        }



  return pcop;
}


/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeOpBit - constructor of pCodeOpRegBit structure */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_newpCodeOpBit(char *s, int bit, int inBitSpace, PICOBLAZE_OPTYPE subt)
{
  pCodeOp *pcop;

  pcop = Safe_calloc(1,sizeof(pCodeOpRegBit) );
  pcop->type = PO_GPR_BIT;
  if(s)
    pcop->name = Safe_strdup(s);
  else
    pcop->name = NULL;

  PCORB(pcop)->bit = bit;
  PCORB(pcop)->inBitSpace = inBitSpace;
  PCORB(pcop)->subtype = subt;

  /* pCodeOpBit is derived from pCodeOpReg. We need to init this too */
  PCOR(pcop)->r = picoBlaze_regWithName(s); //NULL;
//  fprintf(stderr, "%s:%d %s for reg: %s\treg= %p\n", __FILE__, __LINE__, __FUNCTION__, s, PCOR(pcop)->r);
//  PCOR(pcop)->rIdx = 0;
  return pcop;
}

pCodeOp *picoBlaze_newpCodeOpBit_simple (struct asmop *op, int offs, int bit)
{
  return picoBlaze_newpCodeOpBit (picoBlaze_aopGet(op,offs,FALSE,FALSE),
                                bit, 0, PO_GPR_REGISTER);
}


/*-----------------------------------------------------------------*
 * pCodeOp *picoBlaze_newpCodeOpReg(int rIdx) - allocate a new register
 *
 * If rIdx >=0 then a specific register from the set of registers
 * will be selected. If rIdx <0, then a new register will be searched
 * for.
 *-----------------------------------------------------------------*/

pCodeOp *picoBlaze_newpCodeOpReg(int rIdx)
{
  pCodeOp *pcop;
  regs *r;

  pcop = Safe_calloc(1,sizeof(pCodeOpReg) );

  pcop->name = NULL;

  if(rIdx >= 0) {
        r = picoBlaze_regWithIdx(rIdx);
        if(!r)
                r = picoBlaze_allocWithIdx(rIdx);
  } else {
    r = picoBlaze_findFreeReg(REG_GPR);

    if(!r) {
        fprintf(stderr, "%s:%d Could not find a free GPR register\n",
                __FUNCTION__, __LINE__);
        exit(EXIT_FAILURE);
    }
  }

  PCOR(pcop)->rIdx = rIdx;
  PCOR(pcop)->r = r;
  pcop->type = PCOR(pcop)->r->pc_type;

  return pcop;
}

pCodeOp *picoBlaze_newpCodeOpRegFromStr(char *name)
{
  pCodeOp *pcop;
  regs *r;

        pcop = Safe_calloc(1,sizeof(pCodeOpReg) );
        PCOR(pcop)->r = r = picoBlaze_allocRegByName(name, 1, NULL);
        PCOR(pcop)->rIdx = PCOR(pcop)->r->rIdx;
        pcop->type = PCOR(pcop)->r->pc_type;
        pcop->name = PCOR(pcop)->r->name;

//      if(picoBlaze_pcode_verbose) {
//              fprintf(stderr, "%s:%d %s allocates register %s rIdx:0x%02x\n",
//                      __FILE__, __LINE__, __FUNCTION__, r->name, r->rIdx);
//      }

  return pcop;
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_newpCodeOpOpt(OPT_TYPE type, char *key)
{
  pCodeOpOpt *pcop;

        pcop = Safe_calloc(1, sizeof(pCodeOpOpt));

        pcop->type = type;
        pcop->key = Safe_strdup( key );

  return (PCOP(pcop));
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_newpCodeOpLocalRegs(LR_TYPE type)
{
  pCodeOpLocalReg *pcop;

        pcop = Safe_calloc(1, sizeof(pCodeOpLocalReg));

        pcop->type = type;

  return (PCOP(pcop));
}


/*-----------------------------------------------------------------*/
/* picoBlaze_newpCodeOp - calls constructor for specific subtype of pCodeOp according to type parameter */
/*-----------------------------------------------------------------*/

pCodeOp *picoBlaze_newpCodeOp(char *name, PICOBLAZE_OPTYPE type)
{
  pCodeOp *pcop;

  switch(type) {
  case PO_GPR_BIT:
    pcop = picoBlaze_newpCodeOpBit(name, -1,0, type);
    break;

  case PO_LITERAL:
    pcop = picoBlaze_newpCodeOpLit(-1);
    break;

  case PO_LABEL:
    pcop = picoBlaze_newpCodeOpLabel(NULL,-1);
    break;
  case PO_GPR_TEMP:
    pcop = picoBlaze_newpCodeOpReg(-1);
    break;

  case PO_GPR_REGISTER:
    if(name)
      pcop = picoBlaze_newpCodeOpRegFromStr(name);
    else
      pcop = picoBlaze_newpCodeOpReg(-1);
    break;

  default:
    pcop = Safe_calloc(1,sizeof(pCodeOp) );
    pcop->type = type;
    if(name)
      pcop->name = Safe_strdup(name);
    else
      pcop->name = NULL;
  }

  return pcop;
}

pCodeOp *picoBlaze_newpCodeOp2(pCodeOp *src, pCodeOp *dst)
{
  pCodeOp2 *pcop2 = Safe_calloc(1, sizeof(pCodeOp2));
  pcop2->pcop.type = PO_GPR_REGISTER;
  pcop2->pcopL = src;
  pcop2->pcopR = dst;
  return PCOP(pcop2);
}

/* This is a multiple of two as gpasm pads DB directives to even length,
 * thus the data would be interleaved with \0 bytes...
 * This is a multiple of three in order to have arrays of 3-byte pointers
 * continuously in memory (without 0-padding at the lines' end).
 * This is rather 12 than 6 in order not to split up 4-byte data types
 * in arrays right in the middle of a 4-byte word. */
#define DB_ITEMS_PER_LINE       12

typedef struct DBdata
  {
    int count;
    char buffer[512];
  } DBdata;

struct DBdata DBd;
static int DBd_init = -1;

/*-----------------------------------------------------------------*/
/*    Initialiase "DB" data buffer                                 */
/*-----------------------------------------------------------------*/
void picoBlaze_initDB(void)
{
        DBd_init = -1;
}


/*-----------------------------------------------------------------*/
/*    Flush pending "DB" data to a pBlock                          */
/*                                                                 */
/* ptype - type of p pointer, 'f' file pointer, 'p' pBlock pointer */
/*-----------------------------------------------------------------*/
void picoBlaze_flushDB(char ptype, void *p)
{
        if (DBd.count>0) {
                if(ptype == 'p')
                        picoBlaze_addpCode2pBlock(((pBlock *)p),picoBlaze_newpCodeAsmDir("DB", "%s", DBd.buffer));
                else
                if(ptype == 'f')
                        fprintf(((FILE *)p), "\tdb\t%s\n", DBd.buffer);
                else {
                        /* sanity check */
                        fprintf(stderr, "PICOBLAZE port error: could not emit initial value data\n");
                }

                DBd.count = 0;
                DBd.buffer[0] = '\0';
        }
}


/*-----------------------------------------------------------------*/
/*    Add "DB" directives to a pBlock                              */
/*-----------------------------------------------------------------*/
void picoBlaze_emitDB(int c, char ptype, void *p)
{
  int l;

        if (DBd_init<0) {
         // we need to initialize
                DBd_init = 0;
                DBd.count = 0;
                DBd.buffer[0] = '\0';
        }

        l = strlen(DBd.buffer);
        sprintf(DBd.buffer+l,"%s0x%02x", (DBd.count>0?", ":""), c & 0xff);

//      fprintf(stderr, "%s:%d DBbuffer: '%s'\n", __FILE__, __LINE__, DBd.buffer);

        DBd.count++;
        if (DBd.count>= DB_ITEMS_PER_LINE)
                picoBlaze_flushDB(ptype, p);
}

void picoBlaze_emitDS(char *s, char ptype, void *p)
{
  int l;

        if (DBd_init<0) {
         // we need to initialize
                DBd_init = 0;
                DBd.count = 0;
                DBd.buffer[0] = '\0';
        }

        l = strlen(DBd.buffer);
        sprintf(DBd.buffer+l,"%s%s", (DBd.count>0?", ":""), s);

//      fprintf(stderr, "%s:%d DBbuffer: '%s'\n", __FILE__, __LINE__, DBd.buffer);

        DBd.count++;    //=strlen(s);
        if (DBd.count>=DB_ITEMS_PER_LINE)
                picoBlaze_flushDB(ptype, p);
}


/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
void picoBlaze_pCodeConstString(char *name, char *value, unsigned length)
{
  pBlock *pb;
  char *item;
  static set *emittedSymbols = NULL;

  if(!name || !value)
    return;

  /* keep track of emitted symbols to avoid multiple definition of str_<nr> */
  if (emittedSymbols) {
    /* scan set for name */
    for (item = setFirstItem (emittedSymbols); item; item = setNextItem (emittedSymbols))
    {
      if (!strcmp (item,name)) {
        //fprintf (stderr, "%s already emitted\n", name);
        return;
      } // if
    } // for
  } // if
  addSet (&emittedSymbols, Safe_strdup (name));

  //fprintf(stderr, " %s  %s  %s\n",__FUNCTION__,name,value);

  pb = picoBlaze_newpCodeChain(NULL, 'P', picoBlaze_newpCodeCharP("; Starting pCode block"));

  picoBlaze_addpBlock(pb);

//  sprintf(buffer,"; %s = ", name);
//  strcat(buffer, value);
//  fputs(buffer, stderr);

//  picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeCharP(buffer));
  picoBlaze_addpCode2pBlock(pb,picoBlaze_newpCodeLabel(name,-1));

  while (length--)
    picoBlaze_emitDB(*value++, 'p', (void *)pb);

  picoBlaze_flushDB('p', (void *)pb);
}


/*-----------------------------------------------------------------*/
/* picoBlaze_addpCode2pBlock - place the pCode into the pBlock linked list   */
/*-----------------------------------------------------------------*/
void picoBlaze_addpCode2pBlock(pBlock *pb, pCode *pc)
{

  if(!pc)
    return;

  if(!pb->pcHead) {
    /* If this is the first pcode to be added to a block that
     * was initialized with a NULL pcode, then go ahead and
     * make this pcode the head and tail */
    pb->pcHead  = pb->pcTail = pc;
  } else {
    //    if(pb->pcTail)
    pb->pcTail->next = pc;

    pc->prev = pb->pcTail;
    pc->pb = pb;

    pb->pcTail = pc;
  }
}

/*-----------------------------------------------------------------*/
/* picoBlaze_addpBlock - place a pBlock into the pFile                 */
/*-----------------------------------------------------------------*/
void picoBlaze_addpBlock(pBlock *pb)
{
  // fprintf(stderr," Adding pBlock: dbName =%c\n",getpBlock_dbName(pb));

  if(!the_pFile) {
    /* First time called, we'll pass through here. */
    //_ALLOC(the_pFile,sizeof(pFile));
    the_pFile = Safe_calloc(1,sizeof(pFile));
    the_pFile->pbHead = the_pFile->pbTail = pb;
    the_pFile->functions = NULL;
    return;
  }

  the_pFile->pbTail->next = pb;
  pb->prev = the_pFile->pbTail;
  pb->next = NULL;
  the_pFile->pbTail = pb;
}

/*-----------------------------------------------------------------*/
/* removepBlock - remove a pBlock from the pFile                   */
/*-----------------------------------------------------------------*/
static void removepBlock(pBlock *pb)
{
  pBlock *pbs;

  if(!the_pFile)
    return;


  //fprintf(stderr," Removing pBlock: dbName =%c\n",getpBlock_dbName(pb));

  for(pbs = the_pFile->pbHead; pbs; pbs = pbs->next) {
    if(pbs == pb) {

      if(pbs == the_pFile->pbHead)
        the_pFile->pbHead = pbs->next;

      if (pbs == the_pFile->pbTail)
        the_pFile->pbTail = pbs->prev;

      if(pbs->next)
        pbs->next->prev = pbs->prev;

      if(pbs->prev)
        pbs->prev->next = pbs->next;

      return;

    }
  }

  fprintf(stderr, "Warning: call to %s:%s didn't find pBlock\n",__FILE__,__FUNCTION__);

}

/*-----------------------------------------------------------------*/
/* printpCode - write the contents of a pCode to a file            */
/*-----------------------------------------------------------------*/
static void printpCode(FILE *of, pCode *pc)
{

  if(!pc || !of)
    return;

  if(pc->print) {
    pc->print(of,pc);
    return;
  }

  fprintf(of,"warning - unable to print pCode\n");
}

/*-----------------------------------------------------------------*/
/* picoBlaze_printpBlock - write the contents of a pBlock to a file*/
/*    If it is a function, it ensures its absolute address location*/
/*-----------------------------------------------------------------*/
void picoBlaze_printpBlock(FILE *of, pBlock *pb)
{
  pCode *pc;

        if(!pb)return;

        if(!of)of=stderr;

        for(pc = pb->pcHead; pc; pc = pc->next) {
                if(isPCF(pc) && PCF(pc)->fname) {
						// function code labeled by function name and module name
                        fprintf(of, "S_%s_%s\tcode", PCF(pc)->modname, PCF(pc)->fname);
                        if(pb->dbName == 'A') { // absolute address for the placement of the function is given in auxiliary absSym list
                          absSym *ab;
								// search for the symbol by function name
                                for(ab=setFirstItem(absSymSet); ab; ab=setNextItem(absSymSet)) {
//                                      fprintf(stderr, "%s:%d testing %s <-> %s\n", __FILE__, __LINE__, PCF(pc)->fname, ab->name);
                                        if(!strcmp(ab->name, PCF(pc)->fname)) {
//                                              fprintf(stderr, "%s:%d address = %x\n", __FILE__, __LINE__, ab->address);
                                                if(ab->address != -1)
                                                  fprintf(of, "\t0X%06X", ab->address);
                                                break;
                                        }
                                }
                        }
                        fprintf(of, "\n");
                }
                printpCode(of, pc); // print pCode instruction in the block
        }
}

/*-----------------------------------------------------------------*/
/*                                                                 */
/*       pCode processing                                          */
/*                                                                 */
/*                                                                 */
/*                                                                 */
/*-----------------------------------------------------------------*/
pCode * picoBlaze_findNextInstruction(pCode *pci);
pCode * picoBlaze_findPrevInstruction(pCode *pci);

void picoBlaze_unlinkpCode(pCode *pc)
{
  pCode *prev;

  if(pc) {
#ifdef PCODE_DEBUG
    fprintf(stderr,"Unlinking: ");
    printpCode(stderr, pc);
#endif
    if(pc->prev) {
      pc->prev->next = pc->next;
    } else if (pc->pb && (pc->pb->pcHead == pc)) {
        pc->pb->pcHead = pc->next;
    }
    if(pc->next) {
      pc->next->prev = pc->prev;
    } else if (pc->pb && (pc->pb->pcTail == pc)) {
        pc->pb->pcTail = pc->prev;
    }

    /* move C source line down (or up) */
    if (isPCI(pc) && PCI(pc)->cline) {
      prev = picoBlaze_findNextInstruction (pc->next);
      if (prev && isPCI(prev) && !PCI(prev)->cline) {
        PCI(prev)->cline = PCI(pc)->cline;
      } else {
        prev = picoBlaze_findPrevInstruction (pc->prev);
        if (prev && isPCI(prev) && !PCI(prev)->cline)
          PCI(prev)->cline = PCI(pc)->cline;
      }
    }
    pc->prev = pc->next = NULL;
  }
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/

static void genericDestruct(pCode *pc)
{

  picoBlaze_unlinkpCode(pc);

  if(isPCI(pc)) {
    /* For instructions, tell the register (if there's one used)
     * that it's no longer needed */
    regs *reg = picoBlaze_getRegFromInstruction(pc);
    if(reg)
      deleteSetItem (&(reg->reglives.usedpCodes),pc);

        if(PCI(pc)->is2MemOp) {
                reg = picoBlaze_getRegFromInstruction2(pc);
                if(reg)
                        deleteSetItem(&(reg->reglives.usedpCodes), pc);
        }
  }

  /* Instead of deleting the memory used by this pCode, mark
   * the object as bad so that if there's a pointer to this pCode
   * dangling around somewhere then (hopefully) when the type is
   * checked we'll catch it.
   */

  pc->type = PC_BAD;
  picoBlaze_addpCode2pBlock(pb_dead_pcodes, pc);

  //Safe_free(pc);
}


void DEBUGpicoBlaze_emitcode (char *inst,char *fmt, ...);
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
/* modifiers for constant immediate */
const char *picoBlaze_immdmod[3]={"LOW", "HIGH", "UPPER"};

/* picoBlaze_get_op - get operand (as a string) from pCodeOp */
/*    optionally: result of size size passed to buffer */
char *picoBlaze_get_op(pCodeOp *pcop, char *buffer, size_t size)
{
    regs *r;
    static char b[128];		// local buffer for string representation of the pCodeOp
    char *s;
    int use_buffer = 1;    // copy the string to the passed buffer pointer

    if(!buffer) {			// No buffer passed in buffer-argument, use local buffer b
        buffer = b;
        size = sizeof(b);
        use_buffer = 0;     // Don't bother copying the string to the buffer.
    }

    if(pcop) {

        switch(pcop->type) {
            case PO_GPR_TEMP:
                r = picoBlaze_regWithIdx(PCOR(pcop)->r->rIdx);
                if(use_buffer) {
                    SNPRINTF(buffer, size, "%s", r->name);
                    return (buffer);
                }
                return (r->name);
                break;

 
            case PO_GPR_REGISTER:
            case PO_DIR:
                s = buffer;
                //size = sizeof(buffer);
                if( PCOR(pcop)->instance) {
                    SNPRINTF(s,size,"(%s + %d)",
                            pcop->name,
                            PCOR(pcop)->instance );
                } else {
                    SNPRINTF(s, size, "%s", pcop->name);
                }
                return (buffer);
                break;

            case PO_GPR_BIT:
                s = buffer;
                if(PCORB(pcop)->subtype == PO_GPR_TEMP) {
                    SNPRINTF(s, size, "%s", pcop->name);
                } else {
                    if(PCORB(pcop)->pcor.instance)
                        SNPRINTF(s, size, "(%s + %d)", pcop->name, PCORB(pcop)->pcor.instance);
                    else
                        SNPRINTF(s, size, "%s", pcop->name);
                }
                return (buffer);
                break;

            default:
                if(pcop->name) {
                    if(use_buffer) {
                        SNPRINTF(buffer, size, "%s", pcop->name);
                        return (buffer);
                    }
                    return (pcop->name);
                }

        }
        return ("unhandled type for op1");
    }

    return ("NO operand1");
}

/*-----------------------------------------------------------------*/
/* picoBlaze_get_op2 - variant to support two memory operand commands  */
/*-----------------------------------------------------------------*/
char *picoBlaze_get_op2(pCodeOp *pcop,char *buffer, size_t size)
{

  return "NO operand2";
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
static char *picoBlaze_get_op_from_instruction(pCodeInstruction *pcc)
{

  if(pcc)
    return picoBlaze_get_op(pcc->pcop,NULL,0);

  /* gcc 3.2:  warning: concatenation of string literals with __FUNCTION__ is deprecated
   *   return ("ERROR Null: "__FUNCTION__);
   */
  return ("ERROR Null: picoBlaze_get_op_from_instruction");

}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
static void pCodeOpPrint(FILE *of, pCodeOp *pcop)
{

  fprintf(of,"pcodeopprint- not implemented\n");
}

/*-----------------------------------------------------------------*/
/* picoBlaze_pCode2str - convert a pCode instruction to string               */
/*-----------------------------------------------------------------*/
char *picoBlaze_pCode2str(char *str, size_t size, pCode *pc)
{
    char *s = str;
    regs *r;


    switch(pc->type) {

        case PC_OPCODE:
            SNPRINTF(s, size, "\t%s\t", PCI(pc)->mnemonic);
            size -= strlen(s);
            s += strlen(s);

			// TODO

			if( PCI(pc)->op == PBOC_LOAD_SXKK) {
				SNPRINTF(s,size, "%s, %s", PCOP2(PCI(pc)->pcop)->pcopL->name, PCOP2(PCI(pc)->pcop)->pcopR->name);
				break;
			}
			if( PCI(pc)->op == PBOC_STORE_SXISY) {
				SNPRINTF(s,size, "%s, {%s}", PCOP2(PCI(pc)->pcop)->pcopL->name, PCOP2(PCI(pc)->pcop)->pcopR->name);
				break;
			}
			if( PCI(pc)->op == PBOC_SUB_SXKK) {
				SNPRINTF(s,size, "%s, %s", PCOP2(PCI(pc)->pcop)->pcopL->name, PCOP2(PCI(pc)->pcop)->pcopR->name);
				break;
			}

            if( (PCI(pc)->num_ops >= 1) && (PCI(pc)->pcop)) {

                if(PCI(pc)->is2LitOp) {
                    SNPRINTF(s,size, "%s", PCOP(PCI(pc)->pcop)->name);
                    break;
                }



                if(PCI(pc)->isBitInst) {
                    if(PCI(pc)->pcop->type != PO_GPR_BIT) {
                        if( (((pCodeOpRegBit *)(PCI(pc)->pcop))->inBitSpace) )
                            SNPRINTF(s,size,"(%s >> 3), (%s & 7)",
                                    PCI(pc)->pcop->name ,
                                    PCI(pc)->pcop->name );
                        else
                            SNPRINTF(s,size,"%s,%d", picoBlaze_get_op_from_instruction(PCI(pc)),
                                    (((pCodeOpRegBit *)(PCI(pc)->pcop))->bit ));

                    } else if(PCI(pc)->pcop->type == PO_GPR_BIT) {
                        SNPRINTF(s,size,"%s, %d", picoBlaze_get_op_from_instruction(PCI(pc)),PCORB(PCI(pc)->pcop)->bit);
                    } else
                        SNPRINTF(s,size,"%s,0 ; ?bug", picoBlaze_get_op_from_instruction(PCI(pc)));
                } else { // not isBitInst

                    if(PCI(pc)->pcop->type == PO_GPR_BIT) {
                        if( PCI(pc)->num_ops == 3)
                            SNPRINTF(s,size,"(%s >> 3),%c",picoBlaze_get_op_from_instruction(PCI(pc)),((PCI(pc)->isModReg) ? 'F':'W'));
                        else
                            SNPRINTF(s,size,"(1 << (%s & 7))",picoBlaze_get_op_from_instruction(PCI(pc)));
                    } else {
                        SNPRINTF(s,size,"%s", picoBlaze_get_op_from_instruction(PCI(pc))); // normal or temp register (not only bit register)
                    }
                } // end if-else (isBitInst)

				// instruction with 2 or 3 parameters and access to RAM in some operand
                if( PCI(pc)->num_ops == 3 || ((PCI(pc)->num_ops == 2) && (PCI(pc)->isAccess))) {
                    size -= strlen(s);
                    s += strlen(s);
                    if(PCI(pc)->num_ops == 3 && !PCI(pc)->isBitInst) {
                        SNPRINTF(s,size,", %c", ( (PCI(pc)->isModReg) ? 'F':'W'));
                        size -= strlen(s);
                        s += strlen(s);
                    }

                    r = picoBlaze_getRegFromInstruction(pc); // literal and label returns NULL

                    if(PCI(pc)->isAccess) {
                        static char *bank_spec[2][2] = {
                            { "", ", ACCESS" },  /* gpasm uses access bank by default */
                            { ", B", ", BANKED" }/* MPASM (should) use BANKED by default */
                        };

                        SNPRINTF(s,size,"%s", bank_spec[(r && !isACCESS_BANK(r)) ? 1 : 0][picoBlaze_mplab_comp ? 1 : 0]);
                    }
                }
            }
            break;

        case PC_COMMENT:
            /* assuming that comment ends with a \n */
            SNPRINTF(s,size,";%s", ((pCodeComment *)pc)->comment);
            break;

        case PC_INFO:
            SNPRINTF(s,size,"; info ==>");
            size -= strlen(s);
            s += strlen(s);
            switch( PCINF(pc)->type ) {
                case INF_OPTIMIZATION:
                    SNPRINTF(s,size, " [optimization] %s\n", picoBlaze_OPT_TYPE_STR[ PCOO(PCINF(pc)->oper1)->type ]);
                    break;
                case INF_LOCALREGS:
                    SNPRINTF(s,size, " [localregs] %s\n", picoBlaze_LR_TYPE_STR[ PCOLR(PCINF(pc)->oper1)->type ]);
                    break;
            }; break;

        case PC_INLINE:
            /* assuming that inline code ends with a \n */
            SNPRINTF(s,size,"%s", ((pCodeComment *)pc)->comment);
            break;

        case PC_LABEL:
            SNPRINTF(s,size,";label=%s, key=%d\n",PCL(pc)->label,PCL(pc)->key);
            break;
        case PC_FUNCTION:
            SNPRINTF(s,size,";modname=%s,function=%s: id=%d\n",PCF(pc)->modname,PCF(pc)->fname);
            break;
        case PC_WILD:
            SNPRINTF(s,size,";\tWild opcode: id=%d\n",PCW(pc)->id);
            break;
        case PC_FLOW:
            SNPRINTF(s,size,";\t--FLOW change\n");
            break;
        case PC_CSOURCE:
            SNPRINTF(s,size,"%s\t.line\t%d; %s\t%s\n", ((picoBlaze_mplab_comp || !options.debug)?";":""),
                    PCCS(pc)->line_number, PCCS(pc)->file_name, PCCS(pc)->line);
            break;
        case PC_ASMDIR:
            if(PCAD(pc)->directive) {
                SNPRINTF(s,size,"\t%s%s%s\n", PCAD(pc)->directive, PCAD(pc)->arg?"\t":"", PCAD(pc)->arg?PCAD(pc)->arg:"");
            } else
                if(PCAD(pc)->arg) {
                    /* special case to handle inline labels without a tab */
                    SNPRINTF(s,size,"%s\n", PCAD(pc)->arg);
                }
            break;

        case PC_BAD:
            SNPRINTF(s,size,";A bad pCode is being used\n");
            break;
    }

    return str;
}

/*-----------------------------------------------------------------*/
/* genericPrint - the contents of a pCode to a file                */
/*-----------------------------------------------------------------*/
static void genericPrint(FILE *of, pCode *pc)
{

  if(!pc || !of)
    return;

  switch(pc->type) {
  case PC_COMMENT:
//    fputs(((pCodeComment *)pc)->comment, of);
    fprintf(of,"; %s\n", ((pCodeComment *)pc)->comment);
    break;

  case PC_INFO:
    {
      pBranch *pbl = PCI(pc)->label;
      while(pbl && pbl->pc) {
        if(pbl->pc->type == PC_LABEL)
          pCodePrintLabel(of, pbl->pc);
        pbl = pbl->next;
      }
    }

    if(picoBlaze_pcode_verbose) {
      fprintf(of, "; info ==>");
      switch(((pCodeInfo *)pc)->type) {
        case INF_OPTIMIZATION:
              fprintf(of, " [optimization] %s\n", picoBlaze_OPT_TYPE_STR[ PCOO(PCINF(pc)->oper1)->type ]);
              break;
        case INF_LOCALREGS:
              fprintf(of, " [localregs] %s\n", picoBlaze_LR_TYPE_STR[ PCOLR(PCINF(pc)->oper1)->type ]);
              break;
        }
    };

    break;

  case PC_INLINE:
    fprintf(of,"%s\n", ((pCodeComment *)pc)->comment);
     break;

  case PC_OPCODE:
    // If the opcode has a label, print that first
    {
      pBranch *pbl = PCI(pc)->label;
      while(pbl && pbl->pc) {
        if(pbl->pc->type == PC_LABEL)
          pCodePrintLabel(of, pbl->pc);
        pbl = pbl->next;
      }
    }

    if(PCI(pc)->cline)
      genericPrint(of,PCODE(PCI(pc)->cline));

    {
      char str[256];

      picoBlaze_pCode2str(str, 256, pc);

      fprintf(of,"%s",str);
      /* Debug */
      if(picoBlaze_debug_verbose) {
        fprintf(of, "\t;key=%03x",pc->seq);
        if(PCI(pc)->pcflow)
          fprintf(of,", flow seq=%03x",PCI(pc)->pcflow->pc.seq);
      }
    }
    fprintf(of, "\n");
    break;

  case PC_WILD:
    fprintf(of,";\tWild opcode: id=%d\n",PCW(pc)->id);
    if(PCW(pc)->pci.label)
      pCodePrintLabel(of, PCW(pc)->pci.label->pc);

    if(PCW(pc)->operand) {
      fprintf(of,";\toperand  ");
      pCodeOpPrint(of, PCW(pc)->operand);
    }
    break;

  case PC_FLOW:
    if(picoBlaze_debug_verbose) {
      fprintf(of, ";<>Start of new flow, seq=0x%x", pc->seq);
      if(PCFL(pc)->ancestor)
        fprintf(of, " ancestor = 0x%x", PCODE(PCFL(pc)->ancestor)->seq);
      fprintf(of,"\n");
    }
    break;

  case PC_CSOURCE:
//    fprintf(of,";#CSRC\t%s %d\t\t%s\n", PCCS(pc)->file_name, PCCS(pc)->line_number, PCCS(pc)->line);
    fprintf(of,"%s\t.line\t%d; %s\t%s\n", ((picoBlaze_mplab_comp || !options.debug)?";":""),
        PCCS(pc)->line_number, PCCS(pc)->file_name, PCCS(pc)->line);

    break;

  case PC_ASMDIR:
        {
          pBranch *pbl = PCAD(pc)->pci.label;
                while(pbl && pbl->pc) {
                        if(pbl->pc->type == PC_LABEL)
                                pCodePrintLabel(of, pbl->pc);
                        pbl = pbl->next;
                }
        }
        if(PCAD(pc)->directive) {
                fprintf(of, "\t%s%s%s\n", PCAD(pc)->directive, PCAD(pc)->arg?"\t":"", PCAD(pc)->arg?PCAD(pc)->arg:"");
        } else
        if(PCAD(pc)->arg) {
                /* special case to handle inline labels without tab */
                fprintf(of, "%s\n", PCAD(pc)->arg);
        }
        break;

  case PC_LABEL: // processed by another printing function => error directly into output file
  default:
    fprintf(of, "unknown pCode type %d\n", pc->type);
  }

}

/*-----------------------------------------------------------------*/
/* pCodePrintFunction - prints function begin/end                  */
/*-----------------------------------------------------------------*/
static void pCodePrintFunction(FILE *of, pCode *pc)
{

  if(!pc || !of)
    return;


  if(!PCF(pc)->absblock) {
      if(PCF(pc)->fname) {
      pBranch *exits = PCF(pc)->to;
      int i=0;

      fprintf(of,"%s:", PCF(pc)->fname);

      if(picoBlaze_pcode_verbose)
        fprintf(of, "\t;Function start");

      fprintf(of, "\n");

      while(exits) {	// counts the number of exits from the function
        i++;
        exits = exits->next;
      }
      //if(i) i--;

      if(picoBlaze_pcode_verbose)
        fprintf(of,"; %d exit point%c\n",i, ((i==1) ? ' ':'s'));

    } else { // fname == NULL implies that it is the end of the function
        if((PCF(pc)->from &&	// previous pCode was the last pCode of a function?
                PCF(pc)->from->pc->type == PC_FUNCTION &&
                PCF(PCF(pc)->from->pc)->fname) ) {

                if(picoBlaze_pcode_verbose)
                        fprintf(of,"; exit point of %s\n",PCF(PCF(pc)->from->pc)->fname);
        } else {
                if(picoBlaze_pcode_verbose)
                        fprintf(of,"; exit point [can't find entry point]\n");
        }
        fprintf(of, "\n");
    }
  } // if !absblock
}

/*-----------------------------------------------------------------*/
/* pCodePrintLabel - prints label                                  */
/*-----------------------------------------------------------------*/
static void pCodePrintLabel(FILE *of, pCode *pc)
{

  if(!pc || !of)
    return;

  if(PCL(pc)->label)
    fprintf(of,"%s:\n",PCL(pc)->label);
  else if (PCL(pc)->key >=0)
    fprintf(of,"_%05d_DS_:\n",PCL(pc)->key);
  else
    fprintf(of,";wild card label: id=%d\n",-PCL(pc)->key);

}
/*-----------------------------------------------------------------*/
/* unlinkpCodeFromBranch - Search for a label in a pBranch and     */
/*                         remove it if it is found.               */
/*-----------------------------------------------------------------*/
static void unlinkpCodeFromBranch(pCode *pcl , pCode *pc)
{
  pBranch *b, *bprev;


  bprev = NULL;

  if(pcl->type == PC_OPCODE || pcl->type == PC_INLINE || pcl->type == PC_ASMDIR)
    b = PCI(pcl)->label;
  else {
    fprintf(stderr, "LINE %d. can't unlink from non opcode\n",__LINE__);
    exit(1);

  }

  //fprintf (stderr, "%s \n",__FUNCTION__);
  //pcl->print(stderr,pcl);
  //pc->print(stderr,pc);
  while(b) {
    if(b->pc == pc) {
      //fprintf (stderr, "found label\n");
      //pc->print(stderr, pc);

      /* Found a label */
      if(bprev) {
        bprev->next = b->next;  /* Not first pCode in chain */
//      Safe_free(b);
      } else {
        pc->destruct(pc);
        PCI(pcl)->label = b->next;   /* First pCode in chain */
//      Safe_free(b);
      }
      return;  /* A label can't occur more than once */
    }
    bprev = b;
    b = b->next;
  }

}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
pBranch * picoBlaze_pBranchAppend(pBranch *h, pBranch *n)
{
  pBranch *b;

  if(!h)
    return n;

  if(h == n)
    return n;

  b = h;
  while(b->next)
    b = b->next;

  b->next = n;

  return h;

}
/*-----------------------------------------------------------------*/
/* pBranchLink - given two pcodes, this function will link them    */
/*               together through their pBranches                  */
/*-----------------------------------------------------------------*/
static void pBranchLink(pCodeFunction *f, pCodeFunction *t)
{
  pBranch *b;

  // Declare a new branch object for the 'from' pCode.

  //_ALLOC(b,sizeof(pBranch));
  b = Safe_calloc(1,sizeof(pBranch));
  b->pc = PCODE(t);             // The link to the 'to' pCode.
  b->next = NULL;

  f->to = picoBlaze_pBranchAppend(f->to,b);

  // Now do the same for the 'to' pCode.

  //_ALLOC(b,sizeof(pBranch));
  b = Safe_calloc(1,sizeof(pBranch));
  b->pc = PCODE(f);
  b->next = NULL;

  t->from = picoBlaze_pBranchAppend(t->from,b);

}

#if 1
/*-----------------------------------------------------------------*/
/* pBranchFind - find the pBranch in a pBranch chain that contains */
/*               a pCode                                           */
/*-----------------------------------------------------------------*/
static pBranch *pBranchFind(pBranch *pb,pCode *pc)
{
  while(pb) {

    if(pb->pc == pc)
      return pb;

    pb = pb->next;
  }

  return NULL;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_pCodeUnlink - Unlink the given pCode from its pCode chain.      */
/*-----------------------------------------------------------------*/
void picoBlaze_pCodeUnlink(pCode *pc)
{
  pBranch *pb1,*pb2;
  pCode *pc1;

  if (!pc) {
    return;
  }

  /* Remove the branches */

  pb1 = PCI(pc)->from;
  while(pb1) {
    pc1 = pb1->pc;    /* Get the pCode that branches to the
                       * one we're unlinking */

    /* search for the link back to this pCode (the one we're
     * unlinking) */
    if((pb2 = pBranchFind(PCI(pc1)->to,pc))) {
      pb2->pc = PCI(pc)->to->pc;  // make the replacement

      /* if the pCode we're unlinking contains multiple 'to'
       * branches (e.g. this a skip instruction) then we need
       * to copy these extra branches to the chain. */
      if(PCI(pc)->to->next)
        picoBlaze_pBranchAppend(pb2, PCI(pc)->to->next);
    }

    pb1 = pb1->next;
  }

  picoBlaze_unlinkpCode (pc);

}
#endif
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
static int compareLabel(pCode *pc, pCodeOpLabel *pcop_label)
{
  pBranch *pbr;

  if(pc->type == PC_LABEL) {
    if( ((pCodeLabel *)pc)->key ==  pcop_label->key)
      return TRUE;
  }
  if((pc->type == PC_OPCODE)
        || (pc->type == PC_ASMDIR)
        ) {
    pbr = PCI(pc)->label;
    while(pbr) {
      if(pbr->pc->type == PC_LABEL) {
        if( ((pCodeLabel *)(pbr->pc))->key ==  pcop_label->key)
          return TRUE;
      }
      pbr = pbr->next;
    }
  }

  return FALSE;
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
static int checkLabel(pCode *pc)
{
  pBranch *pbr;

  if(pc && isPCI(pc)) {
    pbr = PCI(pc)->label;
    while(pbr) {
      if(isPCL(pbr->pc) && (PCL(pbr->pc)->key >= 0))
        return TRUE;

      pbr = pbr->next;
    }
  }

  return FALSE;
}

/*-----------------------------------------------------------------*/
/* findLabelinpBlock - Search the pCode for a particular label     */
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
/* picoBlaze_findNextpCode - given a pCode, find the next of type 'pct'      */
/*                 in the linked list                              */
/*-----------------------------------------------------------------*/
pCode * picoBlaze_findNextpCode(pCode *pc, PC_TYPE pct)
{

  while(pc) {
    if(pc->type == pct)
      return pc;

    pc = pc->next;
  }

  return NULL;
}

/*-----------------------------------------------------------------*/
/* findPrevpCode - given a pCode, find the previous of type 'pct'  */
/*                 in the linked list                              */
/*-----------------------------------------------------------------*/
static pCode * findPrevpCode(pCode *pc, PC_TYPE pct)
{

  while(pc) {
    if(pc->type == pct)
      return pc;

    pc = pc->prev;
  }

  return NULL;
}


//#define PCODE_DEBUG
/*-----------------------------------------------------------------*/
/* picoBlaze_findNextInstruction - given a pCode, find the next instruction  */
/*                       in the linked list                        */
/*-----------------------------------------------------------------*/
pCode * picoBlaze_findNextInstruction(pCode *pci)
{
  pCode *pc = pci;

  while(pc) {
    if((pc->type == PC_OPCODE)
        || (pc->type == PC_WILD)
        || (pc->type == PC_ASMDIR)
        )
      return pc;

#ifdef PCODE_DEBUG
    fprintf(stderr,"picoBlaze_findNextInstruction:  ");
    printpCode(stderr, pc);
#endif
    pc = pc->next;
  }

  //fprintf(stderr,"Couldn't find instruction\n");
  return NULL;
}

/*-----------------------------------------------------------------*/
/* picoBlaze_findPrevInstruction - given a pCode, find the next instruction  */
/*                       in the linked list                        */
/*-----------------------------------------------------------------*/
pCode * picoBlaze_findPrevInstruction(pCode *pci)
{
  pCode *pc = pci;

  while(pc) {

    if((pc->type == PC_OPCODE)
        || (pc->type == PC_WILD)
        || (pc->type == PC_ASMDIR)
        )
      return pc;


#ifdef PCODE_DEBUG
    fprintf(stderr,"picoBlaze_findPrevInstruction:  ");
    printpCode(stderr, pc);
#endif
    pc = pc->prev;
  }

  //fprintf(stderr,"Couldn't find instruction\n");
  return NULL;
}

#undef PCODE_DEBUG



/*-------------------------------------------------------------------*/
/* picoBlaze_getRegFrompCodeOp - extract the register from a pCodeOp     */
/*                            if one is present. This is the common  */
/*                            part of picoBlaze_getRegFromInstruction(2) */
/*-------------------------------------------------------------------*/

regs * picoBlaze_getRegFrompCodeOp (pCodeOp *pcop) {
  if (!pcop) return NULL;

  switch(pcop->type) {

  case PO_GPR_TEMP:
  case PO_GPR_SP:
//      fprintf(stderr, "picoBlaze_getRegFromInstruction - bit or temp\n");
    return PCOR(pcop)->r;

  case PO_GPR_BIT:
    return PCOR(pcop)->r;

  case PO_GPR_REGISTER:
  case PO_DIR:
//      fprintf(stderr, "picoBlaze_getRegFromInstruction - dir\n");
    return PCOR(pcop)->r;

  case PO_LITERAL:
    //fprintf(stderr, "picoBlaze_getRegFromInstruction - literal\n");
    break;

  case PO_LABEL:
    //fprintf (stderr, "%s - label or address: %d (%s)\n", __FUNCTION__, pcop->type, picoBlaze_dumpPicOptype(pcop->type));
    break;

  default:
        fprintf(stderr, "picoBlaze_getRegFrompCodeOp - unknown reg type %d (%s)\n",pcop->type, picoBlaze_dumpPicOptype (pcop->type));
//      assert( 0 );
        break;
  }

  return NULL;
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
regs * picoBlaze_getRegFromInstruction(pCode *pc)
{
  if(!pc                   ||
     !isPCI(pc)            ||
     !PCI(pc)->pcop        ||
     PCI(pc)->num_ops == 0 ||
     (PCI(pc)->num_ops == 1 && PCI(pc)->isFastCall))
    return NULL;

  // bookmark
	return NULL;

  return( picoBlaze_getRegFrompCodeOp (PCI(pc)->pcop) );
}

/*-------------------------------------------------------------------------------*/
/* picoBlaze_getRegFromInstruction2 - variant to support two memory operand commands */
/*-------------------------------------------------------------------------------*/
regs * picoBlaze_getRegFromInstruction2(pCode *pc)
{

  if(!pc                   ||
     !isPCI(pc)            ||
     !PCI(pc)->pcop        ||
     PCI(pc)->num_ops == 0 ||
     (PCI(pc)->num_ops == 1))           // accept only 2 operand commands
    return NULL;

    return NULL;


}

/*-----------------------------------------------------------------*/
/* AnalyzepBlock - TODO											   */
/*-----------------------------------------------------------------*/
static void AnalyzepBlock(pBlock *pb)
{
  pCode *pc;

  if(!pb)
    return;

  /* Find all of the registers used in this pBlock
   * by looking at each instruction and examining it's
   * operands
   */
  for(pc = pb->pcHead; pc; pc = pc->next) {

    /* Is this an instruction with operands? */
    if(pc->type == PC_OPCODE && PCI(pc)->pcop) {

      if(PCI(pc)->pcop->type == PO_GPR_TEMP) {

        /* Loop through all of the registers declared so far in
           this block and see if we find this one there */

        regs *r = setFirstItem(pb->tregisters);

        while(r) {
          if(r->rIdx == PCOR(PCI(pc)->pcop)->r->rIdx) {
            PCOR(PCI(pc)->pcop)->r = r;
            break;
          }
          r = setNextItem(pb->tregisters);
        }

        if(!r) {
          /* register wasn't found */
          //r = Safe_calloc(1, sizeof(regs));
          //memcpy(r,PCOR(PCI(pc)->pcop)->r, sizeof(regs));
          //addSet(&pb->tregisters, r);
          addSet(&pb->tregisters, PCOR(PCI(pc)->pcop)->r);
          //PCOR(PCI(pc)->pcop)->r = r;
          //fprintf(stderr,"added register to pblock: reg %d\n",r->rIdx);
        }/* else
          fprintf(stderr,"found register in pblock: reg %d\n",r->rIdx);
         */
      }
      if(PCI(pc)->pcop->type == PO_GPR_REGISTER) {
        if(PCOR(PCI(pc)->pcop)->r) {
          picoBlaze_allocWithIdx(PCOR(PCI(pc)->pcop)->r->rIdx);                     /* FIXME! - VR */
          DFPRINTF((stderr,"found register in pblock: reg 0x%x\n",PCOR(PCI(pc)->pcop)->r->rIdx));
        } else {
          if(PCI(pc)->pcop->name)
            fprintf(stderr,"ERROR: %s is a NULL register\n",PCI(pc)->pcop->name );
          else
            fprintf(stderr,"ERROR: NULL register\n");
        }
      }
    }


  }
}

#define PCI_HAS_LABEL(x) ((x) && (PCI(x)->label != NULL))

/*-----------------------------------------------------------------*/
/* InsertpFlow - creates and inserts new/existing pCodeFlow object to given pCode list */
/*-----------------------------------------------------------------*/
static void InsertpFlow(pCode *pc, pCode **pflow)
{
  if(*pflow)	// already points to valid pCodeFlow object
    PCFL(*pflow)->end = pc;

  if(!pc || !pc->next)
    return;

  *pflow = picoBlaze_newpCodeFlow();		// create new pCodeFlow object and return its pointer in pflow
  picoBlaze_pCodeInsertAfter(pc, *pflow);	// inserts *pflow after the head of pc (chain/double-linked list of more instructions)
}

/*-----------------------------------------------------------------*/
/* picoBlaze_BuildFlow(pBlock *pb) - examine the code in a pBlock and build  */
/*                         the flow blocks.                        */
/*
 * picoBlaze_BuildFlow inserts pCodeFlow objects into the pCode chain at each
 * point the instruction flow changes.
 */
/*-----------------------------------------------------------------*/
void picoBlaze_BuildFlow(pBlock *pb)
{
  pCode *pc;
  pCode *last_pci = NULL;
  pCode *pflow = NULL;
  int seq = 0;				// serial counter of solid instructions

  if(!pb)
    return;

  //fprintf (stderr,"build flow start seq %d  ",GpcFlowSeq);
  /* Insert a pCodeFlow object at the beginning of a pBlock */

  InsertpFlow(pb->pcHead, &pflow);

  //pflow = picoBlaze_newpCodeFlow();    /* Create a new Flow object */
  //pflow->next = pb->pcHead;  /* Make the current head the next object */
  //pb->pcHead->prev = pflow;  /* let the current head point back to the flow object */
  //pb->pcHead = pflow;        /* Make the Flow object the head */
  //pflow->pb = pb;

  // cycle over only pCodes of type OP_CODE, OP_ASMDIR and OP_WILD
  for( pc = picoBlaze_findNextInstruction(pb->pcHead);
       pc != NULL;
       pc = picoBlaze_findNextInstruction(pc)) {

    pc->seq = seq++;
    PCI(pc)->pcflow = PCFL(pflow);

    //fprintf(stderr," build: ");
    //pflow->print(stderr,pflow);

    if (checkLabel(pc)) {		// one of pc->label instructions (in pBranch) is a pCodeLabel

      /* This instruction marks the beginning of a
       * new flow segment */

      pc->seq = 0;
      seq = 1;

      /* If the previous pCode is not a flow object, then
       * insert a new flow object. (This check prevents
       * two consecutive flow objects from being insert in
       * the case where a skip instruction preceeds an
       * instruction containing a label.) */

      if(last_pci && (PCI(last_pci)->pcflow == PCFL(pflow)))
        InsertpFlow(picoBlaze_findPrevInstruction(pc->prev), &pflow);

      PCI(pc)->pcflow = PCFL(pflow);

    } // if checkLabel

    if( PCI(pc)->isSkip) {

      /* The two instructions immediately following this one
       * mark the beginning of a new flow segment */

      while(pc && PCI(pc)->isSkip) {

        PCI(pc)->pcflow = PCFL(pflow);
        pc->seq = seq-1;
        seq = 1;

        InsertpFlow(pc, &pflow);
        pc = picoBlaze_findNextInstruction(pc->next);
      }

      seq = 0;

      if(!pc)
        break;

      PCI(pc)->pcflow = PCFL(pflow);
      pc->seq = 0;
      InsertpFlow(pc, &pflow);

    } else if ( PCI(pc)->isBranch && !checkLabel(picoBlaze_findNextInstruction(pc->next)))  {

      InsertpFlow(pc, &pflow);
      seq = 0;

    }
    last_pci = pc;
    pc = pc->next;
  } // for

  //fprintf (stderr,",end seq %d",GpcFlowSeq);
  if(pflow)
    PCFL(pflow)->end = pb->pcTail;
}

/*-------------------------------------------------------------------*/
/* unBuildFlow(pBlock *pb) - examine the code in a pBlock and build  */
/*                           the flow blocks.                        */
/*
 * unBuildFlow removes pCodeFlow objects from a pCode chain
 */
/*-----------------------------------------------------------------*/
static void unBuildFlow(pBlock *pb)
{
  pCode *pc,*pcnext;

  if(!pb)
    return;

  pc = pb->pcHead;

  while(pc) {
    pcnext = pc->next;

    if(isPCI(pc)) {

      pc->seq = 0;
      if(PCI(pc)->pcflow) {
        //Safe_free(PCI(pc)->pcflow);
        PCI(pc)->pcflow = NULL;
      }

    } else if(isPCFL(pc) )
      pc->destruct(pc);

    pc = pcnext;
  }


}


/*-----------------------------------------------------------------*
 * int isBankInstruction(pCode *pc) - examine the pCode *pc to determine
 *    if it affects the banking bits.
 *
 * return: -1 == Banking bits are unaffected by this pCode.
 *
 * return: > 0 == Banking bits are affected.
 *
 *  If the banking bits are affected, then the returned value describes
 * which bits are affected and how they're affected. The lower half
 * of the integer maps to the bits that are affected, the upper half
 * to whether they're set or cleared.
 *
 *-----------------------------------------------------------------*/

static int isBankInstruction(pCode *pc)
{
	return 0;
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
int picoBlaze_isPCinFlow(pCode *pc, pCode *pcflow)
{

  if(!pc || !pcflow)
    return 0;

  if((!isPCI(pc) && !isPCAD(pc)) || !PCI(pc)->pcflow || !isPCFL(pcflow) )
    return 0;

  if( PCI(pc)->pcflow->pc.seq == pcflow->seq)
    return 1;

  return 0;
}





/*-----------------------------------------------------------------*/
/* insertBankSwitch - inserts a bank switch statement in the       */
/*                    assembly listing                             */
/*                                                                 */
/* position == 0: insert before                                    */
/* position == 1: insert after pc                                  */
/* position == 2: like 0 but previous was a skip instruction       */
/*-----------------------------------------------------------------*/
pCodeOp *picoBlaze_popGetLabel(unsigned int key);
extern int picoBlaze_labelOffset;

static void insertBankSwitch(unsigned char position, pCode *pc)
{
  pCode *new_pc;

        if(!pc)
                return;

        /* emit BANKSEL [symbol] */


        new_pc = picoBlaze_newpCodeAsmDir("BANKSEL", "%s", picoBlaze_get_op_from_instruction(PCI(pc)));

//      position = 0;           // position is always before (sanity check!)


        switch(position) {
                case 1: {
                        /* insert the bank switch after this pc instruction */
                        pCode *pcnext = picoBlaze_findNextInstruction(pc);

                                picoBlaze_pCodeInsertAfter(pc, new_pc);
                                if(pcnext)pc = pcnext;
                }; break;

                case 0:
                        /* insert the bank switch BEFORE this pc instruction */
                        picoBlaze_pCodeInsertAfter(pc->prev, new_pc);
                        break;

                case 2: {
                          symbol *tlbl;
                          pCode *pcnext, *pcprev, *npci, *ppc;
                          PIC_OPCODE ipci;
                          int ofs1=0, ofs2=0, len=0;

                        /* just like 0, but previous was a skip instruction,
                         * so some care should be taken */

                                picoBlaze_labelOffset += 10000;
                                tlbl = newiTempLabel(NULL);

                                /* invert skip instruction */
                                pcprev = picoBlaze_findPrevInstruction(pc->prev);
                                ipci = PCI(pcprev)->inverted_op;
                                npci = picoBlaze_newpCode(ipci, PCI(pcprev)->pcop);

//                              fprintf(stderr, "%s:%d old OP: %d\tnew OP: %d\n", __FILE__, __LINE__, PCI(pcprev)->op, ipci);

                                /* copy info from old pCode */
                                ofs1 = ofs2 = sizeof( pCode ) + sizeof(PIC_OPCODE);
                                len = sizeof(pCodeInstruction) - ofs1 - sizeof( char const * const *);
                                ofs1 += strlen( PCI(pcprev)->mnemonic) + 1;
                                ofs2 += strlen( PCI(npci)->mnemonic) + 1;
                                memcpy(&PCI(npci)->from, &PCI(pcprev)->from, (char *)(&(PCI(npci)->pci_magic)) - (char *)(&(PCI(npci)->from)));
                                PCI(npci)->op = PCI(pcprev)->inverted_op;

                                /* unlink old pCode */
                                ppc = pcprev->prev;
                                ppc->next = pcprev->next;
                                pcprev->next->prev = ppc;
                                picoBlaze_pCodeInsertAfter(ppc, npci);

                                /* extra instructions to handle invertion */
                                pcnext = picoBlaze_newpCode(POC_BRA, picoBlaze_popGetLabel(tlbl->key));
                                picoBlaze_pCodeInsertAfter(npci, pcnext);
                                picoBlaze_pCodeInsertAfter(pc->prev, new_pc);

                                pcnext = picoBlaze_newpCodeLabel(NULL,tlbl->key+100+picoBlaze_labelOffset);
                                picoBlaze_pCodeInsertAfter(pc, pcnext);
                        }; break;
        }


        /* Move the label, if there is one */
        if(PCI(pc)->label) {
//              fprintf(stderr, "%s:%d: moving label due to bank switch directive src= 0x%p dst= 0x%p\n",
//                      __FILE__, __LINE__, pc, new_pc);
                PCAD(new_pc)->pci.label = PCI(pc)->label;
                PCI(pc)->label = NULL;
        }
}


/*-----------------------------------------------------------------*/
/*int compareBankFlow - compare the banking requirements between   */
/*  flow objects. */
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
static pCode * findInstructionUsingLabel(pCodeLabel *pcl, pCode *pcs)
{
  pCode *pc;

  for(pc = pcs; pc; pc = pc->next) {

    if(((pc->type == PC_OPCODE) || (pc->type == PC_INLINE) || (pc->type == PC_ASMDIR)) &&
       (PCI(pc)->pcop) &&
       (PCI(pc)->pcop->type == PO_LABEL) &&
       (PCOLAB(PCI(pc)->pcop)->key == pcl->key))
      return pc;
  }


  return NULL;
}

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
static void exchangeLabels(pCodeLabel *pcl, pCode *pc)
{

  char *s=NULL;

  if(isPCI(pc) &&
     (PCI(pc)->pcop) &&
     (PCI(pc)->pcop->type == PO_LABEL)) {

    pCodeOpLabel *pcol = PCOLAB(PCI(pc)->pcop);

//      fprintf(stderr,"changing label key from %d to %d\n",pcol->key, pcl->key);
//    if(pcol->pcop.name)
//      Safe_free(pcol->pcop.name);

    /* If the key is negative, then we (probably) have a label to
     * a function and the name is already defined */

    if(pcl->key>0)
      sprintf(s=buffer,"_%05d_DS_",pcl->key);
    else
      s = pcl->label;

    //sprintf(buffer,"_%05d_DS_",pcl->key);
    if(!s) {
      fprintf(stderr, "ERROR %s:%d function label is null\n",__FUNCTION__,__LINE__);
    }
    pcol->pcop.name = Safe_strdup(s);
    pcol->key = pcl->key;
    //pc->print(stderr,pc);

  }


}

/*-----------------------------------------------------------------*/
/* pBlockRemoveUnusedLabels - remove the pCode labels from the     */
/*                            pCode chain if they're not used.     */
/*-----------------------------------------------------------------*/
static void pBlockRemoveUnusedLabels(pBlock *pb)
{
  pCode *pc; pCodeLabel *pcl;

  if(!pb || !pb->pcHead)
    return;

  for(pc = pb->pcHead; (pc=picoBlaze_findNextInstruction(pc->next)) != NULL; ) {

    pBranch *pbr = PCI(pc)->label;
    if(pbr && pbr->next) {
      pCode *pcd = pb->pcHead;

//      fprintf(stderr, "multiple labels\n");
//      pc->print(stderr,pc);

      pbr = pbr->next;
      while(pbr) {

        while ( (pcd = findInstructionUsingLabel(PCL(PCI(pc)->label->pc), pcd)) != NULL) {
          //fprintf(stderr,"Used by:\n");
          //pcd->print(stderr,pcd);

          exchangeLabels(PCL(pbr->pc),pcd);

          pcd = pcd->next;
        }
        pbr = pbr->next;
      }
    }
  }

  for(pc = pb->pcHead; pc; pc = pc->next) {

    if(isPCL(pc)) // pc->type == PC_LABEL)
      pcl = PCL(pc);
    else if (isPCI(pc) && PCI(pc)->label) //((pc->type == PC_OPCODE) && PCI(pc)->label)
      pcl = PCL(PCI(pc)->label->pc);
    else continue;

//      fprintf(stderr," found  A LABEL !!! key = %d, %s\n", pcl->key,pcl->label);

    /* This pCode is a label, so search the pBlock to see if anyone
     * refers to it */

    if( (pcl->key>0) && (!findInstructionUsingLabel(pcl, pb->pcHead))
        && (!pcl->force)) {
    //if( !findInstructionUsingLabel(pcl, pb->pcHead)) {
      /* Couldn't find an instruction that refers to this label
       * So, unlink the pCode label from it's pCode chain
       * and destroy the label */
//      fprintf(stderr," removed  A LABEL !!! key = %d, %s\n", pcl->key,pcl->label);

      DFPRINTF((stderr," !!! REMOVED A LABEL !!! key = %d, %s\n", pcl->key,pcl->label));
      if(pc->type == PC_LABEL) {
        picoBlaze_unlinkpCode(pc);
        pCodeLabelDestruct(pc);
      } else {
        unlinkpCodeFromBranch(pc, PCODE(pcl));
        /*if(pc->label->next == NULL && pc->label->pc == NULL) {
          Safe_free(pc->label);
        }*/
      }

    }
  }

}


/*-----------------------------------------------------------------*/
/* picoBlaze_pBlockMergeLabels - remove the pCode labels from the pCode      */
/*                     chain and put them into pBranches that are  */
/*                     associated with the appropriate pCode       */
/*                     instructions.                               */
/*-----------------------------------------------------------------*/
void picoBlaze_pBlockMergeLabels(pBlock *pb)
{
  pBranch *pbr;
  pCode *pc, *pcnext=NULL;

  if(!pb)
    return;

  /* First, Try to remove any unused labels */
  //pBlockRemoveUnusedLabels(pb);

  /* Now loop through the pBlock and merge the labels with the opcodes */

  pc = pb->pcHead;
  //  for(pc = pb->pcHead; pc; pc = pc->next) {

  while(pc) {
    pCode *pcn = pc->next;

    if(pc->type == PC_LABEL) {

//      fprintf(stderr," checking merging label %s\n",PCL(pc)->label);
//      fprintf(stderr,"Checking label key = %d\n",PCL(pc)->key);

      if((pcnext = picoBlaze_findNextInstruction(pc) )) {

//              pcnext->print(stderr, pcnext);

        // Unlink the pCode label from it's pCode chain
        picoBlaze_unlinkpCode(pc);

//      fprintf(stderr,"Merged label key = %d\n",PCL(pc)->key);
        // And link it into the instruction's pBranch labels. (Note, since
        // it's possible to have multiple labels associated with one instruction
        // we must provide a means to accomodate the additional labels. Thus
        // the labels are placed into the singly-linked list "label" as
        // opposed to being a single member of the pCodeInstruction.)

        //_ALLOC(pbr,sizeof(pBranch));
#if 1
        pbr = Safe_calloc(1,sizeof(pBranch));
        pbr->pc = pc;
        pbr->next = NULL;

        PCI(pcnext)->label = picoBlaze_pBranchAppend(PCI(pcnext)->label,pbr);
#endif
      } else {
        if(picoBlaze_pcode_verbose)
        fprintf(stderr, "WARNING: couldn't associate label %s with an instruction\n",PCL(pc)->label);
      }
    } else if(pc->type == PC_CSOURCE) {

      /* merge the source line symbolic info into the next instruction */
      if((pcnext = picoBlaze_findNextInstruction(pc) )) {

        // Unlink the pCode label from it's pCode chain
        picoBlaze_unlinkpCode(pc);
        PCI(pcnext)->cline = PCCS(pc);
        //fprintf(stderr, "merging CSRC\n");
        //genericPrint(stderr,pcnext);
      }

    }
    pc = pcn;
  }
  pBlockRemoveUnusedLabels(pb);

}

const char *picoBlaze_pCodeOpType(pCodeOp *pcop);
const char *picoBlaze_pCodeOpSubType(pCodeOp *pcop);


/*-----------------------------------------------------------------*/
/* picoBlaze_popCopyGPR2Bit - copy a pcode operator                          */
/*-----------------------------------------------------------------*/

pCodeOp *picoBlaze_popCopyGPR2Bit(pCodeOp *pc, int bitval)
{
  pCodeOp *pcop=NULL;

//  fprintf(stderr, "%s:%d pc type: %s\tname: %s\n", __FILE__, __LINE__, picoBlaze_pCodeOpType(pc), pc->name);

  if(pc->name) {
        pcop = picoBlaze_newpCodeOpBit(pc->name, bitval, 0, pc->type);
  } else {
    if(PCOR(pc)->r)pcop = picoBlaze_newpCodeOpBit(PCOR(pc)->r->name, bitval, 0, pc->type);
  }

  assert(pcop != NULL);

  if( !( (pcop->type == PO_LABEL) ||
         (pcop->type == PO_LITERAL) ))
    PCOR(pcop)->r = PCOR(pc)->r;  /* This is dangerous... */
    PCOR(pcop)->r->wasUsed = 1;
    PCOR(pcop)->instance = PCOR(pc)->instance;

  return pcop;
}


/*----------------------------------------------------------------------*
 * picoBlaze_areRegsSame - check to see if the names of two registers match *
 *----------------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
/* TODO: remove because PicoBlaze has no Register Banking */
static void picoBlaze_FixRegisterBanking(pBlock *pb)
{
  pCode *pc=NULL;
  pCode *pcprev=NULL;
  regs *reg, *prevreg;
  unsigned char flag=0;

        if(!pb)
                return;

        pc = picoBlaze_findNextpCode(pb->pcHead, PC_OPCODE);
        if(!pc)return;

        /* loop through all of the flow blocks with in one pblock */

//      fprintf(stderr,"%s:%d: Register banking\n", __FUNCTION__, __LINE__);

        prevreg = NULL;
        do {
                /* at this point, pc should point to a PC_FLOW object */
                /* for each flow block, determine the register banking
                 * requirements */


                /* if label, then might come from other point, force banksel */
                if(isPCL(pc))prevreg = NULL;

                if(!isPCI(pc))goto loop;

                if(PCI(pc)->label)prevreg = NULL;

                if(PCI(pc)->is2MemOp)goto loop;

                /* if goto, then force banksel */
//              if(PCI(pc)->op == POC_GOTO)prevreg = NULL;

                reg = picoBlaze_getRegFromInstruction(pc);


                /* now make some tests to make sure that instruction needs bank switch */

                /* if no register exists, and if not a bit opcode goto loop */
                if(!reg) {
                        if(!(PCI(pc)->pcop && PCI(pc)->pcop->type == PO_GPR_BIT))goto loop;
                }

                if(isPCI_SKIP(pc)) {
//                      fprintf(stderr, "instruction is SKIP instruction\n");
//                prevreg = NULL;
                }
                if(reg && isACCESS_BANK(reg))goto loop;

                if(!isBankInstruction(pc))goto loop;

                if(isPCI_LIT(pc))goto loop;

                if(PCI(pc)->op == POC_CALL)goto loop;

                /* Examine the instruction before this one to make sure it is
                 * not a skip type instruction */
                pcprev = findPrevpCode(pc->prev, PC_OPCODE);

                flag = 0;               /* add before this instruction */

                /* if previous instruction is a skip one, then set flag
                 * to 2 and call insertBankSwitch */
                if(pcprev && isPCI_SKIP(pcprev)) {
                  flag=2;       //goto loop
//                prevreg = NULL;
                }

                if(picoBlaze_options.opt_banksel>0) {
                  char op1[128], op2[128];

                    if(prevreg) {
                      strcpy(op1, picoBlaze_get_op_from_instruction(PCI(pc)));
                      strcpy(op2, picoBlaze_get_op_from_instruction(PCI(pcprev)));
                      if(!strcmp(op1, op2))goto loop;
                    }
                }
                prevreg = reg;
                insertBankSwitch(flag, pc);

//              fprintf(stderr, "BANK SWITCH inserted\n");

loop:
                pcprev = pc;
                pc = pc->next;
        } while (pc);
}

/** ADDITIONS BY RAPHAEL NEIDER, 2004-11-16: GOTO OPTIMIZATIONS **/

/* Returns the (maximum of the) number of bytes used by the specified pCode. */
int picoBlaze_instrSize (pCode *pc)
{
  if (!pc) return 0;

  if (isPCAD(pc)) {
    if (!PCAD(pc)->directive || strlen (PCAD(pc)->directive) < 3) return 0;
    return 4; // assumes only regular instructions using <= 4 bytes
  }

  if (isPCI(pc)) return PCI(pc)->isize;

  return 0;
}

/* Returns 1 if pc is referenced by the given label (either
 * pc is the label itself or is an instruction with an attached
 * label).
 * Returns 0 if pc is not preceeded by the specified label.
 */
int picoBlaze_isLabel (pCode *pc, char *label)
{
  if (!pc) return 0;

  // label attached to the pCode?
  if (isPCI(pc) || isPCAD(pc) || isPCW(pc) || pc->type == PC_INFO) {
    pBranch *lab = NULL;
    lab = PCI(pc)->label;

    while (lab) {
      if (isPCL(lab->pc) && strcmp(PCL(lab->pc)->label, label) == 0) {
        return 1;
      }
      lab = lab->next;
    } // while
  } // if

  // is inline assembly label?
  if (isPCAD(pc) && PCAD(pc)->directive == NULL && PCAD(pc)->arg) {
    // do not compare trailing ':'
    if (strncmp (PCAD(pc)->arg, label, strlen (label)) == 0) {
      return 1;
    }
  } // if

  // is pCodeLabel?
  if (isPCL(pc)) {
      if (strcmp(PCL(pc)->label,label) == 0) {
      return 1;
    }
  } // if

  // no label/no label attached/wrong label(s)
  return 0;
}

/* Returns the distance to the given label in terms of words.
 * Labels are searched only within -max .. max words from pc.
 * Returns max if the label could not be found or
 * its distance from pc in (-max..+max).
 */
int picoBlaze_findpCodeLabel (pCode *pc, char *label, int max, pCode **target) {
  int dist = picoBlaze_instrSize(pc);
  pCode *curr = pc;

  // search backwards
  while (dist < max && curr && !picoBlaze_isLabel (curr, label)) {
    curr = curr->prev;
    dist += picoBlaze_instrSize(curr); // sizeof (instruction)
  } // while
  if (curr && dist < max) {
    if (target != NULL) *target = curr;
    return -dist;
  }

  dist = 0;
  curr = picoBlaze_findNextInstruction (pc->next);
  //search forwards
  while (dist < max && curr && !picoBlaze_isLabel (curr, label)) {
    dist += picoBlaze_instrSize(curr); // sizeof (instruction)
    curr = curr->next;
  } // while
  if (curr && dist < max) {
    if (target != NULL) *target = curr;
    return dist;
  }

  if (target != NULL) *target = NULL;
  return max;
}

/* Returns -1 if pc does NOT denote an instruction like
 * BTFS[SC] STATUS,i
 * Otherwise we return
 *   (a) 0x10 + i for BTFSS
 *   (b) 0x00 + i for BTFSC
 */
/* Returns 1 if pc is one of BC, BZ, BOV, BN, BNC, BNZ, BNOV or BNN,
 * returns 0 otherwise. */

/* Returns 1 if pc has a label attached to it.
 * This can be either a label stored in the pCode itself (.label)
 * or a label making up its own pCode preceding this pc.
 * Returns 0 if pc cannot be reached directly via a label.
 */
int picoBlaze_hasNoLabel (pCode *pc)
{
  pCode *prev;
  if (!pc) return 1;

  // are there any label pCodes between pc and the previous instruction?
  prev = picoBlaze_findPrevInstruction (pc->prev);
  while (pc && pc != prev) {
    // pCode with attached label?
    if ((isPCI(pc) || isPCAD(pc) || isPCW(pc) || pc->type == PC_INFO)
        && PCI(pc)->label) {
      return 0;
    }
    // is inline assembly label?
    if (isPCAD(pc) && PCAD(pc)->directive == NULL) return 0;
    if (isPCW(pc) && PCW(pc)->label) return 0;

    // pCodeLabel?
    if (isPCL(pc)) return 0;

    pc = pc->prev;
  } // if

  // no label found
  return 1;
}


/* Replaces the old pCode with the new one, moving the labels,
 * C source line and probably flow information to the new pCode.
 */

/* Returns the inverted conditional branch (if any) or NULL.
 * pcop must be set to the new jump target.
 */

#define MAX_DIST_GOTO         0x7FFFFFFF
#define MAX_DIST_BRA                1020        // maximum offset (in bytes) possible with BRA
#define MAX_DIST_BCC                 120        // maximum offset (in bytes) possible with Bcc
#define MAX_JUMPCHAIN_DEPTH           16        // number of GOTOs to follow in picoBlaze_resolveJumpChain() (to prevent endless loops)
#define IS_GOTO(arg) ((arg) && isPCI(arg) && (PCI(arg)->op == POC_GOTO || PCI(arg)->op == POC_BRA))

/* Follows GOTO/BRA instructions to their target instructions, stores the
 * final destination (not a GOTO or BRA instruction) in target and returns
 * the distance from the original pc to *target.
 */

/* Returns pc if it is not a OPT_JUMPTABLE_BEGIN INFO pCode.
 * Otherwise the first pCode after the jumptable (after
 * the OPT_JUMPTABLE_END tag) is returned.
 */

/* Turn GOTOs into BRAs if distance between GOTO and label
 * is less than 1024 bytes.
 *
 * This method is especially useful if GOTOs after BTFS[SC]
 * can be turned into BRAs as GOTO would cost another NOP
 * if skipped.
 */

#undef IS_GOTO
#undef MAX_JUMPCHAIN_DEPTH
#undef MAX_DIST_GOTO
#undef MAX_DIST_BRA
#undef MAX_DIST_BCC

/** END OF RAPHAEL NEIDER'S ADDITIONS **/

/*-----------------------------------------------------------------*/
/* void mergepBlocks(char dbName) - Search for all pBlocks with the*/
/*                                  name dbName and combine them   */
/*                                  into one block                 */
/*-----------------------------------------------------------------*/
static void mergepBlocks(char dbName)
{

  pBlock *pb, *pbmerged = NULL,*pbn;

  pb = the_pFile->pbHead;

  //fprintf(stderr," merging blocks named %c\n",dbName);
  while(pb) {

    pbn = pb->next;
    //fprintf(stderr,"looking at %c\n",getpBlock_dbName(pb));
    if( getpBlock_dbName(pb) == dbName) {

      //fprintf(stderr," merged block %c\n",dbName);

      if(!pbmerged) {
        pbmerged = pb;
      } else {
        picoBlaze_addpCode2pBlock(pbmerged, pb->pcHead);
        /* picoBlaze_addpCode2pBlock doesn't handle the tail: */
        pbmerged->pcTail = pb->pcTail;

        pb->prev->next = pbn;
        if(pbn)
          pbn->prev = pb->prev;
      }
      //picoBlaze_printpBlock(stderr, pbmerged);
    }
    pb = pbn;
  }

}

/*-----------------------------------------------------------------*/
/* AnalyzeFlow - Examine the flow of the code and optimize         */
/*                                                                 */
/* level 0 == minimal optimization                                 */
/*   optimize registers that are used only by two instructions     */
/* level 1 == maximal optimization                                 */
/*   optimize by looking at pairs of instructions that use the     */
/*   register.                                                     */
/*-----------------------------------------------------------------*/



/* VR -- no need to analyze banking in flow, but left here :
 *      1. because it may be used in the future for other purposes
 *      2. because if omitted we'll miss some optimization done here
 *
 * Perhaps I should rename it to something else
 */

/*-----------------------------------------------------------------*/
/* picoBlaze_AnalyzeBanking - Called after the memory addresses have been    */
/*                  assigned to the registers.                     */
/*                                                                 */
/*-----------------------------------------------------------------*/

void picoBlaze_AnalyzeBanking(void)
{
  pBlock  *pb;

    /* Phase x - Flow Analysis - Used Banks
     *
     * In this phase, the individual flow blocks are examined
     * to determine the Register Banks they use
     */

    if(!the_pFile)return;

    if(!picoBlaze_options.no_banksel) {
      for(pb = the_pFile->pbHead; pb; pb = pb->next) {
//        fprintf(stderr, "%s:%d: Fix register banking in pb= 0x%p\n", __FILE__, __LINE__, pb);
        picoBlaze_FixRegisterBanking(pb);
      }
    }
}

/*-----------------------------------------------------------------*/
/* buildCallTree - Look at the flow and extract all of the calls.  */
/*-----------------------------------------------------------------*/
static set *register_usage(pBlock *pb);

static void buildCallTree(void)
{
  pBranch *pbr;
  pBlock  *pb;
  pCode   *pc;
  regs *r;

  if(!the_pFile)
    return;



  /* Now build the call tree.
     First we examine all of the pCodes for functions.
     Keep in mind that the function boundaries coincide
     with pBlock boundaries.

     The algorithm goes something like this:
     We have two nested loops. The outer loop iterates
     through all of the pBlocks/functions. The inner
     loop iterates through all of the pCodes for
     a given pBlock. When we begin iterating through
     a pBlock, the variable pc_fstart, pCode of the start
     of a function, is cleared. We then search for pCodes
     of type PC_FUNCTION. When one is encountered, we
     initialize pc_fstart to this and at the same time
     associate a new pBranch object that signifies a
     branch entry. If a return is found, then this signifies
     a function exit point. We'll link the pCodes of these
     returns to the matching pc_fstart.

     When we're done, a doubly linked list of pBranches
     will exist. The head of this list is stored in
     `the_pFile', which is the meta structure for all
     of the pCode. Look at the picoBlaze_printCallTree function
     on how the pBranches are linked together.

   */
  for(pb = the_pFile->pbHead; pb; pb = pb->next) {
    pCode *pc_fstart = NULL;
    for(pc = pb->pcHead; pc; pc = pc->next) {

        if(isPCI(pc) && pc_fstart) {
                if(PCI(pc)->is2MemOp) {
                        r = picoBlaze_getRegFromInstruction2(pc);
                        if(r && !strcmp(r->name, "POSTDEC1"))
                                PCF(pc_fstart)->stackusage++;
                } else {
                        r = picoBlaze_getRegFromInstruction(pc);
                        if(r && !strcmp(r->name, "PREINC1"))
                                PCF(pc_fstart)->stackusage--;
                }
        }

      if(isPCF(pc)) {
        if (PCF(pc)->fname) {
        char buf[16];

          sprintf(buf, "%smain", port->fun_prefix);
          if(STRCASECMP(PCF(pc)->fname, buf) == 0) {
            //fprintf(stderr," found main \n");
            pb->cmemmap = NULL;  /* FIXME do we need to free ? */
            pb->dbName = 'M';
          }

          pbr = Safe_calloc(1,sizeof(pBranch));
          pbr->pc = pc_fstart = pc;
          pbr->next = NULL;

          the_pFile->functions = picoBlaze_pBranchAppend(the_pFile->functions, pbr);

          // Here's a better way of doing the same:
          addSet(&pb->function_entries, pc);

        } else {
          // Found an exit point in a function, e.g. return
          // (Note, there may be more than one return per function)
          if(pc_fstart)
            pBranchLink(PCF(pc_fstart), PCF(pc));

          addSet(&pb->function_exits, pc);
        }
      } else if(isCALL(pc)) {
        addSet(&pb->function_calls,pc);
      }
    }
  }



}

/*-----------------------------------------------------------------*/
/* picoBlaze_AnalyzepCode - parse the pCode that has been generated and form */
/*                all of the logical connections.                  */
/*                                                                 */
/* Essentially what's done here is that the pCode flow is          */
/* determined.                                                     */
/*-----------------------------------------------------------------*/

void picoBlaze_AnalyzepCode(char dbName)
{
  pBlock *pb;
  int i,changes;

  if(!the_pFile)
    return;

  mergepBlocks('D');


  /* Phase 1 - Register allocation and peep hole optimization
   *
   * The first part of the analysis is to determine the registers
   * that are used in the pCode. Once that is done, the peep rules
   * are applied to the code. We continue to loop until no more
   * peep rule optimizations are found (or until we exceed the
   * MAX_PASSES threshold).
   *
   * When done, the required registers will be determined.
   *
   */

  buildCallTree();
}


/* convert a series of movff's of local regs to stack, with a single call to
 * a support functions which does the same thing via loop */

/*-----------------------------------------------------------------*/
/* ispCodeFunction - returns true if *pc is the pCode of a         */
/*                   function                                      */
/*-----------------------------------------------------------------*/
static bool ispCodeFunction(pCode *pc)
{

  if(pc && pc->type == PC_FUNCTION && PCF(pc)->fname)
    return 1;

  return 0;
}

/*-----------------------------------------------------------------*/
/* findFunction - Search for a function by name (given the name)   */
/*                in the set of all functions that are in a pBlock */
/* (note - I expect this to change because I'm planning to limit   */
/*  pBlock's to just one function declaration                      */
/*-----------------------------------------------------------------*/
static pCode *findFunction(char *fname)
{
  pBlock *pb;
  pCode *pc;
  if(!fname)
    return NULL;

  for(pb = the_pFile->pbHead; pb; pb = pb->next) {

    pc = setFirstItem(pb->function_entries);
    while(pc) {

      if((pc->type == PC_FUNCTION) &&
         (PCF(pc)->fname) &&
         (strcmp(fname, PCF(pc)->fname)==0))
        return pc;

      pc = setNextItem(pb->function_entries);

    }

  }
  return NULL;
}




static void pBlockStats(FILE *of, pBlock *pb)
/* used by copy code */
{

  pCode *pc;
  regs  *r;

        if(!picoBlaze_pcode_verbose)return;

  fprintf(of,";***\n;  pBlock Stats: dbName = %c\n;***\n",getpBlock_dbName(pb));

  // for now just print the first element of each set
  pc = setFirstItem(pb->function_entries);
  if(pc) {
    fprintf(of,";entry:  ");
    pc->print(of,pc);
  }
  pc = setFirstItem(pb->function_exits);
  if(pc) {
    fprintf(of,";has an exit\n");
    //pc->print(of,pc);
  }

  pc = setFirstItem(pb->function_calls);
  if(pc) {
    fprintf(of,";functions called:\n");

    while(pc) {
      if(pc->type == PC_OPCODE && PCI(pc)->op == POC_CALL) {
        fprintf(of,";   %s\n",picoBlaze_get_op_from_instruction(PCI(pc)));
      }
      pc = setNextItem(pb->function_calls);
    }
  }

  r = setFirstItem(pb->tregisters);
  if(r) {
    int n = elementsInSet(pb->tregisters);

    fprintf(of,";%d compiler assigned register%c:\n",n, ( (n!=1) ? 's' : ' '));

    while (r) {
      fprintf(of,   ";   %s\n",r->name);
      r = setNextItem(pb->tregisters);
    }
  }

  fprintf(of, "; uses %d bytes of stack\n", 1+ elementsInSet(pb->tregisters));
}



/*-----------------------------------------------------------------*/
/* pct2 - writes the call tree to a file                           */
/*                                                                 */
/*-----------------------------------------------------------------*/
static void pct2(FILE *of,pBlock *pb,int indent,int usedstack)
{
  pCode *pc,*pcn;
  int i;
  //  set *registersInCallPath = NULL;

  if(!of)
    return;

  if(indent > 10) {
        fprintf(of, "recursive function\n");
    return; //recursion ?
  }

  pc = setFirstItem(pb->function_entries);

  if(!pc)
    return;

  pb->visited = 0;

  for(i=0;i<indent;i++)   // Indentation
        fputs("+   ", of);
  fputs("+- ", of);

  if(pc->type == PC_FUNCTION) {
    usedstack += PCF(pc)->stackusage;
    fprintf(of,"%s (stack: %i)\n",PCF(pc)->fname, usedstack);
  } else return;  // ???


  pc = setFirstItem(pb->function_calls);
  for( ; pc; pc = setNextItem(pb->function_calls)) {

    if(pc->type == PC_OPCODE && PCI(pc)->op == POC_CALL) {
      char *dest = picoBlaze_get_op_from_instruction(PCI(pc));

      pcn = findFunction(dest);
      if(pcn)
        pct2(of,pcn->pb,indent+1, usedstack);   // + PCF(pcn)->stackusage);
    } else
      fprintf(of,"BUG? pCode isn't a POC_CALL %d\n",__LINE__);

  }


}



char *picoBlaze_optype_names[]={
        "PO_NONE",         // No operand e.g. NOP
        "PO_GPR_REGISTER",   // A general purpose register
        "PO_GPR_BIT",        // A bit of a general purpose register
        "PO_GPR_TEMP",       // A general purpose temporary register
        "PO_LITERAL",        // A constant
        "PO_DIR",            // Direct memory (8051 legacy)
        "PO_LABEL",
        "PO_GPR_SP",
};


char *picoBlaze_dumpPicOptype(PICOBLAZE_OPTYPE type)
{
        assert( type >= 0 && type < sizeof(picoBlaze_optype_names)/sizeof( char *) );
        return (picoBlaze_optype_names[ type ]);
}

