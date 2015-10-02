// kbd+lcd demo for picoblaze
#define KCPSM

#define global_cell  30

#ifdef KCPSM
#include "delay.h"
#include "port.h"
#include "lcd.h"
#include "kbd.h"
#include "intr.h"
#endif

void KBD_init()
{
  volatile unsigned char aux = 0;
  __asm
           STORE _aux, global_cell
  __endasm;      
}

unsigned char keypressed()
{
   volatile unsigned char ret = 0;
   __asm
     FETCH _ret, global_cell
   __endasm;
   return ret; 
}


void isr(void) interrupt
{
  volatile unsigned char aux = 1;
  
  __asm
           STORE _aux, global_cell
  __endasm;
       
}

   

void main(void)
{
  volatile unsigned char ch = 0;
  volatile unsigned char cnt = 0;
 
  LCD_init();

for(;;)
  {
      KBD_init();  

      pbcc_enable_interrupt();
      
      // test the global flag set in the interrupt routine
      while(!keypressed())
      {
            // nope()
      }      
      
      pbcc_disable_interrupt();
      
      // get pressed key (ASCII value)
      ch = readkey();
    
      // print only printable characters
      if ((ch > 32) && (ch < 123))  
      {
        cnt++;
        if (cnt > 7 || ch == 'C')  // print only on first 7 positions on LCD
        {
          LCD_clear();
          LCD_set_cursor();  
          cnt = 0;
        }
        if (ch != 'C')      
          LCD_write(ch);
      }
  
  }
  //  endfor
                
}