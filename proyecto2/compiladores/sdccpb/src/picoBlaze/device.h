/*-------------------------------------------------------------------------

  picoBlaze

  device.c - Accomodates subtle variations in PICOBLAZE devices

   Written By -  Scott Dattalo scott@dattalo.com

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

/*
  PIC device abstraction

  There are dozens of variations of PIC microcontrollers. This include
  file attempts to abstract those differences so that SDCC can easily
  deal with them.
*/

#ifndef  __DEVICE_H__
#define  __DEVICE_H__

#define CONFIGURATION_WORDS	20
#define IDLOCATION_BYTES	20

typedef struct {
	unsigned int mask;
	int emit;
	unsigned int value;
} configRegInfo_t;

typedef struct {
	int confAddrStart;	/* starting address */
	int confAddrEnd;	/* ending address */
	configRegInfo_t crInfo[ CONFIGURATION_WORDS ];
} configWordsInfo_t;

typedef struct {
	unsigned char emit;
	unsigned char value;
} idRegInfo_t;

typedef struct {
	int idAddrStart;	/* starting ID address */
	int idAddrEnd;		/* ending ID address */
	idRegInfo_t irInfo[ IDLOCATION_BYTES ];
} idBytesInfo_t;


#define PROCESSOR_NAMES    4
/* Processor unique attributes */
typedef struct PICOBLAZE_device {
  char *name[PROCESSOR_NAMES];  /* aliases for the processor name */
  /* RAMsize *must* be the first item to copy for 'using' */
  int RAMsize;			/* size of Data RAM - VR 031120 */
  int acsSplitOfs;		/* access bank split offset */
  configWordsInfo_t cwInfo;	/* configuration words info */
  idBytesInfo_t idInfo;		/* ID Locations info */
  /* next *must* be the first field NOT being copied via 'using' */
  struct PICOBLAZE_device *next;    /* linked list */
} PICOBLAZE_device;

extern PICOBLAZE_device *picoBlaze;

/* Given a pointer to a register, this macro returns the bank that it is in */
#define REG_ADDR(r)        ((r)->isBitField ? (((r)->address)>>3) : (r)->address)

#define OF_LR_SUPPORT		0x00000001
#define OF_NO_OPTIMIZE_GOTO	0x00000002
#define OF_OPTIMIZE_CMP		0x00000004
#define OF_OPTIMIZE_DF		0x00000008

typedef struct {
  int no_banksel;
  int opt_banksel;
  int omit_configw;
  int omit_ivt;
  int leave_reset;
  int stack_model;
  int ivt_loc;
  int nodefaultlibs;
  int dumpcalltree;
  char *crt_name;
  int no_crt;
  int ip_stack;
  unsigned long opt_flags;
  int gstack;
  unsigned int debgen;
  int xinst;
  int json_flag;		// JSON flag if to do the dump of iCodes in JSON format
  char *json_dumpfile;  // name of the JSON dump file
} picoBlaze_options_t;

extern picoBlaze_options_t picoBlaze_options;

#define STACK_MODEL_SMALL	(picoBlaze_options.stack_model == 0)
#define STACK_MODEL_LARGE	(picoBlaze_options.stack_model == 1)

extern set *picoBlaze_fix_idataSymSet;
extern set *picoBlaze_rel_idataSymSet;

typedef struct {
  unsigned long isize;
  unsigned long adsize;
  unsigned long udsize;
  unsigned long idsize;
  unsigned long intsize;
} stats_t;

extern stats_t picoBlaze_statistics;

/****************************************/
void picoBlaze_assignConfigWordValue(int address, unsigned int value);
void picoBlaze_assignIdByteValue(int address, char value);
int picoBlaze_isREGinBank(regs *reg, int bank);		/* NOT IMPLEMENTED and USED */
int picoBlaze_REGallBanks(regs *reg);				/* NOT IMPLEMENTED and USED */

int picoBlaze_checkAddReg(set **set, regs *reg);
int picoBlaze_checkAddSym(set **set, symbol *reg);
int picoBlaze_checkSym(set *set, symbol *reg);

#endif  /* __DEVICE_H__ */

