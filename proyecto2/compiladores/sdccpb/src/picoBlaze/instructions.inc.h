/****************************************************************/
/*                    PIC Instructions                          */
/****************************************************************/

/* 
Only basic list of 12-bit PIC instruction set:
Opcode (binary) Mnemonic 	Description
--------------	--------	-----------
0000 0000 0000 	NOP 		No operation
0000 0000 0010 	OPTION 		Load OPTION register with contents of W
0000 0000 0011 	SLEEP 		Go into standby mode
0000 0000 0100 	CLRWDT 		Reset watchdog timer
0000 0000 01ff 	TRIS f 		Move W to port control register (f=1..3)
0000 001 fffff 	MOVWF f 	Move W to f
0000 010 xxxxx 	CLRW 		Clear W to 0 (a.k.a CLR x,W)
0000 011 fffff 	CLRF f		Clear f to 0 (a.k.a. CLR f,F)
0000 10d fffff 	SUBWF f,d 	Subtract W from f (d = f ? W)
0000 11d fffff 	DECF f,d 	Decrement f (d = f ? 1)
0001 00d fffff 	IORWF f,d 	Inclusive OR W with F (d = f OR W)
0001 01d fffff 	ANDWF f,d 	AND W with F (d = f AND W)
0001 10d fffff 	XORWF f,d 	Exclusive OR W with F (d = f XOR W)
0001 11d fffff 	ADDWF f,d 	Add W with F (d = f + W)
0010 00d fffff 	MOVF f,d 	Move F (d = f)
0010 01d fffff 	COMF f,d 	Complement f (d = NOT f)
0010 10d fffff 	INCF f,d 	Increment f (d = f + 1)
0010 11d fffff 	DECFSZ f,d 	Decrement f (d = f ? 1) and skip if zero
0011 00d fffff 	RRF f,d 	Rotate right F (rotate right through carry)
0011 01d fffff 	RLF f,d 	Rotate left F (rotate left through carry)
0011 10d fffff 	SWAPF f,d 	Swap 4-bit halves of f (d = f<<4 | f>>4)
0011 11d fffff 	INCFSZ f,d 	Increment f (d = f + 1) and skip if zero
0100 bbb fffff 	BCF f,b 	Bit clear f (Clear bit b of f)
0101 bbb fffff 	BSF f,b 	Bit set f (Set bit b of f)
0110 bbb fffff 	BTFSC f,b 	Bit test f, skip if clear (Test bit b of f)
0111 bbb fffff 	BTFSS f,b 	Bit test f, skip if set (Test bit b of f)
1000 kkkkkkkk 	RETLW k 	Set W to k and return
1001 kkkkkkkk 	CALL k 		Save return address, load PC with k
101 kkkkkkkkk 	GOTO k 		Jump to address k (9 bits!)
1100 kkkkkkkk 	MOVLW k 	Move literal to W (W = k)
1101 kkkkkkkk 	IORLW k 	Inclusive or literal with W (W = k OR W)
1110 kkkkkkkk 	ANDLW k 	AND literal with W (W = k AND W)
1111 kkkkkkkk 	XORLW k 	Exclusive or literal with W (W = k XOR W)

Additional PIC instructions: http://wiki.4hv.org/index.php/Instruction_set:_PIC

Registers (http://hobby_elec.piclist.com/e_pic2_1.htm)
---------
INDF	:	Data memory contents by indirect addressing
TMR0	:	Timer counter
PCL		:	Low order 8 bits of the program counter
STATUS	:	Flag of the calculation result
FSR		:	Indirect data memory address pointer
PORTA	:	PORTA DATA I/O
PORTB	:	PORTB DATA I/O
EEDATA	:	Data for EEPROM
EEADR	:	Address for EEPROM
PCLATH	:	Write buffer for upper 5 bits of the program counter
INTCON	:	Interruption control
OPTION_REG	:	Mode set
TRISA	:	Mode set for PORTA
TRISB	:	Mode set for PORTB
EECON1	:	Control Register for EEPROM
EECON2	:	Write protection Register for EEPROM

*/

