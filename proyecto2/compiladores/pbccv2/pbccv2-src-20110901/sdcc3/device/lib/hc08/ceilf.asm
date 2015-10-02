;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module ceilf
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
	.globl _ceilf
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
;Allocation info for local variables in function 'ceilf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;r                         Allocated to stack - offset -4
;sloc0                     Allocated to stack - offset -8
;------------------------------------------------------------
;../ceilf.c:33: float ceilf(float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function ceilf
;	-----------------------------------------
_ceilf:
	ais	#-8
;../ceilf.c:36: r=x;
	lda	11,s
	sta	___fs2slong_PARM_1
	lda	12,s
	sta	(___fs2slong_PARM_1 + 1)
	lda	13,s
	sta	(___fs2slong_PARM_1 + 2)
	lda	14,s
	sta	(___fs2slong_PARM_1 + 3)
	jsr	___fs2slong
	sta	8,s
	stx	7,s
	lda	*__ret2
	sta	6,s
	lda	*__ret3
	sta	5,s
;../ceilf.c:37: if (r<0)
	lda	5,s
	sub	#0x00
	bge	00102$
00110$:
;../ceilf.c:38: return r;
	lda	5,s
	sta	___slong2fs_PARM_1
	lda	6,s
	sta	(___slong2fs_PARM_1 + 1)
	lda	7,s
	sta	(___slong2fs_PARM_1 + 2)
	lda	8,s
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
	jmp	00104$
00102$:
;../ceilf.c:40: return (r+((r<x)?1:0));
	lda	5,s
	sta	___slong2fs_PARM_1
	lda	6,s
	sta	(___slong2fs_PARM_1 + 1)
	lda	7,s
	sta	(___slong2fs_PARM_1 + 2)
	lda	8,s
	sta	(___slong2fs_PARM_1 + 3)
	jsr	___slong2fs
	sta	(___fslt_PARM_1 + 3)
	stx	(___fslt_PARM_1 + 2)
	lda	*__ret2
	sta	(___fslt_PARM_1 + 1)
	lda	*__ret3
	sta	___fslt_PARM_1
	lda	11,s
	sta	___fslt_PARM_2
	lda	12,s
	sta	(___fslt_PARM_2 + 1)
	lda	13,s
	sta	(___fslt_PARM_2 + 2)
	lda	14,s
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	1,s
	tst	1,s
	beq	00106$
00111$:
	lda	#0x01
	sta	1,s
	bra	00107$
00106$:
	clra
	sta	1,s
00107$:
	lda	1,s
	sta	2,s
	clra
	sta	1,s
	lda	2,s
	sta	4,s
	lda	1,s
	sta	3,s
	lda	1,s
	rola	
	clra	
	sbc	#0x00
	sta	2,s
	sta	1,s
	lda	8,s
	add	4,s
	sta	(___slong2fs_PARM_1 + 3)
	lda	7,s
	adc	3,s
	sta	(___slong2fs_PARM_1 + 2)
	lda	6,s
	adc	2,s
	sta	(___slong2fs_PARM_1 + 1)
	lda	5,s
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
00104$:
	ais	#8
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
