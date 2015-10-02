;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _fs2ulong
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
	.globl ___fs2ulong_PARM_1
	.globl ___fs2ulong
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
___fs2ulong_sloc0_1_0::
	.ds 4
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
___fs2ulong_PARM_1:
	.ds 4
___fs2ulong_fl1_1_1:
	.ds 4
___fs2ulong_exp_1_1:
	.ds 2
___fs2ulong_l_1_1:
	.ds 4
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
;Allocation info for local variables in function '__fs2ulong'
;------------------------------------------------------------
;a1                        Allocated with name '___fs2ulong_PARM_1'
;fl1                       Allocated with name '___fs2ulong_fl1_1_1'
;exp                       Allocated with name '___fs2ulong_exp_1_1'
;l                         Allocated with name '___fs2ulong_l_1_1'
;sloc0                     Allocated with name '___fs2ulong_sloc0_1_0'
;------------------------------------------------------------
;../_fs2ulong.c:103: __fs2ulong (float a1)
;	-----------------------------------------
;	 function __fs2ulong
;	-----------------------------------------
___fs2ulong:
;../_fs2ulong.c:109: fl1.f = a1;
	lda	___fs2ulong_PARM_1
	sta	___fs2ulong_fl1_1_1
	lda	(___fs2ulong_PARM_1 + 1)
	sta	(___fs2ulong_fl1_1_1 + 1)
	lda	(___fs2ulong_PARM_1 + 2)
	sta	(___fs2ulong_fl1_1_1 + 2)
	lda	(___fs2ulong_PARM_1 + 3)
	sta	(___fs2ulong_fl1_1_1 + 3)
;../_fs2ulong.c:111: if (!fl1.l || SIGN(fl1.l))
	lda	___fs2ulong_fl1_1_1
	sta	*___fs2ulong_sloc0_1_0
	lda	(___fs2ulong_fl1_1_1 + 1)
	sta	*(___fs2ulong_sloc0_1_0 + 1)
	lda	(___fs2ulong_fl1_1_1 + 2)
	sta	*(___fs2ulong_sloc0_1_0 + 2)
	lda	(___fs2ulong_fl1_1_1 + 3)
	sta	*(___fs2ulong_sloc0_1_0 + 3)
	lda	*(___fs2ulong_sloc0_1_0 + 3)
	ora	*(___fs2ulong_sloc0_1_0 + 2)
	ora	*(___fs2ulong_sloc0_1_0 + 1)
	ora	*___fs2ulong_sloc0_1_0
	beq	00101$
00107$:
	lda	___fs2ulong_fl1_1_1
	sta	*___fs2ulong_sloc0_1_0
	lda	(___fs2ulong_fl1_1_1 + 1)
	sta	*(___fs2ulong_sloc0_1_0 + 1)
	lda	(___fs2ulong_fl1_1_1 + 2)
	sta	*(___fs2ulong_sloc0_1_0 + 2)
	lda	(___fs2ulong_fl1_1_1 + 3)
	sta	*(___fs2ulong_sloc0_1_0 + 3)
	lda	*___fs2ulong_sloc0_1_0
	rola
	clra
	rola
	tsta
	beq	00102$
00108$:
00101$:
;../_fs2ulong.c:112: return (0);
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	rts
00102$:
;../_fs2ulong.c:114: exp = EXP (fl1.l) - EXCESS - 24;
	lda	___fs2ulong_fl1_1_1
	sta	*___fs2ulong_sloc0_1_0
	lda	(___fs2ulong_fl1_1_1 + 1)
	sta	*(___fs2ulong_sloc0_1_0 + 1)
	lda	(___fs2ulong_fl1_1_1 + 2)
	sta	*(___fs2ulong_sloc0_1_0 + 2)
	lda	(___fs2ulong_fl1_1_1 + 3)
	sta	*(___fs2ulong_sloc0_1_0 + 3)
	lda	*(___fs2ulong_sloc0_1_0 + 1)
	ldx	*___fs2ulong_sloc0_1_0
	lsla
	txa
	rola
	clrx
	rolx
	sta	*(___fs2ulong_sloc0_1_0 + 3)
	stx	*(___fs2ulong_sloc0_1_0 + 2)
	clr	*(___fs2ulong_sloc0_1_0 + 1)
	clr	*___fs2ulong_sloc0_1_0
	clr	*(___fs2ulong_sloc0_1_0 + 2)
	clr	*(___fs2ulong_sloc0_1_0 + 1)
	clr	*___fs2ulong_sloc0_1_0
	lda	*(___fs2ulong_sloc0_1_0 + 3)
	sub	#0x96
	sta	*(___fs2ulong_sloc0_1_0 + 3)
	lda	*(___fs2ulong_sloc0_1_0 + 2)
	sbc	#0x00
	sta	*(___fs2ulong_sloc0_1_0 + 2)
	lda	*(___fs2ulong_sloc0_1_0 + 1)
	sbc	#0x00
	sta	*(___fs2ulong_sloc0_1_0 + 1)
	lda	*___fs2ulong_sloc0_1_0
	sbc	#0x00
	sta	*___fs2ulong_sloc0_1_0
	lda	*(___fs2ulong_sloc0_1_0 + 3)
	sta	(___fs2ulong_exp_1_1 + 1)
	lda	*(___fs2ulong_sloc0_1_0 + 2)
	sta	___fs2ulong_exp_1_1
