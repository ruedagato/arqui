;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _moduint
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
	.globl __moduint_PARM_2
	.globl __moduint
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
__moduint_sloc0_1_0::
	.ds 1
__moduint_sloc1_1_0::
	.ds 1
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
__moduint_PARM_2:
	.ds 2
__moduint_a_1_1:
	.ds 2
__moduint_count_1_1:
	.ds 1
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
;Allocation info for local variables in function '_moduint'
;------------------------------------------------------------
;b                         Allocated with name '__moduint_PARM_2'
;a                         Allocated with name '__moduint_a_1_1'
;count                     Allocated with name '__moduint_count_1_1'
;sloc0                     Allocated with name '__moduint_sloc0_1_0'
;sloc1                     Allocated with name '__moduint_sloc1_1_0'
;------------------------------------------------------------
;../_moduint.c:173: _moduint (unsigned int a, unsigned int b)
;	-----------------------------------------
;	 function _moduint
;	-----------------------------------------
__moduint:
	sta	(__moduint_a_1_1 + 1)
	stx	__moduint_a_1_1
;../_moduint.c:175: unsigned char count = 0;
	clra
	sta	__moduint_count_1_1
;../_moduint.c:178: while (!MSB_SET(b))
	clr	*__moduint_sloc0_1_0
00103$:
	lda	__moduint_PARM_2
	rola
	clra
	rola
	tsta
	bne	00117$
00120$:
;../_moduint.c:180: b <<= 1;
	lda	(__moduint_PARM_2 + 1)
	ldx	__moduint_PARM_2
	lsla
	rolx
	sta	(__moduint_PARM_2 + 1)
	stx	__moduint_PARM_2
;../_moduint.c:181: if (b > a)
	lda	(__moduint_a_1_1 + 1)
	sub	(__moduint_PARM_2 + 1)
	lda	__moduint_a_1_1
	sbc	__moduint_PARM_2
	bcc	00102$
00121$:
;../_moduint.c:183: b >>=1;
	lda	(__moduint_PARM_2 + 1)
	ldx	__moduint_PARM_2
	lsrx
	rora
	sta	(__moduint_PARM_2 + 1)
	stx	__moduint_PARM_2
;../_moduint.c:184: break;
	bra	00117$
00102$:
;../_moduint.c:186: count++;
	inc	*__moduint_sloc0_1_0
	lda	*__moduint_sloc0_1_0
	sta	__moduint_count_1_1
	bra	00103$
;../_moduint.c:188: do
00117$:
	lda	__moduint_count_1_1
	sta	*__moduint_sloc0_1_0
00108$:
;../_moduint.c:190: if (a >= b)
	lda	(__moduint_a_1_1 + 1)
	sub	(__moduint_PARM_2 + 1)
	lda	__moduint_a_1_1
	sbc	__moduint_PARM_2
	bcs	00107$
00122$:
;../_moduint.c:191: a -= b;
	lda	(__moduint_a_1_1 + 1)
	sub	(__moduint_PARM_2 + 1)
	sta	(__moduint_a_1_1 + 1)
	lda	__moduint_a_1_1
	sbc	__moduint_PARM_2
	sta	__moduint_a_1_1
00107$:
;../_moduint.c:192: b >>= 1;
	lda	(__moduint_PARM_2 + 1)
	ldx	__moduint_PARM_2
	lsrx
	rora
	sta	(__moduint_PARM_2 + 1)
	stx	__moduint_PARM_2
;../_moduint.c:194: while (count--);
	mov	*__moduint_sloc0_1_0,*__moduint_sloc1_1_0
	dec	*__moduint_sloc0_1_0
	tst	*__moduint_sloc1_1_0
	bne	00108$
00123$:
;../_moduint.c:195: return a;
	ldx	__moduint_a_1_1
	lda	(__moduint_a_1_1 + 1)
00111$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
