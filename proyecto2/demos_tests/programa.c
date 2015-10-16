// http://www.fit.vutbr.cz/~meduna/work/doku.php?id=projects:vlam:pbcc:pbcc
// 
// Test of BitWise operations (|, &, ^) (for pBlazeIDE), problem with NOT_OP
// In addition, test of the modulo operation.

// 100ms = (4 + 1032*DELAY_LOOP )*(1/50MHz)

// prende led
void led_on();
// apaga led
void led_off();
// espera 1 ms
void delay();
// espera n ms
void delay_ms(int n);

// cambia posicion ficha en un pixel
void saltar();

void main()
{
	char cont_sato = 20;
	char cont_nivel = 40;
	char cont_led = 100;
	led_on();
	while(1)
	{
		if (cont_sato == 0)
		{
			cont_sato = 20;
			saltar();
		}
		else
			cont_sato --;

		if (cont_led == 50)
			led_on();
		else
			cont_led --;
		if (cont_led == 0)
		{
			led_off();
			cont_led = 100;	
		}
		else
			cont_led --;
		delay_ms(10);
	}
}

void saltar()
{
	__asm
	XOR 	s7, 	02
	OUTPUT 	s7, 	00
	__endasm;
	delay();
	__asm
	XOR 	s7, 	02
	OUTPUT 	s7, 	00
	__endasm;
}

void led_on()
{
__asm
LOAD 	s7, 	01
OUTPUT 	s7, 	00
__endasm;
}

void led_off()
{
__asm
	LOAD 	s7, 	00
	OUTPUT 	s7, 	00
__endasm;
}

void delay()
{
	__asm
		CONSTANT DELAY_LOOP2		, 30   		; Loop delay				
					
   		LOAD s1, 00				
		_rpt2:  ADD s1, 01				
					
   		LOAD s0, 00				
		_rpt1:  ADD s0, 01						 
   		JUMP NZ,_rpt1				
					
   		COMPARE s1, DELAY_LOOP2				
   		JUMP NZ,_rpt2					
	__endasm;
}

void delay_ms(int n)
{
	int valor = n;
	while(valor!=0)
	{
		valor = valor - 1;
		delay();
	}
}