;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:28 2015
;--------------------------------------------------------
	.module sincoshf
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sincoshf
	.globl _sincoshf_PARM_2
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_sincoshf_sloc0_1_0:
	.ds 4
_sincoshf_sloc1_1_0:
	.ds 4
_sincoshf_sloc2_1_0:
	.ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area OSEG    (OVR,DATA)
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
_sincoshf_sign_1_1:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_sincoshf_PARM_2:
	.ds 2
_sincoshf_x_1_1:
	.ds 4
_sincoshf_y_1_1:
	.ds 4
_sincoshf_w_1_1:
	.ds 4
_sincoshf_z_1_1:
	.ds 4
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'sincoshf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_sincoshf_sloc0_1_0'
;sloc1                     Allocated with name '_sincoshf_sloc1_1_0'
;sloc2                     Allocated with name '_sincoshf_sloc2_1_0'
;iscosh                    Allocated with name '_sincoshf_PARM_2'
;x                         Allocated with name '_sincoshf_x_1_1'
;y                         Allocated with name '_sincoshf_y_1_1'
;w                         Allocated with name '_sincoshf_w_1_1'
;z                         Allocated with name '_sincoshf_z_1_1'
;------------------------------------------------------------
;	sincoshf.c:53: float sincoshf(const float x, const int iscosh)
;	-----------------------------------------
;	 function sincoshf
;	-----------------------------------------
_sincoshf:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	sincoshf.c:58: if (x<0.0) { y=-x; sign=1; }
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	dptr,#_sincoshf_x_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	clr	a
	push	acc
	push	acc
	push	acc
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jz	00102$
	mov	dptr,#_sincoshf_y_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	mov	a,r5
	cpl	acc.7
	inc	dptr
	movx	@dptr,a
	setb	_sincoshf_sign_1_1
	sjmp	00103$
00102$:
;	sincoshf.c:59: else { y=x;  sign=0; }
	mov	dptr,#_sincoshf_y_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	clr	_sincoshf_sign_1_1
00103$:
;	sincoshf.c:61: if ((y>1.0) || iscosh)
	mov	dptr,#_sincoshf_y_1_1
	movx	a,@dptr
	mov	_sincoshf_sloc0_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_sincoshf_sloc0_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_sincoshf_sloc0_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(_sincoshf_sloc0_1_0 + 3),a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	clr	a
	push	acc
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_sincoshf_sloc0_1_0
	mov	dph,(_sincoshf_sloc0_1_0 + 1)
	mov	b,(_sincoshf_sloc0_1_0 + 2)
	mov	a,(_sincoshf_sloc0_1_0 + 3)
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jnz	00117$
	mov	dptr,#_sincoshf_PARM_2
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	orl	a,r6
	jnz	00132$
	ljmp	00118$
00132$:
00117$:
;	sincoshf.c:63: if(y>YBAR)
	clr	a
	push	acc
	push	acc
	mov	a,#0x10
	push	acc
	mov	a,#0x41
	push	acc
	mov	dpl,_sincoshf_sloc0_1_0
	mov	dph,(_sincoshf_sloc0_1_0 + 1)
	mov	b,(_sincoshf_sloc0_1_0 + 2)
	mov	a,(_sincoshf_sloc0_1_0 + 3)
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r6
	jnz	00133$
	ljmp	00110$
00133$:
;	sincoshf.c:65: w=y-K1;
	clr	a
	push	acc
	mov	a,#0x73
	push	acc
	mov	a,#0x31
	push	acc
	mov	a,#0x3F
	push	acc
