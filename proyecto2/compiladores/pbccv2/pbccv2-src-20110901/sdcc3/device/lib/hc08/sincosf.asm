;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module sincosf
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
	.globl _sincosf
	.globl _sincosf_PARM_2
	.globl _sincosf_PARM_1
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_sincosf_sloc0_1_0:
	.ds 1
_sincosf_sloc1_1_0:
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
_sincosf_PARM_1:
	.ds 4
_sincosf_PARM_2:
	.ds 1
_sincosf_y_1_1:
	.ds 4
_sincosf_f_1_1:
	.ds 4
_sincosf_r_1_1:
	.ds 4
_sincosf_g_1_1:
	.ds 4
_sincosf_XN_1_1:
	.ds 4
_sincosf_N_1_1:
	.ds 2
_sincosf_sign_1_1:
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
;Allocation info for local variables in function 'sincosf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_sincosf_sloc0_1_0'
;sloc1                     Allocated with name '_sincosf_sloc1_1_0'
;x                         Allocated with name '_sincosf_PARM_1'
;iscos                     Allocated with name '_sincosf_PARM_2'
;y                         Allocated with name '_sincosf_y_1_1'
;f                         Allocated with name '_sincosf_f_1_1'
;r                         Allocated with name '_sincosf_r_1_1'
;g                         Allocated with name '_sincosf_g_1_1'
;XN                        Allocated with name '_sincosf_XN_1_1'
;N                         Allocated with name '_sincosf_N_1_1'
;sign                      Allocated with name '_sincosf_sign_1_1'
;------------------------------------------------------------
;../sincosf.c:50: float sincosf(const float x, const BOOL iscos)
;	-----------------------------------------
;	 function sincosf
;	-----------------------------------------
_sincosf:
;../sincosf.c:56: if(iscos)
	lda	_sincosf_PARM_2
	beq	00105$
00126$:
;../sincosf.c:58: y=fabsf(x)+HALF_PI;
	lda	(_sincosf_PARM_1 + 3)
	psha
	lda	(_sincosf_PARM_1 + 2)
	psha
	lda	(_sincosf_PARM_1 + 1)
	psha
	lda	_sincosf_PARM_1
	psha
	jsr	_fabsf
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	ais	#4
	lda	#0x3F
	sta	___fsadd_PARM_2
	lda	#0xC9
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x0F
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xDB
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(_sincosf_y_1_1 + 3)
	stx	(_sincosf_y_1_1 + 2)
	lda	*__ret2
	sta	(_sincosf_y_1_1 + 1)
	lda	*__ret3
	sta	_sincosf_y_1_1
;../sincosf.c:59: sign=0;
	clra
	sta	_sincosf_sign_1_1
	jmp	00106$
00105$:
;../sincosf.c:63: if(x<0.0)
	lda	_sincosf_PARM_1
	sta	___fslt_PARM_1
	lda	(_sincosf_PARM_1 + 1)
	sta	(___fslt_PARM_1 + 1)
	lda	(_sincosf_PARM_1 + 2)
	sta	(___fslt_PARM_1 + 2)
	lda	(_sincosf_PARM_1 + 3)
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_sincosf_sloc0_1_0
	tst	*_sincosf_sloc0_1_0
	beq	00102$
00127$:
;../sincosf.c:64: { y=-x; sign=1; }
	lda	(_sincosf_PARM_1 + 3)
	sta	(_sincosf_y_1_1 + 3)
	lda	(_sincosf_PARM_1 + 2)
	sta	(_sincosf_y_1_1 + 2)
	lda	(_sincosf_PARM_1 + 1)
	sta	(_sincosf_y_1_1 + 1)
	lda	_sincosf_PARM_1
	eor	#0x80
	sta	_sincosf_y_1_1
	lda	#0x01
	sta	_sincosf_sign_1_1
	bra	00106$
00102$:
;../sincosf.c:66: { y=x; sign=0; }
	lda	_sincosf_PARM_1
	sta	_sincosf_y_1_1
	lda	(_sincosf_PARM_1 + 1)
	sta	(_sincosf_y_1_1 + 1)
	lda	(_sincosf_PARM_1 + 2)
	sta	(_sincosf_y_1_1 + 2)
	lda	(_sincosf_PARM_1 + 3)
	sta	(_sincosf_y_1_1 + 3)
	clra
	sta	_sincosf_sign_1_1
