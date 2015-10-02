;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:28 2015
;--------------------------------------------------------
	.module asincosf
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _asincosf
	.globl _asincosf_PARM_2
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
_asincosf_sloc0_1_0:
	.ds 4
_asincosf_sloc1_1_0:
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
_asincosf_PARM_2:
	.ds 1
_asincosf_quartPI_1_1:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_asincosf_x_1_1:
	.ds 4
_asincosf_y_1_1:
	.ds 4
_asincosf_g_1_1:
	.ds 4
_asincosf_r_1_1:
	.ds 4
_asincosf_a_1_1:
	.ds 8
_asincosf_b_1_1:
	.ds 8
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
;------------------------------------------------------------
;Allocation info for local variables in function 'asincosf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_asincosf_sloc0_1_0'
;sloc1                     Allocated with name '_asincosf_sloc1_1_0'
;x                         Allocated with name '_asincosf_x_1_1'
;y                         Allocated with name '_asincosf_y_1_1'
;g                         Allocated with name '_asincosf_g_1_1'
;r                         Allocated with name '_asincosf_r_1_1'
;i                         Allocated with name '_asincosf_i_1_1'
;a                         Allocated with name '_asincosf_a_1_1'
;b                         Allocated with name '_asincosf_b_1_1'
;------------------------------------------------------------
;	asincosf.c:53: static const float a[2] = { 0.0, QUART_PI };
	mov	dptr,#_asincosf_a_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	mov	dptr,#(_asincosf_a_1_1 + 0x0004)
	mov	a,#0xDB
	movx	@dptr,a
	inc	dptr
	mov	a,#0x0F
	movx	@dptr,a
	inc	dptr
	mov	a,#0x49
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
;	asincosf.c:54: static const float b[2] = { HALF_PI, QUART_PI };
	mov	dptr,#_asincosf_b_1_1
	mov	a,#0xDB
	movx	@dptr,a
	inc	dptr
	mov	a,#0x0F
	movx	@dptr,a
	inc	dptr
	mov	a,#0xC9
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
	mov	dptr,#(_asincosf_b_1_1 + 0x0004)
	mov	a,#0xDB
	movx	@dptr,a
	inc	dptr
	mov	a,#0x0F
	movx	@dptr,a
	inc	dptr
	mov	a,#0x49
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
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
;Allocation info for local variables in function 'asincosf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_asincosf_sloc0_1_0'
;sloc1                     Allocated with name '_asincosf_sloc1_1_0'
;x                         Allocated with name '_asincosf_x_1_1'
;y                         Allocated with name '_asincosf_y_1_1'
;g                         Allocated with name '_asincosf_g_1_1'
;r                         Allocated with name '_asincosf_r_1_1'
;i                         Allocated with name '_asincosf_i_1_1'
;a                         Allocated with name '_asincosf_a_1_1'
;b                         Allocated with name '_asincosf_b_1_1'
;------------------------------------------------------------
;	asincosf.c:47: float asincosf(const float x, const BOOL isacos)
;	-----------------------------------------
;	 function asincosf
;	-----------------------------------------
_asincosf:
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
	mov	dptr,#_asincosf_x_1_1
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
;	asincosf.c:51: BOOL quartPI = isacos;
	mov	c,_asincosf_PARM_2
	mov	_asincosf_quartPI_1_1,c
;	asincosf.c:56: y = fabsf(x);
	mov	dptr,#_asincosf_x_1_1
	movx	a,@dptr
	mov	_asincosf_sloc0_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_asincosf_sloc0_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_asincosf_sloc0_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(_asincosf_sloc0_1_0 + 3),a
	mov	dpl,_asincosf_sloc0_1_0
	mov	dph,(_asincosf_sloc0_1_0 + 1)
	mov	b,(_asincosf_sloc0_1_0 + 2)
	lcall	_fabsf
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	dptr,#_asincosf_y_1_1
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
;	asincosf.c:57: if (y < EPS)
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	clr	a
	push	acc
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#0x39
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	mov	a,r2
	jz	00107$
;	asincosf.c:59: r = y;
	mov	dptr,#_asincosf_r_1_1
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
	ljmp	00108$
00107$:
;	asincosf.c:63: if (y > 0.5)
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	mov	a,r2
	jnz	00126$
	ljmp	00104$
00126$:
;	asincosf.c:65: quartPI = !isacos;
	cpl	_asincosf_quartPI_1_1
;	asincosf.c:66: if (y > 1.0)
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	clr	a
	push	acc
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	mov	a,r2
	jz	00102$
;	asincosf.c:68: errno = EDOM;
	mov	dptr,#_errno
	mov	a,#0x21
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	asincosf.c:69: return 0.0;
	mov	dptr,#(0x00&0x00ff)
	clr	a
	mov	b,a
	ret
00102$:
;	asincosf.c:71: g = (0.5 - y) + 0.5;
	push	ar6
	push	ar7
	push	ar0
	push	ar1
;	asincosf.c:72: g = ldexpf(g, -1);
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x3F
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_ldexpf_PARM_2
	mov	a,#0xFF
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	_ldexpf
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	dptr,#_asincosf_g_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
;	asincosf.c:73: y = sqrtf(g);
	mov	a,r5
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_sqrtf
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	asincosf.c:74: y = -(y + y);
	push	ar2
	push	ar3
	push	ar4
	push	ar5
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
	mov	dptr,#_asincosf_y_1_1
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
	sjmp	00105$
