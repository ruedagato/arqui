;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:27 2015
;--------------------------------------------------------
	.module sincosf
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sincosf
	.globl _sincosf_PARM_2
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
_sincosf_sloc0_1_0:
	.ds 4
_sincosf_sloc1_1_0:
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
_sincosf_PARM_2:
	.ds 1
_sincosf_sign_1_1:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_sincosf_x_1_1:
	.ds 4
_sincosf_y_1_1:
	.ds 4
_sincosf_f_1_1:
	.ds 4
_sincosf_XN_1_1:
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
;Allocation info for local variables in function 'sincosf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_sincosf_sloc0_1_0'
;sloc1                     Allocated with name '_sincosf_sloc1_1_0'
;x                         Allocated with name '_sincosf_x_1_1'
;y                         Allocated with name '_sincosf_y_1_1'
;f                         Allocated with name '_sincosf_f_1_1'
;r                         Allocated with name '_sincosf_r_1_1'
;g                         Allocated with name '_sincosf_g_1_1'
;XN                        Allocated with name '_sincosf_XN_1_1'
;N                         Allocated with name '_sincosf_N_1_1'
;------------------------------------------------------------
;	sincosf.c:50: float sincosf(const float x, const BOOL iscos)
;	-----------------------------------------
;	 function sincosf
;	-----------------------------------------
_sincosf:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	dptr,#_sincosf_x_1_1
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
;	sincosf.c:56: if(iscos)
	jnb	_sincosf_PARM_2,00105$
;	sincosf.c:58: y=fabsf(x)+HALF_PI;
	mov	dptr,#_sincosf_x_1_1
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
	lcall	_fabsf
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,#0xDB
	push	acc
	mov	a,#0x0F
	push	acc
	mov	a,#0xC9
	push	acc
	mov	a,#0x3F
	push	acc
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
	mov	dptr,#_sincosf_y_1_1
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
;	sincosf.c:59: sign=0;
	clr	_sincosf_sign_1_1
	sjmp	00106$
00105$:
;	sincosf.c:63: if(x<0.0)
	mov	dptr,#_sincosf_x_1_1
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
	mov	r5,a
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
;	sincosf.c:64: { y=-x; sign=1; }
	mov	dptr,#_sincosf_y_1_1
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
	setb	_sincosf_sign_1_1
	sjmp	00106$
00102$:
;	sincosf.c:66: { y=x; sign=0; }
	mov	dptr,#_sincosf_y_1_1
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
	clr	_sincosf_sign_1_1
00106$:
;	sincosf.c:69: if(y>YMAX)
	mov	dptr,#_sincosf_y_1_1
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
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	clr	a
	push	acc
	mov	a,#0x0C
	push	acc
	mov	a,#0x49
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
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
	jz	00108$
;	sincosf.c:71: errno=ERANGE;
	mov	dptr,#_errno
	mov	a,#0x22
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	sincosf.c:72: return 0.0;
	mov	dptr,#(0x00&0x00ff)
	clr	a
	mov	b,a
	ret
00108$:
;	sincosf.c:76: N=((y*iPI)+0.5); /*y is positive*/
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0xF983
	mov	b,#0xA2
	mov	a,#0x3E
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
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
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fs2sint
	mov	r2,dpl
	mov	r3,dph
;	sincosf.c:79: if(N&1) sign=!sign;
	mov	a,r2
	jnb	acc.0,00110$
	cpl	_sincosf_sign_1_1
00110$:
;	sincosf.c:81: XN=N;
	mov	dpl,r2
	mov	dph,r3
	lcall	___sint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	dptr,#_sincosf_XN_1_1
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
;	sincosf.c:83: if(iscos) XN-=0.5;
	jnb	_sincosf_PARM_2,00112$
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_sincosf_XN_1_1
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
00112$:
;	sincosf.c:85: y=fabsf(x);
	mov	dptr,#_sincosf_x_1_1
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
	lcall	_fabsf
;	sincosf.c:86: r=(int)y;
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	___fs2sint
	lcall	___sint2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	sincosf.c:87: g=y-r;
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	push	ar6
	push	ar7
	push	ar0
	push	ar1