/*
PIC comment: 	ADDWF f,d: 	Add W with F (d = f + W)
*/
pCodeInstruction picoBlaze_pciADDWF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_ADDWF,
  "ADDWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond (see pcodeflow.h, uses W and some reg.)
  (PCC_REGISTER | PCC_STATUS), // outCond (see pcodeflow.h, afftects some reg. and status register)
  PCI_MAGIC
};

/*
PIC comment: 	dual to ADDWF: ADDWF f,d: 	Add W with F (d = f + W)
*/
pCodeInstruction picoBlaze_pciADDFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_ADDFW,
  "ADDWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  (PCC_W | PCC_STATUS), // outCond
  PCI_MAGIC
};

/*
PIC comment: ADDWFC f,d: 	 ADD WREG and Carry bit to f 	 (Flags changed:OV,C,DC,Z)
*/
pCodeInstruction picoBlaze_pciADDWFC = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_ADDWFC,
  "ADDWFC",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER | PCC_C),   // inCond
  (PCC_REGISTER | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciADDFWC = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_ADDFWC,
  "ADDWFC",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER | PCC_C),   // inCond
  (PCC_W | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciADDLW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_ADDLW,
  "ADDLW",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_LITERAL),   // inCond
  (PCC_W | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciANDLW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_ANDLW,
  "ANDLW",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_LITERAL),   // inCond
  (PCC_W | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciANDWF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_ANDWF,
  "ANDWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  (PCC_REGISTER | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciANDFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_ANDFW,
  "ANDWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  (PCC_W | PCC_Z | PCC_N) // outCond
};

pCodeInstruction picoBlaze_pciBC = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BC,
  "BC",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REL_ADDR | PCC_C),   // inCond
  PCC_NONE,    // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBCF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BCF,
  "BCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_BSF,
  (PCC_REGISTER | PCC_EXAMINE_PCOP),   // inCond
  PCC_REGISTER, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBN = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BN,
  "BN",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REL_ADDR | PCC_N),   // inCond
  PCC_NONE   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBNC = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BNC,
  "BNC",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REL_ADDR | PCC_C),   // inCond
  PCC_NONE   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBNN = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BNN,
  "BNN",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REL_ADDR | PCC_N),   // inCond
  PCC_NONE   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBNOV = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BNOV,
  "BNOV",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REL_ADDR | PCC_OV),   // inCond
  PCC_NONE   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBNZ = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BNZ,
  "BNZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REL_ADDR | PCC_Z),   // inCond
  PCC_NONE   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBOV = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BOV,
  "BOV",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REL_ADDR | PCC_OV),   // inCond
  PCC_NONE , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBRA = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BRA,
  "BRA",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REL_ADDR,   // inCond
  PCC_NONE   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBSF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BSF,
  "BSF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_BCF,
  (PCC_REGISTER | PCC_EXAMINE_PCOP),   // inCond
  (PCC_REGISTER | PCC_EXAMINE_PCOP), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBTFSC = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeSKIP,
   genericDestruct,
   genericPrint},
  POC_BTFSC,
  "BTFSC",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,1,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_BTFSS,
  (PCC_REGISTER | PCC_EXAMINE_PCOP),   // inCond
  PCC_EXAMINE_PCOP, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBTFSS = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeSKIP,
   genericDestruct,
   genericPrint},
  POC_BTFSS,
  "BTFSS",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,1,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_BTFSC,
  (PCC_REGISTER | PCC_EXAMINE_PCOP),   // inCond
  PCC_EXAMINE_PCOP, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBTG = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BTG,
  "BTG",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REGISTER | PCC_EXAMINE_PCOP),   // inCond
  (PCC_REGISTER | PCC_EXAMINE_PCOP), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciBZ = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_BZ,
  "BZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REL_ADDR | PCC_Z),   // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCALL = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_CALL,
  "CALL",
  4,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  1,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCOMF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_COMF,
  "COMF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,  // inCond
  (PCC_REGISTER | PCC_Z | PCC_N) , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCOMFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_COMFW,
  "COMF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,  // inCond
  (PCC_W | PCC_Z | PCC_N) , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCLRF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_CLRF,
  "CLRF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE, // inCond
  (PCC_REGISTER | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCLRWDT = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_CLRWDT,
  "CLRWDT",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE, // inCond
  PCC_NONE , // outCond
  PCI_MAGIC
};

