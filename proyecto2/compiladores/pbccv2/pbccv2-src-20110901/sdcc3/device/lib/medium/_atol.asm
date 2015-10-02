;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:25 2015
;--------------------------------------------------------
	.module _atol
	.optsdcc -mmcs51 --model-medium
	
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
_atol_rv_1_1:
	.ds 4
_atol_sloc0_1_0:
	.ds 3
_atol_sloc1_1_0:
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
;rv                        Allocated with name '_atol_rv_1_1'
;sign                      Allocated to registers r4 
;sloc0                     Allocated with name '_atol_sloc0_1_0'
;sloc1                     Allocated with name '_atol_sloc1_1_0'
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
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
;	_atol.c:31: register long rv=0; 
	clr	a
	mov	_atol_rv_1_1,a
	mov	(_atol_rv_1_1 + 1),a
	mov	(_atol_rv_1_1 + 2),a
	mov	(_atol_rv_1_1 + 3),a
;	_atol.c:35: while (*s) {
	mov	ar3,r5
	mov	ar4,r6
	mov	ar2,r7
00107$:
	mov	dpl,r3
	mov	dph,r4
	mov	b,r2
	lcall	__gptrget
	mov	r5,a
	jz	00133$
;	_atol.c:36: if (*s <= '9' && *s >= '0')
	clr	c
	mov	a,#(0x39 ^ 0x80)
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jc	00102$
	mov	a,r5
	xrl	a,#0x80
	subb	a,#0xb0
	jnc	00133$
;	_atol.c:37: break;
00102$:
;	_atol.c:38: if (*s == '-' || *s == '+') 
	mov	dpl,r3
	mov	dph,r4
	mov	b,r2
	lcall	__gptrget
	mov	r5,a
	cjne	r5,#0x2D,00138$
	sjmp	00133$
00138$:
	cjne	r5,#0x2B,00139$
	sjmp	00133$
00139$:
;	_atol.c:40: s++;
	inc	r3
	cjne	r3,#0x00,00107$
	inc	r4
	sjmp	00107$
00133$:
	mov	ar5,r3
	mov	ar6,r4
	mov	ar7,r2
;	_atol.c:43: sign = (*s == '-');
	mov	dpl,r3
	mov	dph,r4
	mov	b,r2
	lcall	__gptrget
	mov	r2,a
	clr	a
	cjne	r2,#0x2D,00141$
	inc	a
00141$:
;	_atol.c:44: if (*s == '-' || *s == '+') s++;
	mov	r3,a
	mov	r4,a
	jnz	00110$
	cjne	r2,#0x2B,00131$
00110$:
	inc	r5
	cjne	r5,#0x00,00146$
	inc	r6
00146$:
;	_atol.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
	mov	_atol_sloc0_1_0,r5
	mov	(_atol_sloc0_1_0 + 1),r6
	mov	(_atol_sloc0_1_0 + 2),r7
00115$:
	mov	dpl,_atol_sloc0_1_0
	mov	dph,(_atol_sloc0_1_0 + 1)
	mov	b,(_atol_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	r6,a
	jnz	00147$
	ljmp	00117$
00147$:
	clr	c
	mov	a,r6
	xrl	a,#0x80
	subb	a,#0xb0
	jc	00117$
	mov	a,#(0x39 ^ 0x80)
	mov	b,r6
	xrl	b,#0x80
	subb	a,b
	jc	00117$
;	_atol.c:47: rv = (rv * 10) + (*s - '0');
	push	ar4
	mov	r0,#__mullong_PARM_2
	mov	a,_atol_rv_1_1
	movx	@r0,a
	inc	r0
	mov	a,(_atol_rv_1_1 + 1)
	movx	@r0,a
	inc	r0
	mov	a,(_atol_rv_1_1 + 2)
	movx	@r0,a
	inc	r0
	mov	a,(_atol_rv_1_1 + 3)
	movx	@r0,a
	mov	dptr,#(0x0A&0x00ff)
	clr	a
	mov	b,a
	push	ar4
	push	ar6
	lcall	__mullong
	mov	_atol_sloc1_1_0,dpl
	mov	(_atol_sloc1_1_0 + 1),dph
	mov	(_atol_sloc1_1_0 + 2),b
	mov	(_atol_sloc1_1_0 + 3),a
	pop	ar6
	pop	ar4
	mov	a,r6
	rlc	a
	subb	a,acc
	mov	r5,a
	mov	a,r6
	add	a,#0xd0
	mov	r6,a
	mov	a,r5
	addc	a,#0xff
	mov	r5,a
	rlc	a
	subb	a,acc
	mov	r2,a
	mov	r3,a
	mov	a,r6
	add	a,_atol_sloc1_1_0
	mov	_atol_rv_1_1,a
	mov	a,r5
	addc	a,(_atol_sloc1_1_0 + 1)
	mov	(_atol_rv_1_1 + 1),a
	mov	a,r2
	addc	a,(_atol_sloc1_1_0 + 2)
	mov	(_atol_rv_1_1 + 2),a
	mov	a,r3
	addc	a,(_atol_sloc1_1_0 + 3)
	mov	(_atol_rv_1_1 + 3),a
;	_atol.c:48: s++;
	inc	_atol_sloc0_1_0
	clr	a
	cjne	a,_atol_sloc0_1_0,00150$
	inc	(_atol_sloc0_1_0 + 1)
00150$:
	pop	ar4
	ljmp	00115$
00117$:
;	_atol.c:51: return (sign ? -rv : rv);
	mov	a,r4
	jz	00120$
	clr	c
	clr	a
	subb	a,_atol_rv_1_1
	mov	r2,a
	clr	a
	subb	a,(_atol_rv_1_1 + 1)
	mov	r3,a
	clr	a
	subb	a,(_atol_rv_1_1 + 2)
	mov	r4,a
	clr	a
	subb	a,(_atol_rv_1_1 + 3)
	mov	r5,a
	sjmp	00121$
00120$:
	mov	r2,_atol_rv_1_1
	mov	r3,(_atol_rv_1_1 + 1)
	mov	r4,(_atol_rv_1_1 + 2)
	mov	r5,(_atol_rv_1_1 + 3)
00121$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
