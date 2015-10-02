// test 8-bit deleni
#include "lcd.h"

#define ZERO 0x30

void main()
{
	volatile char i;
	volatile char stovky, desitky;
	LCD_init();
	
	for(i = 0; i < 127; i++)
	{
    LCD_set_cursor();
    
    stovky = i/100;
    desitky = (i-(stovky*100))/10;
    
    LCD_wr(stovky+ZERO);
    LCD_wr(desitky+ZERO);
    LCD_wr(i-stovky*100-desitky*10+ZERO);
    
    delay(100);
  }
}
