;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module floorf
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
	.globl _floorf
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
;Allocation info for local variables in function 'floorf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 1
;r                         Allocated to registers r6 r7 r0 r1 
;------------------------------------------------------------
;	floorf.c:33: float floorf (float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function floorf
;	-----------------------------------------
_floorf:
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
	push	acc
	push	acc
	push	acc
	push	acc
	mov	dpx1,#0xFF
	mov	dph1,_bpx+1
	mov	dpl1,_bpx
	mov	dps,#1
	inc	dptr
	mov	dps, #1
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
;	floorf.c:36: r=x;
	mov	dpx1,#0xFF
	mov	dph1,_bpx+1
	mov	dpl1,_bpx
	mov	dps,#1
	inc	dptr
	mov	dps, #1
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
	lcall	___fs2slong
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
;	floorf.c:37: if (r<=0)
	clr	c
	clr  a
	subb	a,r6
	clr  a
	subb	a,r7
	clr  a
	subb	a,r0
	mov  a,#(0x00 ^ 0x80)
	mov	b,r1
	xrl	b,#0x80
	subb	a,b
	jnc	00110$
	ljmp	00102$
00110$:
;	floorf.c:38: return (r+((r>x)?-1:0));
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___slong2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fsgt_PARM_2
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
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsgt
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	mov	a,dpl
	jz  00106$
00111$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0xFF
	sjmp 00107$
00106$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
00107$:
	mov	a,r2
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	r4,a
	mov	r5,a
	mov	a,r2
	add	a,r6
	mov	r2,a
	mov	a,r3
	addc	a,r7
	mov	r3,a
	mov	a,r4
	addc	a,r0
	mov	r4,a
	mov	a,r5
	addc	a,r1
	mov	r5,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___slong2fs
	sjmp 00104$
00102$:
;	floorf.c:40: return r;
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___slong2fs
00104$:
	mov	sp,_bpx
	mov	esp,_bpx+1
	pop	_bpx+1
	pop	_bpx
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
