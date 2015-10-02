#ifndef SDCCRALLOCDBG_H
#define SDCCRALLOCDBG_H 1

extern FILE *debugF;
extern int picoBlaze_ralloc_debug;

void debugLog (char *fmt,...);
char * debugAopGet (char *str, operand * op);
char * debugLogRegType (short type);
void debugLogClose (void);
void dumpEbbsToDebug (eBBlock ** ebbs, int count);
void isData(sym_link *sl);
void printSymType(char * str, sym_link *sl);

void dbg_dumpregusage(void);

#endif