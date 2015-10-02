;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module sqrtf
	.optsdcc -mds400 --model-flat24
	
;--------------------------------------------------------
; CPU specific extensions
;--------------------------------------------------------
.flat24 on		; 24 bit flat addressing
dpl1	=	0x84
dph1	=	0x85
dps	=	0x86
dpx	=	0x93
dpx1	=	0x95
esp	=	0x9B
ap	=	0x9C
_ap	=	0x9C
mcnt0	=	0xD1
mcnt1	=	0xD2
ma	=	0xD3
mb	=	0xD4
mc	=	0xD5
F1	=	0xD1	; user flag
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sqrtf
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
	.area REG_BANK_3	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
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
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
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
;Allocation info for local variables in function 'sqrtf'
;------------------------------------------------------------
;x                         Allocated to registers r2 r3 r4 r5 
;f                         Allocated to stack - offset 1
;y                         Allocated to registers r6 r7 r0 r1 
;n                         Allocated to stack - offset 5
;sloc0                     Allocated to stack - offset 7
;------------------------------------------------------------
;	sqrtf.c:37: float sqrtf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function sqrtf
;	-----------------------------------------
_sqrtf:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	push	_bpx
	push	_bpx+1
	mov	_bpx,sp
	mov	_bpx+1,esp
	anl	_bpx+1,#3
	orl	_bpx+1,#0xDC
	mov	a,sp
	add	a,#0x0A
	mov	sp,a
	mov	a,esp
	anl	a,#3
	orl	a,#0xDC
	addc	a,#0x00
	mov	esp,a
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	sqrtf.c:42: if (x==0.0) return x;
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jnz  00107$
00117$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	ljmp	00111$
00107$:
;	sqrtf.c:43: else if (x==1.0) return 1.0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fseq_PARM_2
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0x80
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fseq
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,dpl
	jz  00104$
00118$:
	mov  dptr,#0x0000
	mov	dpx,#0x80
	mov	b,#0x3F
	ljmp	00111$
00104$:
;	sqrtf.c:44: else if (x<0.0)
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fslt_PARM_2
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fslt
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,dpl
	jz  00108$
00119$:
;	sqrtf.c:46: errno=EDOM;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_errno
	mov	a,#0x21
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
;	sqrtf.c:47: return 0.0;
	mov  dptr,#0x0000
	mov	b,#0x00
	ljmp	00111$
00108$:
;	sqrtf.c:49: f=frexpf(x, &n);
	mov	a,_bpx
	add	a,#0x05
	mov	b,a
	clr	a
	addc	a,_bpx+1
	mov	r6,b
	mov	r7,a
	mov	r0,#0xFF
	mov	dptr,#_frexpf_PARM_2
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	_frexpf
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
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
;	sqrtf.c:50: y=0.41731+0.59016*f; /*Educated guess*/
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fsmul_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	mov	dptr,#0x1714BA
	mov	b,#0x3F
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
	mov	a,#0xA8
	movx	@dptr,a
	inc	dptr
	mov	a,#0xA9
	movx	@dptr,a
	inc	dptr
	mov	a,#0xD5
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3E
	movx	@dptr,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
;	sqrtf.c:52: y+=f/y;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_PARM_2
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
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpx1,#0xFF
	mov	dph1,_bpx+1
	mov	dpl1,_bpx
	mov     dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
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
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
;	sqrtf.c:53: y=ldexpf(y, -2) + f/y; /*Faster version of 0.25 * y + f/y*/
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_ldexpf_PARM_2
	mov	a,#0xFE
	movx	@dptr,a
	inc	dptr
	mov	a,#0xFF
	movx	@dptr,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	_ldexpf
	mov	a,_bpx
	clr	c
	subb	a,#0xF9
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
	mov	a,dpl
	movx	@dptr,a
	inc	dptr
	mov	a,dph
	movx	@dptr,a
	inc	dptr
	mov	a,dpx
	movx	@dptr,a
	inc	dptr
	mov	a,b
	movx	@dptr,a
	mov	dps,#0
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_PARM_2
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
	mov	dpx1,#0xFF
	mov	dph1,_bpx+1
	mov	dpl1,_bpx
	mov     dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
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
	mov	a,_bpx
	clr	c
	subb	a,#0xF9
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
;	sqrtf.c:55: if (n&1)
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph,a
	mov	dpx,#0xFF
	movx	a,@dptr
	jnb  acc.0,00110$
00120$:
;	sqrtf.c:57: y*=0.7071067812;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_PARM_2
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
	mov	dptr,#0x3504F3
	mov	b,#0x3F
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
;	sqrtf.c:58: ++n;
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph,a
	mov	dpx,#0xFF
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
00110$:
;	sqrtf.c:60: return ldexpf(y, n/2);
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divsint_PARM_2
	mov	a,#0x02
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	mov	dps,#0
	lcall	__divsint
	mov	r2,dpl
	mov	r3,dph
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_ldexpf_PARM_2
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	_ldexpf
00111$:
	mov	sp,_bpx
	mov	esp,_bpx+1
	pop	_bpx+1
	pop	_bpx
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