/*
PIC comment: CPFSEQ f: 	 Compare f with WREG, skip if f = WREG
*/
pCodeInstruction picoBlaze_pciCPFSEQ = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_CPFSEQ,
  "CPFSEQ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER), // inCond
  PCC_NONE , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCPFSGT = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_CPFSGT,
  "CPFSGT",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER), // inCond
  PCC_NONE , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCPFSLT = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_CPFSLT,
  "CPFSLT",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  1,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER), // inCond
  PCC_NONE , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciDAW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_DAW,
  "DAW",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_W, // inCond
  (PCC_W | PCC_C), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciDCFSNZ = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_DCFSNZ,
  "DCFSNZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciDCFSNZW = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_DCFSNZW,
  "DCFSNZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER, // inCond
  PCC_W , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciDECF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_DECF,
  "DECF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_REGISTER | PCC_STATUS)  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciDECFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_DECFW,
  "DECF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_W | PCC_STATUS)  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciDECFSZ = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeSKIP,
   genericDestruct,
   genericPrint},
  POC_DECFSZ,
  "DECFSZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  PCC_REGISTER   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciDECFSZW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeSKIP,
   genericDestruct,
   genericPrint},
  POC_DECFSZW,
  "DECFSZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  PCC_W          , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciGOTO = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeGOTO,
   genericDestruct,
   genericPrint},
  POC_GOTO,
  "GOTO",
  4,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REL_ADDR,   // inCond
  PCC_NONE   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciINCF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_INCF,
  "INCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_REGISTER | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciINCFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_INCFW,
  "INCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_W | PCC_STATUS)  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciINCFSZ = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeSKIP,
   genericDestruct,
   genericPrint},
  POC_INCFSZ,
  "INCFSZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_INFSNZ,
  PCC_REGISTER,   // inCond
  PCC_REGISTER   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciINCFSZW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeSKIP,
   genericDestruct,
   genericPrint},
  POC_INCFSZW,
  "INCFSZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_INFSNZW,
  PCC_REGISTER,   // inCond
  PCC_W          , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciINFSNZ = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeSKIP,
   genericDestruct,
   genericPrint},
  POC_INFSNZ,
  "INFSNZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_INCFSZ,
  PCC_REGISTER,   // inCond
  PCC_REGISTER   , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciINFSNZW = { // vrokas - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeSKIP,
   genericDestruct,
   genericPrint},
  POC_INFSNZW,
  "INFSNZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_INCFSZW,
  PCC_REGISTER,   // inCond
  PCC_W          , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciIORWF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_IORWF,
  "IORWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  (PCC_REGISTER | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciIORFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_IORFW,
  "IORWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  (PCC_W | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciIORLW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_IORLW,
  "IORLW",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_LITERAL),   // inCond
  (PCC_W | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciLFSR = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_LFSR,
  "LFSR",
  4,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  POC_NOP,
  PCC_LITERAL, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciMOVF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_MOVF,
  "MOVF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciMOVFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_MOVFW,
  "MOVF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_W | PCC_N | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciMOVFF = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_MOVFF,
  "MOVFF",
  4,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  1,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  PCC_REGISTER2, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciMOVLB = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_MOVLB,
  "MOVLB",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_NONE | PCC_LITERAL),   // inCond
  PCC_REGISTER, // outCond - BSR
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciMOVLW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_MOVLW,
  "MOVLW",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_NONE | PCC_LITERAL),   // inCond
  PCC_W, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciMOVWF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_MOVWF,
  "MOVWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_W,   // inCond
  PCC_REGISTER, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciMULLW = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_MULLW,
  "MULLW",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_LITERAL),   // inCond
  PCC_NONE, // outCond - PROD
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciMULWF = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_MULWF,
  "MULWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  PCC_REGISTER, // outCond - PROD
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciNEGF = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_NEGF,
  "NEGF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER, // inCond
  (PCC_REGISTER | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciNOP = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_NOP,
  "NOP",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,   // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciPOP = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_POP,
  "POP",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciPUSH = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_PUSH,
  "PUSH",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRCALL = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_RCALL,
  "RCALL",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REL_ADDR,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRETFIE = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeRETURN,
   genericDestruct,
   genericPrint},
  POC_RETFIE,
  "RETFIE",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  1,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,   // inCond
  PCC_NONE,    // outCond (not true... affects the GIE bit too)
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRETLW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeRETURN,
   genericDestruct,
   genericPrint},
  POC_RETLW,
  "RETLW",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_LITERAL,   // inCond
  PCC_W, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRETURN = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   AnalyzeRETURN,
   genericDestruct,
   genericPrint},
  POC_RETURN,
  "RETURN",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  1,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,   // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};
