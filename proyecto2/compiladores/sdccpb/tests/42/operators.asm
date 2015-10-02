;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.4 #5253 (Jan 13 2009) (MSVC)
; This file was generated Thu Jan 15 14:44:44 2009
;--------------------------------------------------------
; PICOBLAZE port for the Xilinx 8-bit PicoBlaze-3 softcore
;--------------------------------------------------------
	list	p=picoBlaze3

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _main


; Internal registers
.registers	udata_ovr	0x0000
s0	res	1
s1	res	1
s2	res	1
s3	res	1
s4	res	1
s5	res	1
s6	res	1
s7	res	1
s8	res	1
s9	res	1

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
;	.line	1; operators.c	int main()
S_operators__main	code
_main:
;	.line	3; operators.c	int i = 0;
;	.line	4; operators.c	int j = 13;
;	.line	5; operators.c	zkouska:
_00105_DS_:
;	.line	6; operators.c	i += 2;
	MOVF	s8, W
	ADDLW	0x02
	MOVWF	s4
	MOVLW	0x00
	ADDWFC	s9, W
	MOVWF	s5
;	.line	7; operators.c	j -= i;
	MOVF	s8, W
	SUBWF	s6, F
	MOVF	s9, W
	SUBWFB	s7, F
;	.line	8; operators.c	i |= j;
	MOVF	s6, W
	IORWF	s8, F
	MOVF	s7, W
	IORWF	s9, F
;	.line	9; operators.c	goto zkouska;
	GOTO	_00105_DS_
;	.line	10; operators.c	return i*j;
_00106_DS_:
	RETURN	



; Statistics:
; code size:	   34 (0x0022) bytes ( 0.03%)
;           	   17 (0x0011) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	   10 (0x000a) bytes


	end
