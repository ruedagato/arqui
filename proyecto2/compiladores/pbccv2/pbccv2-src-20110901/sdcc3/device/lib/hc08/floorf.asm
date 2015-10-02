;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module floorf
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
	.globl _floorf
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
;Allocation info for local variables in function 'floorf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;r                         Allocated to stack - offset -4
;sloc0                     Allocated to stack - offset -5
;sloc1                     Allocated to stack - offset -9
;------------------------------------------------------------
;../floorf.c:33: float floorf (float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function floorf
;	-----------------------------------------
_floorf:
	ais	#-9
;../floorf.c:36: r=x;
	lda	12,s
	sta	___fs2slong_PARM_1
	lda	13,s
	sta	(___fs2slong_PARM_1 + 1)
	lda	14,s
	sta	(___fs2slong_PARM_1 + 2)
	lda	15,s
	sta	(___fs2slong_PARM_1 + 3)
	jsr	___fs2slong
	sta	9,s
	stx	8,s
	lda	*__ret2
	sta	7,s
	lda	*__ret3
	sta	6,s
;../floorf.c:37: if (r<=0)
	clra
	sub	9,s
	clra
	sbc	8,s
	clra
	sbc	7,s
	clra
	sbc	6,s
	bge	00110$
	jmp	00102$
00110$:
;../floorf.c:38: return (r+((r>x)?-1:0));
	lda	6,s
	sta	___slong2fs_PARM_1
	lda	7,s
	sta	(___slong2fs_PARM_1 + 1)
	lda	8,s
	sta	(___slong2fs_PARM_1 + 2)
	lda	9,s
	sta	(___slong2fs_PARM_1 + 3)
	jsr	___slong2fs
	sta	(___fsgt_PARM_1 + 3)
	stx	(___fsgt_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsgt_PARM_1 + 1)
	lda	*__ret3
	sta	___fsgt_PARM_1
	lda	12,s
	sta	___fsgt_PARM_2
	lda	13,s
	sta	(___fsgt_PARM_2 + 1)
	lda	14,s
	sta	(___fsgt_PARM_2 + 2)
	lda	15,s
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	5,s
	tst	5,s
	beq	00106$
00111$:
	lda	#0xFF
	sta	5,s
	bra	00107$
00106$:
	clra
	sta	5,s
00107$:
	lda	5,s
	sta	4,s
	lda	5,s
	rola	
	clra	
	sbc	#0x00
	sta	3,s
	sta	2,s
	sta	1,s
	lda	9,s
	add	4,s
	sta	(___slong2fs_PARM_1 + 3)
	lda	8,s
	adc	3,s
	sta	(___slong2fs_PARM_1 + 2)
	lda	7,s
	adc	2,s
	sta	(___slong2fs_PARM_1 + 1)
	lda	6,s
	adc	1,s
	sta	___slong2fs_PARM_1
	jsr	___slong2fs
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	*__ret3
	lda	2,s
	sta	*__ret2
	ldx	3,s
	lda	4,s
	bra	00104$
00102$:
;../floorf.c:40: return r;
	lda	6,s
	sta	___slong2fs_PARM_1
	lda	7,s
	sta	(___slong2fs_PARM_1 + 1)
	lda	8,s
	sta	(___slong2fs_PARM_1 + 2)
	lda	9,s
	sta	(___slong2fs_PARM_1 + 3)
	jsr	___slong2fs
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	*__ret3
	lda	2,s
	sta	*__ret2
	ldx	3,s
	lda	4,s
00104$:
	ais	#9
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
