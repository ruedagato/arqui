// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Demonstrate the delay function in C language
//
#define port_lcd_high 41
#define port_lcd_low 40

#define LCD_CLEAR_DISPLAY  01

#define LCD_wr(arg)   __port_write(0x40, (arg)); __port_write(0x41, 01) 

void delay(char time, char time2)
{
  char i = 0;
  for(; time > 0; time--)
    for(i = time2; i > 0; i--)
       if (i - time > 0)
          i--;
       else
          i -= 2;
}

void __port_write(volatile char port, volatile char arg) 
{ 
	unsigned volatile char p;
	unsigned volatile char a;
	p = port;
	a = arg;
  __asm 
     OUTPUT _a, _p
  __endasm;
  delay(100, 10);
}

void LCD_init()
{
__asm
       ; LCD clear
       LOAD s6, LCD_CLEAR_DISPLAY
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
__endasm;

delay(100, 10);

__asm
       ; LCD function set - osmibitovy prenos, displej slozen ze dvou polovin, font 5x8
       LOAD s6, 38
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
__endasm;

delay(100, 10);

__asm
       ; LCD display - zobrazeni kurzoru, zapnuti displeje
       LOAD s6, 0E
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
__endasm;

delay(100, 10);

__asm
       ; LCD entry mode - automaticka inkrementace adresy kurzoru
       LOAD s6, 06
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
__endasm;

delay(100, 10);

__asm       
      ; LCD - nastaveni kurzoru na zacatek radku (asi)
       LOAD s6, 80
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
__endasm;

delay(100, 10);
}

int main(void) {
  volatile char ch = 0x40;
  LCD_init();
  for(; ch <= 0x50; ch++)
    {
      LCD_wr(ch);
      delay(100, 100);
    }
  return 0;
}


