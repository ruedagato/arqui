// test pøiøazení short a int mezi sebou
void main()
{
	volatile short s;
	volatile int i;
	s = 0xFFFF;
	i = s;
}
