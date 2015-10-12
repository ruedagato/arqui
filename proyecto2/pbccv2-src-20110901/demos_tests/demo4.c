// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Demonstrate to LCD write - sequence of 0 through 9 on LCD
//
#define port_lcd_high 41
#define port_lcd_low 40

#define LCD_CLEAR_DISPLAY  01

#define LCD_wr(arg)   __port_write(0x40, (arg)); __port_write(0x41, 01) 

void __port_write(volatile char port, volatile char arg) 
{ 
	unsigned volatile char p;
	unsigned volatile char a;
	p = port;
	a = arg;
  __asm 
     OUTPUT _a, _p
     CALL delayms
  __endasm;
}

void LCD_init()
{
__asm
       ; LCD clear
       LOAD s6, LCD_CLEAR_DISPLAY
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
       CALL delayms

       ; LCD function set - osmibitovy prenos, displej slozen ze dvou polovin, font 5x8
       LOAD s6, 38
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
       CALL delayms

       ; LCD display - zobrazeni kurzoru, zapnuti displeje
       LOAD s6, 0E
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
       CALL delayms

       ; LCD entry mode - automaticka inkrementace adresy kurzoru
       LOAD s6, 06
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
       CALL delayms
       
      ; LCD - nastaveni kurzoru na zacatek radku (asi)
       LOAD s6, 80
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
       CALL delayms 
             
delayms:
       LOAD s2, 00
       ADD s2, 01

       LOAD s1, 00
rpt22: 
       ADD s1, 01

       LOAD s0, 00
rpt11: 
       ADD s0, 01
       JUMP NZ, rpt11

       COMPARE s1, 00
       JUMP NZ, rpt22
       RETURN
__endasm;
}

void main(void) {
//  volatile 
char ch = 48; //0x30
//  volatile 
char i = 0;
  LCD_init();
  for (ch = 48; ch<=57; ch++)
  {
    LCD_wr(ch);
      }
}


