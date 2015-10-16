// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Demonstrate to LCD write - in a loop show 00 through 99 on LCD (without numerical division)
//

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