;	sincosf.c:88: f=((r-XN*C1)+g)-XN*C2;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fssub
	mov	_sincosf_sloc0_1_0,dpl
	mov	(_sincosf_sloc0_1_0 + 1),dph
	mov	(_sincosf_sloc0_1_0 + 2),b
	mov	(_sincosf_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_sincosf_XN_1_1
	movx	a,@dptr
	mov	_sincosf_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_sincosf_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_sincosf_sloc1_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(_sincosf_sloc1_1_0 + 3),a
	push	_sincosf_sloc1_1_0
	push	(_sincosf_sloc1_1_0 + 1)
	push	(_sincosf_sloc1_1_0 + 2)
	push	(_sincosf_sloc1_1_0 + 3)
	mov	dptr,#0x0000
	mov	b,#0x49
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_sincosf_sloc0_1_0
	push	(_sincosf_sloc0_1_0 + 1)
	push	(_sincosf_sloc0_1_0 + 2)
	push	(_sincosf_sloc0_1_0 + 3)
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	_sincosf_sloc1_1_0
	push	(_sincosf_sloc1_1_0 + 1)
	push	(_sincosf_sloc1_1_0 + 2)
	push	(_sincosf_sloc1_1_0 + 3)
	mov	dptr,#0xAA22
	mov	b,#0x7D
	mov	a,#0x3A
	lcall	___fsmul
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
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_sincosf_f_1_1
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
;	sincosf.c:90: g=f*f;
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
;	sincosf.c:91: if(g>EPS2) //Used to be if(fabsf(f)>EPS)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsmul
	mov	_sincosf_sloc1_1_0,dpl
	mov	(_sincosf_sloc1_1_0 + 1),dph
	mov	(_sincosf_sloc1_1_0 + 2),b
	mov	(_sincosf_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0xF3
	push	acc
	mov	a,#0xFF
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x33
	push	acc
	mov	dpl,_sincosf_sloc1_1_0
	mov	dph,(_sincosf_sloc1_1_0 + 1)
	mov	b,(_sincosf_sloc1_1_0 + 2)
	mov	a,(_sincosf_sloc1_1_0 + 3)
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
	jnz	00131$
	ljmp	00114$
00131$:
;	sincosf.c:93: r=(((r4*g+r3)*g+r2)*g+r1)*g;
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	_sincosf_sloc1_1_0
	push	(_sincosf_sloc1_1_0 + 1)
	push	(_sincosf_sloc1_1_0 + 2)
	push	(_sincosf_sloc1_1_0 + 3)
	mov	dptr,#0x9C5B
	mov	b,#0x2E
	mov	a,#0x36
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x22
	push	acc
	mov	a,#0xB2
	push	acc
	mov	a,#0x4F
	push	acc
	mov	a,#0xB9
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
	push	_sincosf_sloc1_1_0
	push	(_sincosf_sloc1_1_0 + 1)
	push	(_sincosf_sloc1_1_0 + 2)
	push	(_sincosf_sloc1_1_0 + 3)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x3E
	push	acc
	mov	a,#0x87
	push	acc
	mov	a,#0x08
	push	acc
	mov	a,#0x3C
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
	push	_sincosf_sloc1_1_0
	push	(_sincosf_sloc1_1_0 + 1)
	push	(_sincosf_sloc1_1_0 + 2)
	push	(_sincosf_sloc1_1_0 + 3)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0xA4
	push	acc
	mov	a,#0xAA
	push	acc
	mov	a,#0x2A
	push	acc
	mov	a,#0xBE
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
	push	_sincosf_sloc1_1_0
	push	(_sincosf_sloc1_1_0 + 1)
	push	(_sincosf_sloc1_1_0 + 2)
	push	(_sincosf_sloc1_1_0 + 3)
;	sincosf.c:94: f+=f*r;
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsmul
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsmul
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
	mov	dptr,#_sincosf_f_1_1
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
00114$:
;	sincosf.c:96: return (sign?-f:f);
	jnb	_sincosf_sign_1_1,00117$
	mov	dptr,#_sincosf_f_1_1
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
	cpl	acc.7
	mov	r5,a
	sjmp	00118$
00117$:
	mov	dptr,#_sincosf_f_1_1
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
	mov	r5,a
00118$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
