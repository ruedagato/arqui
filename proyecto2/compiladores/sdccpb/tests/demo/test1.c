// test pøiøazení short a int
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
