void __port_write(char port, char arg) 
{ 
	__asm 
		OUTPUT _arg, _port 
	__endasm;
}

#define LCD_wr(arg)   __port_write(0x40, (arg));__port_write(0x41, 01) 

void LCD_init()
{
__asm
delayms:
       LOAD s2, 00
       ADD s2, 01

       LOAD s1, 00
rpt22:  ADD s1, 01

       LOAD s0, 00
rpt11:  ADD s0, 01
       JUMP NZ,rpt11

       COMPARE s1, 00
       JUMP NZ,rpt22
__endasm;
}

int main(void) {
 char ch = 0x41;
 LCD_init();
 //LCD_wr(ch);
 __port_write(0x40, ch);
 __port_write(0x41, 01)
}
