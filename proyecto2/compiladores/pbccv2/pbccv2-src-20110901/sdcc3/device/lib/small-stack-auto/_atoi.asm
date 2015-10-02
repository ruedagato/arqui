;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:31 2015
;--------------------------------------------------------
	.module _atoi
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atoi
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
;Allocation info for local variables in function 'atoi'
;------------------------------------------------------------
;s                         Allocated to stack - offset 1
;rv                        Allocated to registers r5 r6 
;sign                      Allocated to registers r4 
;sloc0                     Allocated to stack - offset 7
;sloc1                     Allocated to stack - offset 4
;------------------------------------------------------------
;	_atoi.c:29: int atoi(const char * s)
;	-----------------------------------------
;	 function atoi
;	-----------------------------------------
_atoi:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	push	_bp
	mov	_bp,sp
	push	dpl
	push	dph
	push	b
	inc	sp
	inc	sp
	inc	sp
;	_atoi.c:31: register int rv=0; 
	mov	r5,#0x00
	mov	r6,#0x00
;	_atoi.c:35: while (*s) {
	mov	r0,_bp
	inc	r0
	mov	ar7,@r0
	inc	r0
	mov	ar2,@r0
	inc	r0
	mov	ar3,@r0
00107$:
	mov	dpl,r7
	mov	dph,r2
	mov	b,r3
	lcall	__gptrget
	mov	r4,a
	jz	00133$
;	_atoi.c:36: if (*s <= '9' && *s >= '0')
	clr	c
	mov	a,#(0x39 ^ 0x80)
	mov	b,r4
	xrl	b,#0x80
	subb	a,b
	jc	00102$
	mov	a,r4
	xrl	a,#0x80
	subb	a,#0xb0
	jnc	00133$
;	_atoi.c:37: break;
00102$:
;	_atoi.c:38: if (*s == '-' || *s == '+') 
	mov	dpl,r7
	mov	dph,r2
	mov	b,r3
	lcall	__gptrget
	mov	r4,a
	cjne	r4,#0x2D,00138$
	sjmp	00133$
00138$:
	cjne	r4,#0x2B,00139$
	sjmp	00133$
00139$:
;	_atoi.c:40: s++;
	inc	r7
	cjne	r7,#0x00,00107$
	inc	r2
	sjmp	00107$
00133$:
	mov	r0,_bp
	inc	r0
	mov	@r0,ar7
	inc	r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
;	_atoi.c:43: sign = (*s == '-');
	mov	dpl,r7
	mov	dph,r2
	mov	b,r3
	lcall	__gptrget
	mov	r2,a
	clr	a
	cjne	r2,#0x2D,00141$
	inc	a
00141$:
;	_atoi.c:44: if (*s == '-' || *s == '+') s++;
	mov	r3,a
	mov	r4,a
	jnz	00110$
	cjne	r2,#0x2B,00131$
00110$:
	mov	r0,_bp
	inc	r0
	inc	@r0
	cjne	@r0,#0x00,00146$
	inc	r0
	inc	@r0
00146$:
;	_atoi.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
	mov	r0,_bp
	inc	r0
	mov	a,_bp
	add	a,#0x04
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
	inc	r0
	inc	r1
	mov	a,@r0
	mov	@r1,a
00115$:
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r3,a
	jz	00117$
	clr	c
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0xb0
	jc	00117$
	mov	a,#(0x39 ^ 0x80)
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	jc	00117$
;	_atoi.c:47: rv = (rv * 10) + (*s - '0');
	push	ar4
	push	ar3
	push	ar5
	push	ar6
	mov	dptr,#0x000A
	lcall	__mulint
	mov	r4,dpl
	mov	r2,dph
	dec	sp
	dec	sp
	pop	ar3
	mov	a,r3
	rlc	a
	subb	a,acc
	mov	r7,a
	mov	a,r3
	add	a,#0xd0
	mov	r3,a
	mov	a,r7
	addc	a,#0xff
	mov	r7,a
	mov	a,r3
	add	a,r4
	mov	r4,a
	mov	a,r7
	addc	a,r2
	mov	r2,a
	mov	ar5,r4
	mov	ar6,r2
;	_atoi.c:48: s++;
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	inc	@r0
	cjne	@r0,#0x00,00150$
	inc	r0
	inc	@r0
00150$:
	pop	ar4
	sjmp	00115$
00117$:
;	_atoi.c:51: return (sign ? -rv : rv);
	mov	a,r4
	jz	00120$
	clr	c
	clr	a
	subb	a,r5
	mov	r2,a
	clr	a
	subb	a,r6
	mov	r3,a
	sjmp	00121$
00120$:
	mov	ar2,r5
	mov	ar3,r6
00121$:
	mov	dpl,r2
	mov	dph,r3
	mov	sp,_bp
	pop	_bp
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