pCodeInstruction picoBlaze_pciRLCF = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_RLCF,
  "RLCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_C | PCC_REGISTER),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRLCFW = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_RLCFW,
  "RLCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_C | PCC_REGISTER),   // inCond
  (PCC_W | PCC_C | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRLNCF = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_RLNCF,
  "RLNCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_REGISTER | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};
pCodeInstruction picoBlaze_pciRLNCFW = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_RLNCFW,
  "RLNCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_W | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};
pCodeInstruction picoBlaze_pciRRCF = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_RRCF,
  "RRCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_C | PCC_REGISTER),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};
pCodeInstruction picoBlaze_pciRRCFW = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_RRCFW,
  "RRCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_C | PCC_REGISTER),   // inCond
  (PCC_W | PCC_C | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};
pCodeInstruction picoBlaze_pciRRNCF = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_RRNCF,
  "RRNCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_REGISTER | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRRNCFW = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_RRNCFW,
  "RRNCF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_W | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSETF = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SETF,
  "SETF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_REGISTER  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBLW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SUBLW,
  "SUBLW",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_LITERAL),   // inCond
  (PCC_W | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBFWB = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SUBFWB,
  "SUBFWB",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER | PCC_C),   // inCond
  (PCC_W | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBWF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SUBWF,
  "SUBWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  (PCC_REGISTER | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SUBFW,
  "SUBWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  (PCC_W | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBFWB_D1 = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SUBFWB_D1,
  "SUBFWB",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER | PCC_C),   // inCond
  (PCC_REGISTER | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBFWB_D0 = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SUBFWB_D0,
  "SUBFWB",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER | PCC_C),   // inCond
  (PCC_W | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBWFB_D1 = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SUBWFB_D1,
  "SUBWFB",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER | PCC_C),   // inCond
  (PCC_REGISTER | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBWFB_D0 = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SUBWFB_D0,
  "SUBWFB",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER | PCC_C),   // inCond
  (PCC_W | PCC_STATUS), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSWAPF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SWAPF,
  "SWAPF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REGISTER),   // inCond
  (PCC_REGISTER), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSWAPFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_SWAPFW,
  "SWAPF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_REGISTER),   // inCond
  (PCC_W), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTBLRD = {     // patch 15
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_TBLRD,
  "TBLRD*",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTBLRD_POSTINC = {     // patch 15
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_TBLRD_POSTINC,
  "TBLRD*+",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTBLRD_POSTDEC = {     // patch 15
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_TBLRD_POSTDEC,
  "TBLRD*-",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTBLRD_PREINC = {      // patch 15
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_TBLRD_PREINC,
  "TBLRD+*",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTBLWT = {     // patch 15
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_TBLWT,
  "TBLWT*",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTBLWT_POSTINC = {     // patch 15
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_TBLWT_POSTINC,
  "TBLWT*+",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTBLWT_POSTDEC = {     // patch 15
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_TBLWT_POSTDEC,
  "TBLWT*-",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTBLWT_PREINC = {      // patch 15
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_TBLWT_PREINC,
  "TBLWT+*",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,  // inCond
  PCC_NONE  , // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTSTFSZ = { // mdubuc - New
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_TSTFSZ,
  "TSTFSZ",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  1,1,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_REGISTER,   // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciXORWF = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_XORWF,
  "XORWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  1,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  (PCC_REGISTER | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciXORFW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_XORFW,
  "XORWF",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  3,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_REGISTER),   // inCond
  (PCC_W | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciXORLW = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   //   genericAnalyze,
   genericDestruct,
   genericPrint},
  POC_XORLW,
  "XORLW",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  (PCC_W | PCC_LITERAL),   // inCond
  (PCC_W | PCC_Z | PCC_N), // outCond
  PCI_MAGIC
};


pCodeInstruction picoBlaze_pciBANKSEL = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  POC_BANKSEL,
  "BANKSEL",
  2,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  POC_NOP,
  PCC_NONE,   // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};


/* PicoBlaze real instructions 

sX, sY			registers
kk				constant
ss				RAM address
pp				port address

ADD sX,kk		
ADD sX,sY		
ADDCY sX,kk		
ADDCY sX,sY		
AND sX,kk
AND sX,sY
CALL
CALL C
CALL NC
CALL NZ
CALL Z
COMPARE sX,kk
COMPARE sX,sY
DISABLE INTERRUPT
ENABLE INTERRUPT
FETCH sX, ss
FETCH sX,(sY)
INPUT sX,(sY)
INPUT sX,pp
JUMP
JUMP C
JUMP NC
JUMP NZ
JUMP Z
LOAD sX,kk
LOAD sX,sY
OR sX,kk
OR sX,sY
OUTPUT sX,(sY)
OUTPUT sX,pp
RETURN
RETURN C
RETURN NC
RETURN NZ
RETURN Z
RETURNI DISABLE		Return from interrupt, re-enable interrupts
RETURNI ENABLE		Return from interrupt, leave interrupts disabled
RL sX				rotations
RR sX
SL0 sX				shifts
SL1 sX
SLA sX
SLX sX
SR0 sX
SR1 sX
SRA sX
SRX sX
STORE sX, ss		store to RAM
STORE sX,(sY)
SUB sX,kk
SUB sX,sY
SUBCY sX,kk
SUBCY sX,sY
TEST sX,kk
TEST sX,sY
XOR sX,kk
XOR sX,sY

*/

pCodeInstruction picoBlaze_pciADD_SXKK = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_ADD_SXKK,
  "ADD",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER |PCC_LITERAL),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciADD_SXSY = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_ADD_SXSY,
  "ADD",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciADDCY_SXKK = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
    genericDestruct,
   genericPrint},
  PBOC_ADDCY_SXKK,
  "ADDCY",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_C |PCC_LITERAL),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciADDCY_SXSY = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_ADDCY_SXSY,
  "ADDCY",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_C),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciAND_SXKK = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_AND_SXKK,
  "AND",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciAND_SXSY = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_AND_SXSY,
  "AND",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCALL_PICOBLAZE = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_CALL,
  "CALL",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  1,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_NONE, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCALLC = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_CALLC,
  "CALL C",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  1,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_C, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCALLNC = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_CALLNC,
  "CALL NC",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  1,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_C, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCALLZ = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_CALLZ,
  "CALL Z",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  1,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_Z, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCALLNZ = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_CALLZ,
  "CALLZ",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  1,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_Z, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCOMPARE_SXKK = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_COMPARE_SXKK,
  "COMPARE",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL), // inCond
  ( PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciCOMPARE_SXSY = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_COMPARE_SXSY,
  "COMPARE",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER), // inCond
  ( PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciDISABLE_INTERRUPT = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_DISABLE_INTERRUPT,
  "DISABLE INTERRUPT",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_NONE, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciENABLE_INTERRUPT = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_ENABLE_INTERRUPT,
  "ENABLE INTERRUPT",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_NONE, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciFETCH_SXSS = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_FETCH_SXSS,
  "FETCH",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL), // inCond
  PCC_REGISTER, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciFETCH_SXISY = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_FETCH_SXISY,
  "FETCH",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  1,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciINPUT_SXISY = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_INPUT_SXISY,
  "INPUT",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  1,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER, // outCond
  PCI_MAGIC
};


