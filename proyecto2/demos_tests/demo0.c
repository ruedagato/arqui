// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Demonstrate to handle LCD by inline assembler
//
#define port_lcd_high 41
#define port_lcd_low 40

#define LCD_CLEAR_DISPLAY  01
#define LCD_CURSOR_AT_HOME  02

void main(void) {
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

; test zapisu 3 znaku na LCD	   
	   
       LOAD s6, 80
       OUTPUT s6, port_lcd_low
       LOAD s6, 00
       OUTPUT s6, port_lcd_high
       CALL delayms

       ;tisk znaku D
       LOAD s6, 44
       OUTPUT s6, port_lcd_low
       LOAD s6, 01
       OUTPUT s6, port_lcd_high
       CALL delayms

       ;tisk znaku M
       LOAD s6, 4F
       OUTPUT s6, port_lcd_low
       LOAD s6, 01
       OUTPUT s6, port_lcd_high
       CALL delayms

       ;tisk znaku U
       LOAD s6, 55
       OUTPUT s6, port_lcd_low
       LOAD s6, 01
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
       JUMP NZ,rpt11

       COMPARE s1, 00
       JUMP NZ,rpt22
	   
	     RETURN
__endasm;
}
