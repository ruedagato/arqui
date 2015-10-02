;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:32 2015
;--------------------------------------------------------
	.module _itoa
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __itoa
	.globl __uitoa
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
;Allocation info for local variables in function '_uitoa'
;------------------------------------------------------------
;string                    Allocated to stack - offset -5
;radix                     Allocated to stack - offset -6
;value                     Allocated to stack - offset 1
;index                     Allocated to registers r2 
;i                         Allocated to stack - offset 3
;tmp                       Allocated to registers 
;sloc0                     Allocated to stack - offset 4
;sloc1                     Allocated to stack - offset 6
;------------------------------------------------------------
;	_itoa.c:40: void _uitoa(unsigned int value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _uitoa
;	-----------------------------------------
__uitoa:
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
	mov	a,sp
	add	a,#0x08
	mov	sp,a
;	_itoa.c:45: do {
	mov	r3,#0x00
00103$:
;	_itoa.c:46: string[index] = '0' + (value % radix);
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	a,r3
	add	a,@r0
	mov	r5,a
	clr	a
	inc	r0
	addc	a,@r0
	mov	r6,a
	inc	r0
	mov	ar7,@r0
	mov	a,_bp
	add	a,#0xfa
	mov	r0,a
	mov	a,_bp
	add	a,#0x04
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r1
	mov	@r1,#0x00
	push	ar3
	push	ar5
	push	ar6
	push	ar7
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	mov	r0,_bp
	inc	r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	lcall	__moduint
	mov	r4,dpl
	mov	r2,dph
	dec	sp
	dec	sp
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar3
	mov	a,#0x30
	add	a,r4
	mov	r4,a
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrput
;	_itoa.c:47: if (string[index] > '9')
	clr	c
	mov	a,#(0x39 ^ 0x80)
	mov	b,r4
	xrl	b,#0x80
	subb	a,b
	jnc	00102$
;	_itoa.c:48: string[index] += 'A' - '9' - 1;
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r2,a
	mov	a,#0x07
	add	a,r2
	mov	r2,a
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrput
00102$:
;	_itoa.c:49: value /= radix;
	push	ar3
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	mov	r0,_bp
	inc	r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	lcall	__divuint
	mov	r0,_bp
	inc	r0
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	dec	sp
	dec	sp
	pop	ar3
;	_itoa.c:50: ++index;
	inc	r3
;	_itoa.c:51: } while (value != 0);
	mov	r0,_bp
	inc	r0
	mov	a,@r0
	inc	r0
	orl	a,@r0
	jz	00119$
	ljmp	00103$
00119$:
;	_itoa.c:54: string[index--] = '\0';
	mov	a,r3
	dec	a
	mov	r2,a
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	a,r3
	add	a,@r0
	mov	r3,a
	clr	a
	inc	r0
	addc	a,@r0
	mov	r4,a
	inc	r0
	mov	ar5,@r0
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	clr	a
	lcall	__gptrput
;	_itoa.c:57: while (index > i) {
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	mov	@r0,#0x00
00106$:
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	clr	c
	mov	a,@r0
	xrl	a,#0x80
	mov	b,r2
	xrl	b,#0x80
	subb	a,b
	jnc	00109$
;	_itoa.c:58: char tmp = string[i];
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	a,_bp
	add	a,#0x03
	mov	r1,a
	mov	a,@r1
	add	a,@r0
	push	acc
	clr	a
	inc	r0
	addc	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	mov	a,_bp
	add	a,#0x08
	mov	r0,a
	pop	acc
	mov	@r0,a
	dec	r0
	pop	acc
	mov	@r0,a
	dec	r0
	pop	acc
	mov	@r0,a
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r6,a
;	_itoa.c:59: string[i] = string[index];
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	a,r2
	add	a,@r0
	mov	r7,a
	clr	a
	inc	r0
	addc	a,@r0
	mov	r3,a
	inc	r0
	mov	ar4,@r0
	mov	dpl,r7
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	mov	a,_bp
	add	a,#0x06
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	mov	a,r5
	lcall	__gptrput
;	_itoa.c:60: string[index] = tmp;
	mov	dpl,r7
	mov	dph,r3
	mov	b,r4
	mov	a,r6
	lcall	__gptrput
;	_itoa.c:61: ++i;
	mov	a,_bp
	add	a,#0x03
	mov	r0,a
	inc	@r0
;	_itoa.c:62: --index;
	dec	r2
	ljmp	00106$
00109$:
	mov	sp,_bp
	pop	_bp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function '_itoa'
;------------------------------------------------------------
;string                    Allocated to stack - offset -5
;radix                     Allocated to stack - offset -6
;value                     Allocated to registers r2 r3 
;------------------------------------------------------------
;	_itoa.c:66: void _itoa(int value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _itoa
;	-----------------------------------------
__itoa:
	push	_bp
	mov	_bp,sp
	mov	r2,dpl
;	_itoa.c:68: if (value < 0 && radix == 10) {
	mov	a,dph
	mov	r3,a
	jnb	acc.7,00102$
	mov	a,_bp
	add	a,#0xfa
	mov	r0,a
	cjne	@r0,#0x0A,00102$
;	_itoa.c:69: *string++ = '-';
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,#0x2D
	lcall	__gptrput
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	a,#0x01
	add	a,r4
	mov	@r0,a
	clr	a
	addc	a,r5
	inc	r0
	mov	@r0,a
	inc	r0
	mov	@r0,ar6
;	_itoa.c:70: value = -value;
	clr	c
	clr	a
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
00102$:
;	_itoa.c:72: _uitoa(value, string, radix);
	mov	a,_bp
	add	a,#0xfa
	mov	r0,a
	mov	a,@r0
	push	acc
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	mov	dpl,r2
	mov	dph,r3
	lcall	__uitoa
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	_bp
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