00104$:
;	asincosf.c:78: g = y * y;
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_asincosf_g_1_1
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
00105$:
;	asincosf.c:80: r = y + y * ((P(g) * g) / Q(g));
	mov	dptr,#_asincosf_g_1_1
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x2065
	mov	b,#0x01
	mov	a,#0xBF
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x6B
	push	acc
	mov	a,#0x16
	push	acc
	mov	a,#0x6F
	push	acc
	mov	a,#0x3F
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
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsmul
	mov	_asincosf_sloc1_1_0,dpl
	mov	(_asincosf_sloc1_1_0 + 1),dph
	mov	(_asincosf_sloc1_1_0 + 2),b
	mov	(_asincosf_sloc1_1_0 + 3),a
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
	mov	a,#0x0B
	push	acc
	mov	a,#0x8D
	push	acc
	mov	a,#0xB1
	push	acc
	mov	a,#0xC0
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0xF0
	push	acc
	mov	a,#0x50
	push	acc
	mov	a,#0xB3
	push	acc
	mov	a,#0x40
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,_asincosf_sloc1_1_0
	mov	dph,(_asincosf_sloc1_1_0 + 1)
	mov	b,(_asincosf_sloc1_1_0 + 2)
	mov	a,(_asincosf_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_asincosf_y_1_1
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
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
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
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_asincosf_r_1_1
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
00108$:
;	asincosf.c:82: i = quartPI;
	mov	c,_asincosf_quartPI_1_1
	clr	a
	rlc	a
	mov	r2,a
;	asincosf.c:83: if (isacos)
	jb	_asincosf_PARM_2,00128$
	ljmp	00115$
00128$:
;	asincosf.c:85: if (x < 0.0)
	push	ar2
	clr	a
	push	acc
	push	acc
	push	acc
	push	acc
	mov	dpl,_asincosf_sloc0_1_0
	mov	dph,(_asincosf_sloc0_1_0 + 1)
	mov	b,(_asincosf_sloc0_1_0 + 2)
	mov	a,(_asincosf_sloc0_1_0 + 3)
	lcall	___fslt
	mov	r3,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar2
	mov	a,r3
	jz	00110$
;	asincosf.c:86: r = (b[i] + r) + b[i];
	mov	a,r2
	add	a,r2
	add	a,acc
	add	a,#_asincosf_b_1_1
	mov	dpl,a
	clr	a
	addc	a,#(_asincosf_b_1_1 >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	_asincosf_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_asincosf_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_asincosf_sloc1_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(_asincosf_sloc1_1_0 + 3),a
	mov	dptr,#_asincosf_r_1_1
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
	mov	dpl,_asincosf_sloc1_1_0
	mov	dph,(_asincosf_sloc1_1_0 + 1)
	mov	b,(_asincosf_sloc1_1_0 + 2)
	mov	a,(_asincosf_sloc1_1_0 + 3)
	lcall	___fsadd
	mov	r7,dpl
	mov	r0,dph
	mov	r1,b
	mov	r3,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_asincosf_sloc1_1_0
	push	(_asincosf_sloc1_1_0 + 1)
	push	(_asincosf_sloc1_1_0 + 2)
	push	(_asincosf_sloc1_1_0 + 3)
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	mov	a,r3
	lcall	___fsadd
	mov	r3,dpl
	mov	r4,dph
	mov	r5,b
	mov	r6,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_asincosf_r_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	ljmp	00116$
00110$:
;	asincosf.c:88: r = (a[i] - r) + a[i];
	mov	a,r2
	add	a,r2
	add	a,acc
	add	a,#_asincosf_a_1_1
	mov	dpl,a
	clr	a
	addc	a,#(_asincosf_a_1_1 >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	_asincosf_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_asincosf_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_asincosf_sloc1_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(_asincosf_sloc1_1_0 + 3),a
	mov	dptr,#_asincosf_r_1_1
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
	mov	dpl,_asincosf_sloc1_1_0
	mov	dph,(_asincosf_sloc1_1_0 + 1)
	mov	b,(_asincosf_sloc1_1_0 + 2)
	mov	a,(_asincosf_sloc1_1_0 + 3)
	lcall	___fssub
	mov	r7,dpl
	mov	r0,dph
	mov	r1,b
	mov	r3,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_asincosf_sloc1_1_0
	push	(_asincosf_sloc1_1_0 + 1)
	push	(_asincosf_sloc1_1_0 + 2)
	push	(_asincosf_sloc1_1_0 + 3)
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	mov	a,r3
	lcall	___fsadd
	mov	r3,dpl
	mov	r4,dph
	mov	r5,b
	mov	r6,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_asincosf_r_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	ljmp	00116$
00115$:
;	asincosf.c:92: r = (a[i] + r) + a[i];
	mov	a,r2
	add	a,r2
	add	a,acc
	add	a,#_asincosf_a_1_1
	mov	dpl,a
	clr	a
	addc	a,#(_asincosf_a_1_1 >> 8)
	mov	dph,a
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
	mov	dptr,#_asincosf_r_1_1
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
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_asincosf_r_1_1
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
;	asincosf.c:93: if (x < 0.0)
	clr	a
	push	acc
	push	acc
	push	acc
	push	acc
	mov	dpl,_asincosf_sloc0_1_0
	mov	dph,(_asincosf_sloc0_1_0 + 1)
	mov	b,(_asincosf_sloc0_1_0 + 2)
	mov	a,(_asincosf_sloc0_1_0 + 3)
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	00116$
;	asincosf.c:94: r = -r;
	mov	dptr,#_asincosf_r_1_1
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
	mov	dptr,#_asincosf_r_1_1
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
00116$:
;	asincosf.c:96: return r;
	mov	dptr,#_asincosf_r_1_1
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
