// kbd+lcd demo for picoblaze (upraveno docasne na pblazeide)
#define KCPSM

#define global_cell  30

#define port_counter 80
#define port_kb_low  60
#define port_kb_high 61

#ifdef KCPSM
#define iRETI RETURNI DISABLE
#define EINT  ENABLE INTERRUPT
#define DINT  DISABLE INTERRUPT
#else
#define iRETI RETI DISABLE
#define EINT  EINT
#define DINT  DINT
#endif

#ifdef KCPSM
#include "delay.h"
#include "port.h"
#include "lcd.h"
#endif

#define CHAR_SPACE  0x20
#define CHAR_B      0x42
#define CHAR_K      0x4B


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


unsigned char readkey()
{
      volatile unsigned char key = 0;
      __asm
       INPUT _key, port_kb_low
xch1:
       SRA  _key
       JUMP NC, xch4
       LOAD _key, 31
       JUMP xchno

xch4:
       SRA  _key
       JUMP NC, xch7
       LOAD _key, 34
       JUMP xchno

xch7:
       SRA  _key
       JUMP NC, xchs
       LOAD _key, 37
       JUMP xchno

xchs:
       SRA  _key
       JUMP NC, xch2
       LOAD _key, 2A
       JUMP xchno

xch2:
       SRA  _key
       JUMP NC, xch5
       LOAD _key, 32
       JUMP xchno

xch5:
       SRA  _key
       JUMP NC, xch8
       LOAD _key, 35
       JUMP xchno

xch8:
       SRA  _key
       JUMP NC, xch0
       LOAD _key, 38
       JUMP xchno

xch0:
       SRA  _key
       JUMP NC, xch3
       LOAD _key, 30
       JUMP xchno

xch3:
       INPUT _key, port_kb_high
       SRA  _key
       JUMP NC, xch6
       LOAD _key, 33
       JUMP xchno

xch6:
       SRA  _key
       JUMP NC, xch9
       LOAD _key, 36
       JUMP xchno

xch9:
       SRA  _key
       JUMP NC, xchm
       LOAD _key, 39
       JUMP xchno

xchm:
       SRA  _key
       JUMP NC, xcha
       LOAD _key, 23
       JUMP xchno

xcha:
       SRA  _key
       JUMP NC, xchb
       LOAD _key, 41
       JUMP xchno

xchb:
       SRA  _key
       JUMP NC, xchc
       LOAD _key, 42
       JUMP xchno

xchc:
       SRA  _key
       JUMP NC, xchd
       LOAD _key, 43
       JUMP xchno

xchd:
       SRA  _key
       JUMP NC, xchno
       LOAD _key, 44
   
xchno:
       
  __endasm;
  
  return key;
}
    

void main(void)
{
  volatile unsigned char ch = 0;
  volatile unsigned char cnt = 0;

#ifdef KCPSM  
  LCD_init();
#endif

for(;;)
{
  if (cnt > 7) 
  {
#ifdef KCPSM
    LCD_clear();
    LCD_set_cursor();
#endif    
    cnt = 0;
  }

  KBD_init();  
  __asm
       EINT
  __endasm;
  
  // otestovat flag
  while(!keypressed())
  {                   // behem LOAD sF, sF vyhod interrupt (edge)

  }       //endwhile
  
  __asm
       DINT
  __endasm;
  
  //zjistit stisknutou klavesu
  
#ifdef KCPSM  
  //LCD_wr(0x64);
  //ch = __port_read(0x60);   // zde z INPUT pujde treba 00000100 = prelozit na 0x37 v readkey
#else
  ch = 0x02;    // bude přeloženo na 0x34
#endif  
  ch = readkey();

#ifdef KCPSM
  if ((ch > 32) && (ch < 123))  
  {
    cnt++;
    LCD_write(ch);
 // delay(20);
  }
#endif
   

}
//  endfor
                
}