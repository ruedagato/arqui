;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:28 2015
;--------------------------------------------------------
	.module _atol
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atol
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
_atol_sloc0_1_0:
	.ds 3
_atol_sloc1_1_0:
	.ds 3
_atol_sloc2_1_0:
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
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_atol_s_1_1:
	.ds 3
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
;Allocation info for local variables in function 'atol'
;------------------------------------------------------------
;rv                        Allocated to registers r2 r3 r4 r5 
;sign                      Allocated to registers r0 
;sloc0                     Allocated with name '_atol_sloc0_1_0'
;sloc1                     Allocated with name '_atol_sloc1_1_0'
;sloc2                     Allocated with name '_atol_sloc2_1_0'
;s                         Allocated with name '_atol_s_1_1'
;------------------------------------------------------------
;	_atol.c:29: long atol(char * s)
;	-----------------------------------------
;	 function atol
;	-----------------------------------------
_atol:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,b
	mov	r3,dph
	mov	a,dpl
	mov	dptr,#_atol_s_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
;	_atol.c:31: register long rv=0; 
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x00
;	_atol.c:35: while (*s) {
	mov	dptr,#_atol_s_1_1
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
00107$:
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	lcall	__gptrget
	mov	r1,a
	jz	00133$
;	_atol.c:36: if (*s <= '9' && *s >= '0')
	clr	c
	mov	a,#(0x39 ^ 0x80)
	mov	b,r1
	xrl	b,#0x80
	subb	a,b
	jc	00102$
	mov	a,r1
	xrl	a,#0x80
	subb	a,#0xb0
	jnc	00133$
;	_atol.c:37: break;
00102$:
;	_atol.c:38: if (*s == '-' || *s == '+') 
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	lcall	__gptrget
	mov	r1,a
	cjne	r1,#0x2D,00138$
	sjmp	00133$
00138$:
	cjne	r1,#0x2B,00139$
	sjmp	00133$
00139$:
;	_atol.c:40: s++;
	inc	r6
	cjne	r6,#0x00,00140$
	inc	r7
00140$:
	mov	dptr,#_atol_s_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	sjmp	00107$
00133$:
	mov	dptr,#_atol_s_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
;	_atol.c:43: sign = (*s == '-');
	mov	_atol_sloc0_1_0,r6
	mov	(_atol_sloc0_1_0 + 1),r7
	mov	(_atol_sloc0_1_0 + 2),r0
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	lcall	__gptrget
	mov	r6,a
	clr	a
	cjne	r6,#0x2D,00141$
	inc	a
00141$:
;	_atol.c:44: if (*s == '-' || *s == '+') s++;
	mov	r7,a
	mov	r0,a
	jnz	00110$
	cjne	r6,#0x2B,00131$
00110$:
	mov	dptr,#_atol_s_1_1
	mov	a,#0x01
	add	a,_atol_sloc0_1_0
	movx	@dptr,a
	clr	a
	addc	a,(_atol_sloc0_1_0 + 1)
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,(_atol_sloc0_1_0 + 2)
	movx	@dptr,a
;	_atol.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
	mov	dptr,#_atol_s_1_1
	movx	a,@dptr
	mov	_atol_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_atol_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_atol_sloc1_1_0 + 2),a
00115$:
	mov	dpl,_atol_sloc1_1_0
	mov	dph,(_atol_sloc1_1_0 + 1)
	mov	b,(_atol_sloc1_1_0 + 2)
	lcall	__gptrget
	mov	_atol_sloc0_1_0,a
	jnz	00146$
	ljmp	00134$
00146$:
	clr	c
	mov	a,_atol_sloc0_1_0
	xrl	a,#0x80
	subb	a,#0xb0
	jnc	00147$
	ljmp	00134$
00147$:
	clr	c
	mov	a,#(0x39 ^ 0x80)
	mov	b,_atol_sloc0_1_0
	xrl	b,#0x80
	subb	a,b
	jc	00134$
;	_atol.c:47: rv = (rv * 10) + (*s - '0');
	push	ar0
	mov	dptr,#__mullong_PARM_2
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
	mov	dptr,#(0x0A&0x00ff)
	clr	a
	mov	b,a
	push	ar0
	lcall	__mullong
	mov	_atol_sloc2_1_0,dpl
	mov	(_atol_sloc2_1_0 + 1),dph
	mov	(_atol_sloc2_1_0 + 2),b
	mov	(_atol_sloc2_1_0 + 3),a
	pop	ar0
	mov	a,_atol_sloc0_1_0
	mov	r6,a
	rlc	a
	subb	a,acc
	mov	r7,a
	mov	a,r6
	add	a,#0xd0
	mov	r6,a
	mov	a,r7
	addc	a,#0xff
	mov	r7,a
	rlc	a
	subb	a,acc
	mov	r0,a
	mov	r1,a
	mov	a,r6
	add	a,_atol_sloc2_1_0
	mov	r2,a
	mov	a,r7
	addc	a,(_atol_sloc2_1_0 + 1)
	mov	r3,a
	mov	a,r0
	addc	a,(_atol_sloc2_1_0 + 2)
	mov	r4,a
	mov	a,r1
	addc	a,(_atol_sloc2_1_0 + 3)
	mov	r5,a
;	_atol.c:48: s++;
	inc	_atol_sloc1_1_0
	clr	a
	cjne	a,_atol_sloc1_1_0,00149$
	inc	(_atol_sloc1_1_0 + 1)
00149$:
	mov	dptr,#_atol_s_1_1
	mov	a,_atol_sloc1_1_0
	movx	@dptr,a
	inc	dptr
	mov	a,(_atol_sloc1_1_0 + 1)
	movx	@dptr,a
	inc	dptr
	mov	a,(_atol_sloc1_1_0 + 2)
	movx	@dptr,a
	pop	ar0
	ljmp	00115$
00134$:
	mov	dptr,#_atol_s_1_1
	mov	a,_atol_sloc1_1_0
	movx	@dptr,a
	inc	dptr
	mov	a,(_atol_sloc1_1_0 + 1)
	movx	@dptr,a
	inc	dptr
	mov	a,(_atol_sloc1_1_0 + 2)
	movx	@dptr,a
;	_atol.c:51: return (sign ? -rv : rv);
	mov	a,r0
	jz	00120$
	clr	c
	clr	a
	subb	a,r2
	mov	r6,a
	clr	a
	subb	a,r3
	mov	r7,a
	clr	a
	subb	a,r4
	mov	r0,a
	clr	a
	subb	a,r5
	mov	r1,a
	sjmp	00121$
00120$:
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
00121$:
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