pCodeInstruction picoBlaze_pciINPUT_SXPP = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_INPUT_SXPP,
  "INPUT",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL), // inCond
  PCC_REGISTER, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciJUMP = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_JUMP,
  "JUMP",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_NONE, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciJUMPC = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_JUMPC,
  "JUMP C",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_C, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciJUMPNC = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_JUMPNC,
  "JUMP NC",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_C, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciJUMPNZ = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_JUMPNZ,
  "JUMP NZ",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_Z, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciJUMPZ = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_JUMPZ,
  "JUMP Z",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_Z, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};


pCodeInstruction picoBlaze_pciLOAD_SXKK = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_LOAD_SXKK,
  "LOAD",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL), // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciLOAD_SXSY = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_LOAD_SXSY,
  "LOAD",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciOR_SXKK = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_OR_SXKK,
  "OR",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciOR_SXSY = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_OR_SXSY,
  "OR",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciOUTPUT_SXISY = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_OUTPUT_SXISY,
  "OUTPUT",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  1,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL), // inCond
  PCC_REGISTER, // outCond
  PCI_MAGIC
};


pCodeInstruction picoBlaze_pciOUTPUT_SXPP = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_OUTPUT_SXPP,
  "OUTPUT",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL), // inCond
  PCC_REGISTER, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRETURN_PICOBLAZE = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_RETURN,
  "RETURN",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_NONE, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};


