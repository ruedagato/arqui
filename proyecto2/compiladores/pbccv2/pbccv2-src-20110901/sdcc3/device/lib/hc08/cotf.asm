;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module cotf
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
	.globl _cotf
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
;Allocation info for local variables in function 'cotf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;y                         Allocated to registers 
;sloc0                     Allocated to stack - offset -1
;sloc1                     Allocated to stack - offset -5
;------------------------------------------------------------
;../cotf.c:37: float cotf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function cotf
;	-----------------------------------------
_cotf:
	ais	#-5
;../cotf.c:41: y=fabsf(x);
	lda	11,s
	psha
	lda	11,s
	psha
	lda	11,s
	psha
	lda	11,s
	psha
	jsr	_fabsf
	sta	(___fslt_PARM_1 + 3)
	stx	(___fslt_PARM_1 + 2)
	lda	*__ret2
	sta	(___fslt_PARM_1 + 1)
	lda	*__ret3
	sta	___fslt_PARM_1
	ais	#4
;../cotf.c:42: if (y<1.0E-30) //This one requires more thinking...
	lda	#0x0D
	sta	___fslt_PARM_2
	lda	#0xA2
	sta	(___fslt_PARM_2 + 1)
	lda	#0x42
	sta	(___fslt_PARM_2 + 2)
	lda	#0x60
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	5,s
	tst	5,s
	beq	00105$
00110$:
;../cotf.c:44: errno = ERANGE;
	clra
	sta	_errno
	lda	#0x22
	sta	(_errno + 1)
;../cotf.c:45: if (x<0.0)
	lda	8,s
	sta	___fslt_PARM_1
	lda	9,s
	sta	(___fslt_PARM_1 + 1)
	lda	10,s
	sta	(___fslt_PARM_1 + 2)
	lda	11,s
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	5,s
	tst	5,s
	beq	00102$
00111$:
;../cotf.c:46: return -HUGE_VALF;
	mov	#0xFF,*__ret3
	clr	*__ret2
	ldx	#0xFF
	lda	#0xFF
	bra	00106$
00102$:
;../cotf.c:48: return +HUGE_VALF;
	clr	*__ret3
	clr	*__ret2
	ldx	#0xFF
	lda	#0xFF
	bra	00106$
00105$:
;../cotf.c:50: return tancotf(x, 1);
	lda	8,s
	sta	_tancotf_PARM_1
	lda	9,s
	sta	(_tancotf_PARM_1 + 1)
	lda	10,s
	sta	(_tancotf_PARM_1 + 2)
	lda	11,s
	sta	(_tancotf_PARM_1 + 3)
	lda	#0x01
	sta	_tancotf_PARM_2
	jsr	_tancotf
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
00106$:
	ais	#5
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
