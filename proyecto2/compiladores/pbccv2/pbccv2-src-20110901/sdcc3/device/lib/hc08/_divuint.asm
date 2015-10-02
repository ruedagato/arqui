;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _divuint
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
	.globl __divuint_PARM_2
	.globl __divuint
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
__divuint_sloc0_1_0::
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
__divuint_PARM_2:
	.ds 2
__divuint_a_1_1:
	.ds 2
__divuint_reste_1_1:
	.ds 2
__divuint_c_1_1:
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
;Allocation info for local variables in function '_divuint'
;------------------------------------------------------------
;b                         Allocated with name '__divuint_PARM_2'
;a                         Allocated with name '__divuint_a_1_1'
;reste                     Allocated with name '__divuint_reste_1_1'
;count                     Allocated to registers 
;c                         Allocated with name '__divuint_c_1_1'
;sloc0                     Allocated with name '__divuint_sloc0_1_0'
;------------------------------------------------------------
;_divuint.c:153: _divuint (unsigned int a, unsigned int b)
;	-----------------------------------------
;	 function _divuint
;	-----------------------------------------
__divuint:
	sta	(__divuint_a_1_1 + 1)
	stx	__divuint_a_1_1
;_divuint.c:155: unsigned int reste = 0;
	clra
	sta	__divuint_reste_1_1
	sta	(__divuint_reste_1_1 + 1)
;_divuint.c:159: do
	mov	#0x10,*__divuint_sloc0_1_0
00105$:
;_divuint.c:162: c = MSB_SET(a);
	lda	__divuint_a_1_1
	rola
	clra
	rola
	sta	__divuint_c_1_1
;_divuint.c:163: a <<= 1;
	lda	(__divuint_a_1_1 + 1)
	ldx	__divuint_a_1_1
	lsla
	rolx
	sta	(__divuint_a_1_1 + 1)
	stx	__divuint_a_1_1
;_divuint.c:164: reste <<= 1;
	lda	(__divuint_reste_1_1 + 1)
	ldx	__divuint_reste_1_1
	lsla
	rolx
	sta	(__divuint_reste_1_1 + 1)
	stx	__divuint_reste_1_1
;_divuint.c:165: if (c)
	lda	__divuint_c_1_1
	beq	00102$
00115$:
;_divuint.c:166: reste |= 1;
	lda	(__divuint_reste_1_1 + 1)
	ora	#0x01
	sta	(__divuint_reste_1_1 + 1)
00102$:
;_divuint.c:168: if (reste >= b)
	lda	(__divuint_reste_1_1 + 1)
	sub	(__divuint_PARM_2 + 1)
	lda	__divuint_reste_1_1
	sbc	__divuint_PARM_2
	bcs	00106$
00116$:
;_divuint.c:170: reste -= b;
	lda	(__divuint_reste_1_1 + 1)
	sub	(__divuint_PARM_2 + 1)
	sta	(__divuint_reste_1_1 + 1)
	lda	__divuint_reste_1_1
	sbc	__divuint_PARM_2
	sta	__divuint_reste_1_1
;_divuint.c:172: a |= 1;
	lda	(__divuint_a_1_1 + 1)
	ora	#0x01
	sta	(__divuint_a_1_1 + 1)
00106$:
;_divuint.c:175: while (--count);
	dbnz	*__divuint_sloc0_1_0,00117$
	bra	00118$
00117$:
	bra	00105$
00118$:
;_divuint.c:176: return a;
	ldx	__divuint_a_1_1
	lda	(__divuint_a_1_1 + 1)
00108$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