00106$:
;../sincosf.c:69: if(y>YMAX)
	lda	_sincosf_y_1_1
	sta	___fsgt_PARM_1
	lda	(_sincosf_y_1_1 + 1)
	sta	(___fsgt_PARM_1 + 1)
	lda	(_sincosf_y_1_1 + 2)
	sta	(___fsgt_PARM_1 + 2)
	lda	(_sincosf_y_1_1 + 3)
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x46
	sta	___fsgt_PARM_2
	lda	#0x49
	sta	(___fsgt_PARM_2 + 1)
	lda	#0x0C
	sta	(___fsgt_PARM_2 + 2)
	clra
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_sincosf_sloc0_1_0
	tst	*_sincosf_sloc0_1_0
	beq	00108$
00128$:
;../sincosf.c:71: errno=ERANGE;
	clra
	sta	_errno
	lda	#0x22
	sta	(_errno + 1)
;../sincosf.c:72: return 0.0;
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	rts
00108$:
;../sincosf.c:76: N=((y*iPI)+0.5); /*y is positive*/
	lda	#0x3E
	sta	___fsmul_PARM_1
	lda	#0xA2
	sta	(___fsmul_PARM_1 + 1)
	lda	#0xF9
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x83
	sta	(___fsmul_PARM_1 + 3)
	lda	_sincosf_y_1_1
	sta	___fsmul_PARM_2
	lda	(_sincosf_y_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincosf_y_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincosf_y_1_1 + 3)
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
	clra
	sta	(___fsadd_PARM_2 + 1)
	sta	(___fsadd_PARM_2 + 2)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fs2sint_PARM_1 + 3)
	stx	(___fs2sint_PARM_1 + 2)
	lda	*__ret2
	sta	(___fs2sint_PARM_1 + 1)
	lda	*__ret3
	sta	___fs2sint_PARM_1
	jsr	___fs2sint
	sta	(_sincosf_N_1_1 + 1)
	stx	_sincosf_N_1_1
;../sincosf.c:79: if(N&1) sign=!sign;
	lda	(_sincosf_N_1_1 + 1)
	and	#0x01
	bne	00129$
00129$:
	beq	00110$
00130$:
	lda	_sincosf_sign_1_1
	beq	00131$
	lda	#0x01
00131$:
	eor	#0x01
	sta	_sincosf_sign_1_1
00110$:
;../sincosf.c:81: XN=N;
	ldx	_sincosf_N_1_1
	lda	(_sincosf_N_1_1 + 1)
	jsr	___sint2fs
	sta	(_sincosf_XN_1_1 + 3)
	stx	(_sincosf_XN_1_1 + 2)
	lda	*__ret2
	sta	(_sincosf_XN_1_1 + 1)
	lda	*__ret3
	sta	_sincosf_XN_1_1
;../sincosf.c:83: if(iscos) XN-=0.5;
	lda	_sincosf_PARM_2
	beq	00112$
00132$:
	lda	_sincosf_XN_1_1
	sta	___fssub_PARM_1
	lda	(_sincosf_XN_1_1 + 1)
	sta	(___fssub_PARM_1 + 1)
	lda	(_sincosf_XN_1_1 + 2)
	sta	(___fssub_PARM_1 + 2)
	lda	(_sincosf_XN_1_1 + 3)
	sta	(___fssub_PARM_1 + 3)
	lda	#0x3F
	sta	___fssub_PARM_2
	clra
	sta	(___fssub_PARM_2 + 1)
	sta	(___fssub_PARM_2 + 2)
	sta	(___fssub_PARM_2 + 3)
	jsr	___fssub
	sta	(_sincosf_XN_1_1 + 3)
	stx	(_sincosf_XN_1_1 + 2)
	lda	*__ret2
	sta	(_sincosf_XN_1_1 + 1)
	lda	*__ret3
	sta	_sincosf_XN_1_1
00112$:
;../sincosf.c:85: y=fabsf(x);
	lda	(_sincosf_PARM_1 + 3)
	psha
	lda	(_sincosf_PARM_1 + 2)
	psha
	lda	(_sincosf_PARM_1 + 1)
	psha
	lda	_sincosf_PARM_1
	psha
	jsr	_fabsf
	sta	(_sincosf_y_1_1 + 3)
	stx	(_sincosf_y_1_1 + 2)
	lda	*__ret2
	sta	(_sincosf_y_1_1 + 1)
	lda	*__ret3
	sta	_sincosf_y_1_1
	ais	#4
