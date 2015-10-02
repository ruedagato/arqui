;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module atan2f
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
	.globl _atan2f_PARM_2
	.globl _atan2f_PARM_1
	.globl _atan2f
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_atan2f_sloc0_1_0:
	.ds 1
_atan2f_sloc1_1_0:
	.ds 4
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
_atan2f_PARM_1:
	.ds 4
_atan2f_PARM_2:
	.ds 4
_atan2f_r_1_1:
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
;Allocation info for local variables in function 'atan2f'
;------------------------------------------------------------
;sloc0                     Allocated with name '_atan2f_sloc0_1_0'
;sloc1                     Allocated with name '_atan2f_sloc1_1_0'
;x                         Allocated with name '_atan2f_PARM_1'
;y                         Allocated with name '_atan2f_PARM_2'
;r                         Allocated with name '_atan2f_r_1_1'
;------------------------------------------------------------
;../atan2f.c:34: float atan2f(const float x, const float y)
;	-----------------------------------------
;	 function atan2f
;	-----------------------------------------
_atan2f:
;../atan2f.c:38: if ((x==0.0) && (y==0.0))
	lda	(_atan2f_PARM_1 + 3)
	ora	(_atan2f_PARM_1 + 2)
	ora	(_atan2f_PARM_1 + 1)
	ora	_atan2f_PARM_1
	bne	00102$
00121$:
	lda	(_atan2f_PARM_2 + 3)
	ora	(_atan2f_PARM_2 + 2)
	ora	(_atan2f_PARM_2 + 1)
	ora	_atan2f_PARM_2
	bne	00102$
00122$:
;../atan2f.c:40: errno=EDOM;
	clra
	sta	_errno
	lda	#0x21
	sta	(_errno + 1)
;../atan2f.c:41: return 0.0;
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	rts
00102$:
;../atan2f.c:44: if(fabsf(y)>=fabsf(x))
	lda	(_atan2f_PARM_2 + 3)
	psha
	lda	(_atan2f_PARM_2 + 2)
	psha
	lda	(_atan2f_PARM_2 + 1)
	psha
	lda	_atan2f_PARM_2
	psha
	jsr	_fabsf
	sta	(___fslt_PARM_1 + 3)
	stx	(___fslt_PARM_1 + 2)
	lda	*__ret2
	sta	(___fslt_PARM_1 + 1)
	lda	*__ret3
	sta	___fslt_PARM_1
	ais	#4
	lda	(_atan2f_PARM_1 + 3)
	psha
	lda	(_atan2f_PARM_1 + 2)
	psha
	lda	(_atan2f_PARM_1 + 1)
	psha
	lda	_atan2f_PARM_1
	psha
	jsr	_fabsf
	sta	(___fslt_PARM_2 + 3)
	stx	(___fslt_PARM_2 + 2)
	lda	*__ret2
	sta	(___fslt_PARM_2 + 1)
	lda	*__ret3
	sta	___fslt_PARM_2
	ais	#4
	jsr	___fslt
	sta	*_atan2f_sloc0_1_0
	tst	*_atan2f_sloc0_1_0
	beq	00123$
	jmp	00107$