;../_fs2ulong.c:115: l = MANT (fl1.l);
	lda	___fs2ulong_fl1_1_1
	sta	*___fs2ulong_sloc0_1_0
	lda	(___fs2ulong_fl1_1_1 + 1)
	sta	*(___fs2ulong_sloc0_1_0 + 1)
	lda	(___fs2ulong_fl1_1_1 + 2)
	sta	*(___fs2ulong_sloc0_1_0 + 2)
	lda	(___fs2ulong_fl1_1_1 + 3)
	sta	*(___fs2ulong_sloc0_1_0 + 3)
	lda	*(___fs2ulong_sloc0_1_0 + 1)
	and	#0x7F
	sta	*(___fs2ulong_sloc0_1_0 + 1)
	clr	*___fs2ulong_sloc0_1_0
	lda	*(___fs2ulong_sloc0_1_0 + 3)
	sta	(___fs2ulong_l_1_1 + 3)
	lda	*(___fs2ulong_sloc0_1_0 + 2)
	sta	(___fs2ulong_l_1_1 + 2)
	lda	*(___fs2ulong_sloc0_1_0 + 1)
	ora	#0x80
	sta	(___fs2ulong_l_1_1 + 1)
	lda	*___fs2ulong_sloc0_1_0
	sta	___fs2ulong_l_1_1
;../_fs2ulong.c:117: l >>= -exp;
	clra
	sub	(___fs2ulong_exp_1_1 + 1)
	sta	*(___fs2ulong_sloc0_1_0 + 1)
	clra
	sbc	___fs2ulong_exp_1_1
	sta	*___fs2ulong_sloc0_1_0
	lda	(___fs2ulong_l_1_1 + 3)
	psha
	lda	(___fs2ulong_l_1_1 + 2)
	psha
	lda	(___fs2ulong_l_1_1 + 1)
	psha
	lda	___fs2ulong_l_1_1
	psha
	ldx	*(___fs2ulong_sloc0_1_0 + 1)
	beq	00110$
00109$:
	asr	1,s
	ror	2,s
	ror	3,s
	ror	4,s
	decx
	bne	00109$
00110$:
	lda	4,s
	sta	(___fs2ulong_l_1_1 + 3)
	lda	3,s
	sta	(___fs2ulong_l_1_1 + 2)
	lda	2,s
	sta	(___fs2ulong_l_1_1 + 1)
	lda	1,s
	sta	___fs2ulong_l_1_1
	ais	#4
;../_fs2ulong.c:119: return l;
	lda	___fs2ulong_l_1_1
	sta	*___fs2ulong_sloc0_1_0
	lda	(___fs2ulong_l_1_1 + 1)
	sta	*(___fs2ulong_sloc0_1_0 + 1)
	lda	(___fs2ulong_l_1_1 + 2)
	sta	*(___fs2ulong_sloc0_1_0 + 2)
	lda	(___fs2ulong_l_1_1 + 3)
	sta	*(___fs2ulong_sloc0_1_0 + 3)
	mov	*___fs2ulong_sloc0_1_0,*__ret3
	mov	*(___fs2ulong_sloc0_1_0 + 1),*__ret2
	ldx	*(___fs2ulong_sloc0_1_0 + 2)
	lda	*(___fs2ulong_sloc0_1_0 + 3)
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
