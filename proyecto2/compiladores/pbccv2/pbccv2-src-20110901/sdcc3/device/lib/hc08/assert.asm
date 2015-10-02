;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module assert
	.optsdcc -mhc08
	
	.area HOME (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area CSEG (CODE)
	.area XINIT
	.area CONST   (CODE)
	.area DSEG
	.area OSEG    (OVR)
	.area BSEG
	.area XSEG
	.area XISEG
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __assert
	.globl __assert_PARM_3
	.globl __assert_PARM_2
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area OSEG    (OVR)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG
;--------------------------------------------------------
; extended address mode data
;--------------------------------------------------------
	.area XSEG
__assert_PARM_2:
	.ds 2
__assert_PARM_3:
	.ds 2
__assert_expr_1_1:
	.ds 2
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area GSINIT (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME (CODE)
	.area HOME (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function '_assert'
;------------------------------------------------------------
;filename                  Allocated with name '__assert_PARM_2'
;linenumber                Allocated with name '__assert_PARM_3'
;expr                      Allocated with name '__assert_expr_1_1'
;------------------------------------------------------------
;../assert.c:32: void _assert(char *expr, const char *filename, unsigned int linenumber)
;	-----------------------------------------
;	 function _assert
;	-----------------------------------------
__assert:
	sta	(__assert_expr_1_1 + 1)
	stx	__assert_expr_1_1
;../assert.c:34: printf("Assert(%s) failed at line %u in file %s.\n",
	lda	(__assert_PARM_2 + 1)
	psha
	lda	__assert_PARM_2
	psha
	lda	(__assert_PARM_3 + 1)
	psha
	lda	__assert_PARM_3
	psha
	lda	(__assert_expr_1_1 + 1)
	psha
	lda	__assert_expr_1_1
	psha
	ldhx	#__str_0
	pshx
	pshh
	jsr	_printf
	ais	#8
;../assert.c:36: while(1);
00102$:
	bra	00102$
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
__str_0:
	.ascii "Assert(%s) failed at line %u in file %s."
	.db 0x0A
	.db 0x00
	.area XINIT
	.area CABS    (ABS,CODE)
