;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module tancotf
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
	.globl _tancotf
	.globl _tancotf_PARM_2
	.globl _tancotf_PARM_1
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_tancotf_sloc0_1_0:
	.ds 1
_tancotf_sloc1_1_0:
	.ds 4
_tancotf_sloc2_1_0:
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
_tancotf_PARM_1:
	.ds 4
_tancotf_PARM_2:
	.ds 1
_tancotf_f_1_1:
	.ds 4
_tancotf_g_1_1:
	.ds 4
_tancotf_xn_1_1:
	.ds 4
_tancotf_xnum_1_1:
	.ds 4
_tancotf_xden_1_1:
	.ds 4
_tancotf_n_1_1:
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
;Allocation info for local variables in function 'tancotf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_tancotf_sloc0_1_0'
;sloc1                     Allocated with name '_tancotf_sloc1_1_0'
;sloc2                     Allocated with name '_tancotf_sloc2_1_0'
;x                         Allocated with name '_tancotf_PARM_1'
;iscotan                   Allocated with name '_tancotf_PARM_2'
;f                         Allocated with name '_tancotf_f_1_1'
;g                         Allocated with name '_tancotf_g_1_1'
;xn                        Allocated with name '_tancotf_xn_1_1'
;xnum                      Allocated with name '_tancotf_xnum_1_1'
;xden                      Allocated with name '_tancotf_xden_1_1'
;n                         Allocated with name '_tancotf_n_1_1'
;------------------------------------------------------------
;../tancotf.c:53: float tancotf(const float x, const BOOL iscotan)
;	-----------------------------------------
;	 function tancotf
;	-----------------------------------------
_tancotf:
;../tancotf.c:58: if (fabsf(x) > YMAX)
	lda	(_tancotf_PARM_1 + 3)
	psha
	lda	(_tancotf_PARM_1 + 2)
	psha
	lda	(_tancotf_PARM_1 + 1)
	psha
	lda	_tancotf_PARM_1
	psha
	jsr	_fabsf
	sta	(___fsgt_PARM_1 + 3)
	stx	(___fsgt_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsgt_PARM_1 + 1)
	lda	*__ret3
	sta	___fsgt_PARM_1
	ais	#4
	lda	#0x45
	sta	___fsgt_PARM_2
	lda	#0xC9
	sta	(___fsgt_PARM_2 + 1)
	lda	#0x08
	sta	(___fsgt_PARM_2 + 2)
	clra
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_tancotf_sloc0_1_0
	tst	*_tancotf_sloc0_1_0
	beq	00102$
00125$:
;../tancotf.c:60: errno = ERANGE;
	clra
	sta	_errno
	lda	#0x22
	sta	(_errno + 1)