00123$:
;../atan2f.c:46: r=atanf(x/y);
	lda	_atan2f_PARM_1
	sta	___fsdiv_PARM_1
	lda	(_atan2f_PARM_1 + 1)
	sta	(___fsdiv_PARM_1 + 1)
	lda	(_atan2f_PARM_1 + 2)
	sta	(___fsdiv_PARM_1 + 2)
	lda	(_atan2f_PARM_1 + 3)
	sta	(___fsdiv_PARM_1 + 3)
	lda	_atan2f_PARM_2
	sta	___fsdiv_PARM_2
	lda	(_atan2f_PARM_2 + 1)
	sta	(___fsdiv_PARM_2 + 1)
	lda	(_atan2f_PARM_2 + 2)
	sta	(___fsdiv_PARM_2 + 2)
	lda	(_atan2f_PARM_2 + 3)
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	*(_atan2f_sloc1_1_0 + 3)
	stx	*(_atan2f_sloc1_1_0 + 2)
	mov	*__ret2,*(_atan2f_sloc1_1_0 + 1)
	mov	*__ret3,*_atan2f_sloc1_1_0
	lda	*(_atan2f_sloc1_1_0 + 3)
	psha
	lda	*(_atan2f_sloc1_1_0 + 2)
	psha
	lda	*(_atan2f_sloc1_1_0 + 1)
	psha
	lda	*_atan2f_sloc1_1_0
	psha
	jsr	_atanf
	sta	(_atan2f_r_1_1 + 3)
	stx	(_atan2f_r_1_1 + 2)
	lda	*__ret2
	sta	(_atan2f_r_1_1 + 1)
	lda	*__ret3
	sta	_atan2f_r_1_1
	ais	#4
;../atan2f.c:47: if(y<0.0) r+=(x>=0?PI:-PI);
	lda	_atan2f_PARM_2
	sta	___fslt_PARM_1
	lda	(_atan2f_PARM_2 + 1)
	sta	(___fslt_PARM_1 + 1)
	lda	(_atan2f_PARM_2 + 2)
	sta	(___fslt_PARM_1 + 2)
	lda	(_atan2f_PARM_2 + 3)
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_atan2f_sloc1_1_0
	tst	*_atan2f_sloc1_1_0
	bne	00124$
	jmp	00108$
00124$:
	lda	_atan2f_PARM_1
	sta	___fslt_PARM_1
	lda	(_atan2f_PARM_1 + 1)
	sta	(___fslt_PARM_1 + 1)
	lda	(_atan2f_PARM_1 + 2)
	sta	(___fslt_PARM_1 + 2)
	lda	(_atan2f_PARM_1 + 3)
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_atan2f_sloc1_1_0
	lda	*_atan2f_sloc1_1_0
	beq	00125$
	lda	#0x01
00125$:
	eor	#0x01
	tsta
	beq	00111$
00126$:
	clr	*_atan2f_sloc1_1_0
	clr	*(_atan2f_sloc1_1_0 + 1)
	clr	*(_atan2f_sloc1_1_0 + 2)
	mov	#0xDB,*(_atan2f_sloc1_1_0 + 3)
	bra	00112$
00111$:
	mov	#0xC0,*_atan2f_sloc1_1_0
	mov	#0x49,*(_atan2f_sloc1_1_0 + 1)
	mov	#0x0F,*(_atan2f_sloc1_1_0 + 2)
	mov	#0xDB,*(_atan2f_sloc1_1_0 + 3)