pCodeInstruction picoBlaze_pciRETURNC = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_RETURNC,
  "RETURN C",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_C, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRETURNNC = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_RETURNNC,
  "RETURN NC",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_C, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRETURNNZ = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_RETURNNZ,
  "RETURN NZ",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_Z, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRETURNZ = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_RETURNZ,
  "RETURN Z",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_Z, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRETURNI_DISABLE = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_RETURNI_DISABLE,
  "RETURNI DISABLE",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_NONE, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRETURNI_ENABLE = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_RETURNI_ENABLE,
  "RETURNI ENABLE",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  0,    // num ops
  0,0,  // dest, bit instruction
  1,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_NONE, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRL_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_RL_SX,
  "RL",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciRR_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_RR_SX,
  "RR",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSL0_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SL0_SX,
  "SL0",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSL1_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SL1_SX,
  "SL1",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSLA_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SLA_SX,
  "SLA",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSLX_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SLX_SX,
  "SLX",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};


pCodeInstruction picoBlaze_pciSR0_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SR0_SX,
  "SR0",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSR1_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SR1_SX,
  "SR1",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSRA_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SRA_SX,
  "SRA",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSRX_SX = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SRX_SX,
  "SRX",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  1,    // num ops
  0,1,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_REGISTER | PCC_C | PCC_Z, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_STORE_SXSS = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_STORE_SXSS,
  "STORE",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL), // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_STORE_SXISY = { 
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_STORE_SXISY,
  "STORE",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  1,    // RAM access bit
  0,    // fast call/return mode select bit
  1,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER, // inCond
  PCC_NONE, // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUB_SXKK = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SUB_SXKK,
  "SUB",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUB_SXSY = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SUB_SXSY,
  "SUB",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBCY_SXKK = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
    genericDestruct,
   genericPrint},
  PBOC_SUBCY_SXKK,
  "SUBCY",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  1,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_C | PCC_LITERAL),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciSUBCY_SXSY = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_SUBCY_SXSY,
  "SUBCY",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_C),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTEST_SXKK = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_TEST_SXKK,
  "TEST",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_C | PCC_Z | PCC_LITERAL),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciTEST_SXSY = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_TEST_SXSY,
  "TEST",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_C | PCC_Z),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciXOR_SXKK = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_XOR_SXKK,
  "XOR",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  1,    // second literal operand
  PBOC_NOP,
  (PCC_REGISTER | PCC_LITERAL),   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};

pCodeInstruction picoBlaze_pciXOR_SXSY = {
  {PC_OPCODE, NULL, NULL, 0, NULL,
   genericDestruct,
   genericPrint},
  PBOC_XOR_SXSY,
  "XOR",
  1,
  NULL, // from branch
  NULL, // to branch
  NULL, // label
  NULL, // operand
  NULL, // flow block
  NULL, // C source
  2,    // num ops
  0,0,  // dest, bit instruction
  0,0,  // branch, skip
  0,    // literal operand
  0,    // RAM access bit
  0,    // fast call/return mode select bit
  0,    // second memory operand
  0,    // second literal operand
  PBOC_NOP,
  PCC_REGISTER,   // inCond
  (PCC_REGISTER | PCC_C | PCC_Z), // outCond
  PCI_MAGIC
};