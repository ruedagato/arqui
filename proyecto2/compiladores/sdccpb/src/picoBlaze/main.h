#ifndef MAIN_INCLUDE
#define MAIN_INCLUDE

#include "ralloc.h"

bool x_parseOptions (char **argv, int *pargc);
void x_setDefaultOptions (void);
void x_finaliseOptions (void);


typedef struct {
	char *at_udata;
} picoBlaze_sectioninfo_t;

typedef struct absSym {
	char name[SDCC_SYMNAME_MAX+1];
	unsigned int address;
} absSym;

typedef struct sectName {
	char *name;
	set *regsSet;
} sectName;

typedef struct sectSym {
	sectName *section;
	char *name;
	regs *reg;
} sectSym;

extern set *absSymSet;
extern set *picoBlaze_sectNames;
extern set *picoBlaze_sectSyms;
extern set *picoBlaze_wparamList;

extern int picoBlaze_mplab_comp;

#endif
