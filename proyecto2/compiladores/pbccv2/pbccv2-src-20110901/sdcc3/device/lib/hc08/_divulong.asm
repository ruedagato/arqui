;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _divulong
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
	.globl __divulong_PARM_2
	.globl __divulong_PARM_1
	.globl __divulong
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
__divulong_sloc0_1_0::
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
__divulong_PARM_1:
	.ds 4
__divulong_PARM_2:
	.ds 4
__divulong_reste_1_1:
	.ds 4
__divulong_c_1_1:
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
;Allocation info for local variables in function '_divulong'
;------------------------------------------------------------
;a                         Allocated with name '__divulong_PARM_1'
;b                         Allocated with name '__divulong_PARM_2'
;reste                     Allocated with name '__divulong_reste_1_1'
;count                     Allocated to registers 
;c                         Allocated with name '__divulong_c_1_1'
;sloc0                     Allocated with name '__divulong_sloc0_1_0'
;------------------------------------------------------------
;_divulong.c:331: _divulong (unsigned long a, unsigned long b)
;	-----------------------------------------
;	 function _divulong
;	-----------------------------------------
__divulong:
;_divulong.c:333: unsigned long reste = 0L;
	clra
	sta	__divulong_reste_1_1
	sta	(__divulong_reste_1_1 + 1)
	sta	(__divulong_reste_1_1 + 2)
	sta	(__divulong_reste_1_1 + 3)
;_divulong.c:337: do
	mov	#0x20,*__divulong_sloc0_1_0
00105$:
;_divulong.c:340: c = MSB_SET(a);
	lda	__divulong_PARM_1
	rola
	clra
	rola
	sta	__divulong_c_1_1
;_divulong.c:341: a <<= 1;
	lda	(__divulong_PARM_1 + 3)
	ldx	(__divulong_PARM_1 + 2)
	lsla
	rolx
	sta	(__divulong_PARM_1 + 3)
	stx	(__divulong_PARM_1 + 2)
	lda	(__divulong_PARM_1 + 1)
	ldx	__divulong_PARM_1
	rola
	rolx
	sta	(__divulong_PARM_1 + 1)
	stx	__divulong_PARM_1
;_divulong.c:342: reste <<= 1;
	lda	(__divulong_reste_1_1 + 3)
	ldx	(__divulong_reste_1_1 + 2)
	lsla
	rolx
	sta	(__divulong_reste_1_1 + 3)
	stx	(__divulong_reste_1_1 + 2)
	lda	(__divulong_reste_1_1 + 1)
	ldx	__divulong_reste_1_1
	rola
	rolx
	sta	(__divulong_reste_1_1 + 1)
	stx	__divulong_reste_1_1
;_divulong.c:343: if (c)
	lda	__divulong_c_1_1
	beq	00102$
00115$:
;_divulong.c:344: reste |= 1L;
	lda	(__divulong_reste_1_1 + 3)
	ora	#0x01
	sta	(__divulong_reste_1_1 + 3)
00102$:
;_divulong.c:346: if (reste >= b)
	lda	(__divulong_reste_1_1 + 3)
	sub	(__divulong_PARM_2 + 3)
	lda	(__divulong_reste_1_1 + 2)
	sbc	(__divulong_PARM_2 + 2)
	lda	(__divulong_reste_1_1 + 1)
	sbc	(__divulong_PARM_2 + 1)
	lda	__divulong_reste_1_1
	sbc	__divulong_PARM_2
	bcs	00106$
00116$:
;_divulong.c:348: reste -= b;
	lda	(__divulong_reste_1_1 + 3)
	sub	(__divulong_PARM_2 + 3)
	sta	(__divulong_reste_1_1 + 3)
	lda	(__divulong_reste_1_1 + 2)
	sbc	(__divulong_PARM_2 + 2)
	sta	(__divulong_reste_1_1 + 2)
	lda	(__divulong_reste_1_1 + 1)
	sbc	(__divulong_PARM_2 + 1)
	sta	(__divulong_reste_1_1 + 1)
	lda	__divulong_reste_1_1
	sbc	__divulong_PARM_2
	sta	__divulong_reste_1_1
;_divulong.c:350: a |= 1L;
	lda	(__divulong_PARM_1 + 3)
	ora	#0x01
	sta	(__divulong_PARM_1 + 3)
00106$:
;_divulong.c:353: while (--count);
	dbnz	*__divulong_sloc0_1_0,00117$
	bra	00118$
00117$:
	jmp	00105$
00118$:
;_divulong.c:354: return a;
	lda	__divulong_PARM_1
	sta	*__ret3
	lda	(__divulong_PARM_1 + 1)
	sta	*__ret2
	ldx	(__divulong_PARM_1 + 2)
	lda	(__divulong_PARM_1 + 3)
00108$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