;../sincosf.c:86: r=(int)y;
	lda	_sincosf_y_1_1
	sta	___fs2sint_PARM_1
	lda	(_sincosf_y_1_1 + 1)
	sta	(___fs2sint_PARM_1 + 1)
	lda	(_sincosf_y_1_1 + 2)
	sta	(___fs2sint_PARM_1 + 2)
	lda	(_sincosf_y_1_1 + 3)
	sta	(___fs2sint_PARM_1 + 3)
	jsr	___fs2sint
	jsr	___sint2fs
	sta	(_sincosf_r_1_1 + 3)
	stx	(_sincosf_r_1_1 + 2)
	lda	*__ret2
	sta	(_sincosf_r_1_1 + 1)
	lda	*__ret3
	sta	_sincosf_r_1_1
;../sincosf.c:87: g=y-r;
	lda	_sincosf_y_1_1
	sta	___fssub_PARM_1
	lda	(_sincosf_y_1_1 + 1)
	sta	(___fssub_PARM_1 + 1)
	lda	(_sincosf_y_1_1 + 2)
	sta	(___fssub_PARM_1 + 2)
	lda	(_sincosf_y_1_1 + 3)
	sta	(___fssub_PARM_1 + 3)
	lda	_sincosf_r_1_1
	sta	___fssub_PARM_2
	lda	(_sincosf_r_1_1 + 1)
	sta	(___fssub_PARM_2 + 1)
	lda	(_sincosf_r_1_1 + 2)
	sta	(___fssub_PARM_2 + 2)
	lda	(_sincosf_r_1_1 + 3)
	sta	(___fssub_PARM_2 + 3)
	jsr	___fssub
	sta	(_sincosf_g_1_1 + 3)
	stx	(_sincosf_g_1_1 + 2)
	lda	*__ret2
	sta	(_sincosf_g_1_1 + 1)
	lda	*__ret3
	sta	_sincosf_g_1_1
