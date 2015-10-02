// test deleni a nasobeni pro vypis dekadickych cisel (verze pro pBlazeIDE)
void main()
{
	volatile char i;
	volatile char stovky, desitky, jednotky;
	
	for(i = 0; i < 127; i++)
	{
		stovky = i/(char)100;
		desitky = (i-(stovky*100))/(char)10;
		jednotky = i-stovky*100-desitky*(char)10;
		__asm
			STORE _stovky, 20
			STORE _desitky, 21
			STORE _jednotky, 22
		__endasm;
	}
}