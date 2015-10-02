;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.4 #5253 (Jan 12 2009) (MSVC)
; This file was generated Tue Jan 13 13:02:46 2009
;--------------------------------------------------------
; PICOBLAZE port for the Xilinx 8-bit PicoBlaze-3 softcore
;--------------------------------------------------------
	list	p=picoBlaze3

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _sum
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

udata_funlit_0	udata
sE	res	1

udata_funlit_1	udata
_sum	res	1

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
;	.line	7; funlit.c	void main()
S_funlit__main	code
_main:
;	.line	12; funlit.c	sum (c, d, e);
	LOAD	sE, 0x71
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x39
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x1d
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	CALL	_sum
	MOVLW	0x03
_00110_DS_:
	RETURN	

; #### MOV r1, €õŽ2
; #### iCode CALL
; #### **** iCode CALL
; ; Starting pCode block
;	.line	1; funlit.c	char sum(char nnn1, char n2, char n3)
S_funlit__sum	code
_sum:
	MOVLW	0x02
	MOVLW	0x03
	MOVLW	0x04
;	.line	3; funlit.c	return nnn1 + n2 + n3;
	MOVF	s0, W
	ADDWF	s1, F
	MOVF	s2, W
	ADDWF	s1, F
_00105_DS_:
	RETURN	



; Statistics:
; code size:	   39 (0x0027) bytes ( 0.03%)
;           	   19 (0x0013) words
; udata size:	    2 (0x0002) bytes ( 0.39%)
; access size:	    3 (0x0003) bytes


	end