;../tancotf.c:61: return 0.0;
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	rts
00102$:
;../tancotf.c:65: n=(x*TWO_O_PI+(x>0.0?0.5:-0.5)); /*works for +-x*/
	lda	#0x3F
	sta	___fsmul_PARM_1
	lda	#0x22
	sta	(___fsmul_PARM_1 + 1)
	lda	#0xF9
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x83
	sta	(___fsmul_PARM_1 + 3)
	lda	_tancotf_PARM_1
	sta	___fsmul_PARM_2
	lda	(_tancotf_PARM_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_tancotf_PARM_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_tancotf_PARM_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	*(_tancotf_sloc1_1_0 + 3)
	stx	*(_tancotf_sloc1_1_0 + 2)
	mov	*__ret2,*(_tancotf_sloc1_1_0 + 1)
	mov	*__ret3,*_tancotf_sloc1_1_0
	lda	_tancotf_PARM_1
	sta	___fsgt_PARM_1
	lda	(_tancotf_PARM_1 + 1)
	sta	(___fsgt_PARM_1 + 1)
	lda	(_tancotf_PARM_1 + 2)
	sta	(___fsgt_PARM_1 + 2)
	lda	(_tancotf_PARM_1 + 3)
	sta	(___fsgt_PARM_1 + 3)
	clra
	sta	___fsgt_PARM_2
	sta	(___fsgt_PARM_2 + 1)
	sta	(___fsgt_PARM_2 + 2)
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_tancotf_sloc0_1_0
	tst	*_tancotf_sloc0_1_0
	beq	00117$
00126$:
	clr	*_tancotf_sloc2_1_0
	clr	*(_tancotf_sloc2_1_0 + 1)
	clr	*(_tancotf_sloc2_1_0 + 2)
	clr	*(_tancotf_sloc2_1_0 + 3)
	bra	00118$
00117$:
	clr	*_tancotf_sloc2_1_0
	clr	*(_tancotf_sloc2_1_0 + 1)
	clr	*(_tancotf_sloc2_1_0 + 2)
	clr	*(_tancotf_sloc2_1_0 + 3)
00118$:
	lda	*_tancotf_sloc1_1_0
	sta	___fsadd_PARM_1
	lda	*(_tancotf_sloc1_1_0 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	*(_tancotf_sloc1_1_0 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	*(_tancotf_sloc1_1_0 + 3)
	sta	(___fsadd_PARM_1 + 3)
	lda	*_tancotf_sloc2_1_0
	sta	___fsadd_PARM_2
	lda	*(_tancotf_sloc2_1_0 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	*(_tancotf_sloc2_1_0 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	*(_tancotf_sloc2_1_0 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fs2sint_PARM_1 + 3)
	stx	(___fs2sint_PARM_1 + 2)
	lda	*__ret2
	sta	(___fs2sint_PARM_1 + 1)
	lda	*__ret3
	sta	___fs2sint_PARM_1
	jsr	___fs2sint
	sta	(_tancotf_n_1_1 + 1)
	stx	_tancotf_n_1_1
;../tancotf.c:66: xn=n;
	ldx	_tancotf_n_1_1
	lda	(_tancotf_n_1_1 + 1)
	jsr	___sint2fs
	sta	(_tancotf_xn_1_1 + 3)
	stx	(_tancotf_xn_1_1 + 2)
	lda	*__ret2
	sta	(_tancotf_xn_1_1 + 1)
	lda	*__ret3
	sta	_tancotf_xn_1_1
;../tancotf.c:68: xnum=(int)x;
	lda	_tancotf_PARM_1
	sta	___fs2sint_PARM_1
	lda	(_tancotf_PARM_1 + 1)
	sta	(___fs2sint_PARM_1 + 1)
	lda	(_tancotf_PARM_1 + 2)
	sta	(___fs2sint_PARM_1 + 2)
	lda	(_tancotf_PARM_1 + 3)
	sta	(___fs2sint_PARM_1 + 3)
	jsr	___fs2sint
	jsr	___sint2fs
	sta	(_tancotf_xnum_1_1 + 3)
	stx	(_tancotf_xnum_1_1 + 2)
	lda	*__ret2
	sta	(_tancotf_xnum_1_1 + 1)
	lda	*__ret3
	sta	_tancotf_xnum_1_1
;../tancotf.c:69: xden=x-xnum;
	lda	_tancotf_PARM_1
	sta	___fssub_PARM_1
	lda	(_tancotf_PARM_1 + 1)
	sta	(___fssub_PARM_1 + 1)
	lda	(_tancotf_PARM_1 + 2)
	sta	(___fssub_PARM_1 + 2)
	lda	(_tancotf_PARM_1 + 3)
	sta	(___fssub_PARM_1 + 3)
	lda	_tancotf_xnum_1_1
	sta	___fssub_PARM_2
	lda	(_tancotf_xnum_1_1 + 1)
	sta	(___fssub_PARM_2 + 1)
	lda	(_tancotf_xnum_1_1 + 2)
	sta	(___fssub_PARM_2 + 2)
	lda	(_tancotf_xnum_1_1 + 3)
	sta	(___fssub_PARM_2 + 3)
	jsr	___fssub
	sta	(_tancotf_xden_1_1 + 3)
	stx	(_tancotf_xden_1_1 + 2)
	lda	*__ret2
	sta	(_tancotf_xden_1_1 + 1)
	lda	*__ret3
	sta	_tancotf_xden_1_1
;../tancotf.c:70: f=((xnum-xn*C1)+xden)-xn*C2;
	lda	#0x3F
	sta	___fsmul_PARM_1
	lda	#0xC9
	sta	(___fsmul_PARM_1 + 1)
	clra
	sta	(___fsmul_PARM_1 + 2)
	sta	(___fsmul_PARM_1 + 3)
	lda	_tancotf_xn_1_1
	sta	___fsmul_PARM_2
	lda	(_tancotf_xn_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_tancotf_xn_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_tancotf_xn_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fssub_PARM_2 + 3)
	stx	(___fssub_PARM_2 + 2)
	lda	*__ret2
	sta	(___fssub_PARM_2 + 1)
	lda	*__ret3
	sta	___fssub_PARM_2
	lda	_tancotf_xnum_1_1
	sta	___fssub_PARM_1
	lda	(_tancotf_xnum_1_1 + 1)
	sta	(___fssub_PARM_1 + 1)
	lda	(_tancotf_xnum_1_1 + 2)
	sta	(___fssub_PARM_1 + 2)
	lda	(_tancotf_xnum_1_1 + 3)
	sta	(___fssub_PARM_1 + 3)
	jsr	___fssub
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	_tancotf_xden_1_1
	sta	___fsadd_PARM_2
	lda	(_tancotf_xden_1_1 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	(_tancotf_xden_1_1 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	(_tancotf_xden_1_1 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fssub_PARM_1 + 3)
	stx	(___fssub_PARM_1 + 2)
	lda	*__ret2
	sta	(___fssub_PARM_1 + 1)
	lda	*__ret3
	sta	___fssub_PARM_1
	lda	#0x39
	sta	___fsmul_PARM_1
	lda	#0xFD
	sta	(___fsmul_PARM_1 + 1)
	lda	#0xAA
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x22
	sta	(___fsmul_PARM_1 + 3)
	lda	_tancotf_xn_1_1
	sta	___fsmul_PARM_2
	lda	(_tancotf_xn_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_tancotf_xn_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_tancotf_xn_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fssub_PARM_2 + 3)
	stx	(___fssub_PARM_2 + 2)
	lda	*__ret2
	sta	(___fssub_PARM_2 + 1)
	lda	*__ret3
	sta	___fssub_PARM_2
	jsr	___fssub
	sta	(_tancotf_f_1_1 + 3)
	stx	(_tancotf_f_1_1 + 2)
	lda	*__ret2
	sta	(_tancotf_f_1_1 + 1)
	lda	*__ret3
	sta	_tancotf_f_1_1
;../tancotf.c:72: if (fabsf(f) < EPS)
	lda	(_tancotf_f_1_1 + 3)
	psha
	lda	(_tancotf_f_1_1 + 2)
	psha
	lda	(_tancotf_f_1_1 + 1)
	psha
	lda	_tancotf_f_1_1
	psha
	jsr	_fabsf
	sta	(___fslt_PARM_1 + 3)
	stx	(___fslt_PARM_1 + 2)
	lda	*__ret2
	sta	(___fslt_PARM_1 + 1)
	lda	*__ret3
	sta	___fslt_PARM_1
	ais	#4
	lda	#0x39
	sta	___fslt_PARM_2
	lda	#0x80
	sta	(___fslt_PARM_2 + 1)
	clra
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_tancotf_sloc2_1_0
	tst	*_tancotf_sloc2_1_0
	beq	00104$
00127$:
;../tancotf.c:74: xnum = f;
	lda	_tancotf_f_1_1
	sta	_tancotf_xnum_1_1
	lda	(_tancotf_f_1_1 + 1)
	sta	(_tancotf_xnum_1_1 + 1)
	lda	(_tancotf_f_1_1 + 2)
	sta	(_tancotf_xnum_1_1 + 2)
	lda	(_tancotf_f_1_1 + 3)
	sta	(_tancotf_xnum_1_1 + 3)
;../tancotf.c:75: xden = 1.0;
	lda	#0x3F
	sta	_tancotf_xden_1_1
	lda	#0x80
	sta	(_tancotf_xden_1_1 + 1)
	clra
	sta	(_tancotf_xden_1_1 + 2)
	sta	(_tancotf_xden_1_1 + 3)
	jmp	00105$
00104$:
;../tancotf.c:79: g = f*f;
	lda	_tancotf_f_1_1
	sta	___fsmul_PARM_1
	lda	(_tancotf_f_1_1 + 1)
	sta	(___fsmul_PARM_1 + 1)
	lda	(_tancotf_f_1_1 + 2)
	sta	(___fsmul_PARM_1 + 2)
	lda	(_tancotf_f_1_1 + 3)
	sta	(___fsmul_PARM_1 + 3)
	lda	_tancotf_f_1_1
	sta	___fsmul_PARM_2
	lda	(_tancotf_f_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_tancotf_f_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_tancotf_f_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(_tancotf_g_1_1 + 3)
	stx	(_tancotf_g_1_1 + 2)
	lda	*__ret2
	sta	(_tancotf_g_1_1 + 1)
	lda	*__ret3
	sta	_tancotf_g_1_1
;../tancotf.c:80: xnum = P(f,g);
	lda	#0xBD
	sta	___fsmul_PARM_1
	lda	#0xC4
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x33
	sta	(___fsmul_PARM_1 + 2)
	lda	#0xB8
	sta	(___fsmul_PARM_1 + 3)
	lda	_tancotf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_tancotf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_tancotf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_tancotf_g_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	_tancotf_f_1_1
	sta	___fsmul_PARM_2
	lda	(_tancotf_f_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_tancotf_f_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_tancotf_f_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	_tancotf_f_1_1
	sta	___fsadd_PARM_2
	lda	(_tancotf_f_1_1 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	(_tancotf_f_1_1 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	(_tancotf_f_1_1 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(_tancotf_xnum_1_1 + 3)
	stx	(_tancotf_xnum_1_1 + 2)
	lda	*__ret2
	sta	(_tancotf_xnum_1_1 + 1)
	lda	*__ret3
	sta	_tancotf_xnum_1_1
;../tancotf.c:81: xden = Q(g);
	lda	#0x3C
	sta	___fsmul_PARM_1
	lda	#0x1F
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x33
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x75
	sta	(___fsmul_PARM_1 + 3)
	lda	_tancotf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_tancotf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_tancotf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_tancotf_g_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0xBE
	sta	___fsadd_PARM_2
	lda	#0xDB
	sta	(___fsadd_PARM_2 + 1)
	lda	#0xB7
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xAF
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	_tancotf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_tancotf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_tancotf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_tancotf_g_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0x3F
	sta	___fsadd_PARM_2
	lda	#0x80
	sta	(___fsadd_PARM_2 + 1)
	clra
	sta	(___fsadd_PARM_2 + 2)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(_tancotf_xden_1_1 + 3)
	stx	(_tancotf_xden_1_1 + 2)
	lda	*__ret2
	sta	(_tancotf_xden_1_1 + 1)
	lda	*__ret3
	sta	_tancotf_xden_1_1
00105$:
;../tancotf.c:84: if(n&1)
	lda	(_tancotf_n_1_1 + 1)
	and	#0x01
	bne	00128$
00128$:
	bne	00129$
	jmp	00113$
00129$:
;../tancotf.c:87: if(iscotan) return (-xnum/xden);
	lda	_tancotf_PARM_2
	beq	00107$
00130$:
	lda	(_tancotf_xnum_1_1 + 3)
	sta	(___fsdiv_PARM_1 + 3)
	lda	(_tancotf_xnum_1_1 + 2)
	sta	(___fsdiv_PARM_1 + 2)
	lda	(_tancotf_xnum_1_1 + 1)
	sta	(___fsdiv_PARM_1 + 1)
	lda	_tancotf_xnum_1_1
	eor	#0x80
	sta	___fsdiv_PARM_1
	lda	_tancotf_xden_1_1
	sta	___fsdiv_PARM_2
	lda	(_tancotf_xden_1_1 + 1)
	sta	(___fsdiv_PARM_2 + 1)
	lda	(_tancotf_xden_1_1 + 2)
	sta	(___fsdiv_PARM_2 + 2)
	lda	(_tancotf_xden_1_1 + 3)
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	*(_tancotf_sloc2_1_0 + 3)
	stx	*(_tancotf_sloc2_1_0 + 2)
	mov	*__ret2,*(_tancotf_sloc2_1_0 + 1)
	mov	*__ret3,*_tancotf_sloc2_1_0
	mov	*_tancotf_sloc2_1_0,*__ret3
	mov	*(_tancotf_sloc2_1_0 + 1),*__ret2
	ldx	*(_tancotf_sloc2_1_0 + 2)
	lda	*(_tancotf_sloc2_1_0 + 3)
	rts
00107$:
;../tancotf.c:88: else return (-xden/xnum);
	lda	(_tancotf_xden_1_1 + 3)
	sta	(___fsdiv_PARM_1 + 3)
	lda	(_tancotf_xden_1_1 + 2)
	sta	(___fsdiv_PARM_1 + 2)
	lda	(_tancotf_xden_1_1 + 1)
	sta	(___fsdiv_PARM_1 + 1)
	lda	_tancotf_xden_1_1
	eor	#0x80
	sta	___fsdiv_PARM_1
	lda	_tancotf_xnum_1_1
	sta	___fsdiv_PARM_2
	lda	(_tancotf_xnum_1_1 + 1)
	sta	(___fsdiv_PARM_2 + 1)
	lda	(_tancotf_xnum_1_1 + 2)
	sta	(___fsdiv_PARM_2 + 2)
	lda	(_tancotf_xnum_1_1 + 3)
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	*(_tancotf_sloc2_1_0 + 3)
	stx	*(_tancotf_sloc2_1_0 + 2)
	mov	*__ret2,*(_tancotf_sloc2_1_0 + 1)
	mov	*__ret3,*_tancotf_sloc2_1_0
	mov	*_tancotf_sloc2_1_0,*__ret3
	mov	*(_tancotf_sloc2_1_0 + 1),*__ret2
	ldx	*(_tancotf_sloc2_1_0 + 2)
	lda	*(_tancotf_sloc2_1_0 + 3)
	rts
00113$:
;../tancotf.c:92: if(iscotan) return (xden/xnum);
	lda	_tancotf_PARM_2
	beq	00110$
00131$:
	lda	_tancotf_xden_1_1
	sta	___fsdiv_PARM_1
	lda	(_tancotf_xden_1_1 + 1)
	sta	(___fsdiv_PARM_1 + 1)
	lda	(_tancotf_xden_1_1 + 2)
	sta	(___fsdiv_PARM_1 + 2)
	lda	(_tancotf_xden_1_1 + 3)
	sta	(___fsdiv_PARM_1 + 3)
	lda	_tancotf_xnum_1_1
	sta	___fsdiv_PARM_2
	lda	(_tancotf_xnum_1_1 + 1)
	sta	(___fsdiv_PARM_2 + 1)
	lda	(_tancotf_xnum_1_1 + 2)
	sta	(___fsdiv_PARM_2 + 2)
	lda	(_tancotf_xnum_1_1 + 3)
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	*(_tancotf_sloc2_1_0 + 3)
	stx	*(_tancotf_sloc2_1_0 + 2)
	mov	*__ret2,*(_tancotf_sloc2_1_0 + 1)
	mov	*__ret3,*_tancotf_sloc2_1_0
	mov	*_tancotf_sloc2_1_0,*__ret3
	mov	*(_tancotf_sloc2_1_0 + 1),*__ret2
	ldx	*(_tancotf_sloc2_1_0 + 2)
	lda	*(_tancotf_sloc2_1_0 + 3)
	rts
00110$:
;../tancotf.c:93: else return (xnum/xden);
	lda	_tancotf_xnum_1_1
	sta	___fsdiv_PARM_1
	lda	(_tancotf_xnum_1_1 + 1)
	sta	(___fsdiv_PARM_1 + 1)
	lda	(_tancotf_xnum_1_1 + 2)
	sta	(___fsdiv_PARM_1 + 2)
	lda	(_tancotf_xnum_1_1 + 3)
	sta	(___fsdiv_PARM_1 + 3)
	lda	_tancotf_xden_1_1
	sta	___fsdiv_PARM_2
	lda	(_tancotf_xden_1_1 + 1)
	sta	(___fsdiv_PARM_2 + 1)
	lda	(_tancotf_xden_1_1 + 2)
	sta	(___fsdiv_PARM_2 + 2)
	lda	(_tancotf_xden_1_1 + 3)
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	*(_tancotf_sloc2_1_0 + 3)
	stx	*(_tancotf_sloc2_1_0 + 2)
	mov	*__ret2,*(_tancotf_sloc2_1_0 + 1)
	mov	*__ret3,*_tancotf_sloc2_1_0
	mov	*_tancotf_sloc2_1_0,*__ret3
	mov	*(_tancotf_sloc2_1_0 + 1),*__ret2
	ldx	*(_tancotf_sloc2_1_0 + 2)
	lda	*(_tancotf_sloc2_1_0 + 3)
00115$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
