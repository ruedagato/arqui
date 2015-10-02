// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Test of interrupt handler (for pBlazeIDE)
//
void interruptHandler() interrupt
{
	volatile unsigned char val = 0;
	__asm
		FETCH _val, $30
	__endasm;
	val++;
	__asm
		STORE _val, $30
	__endasm;
	
}

void main()
{
	volatile unsigned char c = 0;
	__asm
		EINT
	__endasm;
	for (;;) {
		__asm
			FETCH _c, $30
		__endasm;
		c /= 4;
		__asm
			STORE _c, $31
		__endasm;
	}
}
