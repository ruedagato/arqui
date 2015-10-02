;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _fsneq
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
	.globl ___fsneq_PARM_2
	.globl ___fsneq_PARM_1
	.globl ___fsneq
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
___fsneq_sloc0_1_0::
	.ds 4
___fsneq_sloc1_1_0::
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
___fsneq_PARM_1:
	.ds 4
___fsneq_PARM_2:
	.ds 4
___fsneq_fl1_1_1:
	.ds 4
___fsneq_fl2_1_1:
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
;Allocation info for local variables in function '__fsneq'
;------------------------------------------------------------
;a1                        Allocated with name '___fsneq_PARM_1'
;a2                        Allocated with name '___fsneq_PARM_2'
;fl1                       Allocated with name '___fsneq_fl1_1_1'
;fl2                       Allocated with name '___fsneq_fl2_1_1'
;sloc0                     Allocated with name '___fsneq_sloc0_1_0'
;sloc1                     Allocated with name '___fsneq_sloc1_1_0'
;------------------------------------------------------------
;../_fsneq.c:80: char __fsneq (float a1, float a2)
;	-----------------------------------------
;	 function __fsneq
;	-----------------------------------------
___fsneq:
;../_fsneq.c:84: fl1.f = a1;
	lda	___fsneq_PARM_1
	sta	___fsneq_fl1_1_1
	lda	(___fsneq_PARM_1 + 1)
	sta	(___fsneq_fl1_1_1 + 1)
	lda	(___fsneq_PARM_1 + 2)
	sta	(___fsneq_fl1_1_1 + 2)
	lda	(___fsneq_PARM_1 + 3)
	sta	(___fsneq_fl1_1_1 + 3)
;../_fsneq.c:85: fl2.f = a2;
	lda	___fsneq_PARM_2
	sta	___fsneq_fl2_1_1
	lda	(___fsneq_PARM_2 + 1)
	sta	(___fsneq_fl2_1_1 + 1)
	lda	(___fsneq_PARM_2 + 2)
	sta	(___fsneq_fl2_1_1 + 2)
	lda	(___fsneq_PARM_2 + 3)
	sta	(___fsneq_fl2_1_1 + 3)
;../_fsneq.c:87: if (fl1.l == fl2.l)
	lda	___fsneq_fl1_1_1
	sta	*___fsneq_sloc0_1_0
	lda	(___fsneq_fl1_1_1 + 1)
	sta	*(___fsneq_sloc0_1_0 + 1)
	lda	(___fsneq_fl1_1_1 + 2)
	sta	*(___fsneq_sloc0_1_0 + 2)
	lda	(___fsneq_fl1_1_1 + 3)
	sta	*(___fsneq_sloc0_1_0 + 3)
	lda	___fsneq_fl2_1_1
	sta	*___fsneq_sloc1_1_0
	lda	(___fsneq_fl2_1_1 + 1)
	sta	*(___fsneq_sloc1_1_0 + 1)
	lda	(___fsneq_fl2_1_1 + 2)
	sta	*(___fsneq_sloc1_1_0 + 2)
	lda	(___fsneq_fl2_1_1 + 3)
	sta	*(___fsneq_sloc1_1_0 + 3)
	lda	*(___fsneq_sloc0_1_0 + 3)
	cmp	*(___fsneq_sloc1_1_0 + 3)
	bne	00109$
	lda	*(___fsneq_sloc0_1_0 + 2)
	cmp	*(___fsneq_sloc1_1_0 + 2)
	bne	00109$
	lda	*(___fsneq_sloc0_1_0 + 1)
	cmp	*(___fsneq_sloc1_1_0 + 1)
	bne	00109$
	lda	*___fsneq_sloc0_1_0
	cmp	*___fsneq_sloc1_1_0
	beq	00110$
00109$:
	bra	00102$
00110$:
;../_fsneq.c:88: return (0);
	clra
	rts
00102$:
;../_fsneq.c:89: if (((fl1.l | fl2.l) & 0x7FFFFFFF) == 0)
	lda	___fsneq_fl1_1_1
	sta	*___fsneq_sloc1_1_0
	lda	(___fsneq_fl1_1_1 + 1)
	sta	*(___fsneq_sloc1_1_0 + 1)
	lda	(___fsneq_fl1_1_1 + 2)
	sta	*(___fsneq_sloc1_1_0 + 2)
	lda	(___fsneq_fl1_1_1 + 3)
	sta	*(___fsneq_sloc1_1_0 + 3)
	lda	___fsneq_fl2_1_1
	sta	*___fsneq_sloc0_1_0
	lda	(___fsneq_fl2_1_1 + 1)
	sta	*(___fsneq_sloc0_1_0 + 1)
	lda	(___fsneq_fl2_1_1 + 2)
	sta	*(___fsneq_sloc0_1_0 + 2)
	lda	(___fsneq_fl2_1_1 + 3)
	sta	*(___fsneq_sloc0_1_0 + 3)
	lda	*(___fsneq_sloc1_1_0 + 3)
	ora	*(___fsneq_sloc0_1_0 + 3)
	sta	*(___fsneq_sloc1_1_0 + 3)
	lda	*(___fsneq_sloc1_1_0 + 2)
	ora	*(___fsneq_sloc0_1_0 + 2)
	sta	*(___fsneq_sloc1_1_0 + 2)
	lda	*(___fsneq_sloc1_1_0 + 1)
	ora	*(___fsneq_sloc0_1_0 + 1)
	sta	*(___fsneq_sloc1_1_0 + 1)
	lda	*___fsneq_sloc1_1_0
	ora	*___fsneq_sloc0_1_0
	sta	*___fsneq_sloc1_1_0
	tst	*(___fsneq_sloc1_1_0 + 3)
	bne	00111$
	tst	*(___fsneq_sloc1_1_0 + 2)
	bne	00111$
	tst	*(___fsneq_sloc1_1_0 + 1)
	bne	00111$
	lda	*___fsneq_sloc1_1_0
	and	#0x7F
00111$:
	bne	00104$
00112$:
;../_fsneq.c:90: return (0);
	clra
	rts
00104$:
;../_fsneq.c:91: return (1);
	lda	#0x01
00105$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
