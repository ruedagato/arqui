// postupny vypis 00 az 99 na LCD

#include "lcd.h"

#define ZERO 0x30
#define NINE 0x3A

void main(void) {
  volatile unsigned char i = 0;
  volatile unsigned char j = 0;
  volatile unsigned char d;
  
  LCD_init();
  for(;;)
    for (i = ZERO; i <= NINE; i++)
    {
      for (j = ZERO; j <= NINE; j++)
      {
        LCD_set_cursor();
        LCD_wr(i);
        LCD_wr(j);
        for (d=0;d<55;d++) 
          delay(100);
      } 
    }
}
