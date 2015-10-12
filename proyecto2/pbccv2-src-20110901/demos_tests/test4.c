// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Test of 8-bit division
//
#include "lcd.h"

#define ZERO 0x30

void main()
{
	volatile unsigned char i;
	volatile unsigned char stovky, desitky, jednotky;
	
  LCD_init();
	
	for(i = 0; i < 127; i++)
	{
	  LCD_set_cursor();
	  
		stovky = (unsigned char)i/(unsigned char)100;
		desitky = (unsigned char)((unsigned char)i-((unsigned char)stovky*(unsigned char)100))/(unsigned char)10;
		jednotky = (unsigned char)i-(unsigned char)stovky*(unsigned char)100-(unsigned char)desitky*(unsigned char)10;

    LCD_wr(stovky + ZERO);
    LCD_wr(desitky + ZERO);
    LCD_wr(jednotky + ZERO);
    delay(100);
	}
}