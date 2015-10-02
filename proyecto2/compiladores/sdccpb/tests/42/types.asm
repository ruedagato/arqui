;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.4 #5253 (Jan 13 2009) (MSVC)
; This file was generated Thu Jan 22 18:27:43 2009
;--------------------------------------------------------
; PICOBLAZE port for the Xilinx 8-bit PicoBlaze-3 softcore
;--------------------------------------------------------
	list	p=picoBlaze3

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _i
	global _str
	global _f
	global _main
;--------------------------------------------------------
;	Access bank symbols
;--------------------------------------------------------
	udata_acs
SP	res	1


; Internal registers
.registers	udata_ovr	0x0000
s0	res	1
s1	res	1
s2	res	1
s3	res	1
s4	res	1
s5	res	1

udata_types_0	udata
_i	res	2

udata_types_1	udata
_str	res	4

udata_types_2	udata
sE	res	1

udata_types_3	udata
_f	res	1

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
;	.line	13; types.c	int main(void)
S_types__main	code
_main:
;	.line	16; types.c	i = str.x = str.y = 13;
	MOVLW	_str
	MOVWF	s0
	MOVLW	_str
	MOVWF	s1
	MOVLW	_str
	MOVWF	s2
	MOVLW	_str
	MOVWF	s3
	MOVF	s2, W
	ADDLW	0x02
	MOVWF	s4
	MOVLW	0x00
	ADDWFC	s3, W
	MOVWF	s5
	MOVLW	0x0d
	MOVLW	0x00
	MOVLW	0x0d
	MOVLW	0x00
;	.line	17; types.c	return f(i, str.x);
	SUB	SP, 0x01
	STORE	(null), {SP}
	MOVWF	SP
	SUB	SP, 0x01
	STORE	(null), {SP}
	MOVWF	SP
	LOAD	sE, 0x0d
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	CALL	_f
	MOVWF	s0
	MOVLW	0x03
_00110_DS_:
	RETURN	

; #### MOV r1, Äè2
; #### iCode CALL
; #### **** iCode CALL
; ; Starting pCode block
;	.line	7; types.c	int f(char a, short b)
S_types__f	code
_f:
	MOVLW	0x02
	MOVLW	0x03
	MOVLW	0x04
;	.line	9; types.c	return a + b;
	MOVFF	((null) + -33686019)
	CLRF	s5
	BTFSC	s0, 7
	SETF	s5
	MOVF	s1, W
	ADDWF	s4, F
	MOVF	s2, W
	ADDWFC	s5, F
_00105_DS_:
	RETURN	



; Statistics:
; code size:	   85 (0x0055) bytes ( 0.06%)
;           	   42 (0x002a) words
; udata size:	    8 (0x0008) bytes ( 1.56%)
; access size:	    6 (0x0006) bytes


	end
