;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
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
_atoi_sloc0_1_0:
	.ds 1
_atoi_sloc1_1_0:
	.ds 2
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
;s                         Allocated to registers r2 r3 r4 
;rv                        Allocated to registers r5 r6 
;sign                      Allocated to registers r1 
;sloc0                     Allocated with name '_atoi_sloc0_1_0'
;sloc1                     Allocated with name '_atoi_sloc1_1_0'
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
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	_atoi.c:31: register int rv=0; 
	mov	r5,#0x00
	mov	r6,#0x00
;	_atoi.c:35: while (*s) {
	mov	ar7,r2
	mov	ar0,r3
	mov	ar1,r4
00107$:
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	_atoi_sloc0_1_0,a
	jz	00133$
;	_atoi.c:36: if (*s <= '9' && *s >= '0')
	clr	c
	mov	a,#(0x39 ^ 0x80)
	mov	b,_atoi_sloc0_1_0
	xrl	b,#0x80
	subb	a,b
	jc	00102$
	mov	a,_atoi_sloc0_1_0
	xrl	a,#0x80
	subb	a,#0xb0
	jnc	00133$
;	_atoi.c:37: break;
00102$:
;	_atoi.c:38: if (*s == '-' || *s == '+') 
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	_atoi_sloc0_1_0,a
	mov	a,#0x2D
	cjne	a,_atoi_sloc0_1_0,00138$
	sjmp	00133$
00138$:
	mov	a,#0x2B
	cjne	a,_atoi_sloc0_1_0,00139$
	sjmp	00133$
00139$:
;	_atoi.c:40: s++;
	inc	r7
	cjne	r7,#0x00,00107$
	inc	r0
	sjmp	00107$
00133$:
	mov	ar2,r7
	mov	ar3,r0
	mov	ar4,r1
;	_atoi.c:43: sign = (*s == '-');
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	clr	a
	cjne	r7,#0x2D,00141$
	inc	a
00141$:
;	_atoi.c:44: if (*s == '-' || *s == '+') s++;
	mov	r0,a
	mov	r1,a
	jnz	00110$
	cjne	r7,#0x2B,00131$
00110$:
	inc	r2
	cjne	r2,#0x00,00146$
	inc	r3
00146$:
;	_atoi.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
00115$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r7,a
	jz	00117$
	clr	c
	mov	a,r7
	xrl	a,#0x80
	subb	a,#0xb0
	jc	00117$
	mov	a,#(0x39 ^ 0x80)
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
	jc	00117$
;	_atoi.c:47: rv = (rv * 10) + (*s - '0');
	push	ar1
	mov	__mulint_PARM_2,r5
	mov	(__mulint_PARM_2 + 1),r6
	mov	dptr,#0x000A
	push	ar2
	push	ar3
	push	ar4
	push	ar7
	push	ar1
	lcall	__mulint
	mov	_atoi_sloc1_1_0,dpl
	mov	(_atoi_sloc1_1_0 + 1),dph
	pop	ar1
	pop	ar7
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r7
	rlc	a
	subb	a,acc
	mov	r0,a
	mov	a,r7
	add	a,#0xd0
	mov	r7,a
	mov	a,r0
	addc	a,#0xff
	mov	r0,a
	mov	a,r7
	add	a,_atoi_sloc1_1_0
	mov	r5,a
	mov	a,r0
	addc	a,(_atoi_sloc1_1_0 + 1)
	mov	r6,a
;	_atoi.c:48: s++;
	inc	r2
	cjne	r2,#0x00,00150$
	inc	r3
00150$:
	pop	ar1
	sjmp	00115$
00117$:
;	_atoi.c:51: return (sign ? -rv : rv);
	mov	a,r1
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
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
