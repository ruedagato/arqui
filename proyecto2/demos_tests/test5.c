// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Test of 8-bit division and multiplication to write number to LCD (pBlazeIDE dialect)
// 

void main()
{
	volatile unsigned char i;
	volatile unsigned char stovky, desitky, jednotky;

	
	for(i = 0; i < 127; i++)
	{
		stovky = (unsigned char)i/(unsigned char)100;
		desitky = (unsigned char)((unsigned char)i-((unsigned char)stovky*(unsigned char)100))/(unsigned char)10;
		jednotky = (unsigned char)i-(unsigned char)stovky*(unsigned char)100-(unsigned char)desitky*(unsigned char)10;
		__asm
			STORE _stovky, 30
			STORE _desitky, 31
			STORE _jednotky, 32
		__endasm;
	}
}