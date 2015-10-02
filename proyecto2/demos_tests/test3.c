// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Test of 8-bit multiplication
// 
#include "lcd.h"
#define ZERO 0x30
#define SPACE 0x20

void main()
{
	volatile char a, b, r;
	LCD_init();
  a = 3;
  b = 3;
	r = a * b;
	LCD_wr(r + ZERO);  // print 9
	LCD_wr(SPACE);
  
  a = 2;
  b = 3;
  r = a * b;
	LCD_wr(r + ZERO);  // print 6
	LCD_wr(SPACE);	

  a = 1;
  b = 3;
  r = a * b;
	LCD_wr(r + ZERO);  // print 3
	LCD_wr(SPACE);	
	
  a = 0;
  b = 3;
  r = a * b;
	LCD_wr(r + ZERO);  // print 0
	LCD_wr(SPACE);
}
