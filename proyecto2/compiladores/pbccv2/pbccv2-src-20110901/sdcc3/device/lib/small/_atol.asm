;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module _atol
	.optsdcc -mmcs51 --model-small
	
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
_atol_s_1_1:
	.ds 3
_atol_sloc0_1_0:
	.ds 1
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
;s                         Allocated with name '_atol_s_1_1'
;rv                        Allocated to registers r5 r6 r7 r0 
;sign                      Allocated to registers r4 
;sloc0                     Allocated with name '_atol_sloc0_1_0'
;sloc1                     Allocated with name '_atol_sloc1_1_0'
;sloc2                     Allocated with name '_atol_sloc2_1_0'
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
	mov	_atol_s_1_1,dpl
	mov	(_atol_s_1_1 + 1),dph
	mov	(_atol_s_1_1 + 2),b
;	_atol.c:31: register long rv=0; 
	mov	r5,#0x00
	mov	r6,#0x00
	mov	r7,#0x00
	mov	r0,#0x00
;	_atol.c:35: while (*s) {
	mov	r1,_atol_s_1_1
	mov	r2,(_atol_s_1_1 + 1)
	mov	r3,(_atol_s_1_1 + 2)
00107$:
	mov	dpl,r1
	mov	dph,r2
	mov	b,r3
	lcall	__gptrget
	mov	r4,a
	jz	00133$
;	_atol.c:36: if (*s <= '9' && *s >= '0')
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
;	_atol.c:37: break;
00102$:
;	_atol.c:38: if (*s == '-' || *s == '+') 
	mov	dpl,r1
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
;	_atol.c:40: s++;
	inc	r1
	cjne	r1,#0x00,00107$
	inc	r2
	sjmp	00107$
00133$:
	mov	_atol_s_1_1,r1
	mov	(_atol_s_1_1 + 1),r2
	mov	(_atol_s_1_1 + 2),r3
;	_atol.c:43: sign = (*s == '-');
	mov	dpl,r1
	mov	dph,r2
	mov	b,r3
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
	inc	_atol_s_1_1
	clr	a
	cjne	a,_atol_s_1_1,00146$
	inc	(_atol_s_1_1 + 1)
00146$:
;	_atol.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
	mov	_atol_sloc1_1_0,_atol_s_1_1
	mov	(_atol_sloc1_1_0 + 1),(_atol_s_1_1 + 1)
	mov	(_atol_sloc1_1_0 + 2),(_atol_s_1_1 + 2)
00115$:
	mov	dpl,_atol_sloc1_1_0
	mov	dph,(_atol_sloc1_1_0 + 1)
	mov	b,(_atol_sloc1_1_0 + 2)
	lcall	__gptrget
	mov	_atol_sloc0_1_0,a
	jz	00117$
	clr	c
	mov	a,_atol_sloc0_1_0
	xrl	a,#0x80
	subb	a,#0xb0
	jc	00117$
	mov	a,#(0x39 ^ 0x80)
	mov	b,_atol_sloc0_1_0
	xrl	b,#0x80
	subb	a,b
	jc	00117$
;	_atol.c:47: rv = (rv * 10) + (*s - '0');
	push	ar4
	mov	__mullong_PARM_2,r5
	mov	(__mullong_PARM_2 + 1),r6
	mov	(__mullong_PARM_2 + 2),r7
	mov	(__mullong_PARM_2 + 3),r0
	mov	dptr,#(0x0A&0x00ff)
	clr	a
	mov	b,a
	push	ar4
	lcall	__mullong
	mov	_atol_sloc2_1_0,dpl
	mov	(_atol_sloc2_1_0 + 1),dph
	mov	(_atol_sloc2_1_0 + 2),b
	mov	(_atol_sloc2_1_0 + 3),a
	pop	ar4
	mov	a,_atol_sloc0_1_0
	mov	r2,a
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	a,r2
	add	a,#0xd0
	mov	r2,a
	mov	a,r3
	addc	a,#0xff
	mov	r3,a
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r1,a
	mov	a,r2
	add	a,_atol_sloc2_1_0
	mov	r5,a
	mov	a,r3
	addc	a,(_atol_sloc2_1_0 + 1)
	mov	r6,a
	mov	a,r4
	addc	a,(_atol_sloc2_1_0 + 2)
	mov	r7,a
	mov	a,r1
	addc	a,(_atol_sloc2_1_0 + 3)
	mov	r0,a
;	_atol.c:48: s++;
	inc	_atol_sloc1_1_0
	clr	a
	cjne	a,_atol_sloc1_1_0,00150$
	inc	(_atol_sloc1_1_0 + 1)
00150$:
	pop	ar4
	ljmp	00115$
00117$:
;	_atol.c:51: return (sign ? -rv : rv);
	mov	a,r4
	jz	00120$
	clr	c
	clr	a
	subb	a,r5
	mov	r2,a
	clr	a
	subb	a,r6
	mov	r3,a
	clr	a
	subb	a,r7
	mov	r4,a
	clr	a
	subb	a,r0
	mov	r1,a
	sjmp	00121$
00120$:
	mov	ar2,r5
	mov	ar3,r6
	mov	ar4,r7
	mov	ar1,r0
00121$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r1
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
