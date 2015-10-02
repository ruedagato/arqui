// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Test of short/int assignment
// 
void main()
{
	volatile short s;
	volatile int i;
	volatile unsigned short us;
	volatile unsigned int ui;
	s = 0xFFFE;
	i = 0xFFFFFE;
	us = 0xFFFD;
	ui = 0xFFFFFD;
}