;	sincoshf.c:66: if (w>WMAX)
	mov	dpl,_sincoshf_sloc0_1_0
	mov	dph,(_sincoshf_sloc0_1_0 + 1)
	mov	b,(_sincoshf_sloc0_1_0 + 2)
	mov	a,(_sincoshf_sloc0_1_0 + 3)
	lcall	___fssub
	mov	_sincoshf_sloc1_1_0,dpl
	mov	(_sincoshf_sloc1_1_0 + 1),dph
	mov	(_sincoshf_sloc1_1_0 + 2),b
	mov	(_sincoshf_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0xCF
	push	acc
	mov	a,#0xBD
	push	acc
	mov	a,#0x33
	push	acc
	mov	a,#0x42
	push	acc
	mov	dpl,_sincoshf_sloc1_1_0
	mov	dph,(_sincoshf_sloc1_1_0 + 1)
	mov	b,(_sincoshf_sloc1_1_0 + 2)
	mov	a,(_sincoshf_sloc1_1_0 + 3)
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r6
	jz	00105$
;	sincoshf.c:68: errno=ERANGE;
	mov	dptr,#_errno
	mov	a,#0x22
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	sincoshf.c:69: z=HUGE_VALF;
	mov	dptr,#_sincoshf_z_1_1
	mov	a,#0xFF
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,#0x7F
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	ljmp	00111$
00105$:
;	sincoshf.c:73: z=expf(w);
	mov	dpl,_sincoshf_sloc1_1_0
	mov	dph,(_sincoshf_sloc1_1_0 + 1)
	mov	b,(_sincoshf_sloc1_1_0 + 2)
	mov	a,(_sincoshf_sloc1_1_0 + 3)
	lcall	_expf
	mov	_sincoshf_sloc1_1_0,dpl
	mov	(_sincoshf_sloc1_1_0 + 1),dph
	mov	(_sincoshf_sloc1_1_0 + 2),b
	mov	(_sincoshf_sloc1_1_0 + 3),a
;	sincoshf.c:74: z+=K3*z;
	push	_sincoshf_sloc1_1_0
	push	(_sincoshf_sloc1_1_0 + 1)
	push	(_sincoshf_sloc1_1_0 + 2)
	push	(_sincoshf_sloc1_1_0 + 3)
	mov	dptr,#0x0897
	mov	b,#0x68
	mov	a,#0x37
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,_sincoshf_sloc1_1_0
	mov	dph,(_sincoshf_sloc1_1_0 + 1)
	mov	b,(_sincoshf_sloc1_1_0 + 2)
	mov	a,(_sincoshf_sloc1_1_0 + 3)
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_sincoshf_z_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	ljmp	00111$
00110$:
;	sincoshf.c:79: z=expf(y);
	mov	dpl,_sincoshf_sloc0_1_0
	mov	dph,(_sincoshf_sloc0_1_0 + 1)
	mov	b,(_sincoshf_sloc0_1_0 + 2)
	mov	a,(_sincoshf_sloc0_1_0 + 3)
	lcall	_expf
	mov	_sincoshf_sloc2_1_0,dpl
	mov	(_sincoshf_sloc2_1_0 + 1),dph
	mov	(_sincoshf_sloc2_1_0 + 2),b
	mov	(_sincoshf_sloc2_1_0 + 3),a
;	sincoshf.c:80: w=1.0/z;
	push	_sincoshf_sloc2_1_0
	push	(_sincoshf_sloc2_1_0 + 1)
	push	(_sincoshf_sloc2_1_0 + 2)
	push	(_sincoshf_sloc2_1_0 + 3)
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x3F
	lcall	___fsdiv
	mov	_sincoshf_sloc1_1_0,dpl
	mov	(_sincoshf_sloc1_1_0 + 1),dph
	mov	(_sincoshf_sloc1_1_0 + 2),b
	mov	(_sincoshf_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_sincoshf_w_1_1
	mov	a,_sincoshf_sloc1_1_0
	movx	@dptr,a
	inc	dptr
	mov	a,(_sincoshf_sloc1_1_0 + 1)
	movx	@dptr,a
	inc	dptr
	mov	a,(_sincoshf_sloc1_1_0 + 2)
	movx	@dptr,a
	inc	dptr
	mov	a,(_sincoshf_sloc1_1_0 + 3)
	movx	@dptr,a
;	sincoshf.c:81: if(!iscosh) w=-w;
	mov	dptr,#_sincoshf_PARM_2
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	orl	a,r6
	jnz	00108$
	mov	dptr,#_sincoshf_w_1_1
	mov	a,_sincoshf_sloc1_1_0
	movx	@dptr,a
	inc	dptr
	mov	a,(_sincoshf_sloc1_1_0 + 1)
	movx	@dptr,a
	inc	dptr
	mov	a,(_sincoshf_sloc1_1_0 + 2)
	movx	@dptr,a
	mov	a,(_sincoshf_sloc1_1_0 + 3)
	cpl	acc.7
	inc	dptr
	movx	@dptr,a
00108$:
;	sincoshf.c:82: z=(z+w)*0.5;
	mov	dptr,#_sincoshf_w_1_1
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dpl,_sincoshf_sloc2_1_0
	mov	dph,(_sincoshf_sloc2_1_0 + 1)
	mov	b,(_sincoshf_sloc2_1_0 + 2)
	mov	a,(_sincoshf_sloc2_1_0 + 3)
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#(0x00&0x00ff)
	clr	a
	mov	b,a
	mov	a,#0x3F
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_sincoshf_z_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
00111$:
;	sincoshf.c:84: if(sign) z=-z;
	jb	_sincoshf_sign_1_1,00136$
	ljmp	00119$
00136$:
	mov	dptr,#_sincoshf_z_1_1
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	dptr,#_sincoshf_z_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	mov	a,r1
	cpl	acc.7
	inc	dptr
	movx	@dptr,a
	ljmp	00119$
00118$:
;	sincoshf.c:88: if (y<EPS)
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	clr	a
	push	acc
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#0x39
	push	acc
	mov	dpl,_sincoshf_sloc0_1_0
	mov	dph,(_sincoshf_sloc0_1_0 + 1)
	mov	b,(_sincoshf_sloc0_1_0 + 2)
	mov	a,(_sincoshf_sloc0_1_0 + 3)
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jz	00115$
;	sincoshf.c:89: z=x;
	mov	dptr,#_sincoshf_z_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	ljmp	00119$
00115$:
;	sincoshf.c:92: z=x*x;
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
;	sincoshf.c:93: z=x+x*z*P(z)/Q(z);
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsmul
	mov	_sincoshf_sloc2_1_0,dpl
	mov	(_sincoshf_sloc2_1_0 + 1),dph
	mov	(_sincoshf_sloc2_1_0 + 2),b
	mov	(_sincoshf_sloc2_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	_sincoshf_sloc2_1_0
	push	(_sincoshf_sloc2_1_0 + 1)
	push	(_sincoshf_sloc2_1_0 + 2)
	push	(_sincoshf_sloc2_1_0 + 3)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsmul
	mov	_sincoshf_sloc1_1_0,dpl
	mov	(_sincoshf_sloc1_1_0 + 1),dph
	mov	(_sincoshf_sloc1_1_0 + 2),b
	mov	(_sincoshf_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_sincoshf_sloc2_1_0
	push	(_sincoshf_sloc2_1_0 + 1)
	push	(_sincoshf_sloc2_1_0 + 2)
	push	(_sincoshf_sloc2_1_0 + 3)
	mov	dptr,#0xE6EA
	mov	b,#0x42
	mov	a,#0xBE
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0xF0
	push	acc
	mov	a,#0x69
	push	acc
	mov	a,#0xE4
	push	acc
	mov	a,#0xC0
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,_sincoshf_sloc1_1_0
	mov	dph,(_sincoshf_sloc1_1_0 + 1)
	mov	b,(_sincoshf_sloc1_1_0 + 2)
	mov	a,(_sincoshf_sloc1_1_0 + 3)
	lcall	___fsmul
	mov	_sincoshf_sloc1_1_0,dpl
	mov	(_sincoshf_sloc1_1_0 + 1),dph
	mov	(_sincoshf_sloc1_1_0 + 2),b
	mov	(_sincoshf_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x93
	push	acc
	mov	a,#0x4F
	push	acc
	mov	a,#0x2B
	push	acc
	mov	a,#0xC2
	push	acc
	mov	dpl,_sincoshf_sloc2_1_0
	mov	dph,(_sincoshf_sloc2_1_0 + 1)
	mov	b,(_sincoshf_sloc2_1_0 + 2)
	mov	a,(_sincoshf_sloc2_1_0 + 3)
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,_sincoshf_sloc1_1_0
	mov	dph,(_sincoshf_sloc1_1_0 + 1)
	mov	b,(_sincoshf_sloc1_1_0 + 2)
	mov	a,(_sincoshf_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_sincoshf_z_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
00119$:
;	sincoshf.c:96: return z;
	mov	dptr,#_sincoshf_z_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