00112$:
	lda	_atan2f_r_1_1
	sta	___fsadd_PARM_1
	lda	(_atan2f_r_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_atan2f_r_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_atan2f_r_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	lda	*_atan2f_sloc1_1_0
	sta	___fsadd_PARM_2
	lda	*(_atan2f_sloc1_1_0 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	*(_atan2f_sloc1_1_0 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	*(_atan2f_sloc1_1_0 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(_atan2f_r_1_1 + 3)
	stx	(_atan2f_r_1_1 + 2)
	lda	*__ret2
	sta	(_atan2f_r_1_1 + 1)
	lda	*__ret3
	sta	_atan2f_r_1_1
	jmp	00108$
00107$:
;../atan2f.c:51: r=-atanf(y/x);
	lda	_atan2f_PARM_2
	sta	___fsdiv_PARM_1
	lda	(_atan2f_PARM_2 + 1)
	sta	(___fsdiv_PARM_1 + 1)
	lda	(_atan2f_PARM_2 + 2)
	sta	(___fsdiv_PARM_1 + 2)
	lda	(_atan2f_PARM_2 + 3)
	sta	(___fsdiv_PARM_1 + 3)
	lda	_atan2f_PARM_1
	sta	___fsdiv_PARM_2
	lda	(_atan2f_PARM_1 + 1)
	sta	(___fsdiv_PARM_2 + 1)
	lda	(_atan2f_PARM_1 + 2)
	sta	(___fsdiv_PARM_2 + 2)
	lda	(_atan2f_PARM_1 + 3)
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	*(_atan2f_sloc1_1_0 + 3)
	stx	*(_atan2f_sloc1_1_0 + 2)
	mov	*__ret2,*(_atan2f_sloc1_1_0 + 1)
	mov	*__ret3,*_atan2f_sloc1_1_0
	lda	*(_atan2f_sloc1_1_0 + 3)
	psha
	lda	*(_atan2f_sloc1_1_0 + 2)
	psha
	lda	*(_atan2f_sloc1_1_0 + 1)
	psha
	lda	*_atan2f_sloc1_1_0
	psha
	jsr	_atanf
	sta	*(_atan2f_sloc1_1_0 + 3)
	stx	*(_atan2f_sloc1_1_0 + 2)
	mov	*__ret2,*(_atan2f_sloc1_1_0 + 1)
	mov	*__ret3,*_atan2f_sloc1_1_0
	ais	#4
	lda	*(_atan2f_sloc1_1_0 + 3)
	sta	(_atan2f_r_1_1 + 3)
	lda	*(_atan2f_sloc1_1_0 + 2)
	sta	(_atan2f_r_1_1 + 2)
	lda	*(_atan2f_sloc1_1_0 + 1)
	sta	(_atan2f_r_1_1 + 1)
	lda	*_atan2f_sloc1_1_0
	eor	#0x80
	sta	_atan2f_r_1_1
;../atan2f.c:52: r+=(x<0.0?-HALF_PI:HALF_PI);
	lda	_atan2f_PARM_1
	sta	___fslt_PARM_1
	lda	(_atan2f_PARM_1 + 1)
	sta	(___fslt_PARM_1 + 1)
	lda	(_atan2f_PARM_1 + 2)
	sta	(___fslt_PARM_1 + 2)
	lda	(_atan2f_PARM_1 + 3)
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_atan2f_sloc1_1_0
	tst	*_atan2f_sloc1_1_0
	beq	00113$
00127$:
	mov	#0xBF,*_atan2f_sloc1_1_0
	mov	#0xC9,*(_atan2f_sloc1_1_0 + 1)
	mov	#0x0F,*(_atan2f_sloc1_1_0 + 2)
	mov	#0xDB,*(_atan2f_sloc1_1_0 + 3)
	bra	00114$
00113$:
	clr	*_atan2f_sloc1_1_0
	clr	*(_atan2f_sloc1_1_0 + 1)
	clr	*(_atan2f_sloc1_1_0 + 2)
	mov	#0xDB,*(_atan2f_sloc1_1_0 + 3)
00114$:
	lda	_atan2f_r_1_1
	sta	___fsadd_PARM_1
	lda	(_atan2f_r_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_atan2f_r_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_atan2f_r_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	lda	*_atan2f_sloc1_1_0
	sta	___fsadd_PARM_2
	lda	*(_atan2f_sloc1_1_0 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	*(_atan2f_sloc1_1_0 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	*(_atan2f_sloc1_1_0 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(_atan2f_r_1_1 + 3)
	stx	(_atan2f_r_1_1 + 2)
	lda	*__ret2
	sta	(_atan2f_r_1_1 + 1)
	lda	*__ret3
	sta	_atan2f_r_1_1
00108$:
;../atan2f.c:54: return r;
	lda	_atan2f_r_1_1
	sta	*__ret3
	lda	(_atan2f_r_1_1 + 1)
	sta	*__ret2
	ldx	(_atan2f_r_1_1 + 2)
	lda	(_atan2f_r_1_1 + 3)
00109$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
