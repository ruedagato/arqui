// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Test of short-int implicit conversion
// 
void main()
{
	volatile short s;
	volatile int i;
	s = 0xFFFF;
	i = s;
}
