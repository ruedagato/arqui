;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.4 #5253 (Jan 13 2009) (MSVC)
; This file was generated Tue Jan 13 18:55:43 2009
;--------------------------------------------------------
; PICOBLAZE port for the Xilinx 8-bit PicoBlaze-3 softcore
;--------------------------------------------------------
	list	p=picoBlaze3

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _struktura
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
s3	res	1
s4	res	1
s5	res	1
s6	res	1
s7	res	1
s8	res	1

udata_funstruct_0	udata
sE	res	1

udata_funstruct_1	udata
_sum	res	1

udata_funstruct_2	udata
_struktura	res	3

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
;	.line	11; funstruct.c	void main()
S_funstruct__main	code
_main:
;	.line	18; funstruct.c	if (sum(1, 2, 3) > 5)
	LOAD	sE, 0x00
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x03
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x00
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x02
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x01
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	CALL	_sum
	MOVWF	s0
	MOVLW	0x05
	MOVF	s1, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00116_DS_
	MOVLW	0x06
	SUBWF	s0, W
_00116_DS_:
	CLRF	s1
	RLCF	s1, F
	GOTO	_00111_DS_
;	.line	20; funstruct.c	sum(2, 3, c + d);
	LOAD	sE, 0x00
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x56
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x00
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x03
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x02
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	CALL	_sum
	MOVLW	0x05
;	.line	21; funstruct.c	return;
	GOTO	_00113_DS_
_00111_DS_:
;	.line	25; funstruct.c	struktura.a = 99;
	MOVLW	_struktura
	MOVWF	s3
	MOVLW	_struktura
	MOVWF	s4
	MOVLW	0x63
	MOVLW	0x00
;	.line	27; funstruct.c	struktura.a = 2*e;
	MOVLW	0xe2
	MOVLW	0x00
;	.line	28; funstruct.c	struktura.b = c;
	MOVLW	_struktura
	MOVWF	s5
	MOVLW	_struktura
	MOVWF	s6
	MOVF	s5, W
	ADDLW	0x02
	MOVWF	s7
	MOVLW	0x00
	ADDWFC	s6, W
	MOVWF	s8
	MOVLW	0x1d
;	.line	29; funstruct.c	sum (struktura.b, d, e);
	LOAD	sE, 0x00
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x71
	SUB	SP, 0x01
	STORE	sE, {SP}
	MOVWF	SP
	LOAD	sE, 0x00
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
	MOVLW	0x05
_00113_DS_:
	RETURN	

; #### MOV r1, €õŽ2
; #### iCode CALL
; #### **** iCode CALL
; #### MOV r1, €õŽ2
; #### iCode CALL
; #### **** iCode CALL
; #### MOV r1, €õŽ2
; #### iCode CALL
; #### **** iCode CALL
; ; Starting pCode block
;	.line	6; funstruct.c	int sum(char nnn1, short n2, int n3)
S_funstruct__sum	code
_sum:
	MOVLW	0x02
	MOVLW	0x03
	MOVLW	0x04
	MOVLW	0x05
	MOVLW	0x06
;	.line	8; funstruct.c	return (int)nnn1 + n2 + n3;
	MOVFF	((null) + -33686019)
	CLRF	s7
	BTFSC	s0, 7
	SETF	s7
	MOVF	s1, W
	ADDWF	s6, F
	MOVF	s2, W
	ADDWFC	s7, F
	MOVF	s3, W
	ADDWF	s6, F
	MOVF	s4, W
	ADDWFC	s7, F
_00105_DS_:
	RETURN	



; Statistics:
; code size:	  197 (0x00c5) bytes ( 0.15%)
;           	   98 (0x0062) words
; udata size:	    5 (0x0005) bytes ( 0.98%)
; access size:	    9 (0x0009) bytes


	end
