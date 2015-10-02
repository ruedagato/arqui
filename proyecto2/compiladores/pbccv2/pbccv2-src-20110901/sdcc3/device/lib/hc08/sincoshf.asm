;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module sincoshf
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
	.globl _sincoshf
	.globl _sincoshf_PARM_2
	.globl _sincoshf_PARM_1
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_sincoshf_sloc0_1_0:
	.ds 1
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
_sincoshf_PARM_1:
	.ds 4
_sincoshf_PARM_2:
	.ds 2
_sincoshf_y_1_1:
	.ds 4
_sincoshf_w_1_1:
	.ds 4
_sincoshf_z_1_1:
	.ds 4
_sincoshf_sign_1_1:
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
;Allocation info for local variables in function 'sincoshf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_sincoshf_sloc0_1_0'
;x                         Allocated with name '_sincoshf_PARM_1'
;iscosh                    Allocated with name '_sincoshf_PARM_2'
;y                         Allocated with name '_sincoshf_y_1_1'
;w                         Allocated with name '_sincoshf_w_1_1'
;z                         Allocated with name '_sincoshf_z_1_1'
;sign                      Allocated with name '_sincoshf_sign_1_1'
;------------------------------------------------------------
;../sincoshf.c:53: float sincoshf(const float x, const int iscosh)
;	-----------------------------------------
;	 function sincoshf
;	-----------------------------------------
_sincoshf:
;../sincoshf.c:58: if (x<0.0) { y=-x; sign=1; }
	lda	_sincoshf_PARM_1
	sta	___fslt_PARM_1
	lda	(_sincoshf_PARM_1 + 1)
	sta	(___fslt_PARM_1 + 1)
	lda	(_sincoshf_PARM_1 + 2)
	sta	(___fslt_PARM_1 + 2)
	lda	(_sincoshf_PARM_1 + 3)
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_sincoshf_sloc0_1_0
	tst	*_sincoshf_sloc0_1_0
	beq	00102$
00130$:
	lda	(_sincoshf_PARM_1 + 3)
	sta	(_sincoshf_y_1_1 + 3)
	lda	(_sincoshf_PARM_1 + 2)
	sta	(_sincoshf_y_1_1 + 2)
	lda	(_sincoshf_PARM_1 + 1)
	sta	(_sincoshf_y_1_1 + 1)
	lda	_sincoshf_PARM_1
	eor	#0x80
	sta	_sincoshf_y_1_1
	lda	#0x01
	sta	_sincoshf_sign_1_1
	bra	00103$
00102$:
;../sincoshf.c:59: else { y=x;  sign=0; }
	lda	_sincoshf_PARM_1
	sta	_sincoshf_y_1_1
	lda	(_sincoshf_PARM_1 + 1)
	sta	(_sincoshf_y_1_1 + 1)
	lda	(_sincoshf_PARM_1 + 2)
	sta	(_sincoshf_y_1_1 + 2)
	lda	(_sincoshf_PARM_1 + 3)
	sta	(_sincoshf_y_1_1 + 3)
	clra
	sta	_sincoshf_sign_1_1
00103$:
;../sincoshf.c:61: if ((y>1.0) || iscosh)
	lda	_sincoshf_y_1_1
	sta	___fsgt_PARM_1
	lda	(_sincoshf_y_1_1 + 1)
	sta	(___fsgt_PARM_1 + 1)
	lda	(_sincoshf_y_1_1 + 2)
	sta	(___fsgt_PARM_1 + 2)
	lda	(_sincoshf_y_1_1 + 3)
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x3F
	sta	___fsgt_PARM_2
	lda	#0x80
	sta	(___fsgt_PARM_2 + 1)
	clra
	sta	(___fsgt_PARM_2 + 2)
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_sincoshf_sloc0_1_0
	tst	*_sincoshf_sloc0_1_0
	bne	00117$
00131$:
	lda	(_sincoshf_PARM_2 + 1)
	ora	_sincoshf_PARM_2
	bne	00132$
	jmp	00118$