;../sincosf.c:88: f=((r-XN*C1)+g)-XN*C2;
	lda	#0x40
	sta	___fsmul_PARM_1
	lda	#0x49
	sta	(___fsmul_PARM_1 + 1)
	clra
	sta	(___fsmul_PARM_1 + 2)
	sta	(___fsmul_PARM_1 + 3)
	lda	_sincosf_XN_1_1
	sta	___fsmul_PARM_2
	lda	(_sincosf_XN_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincosf_XN_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincosf_XN_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fssub_PARM_2 + 3)
	stx	(___fssub_PARM_2 + 2)
	lda	*__ret2
	sta	(___fssub_PARM_2 + 1)
	lda	*__ret3
	sta	___fssub_PARM_2
	lda	_sincosf_r_1_1
	sta	___fssub_PARM_1
	lda	(_sincosf_r_1_1 + 1)
	sta	(___fssub_PARM_1 + 1)
	lda	(_sincosf_r_1_1 + 2)
	sta	(___fssub_PARM_1 + 2)
	lda	(_sincosf_r_1_1 + 3)
	sta	(___fssub_PARM_1 + 3)
	jsr	___fssub
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	_sincosf_g_1_1
	sta	___fsadd_PARM_2
	lda	(_sincosf_g_1_1 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	(_sincosf_g_1_1 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	(_sincosf_g_1_1 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fssub_PARM_1 + 3)
	stx	(___fssub_PARM_1 + 2)
	lda	*__ret2
	sta	(___fssub_PARM_1 + 1)
	lda	*__ret3
	sta	___fssub_PARM_1
	lda	#0x3A
	sta	___fsmul_PARM_1
	lda	#0x7D
	sta	(___fsmul_PARM_1 + 1)
	lda	#0xAA
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x22
	sta	(___fsmul_PARM_1 + 3)
	lda	_sincosf_XN_1_1
	sta	___fsmul_PARM_2
	lda	(_sincosf_XN_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincosf_XN_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincosf_XN_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fssub_PARM_2 + 3)
	stx	(___fssub_PARM_2 + 2)
	lda	*__ret2
	sta	(___fssub_PARM_2 + 1)
	lda	*__ret3
	sta	___fssub_PARM_2
	jsr	___fssub
	sta	(_sincosf_f_1_1 + 3)
	stx	(_sincosf_f_1_1 + 2)
	lda	*__ret2
	sta	(_sincosf_f_1_1 + 1)
	lda	*__ret3
	sta	_sincosf_f_1_1
;../sincosf.c:90: g=f*f;
	lda	_sincosf_f_1_1
	sta	___fsmul_PARM_1
	lda	(_sincosf_f_1_1 + 1)
	sta	(___fsmul_PARM_1 + 1)
	lda	(_sincosf_f_1_1 + 2)
	sta	(___fsmul_PARM_1 + 2)
	lda	(_sincosf_f_1_1 + 3)
	sta	(___fsmul_PARM_1 + 3)
	lda	_sincosf_f_1_1
	sta	___fsmul_PARM_2
	lda	(_sincosf_f_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincosf_f_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincosf_f_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(_sincosf_g_1_1 + 3)
	stx	(_sincosf_g_1_1 + 2)
	lda	*__ret2
	sta	(_sincosf_g_1_1 + 1)
	lda	*__ret3
	sta	_sincosf_g_1_1
;../sincosf.c:91: if(g>EPS2) //Used to be if(fabsf(f)>EPS)
	lda	_sincosf_g_1_1
	sta	___fsgt_PARM_1
	lda	(_sincosf_g_1_1 + 1)
	sta	(___fsgt_PARM_1 + 1)
	lda	(_sincosf_g_1_1 + 2)
	sta	(___fsgt_PARM_1 + 2)
	lda	(_sincosf_g_1_1 + 3)
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x33
	sta	___fsgt_PARM_2
	lda	#0x7F
	sta	(___fsgt_PARM_2 + 1)
	lda	#0xFF
	sta	(___fsgt_PARM_2 + 2)
	lda	#0xF3
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_sincosf_sloc0_1_0
	tst	*_sincosf_sloc0_1_0
	bne	00133$
	jmp	00114$
00133$:
;../sincosf.c:93: r=(((r4*g+r3)*g+r2)*g+r1)*g;
	lda	#0x36
	sta	___fsmul_PARM_1
	lda	#0x2E
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x9C
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x5B
	sta	(___fsmul_PARM_1 + 3)
	lda	_sincosf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_sincosf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincosf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincosf_g_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0xB9
	sta	___fsadd_PARM_2
	lda	#0x4F
	sta	(___fsadd_PARM_2 + 1)
	lda	#0xB2
	sta	(___fsadd_PARM_2 + 2)
	lda	#0x22
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	_sincosf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_sincosf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincosf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincosf_g_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0x3C
	sta	___fsadd_PARM_2
	lda	#0x08
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x87
	sta	(___fsadd_PARM_2 + 2)
	lda	#0x3E
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	_sincosf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_sincosf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincosf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincosf_g_1_1 + 3)
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
	lda	#0x2A
	sta	(___fsadd_PARM_2 + 1)
	lda	#0xAA
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xA4
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	_sincosf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_sincosf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincosf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincosf_g_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsmul_PARM_2 + 3)
	stx	(___fsmul_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_2 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_2
;../sincosf.c:94: f+=f*r;
	lda	_sincosf_f_1_1
	sta	___fsmul_PARM_1
	lda	(_sincosf_f_1_1 + 1)
	sta	(___fsmul_PARM_1 + 1)
	lda	(_sincosf_f_1_1 + 2)
	sta	(___fsmul_PARM_1 + 2)
	lda	(_sincosf_f_1_1 + 3)
	sta	(___fsmul_PARM_1 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	lda	_sincosf_f_1_1
	sta	___fsadd_PARM_1
	lda	(_sincosf_f_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_sincosf_f_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_sincosf_f_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	(_sincosf_f_1_1 + 3)
	stx	(_sincosf_f_1_1 + 2)
	lda	*__ret2
	sta	(_sincosf_f_1_1 + 1)
	lda	*__ret3
	sta	_sincosf_f_1_1
00114$:
;../sincosf.c:96: return (sign?-f:f);
	lda	_sincosf_sign_1_1
	beq	00117$
00134$:
	lda	(_sincosf_f_1_1 + 3)
	sta	*(_sincosf_sloc1_1_0 + 3)
	lda	(_sincosf_f_1_1 + 2)
	sta	*(_sincosf_sloc1_1_0 + 2)
	lda	(_sincosf_f_1_1 + 1)
	sta	*(_sincosf_sloc1_1_0 + 1)
	lda	_sincosf_f_1_1
	eor	#0x80
	sta	*_sincosf_sloc1_1_0
	bra	00118$
00117$:
	lda	_sincosf_f_1_1
	sta	*_sincosf_sloc1_1_0
	lda	(_sincosf_f_1_1 + 1)
	sta	*(_sincosf_sloc1_1_0 + 1)
	lda	(_sincosf_f_1_1 + 2)
	sta	*(_sincosf_sloc1_1_0 + 2)
	lda	(_sincosf_f_1_1 + 3)
	sta	*(_sincosf_sloc1_1_0 + 3)
00118$:
	mov	*_sincosf_sloc1_1_0,*__ret3
	mov	*(_sincosf_sloc1_1_0 + 1),*__ret2
	ldx	*(_sincosf_sloc1_1_0 + 2)
	lda	*(_sincosf_sloc1_1_0 + 3)
00115$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