00132$:
00117$:
;../sincoshf.c:63: if(y>YBAR)
	lda	_sincoshf_y_1_1
	sta	___fsgt_PARM_1
	lda	(_sincoshf_y_1_1 + 1)
	sta	(___fsgt_PARM_1 + 1)
	lda	(_sincoshf_y_1_1 + 2)
	sta	(___fsgt_PARM_1 + 2)
	lda	(_sincoshf_y_1_1 + 3)
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x41
	sta	___fsgt_PARM_2
	lda	#0x10
	sta	(___fsgt_PARM_2 + 1)
	clra
	sta	(___fsgt_PARM_2 + 2)
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_sincoshf_sloc0_1_0
	tst	*_sincoshf_sloc0_1_0
	bne	00133$
	jmp	00110$
00133$:
;../sincoshf.c:65: w=y-K1;
	lda	_sincoshf_y_1_1
	sta	___fssub_PARM_1
	lda	(_sincoshf_y_1_1 + 1)
	sta	(___fssub_PARM_1 + 1)
	lda	(_sincoshf_y_1_1 + 2)
	sta	(___fssub_PARM_1 + 2)
	lda	(_sincoshf_y_1_1 + 3)
	sta	(___fssub_PARM_1 + 3)
	lda	#0x3F
	sta	___fssub_PARM_2
	lda	#0x31
	sta	(___fssub_PARM_2 + 1)
	lda	#0x73
	sta	(___fssub_PARM_2 + 2)
	clra
	sta	(___fssub_PARM_2 + 3)
	jsr	___fssub
	sta	(_sincoshf_w_1_1 + 3)
	stx	(_sincoshf_w_1_1 + 2)
	lda	*__ret2
	sta	(_sincoshf_w_1_1 + 1)
	lda	*__ret3
	sta	_sincoshf_w_1_1
;../sincoshf.c:66: if (w>WMAX)
	lda	_sincoshf_w_1_1
	sta	___fsgt_PARM_1
	lda	(_sincoshf_w_1_1 + 1)
	sta	(___fsgt_PARM_1 + 1)
	lda	(_sincoshf_w_1_1 + 2)
	sta	(___fsgt_PARM_1 + 2)
	lda	(_sincoshf_w_1_1 + 3)
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x42
	sta	___fsgt_PARM_2
	lda	#0x33
	sta	(___fsgt_PARM_2 + 1)
	lda	#0xBD
	sta	(___fsgt_PARM_2 + 2)
	lda	#0xCF
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_sincoshf_sloc0_1_0
	tst	*_sincoshf_sloc0_1_0
	beq	00105$
00134$:
;../sincoshf.c:68: errno=ERANGE;
	clra
	sta	_errno
	lda	#0x22
	sta	(_errno + 1)
;../sincoshf.c:69: z=HUGE_VALF;
	lda	#0x7F
	sta	_sincoshf_z_1_1
	sta	(_sincoshf_z_1_1 + 1)
	lda	#0xFF
	sta	(_sincoshf_z_1_1 + 2)
	sta	(_sincoshf_z_1_1 + 3)
	jmp	00111$
00105$:
;../sincoshf.c:73: z=expf(w);
	lda	_sincoshf_w_1_1
	sta	_expf_PARM_1
	lda	(_sincoshf_w_1_1 + 1)
	sta	(_expf_PARM_1 + 1)
	lda	(_sincoshf_w_1_1 + 2)
	sta	(_expf_PARM_1 + 2)
	lda	(_sincoshf_w_1_1 + 3)
	sta	(_expf_PARM_1 + 3)
	jsr	_expf
	sta	(_sincoshf_z_1_1 + 3)
	stx	(_sincoshf_z_1_1 + 2)
	lda	*__ret2
	sta	(_sincoshf_z_1_1 + 1)
	lda	*__ret3
	sta	_sincoshf_z_1_1
;../sincoshf.c:74: z+=K3*z;
	lda	#0x37
	sta	___fsmul_PARM_1
	lda	#0x68
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x08
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x97
	sta	(___fsmul_PARM_1 + 3)
	lda	_sincoshf_z_1_1
	sta	___fsmul_PARM_2
	lda	(_sincoshf_z_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincoshf_z_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincoshf_z_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	lda	_sincoshf_z_1_1
	sta	___fsadd_PARM_1
	lda	(_sincoshf_z_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_sincoshf_z_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_sincoshf_z_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	(_sincoshf_z_1_1 + 3)
	stx	(_sincoshf_z_1_1 + 2)
	lda	*__ret2
	sta	(_sincoshf_z_1_1 + 1)
	lda	*__ret3
	sta	_sincoshf_z_1_1
	jmp	00111$
00110$:
;../sincoshf.c:79: z=expf(y);
	lda	_sincoshf_y_1_1
	sta	_expf_PARM_1
	lda	(_sincoshf_y_1_1 + 1)
	sta	(_expf_PARM_1 + 1)
	lda	(_sincoshf_y_1_1 + 2)
	sta	(_expf_PARM_1 + 2)
	lda	(_sincoshf_y_1_1 + 3)
	sta	(_expf_PARM_1 + 3)
	jsr	_expf
	sta	(_sincoshf_z_1_1 + 3)
	stx	(_sincoshf_z_1_1 + 2)
	lda	*__ret2
	sta	(_sincoshf_z_1_1 + 1)
	lda	*__ret3
	sta	_sincoshf_z_1_1
;../sincoshf.c:80: w=1.0/z;
	lda	#0x3F
	sta	___fsdiv_PARM_1
	lda	#0x80
	sta	(___fsdiv_PARM_1 + 1)
	clra
	sta	(___fsdiv_PARM_1 + 2)
	sta	(___fsdiv_PARM_1 + 3)
	lda	_sincoshf_z_1_1
	sta	___fsdiv_PARM_2
	lda	(_sincoshf_z_1_1 + 1)
	sta	(___fsdiv_PARM_2 + 1)
	lda	(_sincoshf_z_1_1 + 2)
	sta	(___fsdiv_PARM_2 + 2)
	lda	(_sincoshf_z_1_1 + 3)
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	(_sincoshf_w_1_1 + 3)
	stx	(_sincoshf_w_1_1 + 2)
	lda	*__ret2
	sta	(_sincoshf_w_1_1 + 1)
	lda	*__ret3
	sta	_sincoshf_w_1_1
;../sincoshf.c:81: if(!iscosh) w=-w;
	lda	(_sincoshf_PARM_2 + 1)
	ora	_sincoshf_PARM_2
	bne	00108$
00135$:
	lda	_sincoshf_w_1_1
	eor	#0x80
	sta	_sincoshf_w_1_1
00108$:
;../sincoshf.c:82: z=(z+w)*0.5;
	lda	_sincoshf_z_1_1
	sta	___fsadd_PARM_1
	lda	(_sincoshf_z_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_sincoshf_z_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_sincoshf_z_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	lda	_sincoshf_w_1_1
	sta	___fsadd_PARM_2
	lda	(_sincoshf_w_1_1 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	(_sincoshf_w_1_1 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	(_sincoshf_w_1_1 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_2 + 3)
	stx	(___fsmul_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_2 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_2
	lda	#0x3F
	sta	___fsmul_PARM_1
	clra
	sta	(___fsmul_PARM_1 + 1)
	sta	(___fsmul_PARM_1 + 2)
	sta	(___fsmul_PARM_1 + 3)
	jsr	___fsmul
	sta	(_sincoshf_z_1_1 + 3)
	stx	(_sincoshf_z_1_1 + 2)
	lda	*__ret2
	sta	(_sincoshf_z_1_1 + 1)
	lda	*__ret3
	sta	_sincoshf_z_1_1
00111$:
;../sincoshf.c:84: if(sign) z=-z;
	lda	_sincoshf_sign_1_1
	bne	00136$
	jmp	00119$
00136$:
	lda	_sincoshf_z_1_1
	eor	#0x80
	sta	_sincoshf_z_1_1
	jmp	00119$
00118$:
;../sincoshf.c:88: if (y<EPS)
	lda	_sincoshf_y_1_1
	sta	___fslt_PARM_1
	lda	(_sincoshf_y_1_1 + 1)
	sta	(___fslt_PARM_1 + 1)
	lda	(_sincoshf_y_1_1 + 2)
	sta	(___fslt_PARM_1 + 2)
	lda	(_sincoshf_y_1_1 + 3)
	sta	(___fslt_PARM_1 + 3)
	lda	#0x39
	sta	___fslt_PARM_2
	lda	#0x80
	sta	(___fslt_PARM_2 + 1)
	clra
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_sincoshf_sloc0_1_0
	tst	*_sincoshf_sloc0_1_0
	beq	00115$
00137$:
;../sincoshf.c:89: z=x;
	lda	_sincoshf_PARM_1
	sta	_sincoshf_z_1_1
	lda	(_sincoshf_PARM_1 + 1)
	sta	(_sincoshf_z_1_1 + 1)
	lda	(_sincoshf_PARM_1 + 2)
	sta	(_sincoshf_z_1_1 + 2)
	lda	(_sincoshf_PARM_1 + 3)
	sta	(_sincoshf_z_1_1 + 3)
	jmp	00119$
00115$:
;../sincoshf.c:92: z=x*x;
	lda	_sincoshf_PARM_1
	sta	___fsmul_PARM_1
	lda	(_sincoshf_PARM_1 + 1)
	sta	(___fsmul_PARM_1 + 1)
	lda	(_sincoshf_PARM_1 + 2)
	sta	(___fsmul_PARM_1 + 2)
	lda	(_sincoshf_PARM_1 + 3)
	sta	(___fsmul_PARM_1 + 3)
	lda	_sincoshf_PARM_1
	sta	___fsmul_PARM_2
	lda	(_sincoshf_PARM_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincoshf_PARM_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincoshf_PARM_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(_sincoshf_z_1_1 + 3)
	stx	(_sincoshf_z_1_1 + 2)
	lda	*__ret2
	sta	(_sincoshf_z_1_1 + 1)
	lda	*__ret3
	sta	_sincoshf_z_1_1
;../sincoshf.c:93: z=x+x*z*P(z)/Q(z);
	lda	_sincoshf_PARM_1
	sta	___fsmul_PARM_1
	lda	(_sincoshf_PARM_1 + 1)
	sta	(___fsmul_PARM_1 + 1)
	lda	(_sincoshf_PARM_1 + 2)
	sta	(___fsmul_PARM_1 + 2)
	lda	(_sincoshf_PARM_1 + 3)
	sta	(___fsmul_PARM_1 + 3)
	lda	_sincoshf_z_1_1
	sta	___fsmul_PARM_2
	lda	(_sincoshf_z_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincoshf_z_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincoshf_z_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	#0xBE
	sta	___fsmul_PARM_1
	lda	#0x42
	sta	(___fsmul_PARM_1 + 1)
	lda	#0xE6
	sta	(___fsmul_PARM_1 + 2)
	lda	#0xEA
	sta	(___fsmul_PARM_1 + 3)
	lda	_sincoshf_z_1_1
	sta	___fsmul_PARM_2
	lda	(_sincoshf_z_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_sincoshf_z_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_sincoshf_z_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0xC0
	sta	___fsadd_PARM_2
	lda	#0xE4
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x69
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xF0
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_2 + 3)
	stx	(___fsmul_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_2 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_2
	jsr	___fsmul
	sta	(___fsdiv_PARM_1 + 3)
	stx	(___fsdiv_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_1 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_1
	lda	_sincoshf_z_1_1
	sta	___fsadd_PARM_1
	lda	(_sincoshf_z_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_sincoshf_z_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_sincoshf_z_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	lda	#0xC2
	sta	___fsadd_PARM_2
	lda	#0x2B
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x4F
	sta	(___fsadd_PARM_2 + 2)
	lda	#0x93
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsdiv_PARM_2 + 3)
	stx	(___fsdiv_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_2 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_2
	jsr	___fsdiv
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	lda	_sincoshf_PARM_1
	sta	___fsadd_PARM_1
	lda	(_sincoshf_PARM_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_sincoshf_PARM_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_sincoshf_PARM_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	(_sincoshf_z_1_1 + 3)
	stx	(_sincoshf_z_1_1 + 2)
	lda	*__ret2
	sta	(_sincoshf_z_1_1 + 1)
	lda	*__ret3
	sta	_sincoshf_z_1_1
00119$:
;../sincoshf.c:96: return z;
	lda	_sincoshf_z_1_1
	sta	*__ret3
	lda	(_sincoshf_z_1_1 + 1)
	sta	*__ret2
	ldx	(_sincoshf_z_1_1 + 2)
	lda	(_sincoshf_z_1_1 + 3)
00121$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
