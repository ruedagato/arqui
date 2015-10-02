;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:32 2015
;--------------------------------------------------------
	.module gets
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gets
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
;Allocation info for local variables in function 'gets'
;------------------------------------------------------------
;s                         Allocated to registers r2 r3 r4 
;c                         Allocated to registers r7 
;count                     Allocated to registers r5 r6 
;------------------------------------------------------------
;	gets.c:32: gets (char *s)
;	-----------------------------------------
;	 function gets
;	-----------------------------------------
_gets:
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
;	gets.c:35: unsigned int count = 0;
	mov	r5,#0x00
	mov	r6,#0x00
;	gets.c:37: while (1)
00109$:
;	gets.c:39: c = getchar ();
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_getchar
	mov	r7,dpl
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	gets.c:40: switch(c)
	cjne	r7,#0x08,00118$
	sjmp	00101$
00118$:
	cjne	r7,#0x0A,00119$
	sjmp	00105$
00119$:
;	gets.c:42: case '\b': /* backspace */
	cjne	r7,#0x0D,00106$
	sjmp	00105$
00101$:
;	gets.c:43: if (count)
	mov	a,r5
	orl	a,r6
	jz	00109$
;	gets.c:45: putchar ('\b');
	mov	dpl,#0x08
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_putchar
;	gets.c:46: putchar (' ');
	mov	dpl,#0x20
	lcall	_putchar
;	gets.c:47: putchar ('\b');
	mov	dpl,#0x08
	lcall	_putchar
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	gets.c:48: --s;
	dec	r2
	cjne	r2,#0xff,00122$
	dec	r3
00122$:
;	gets.c:49: --count;
	dec	r5
	cjne	r5,#0xff,00123$
	dec	r6
00123$:
;	gets.c:51: break;
;	gets.c:54: case '\r': /* CR or LF */
	sjmp	00109$
00105$:
;	gets.c:55: putchar ('\r');
	mov	dpl,#0x0D
	push	ar2
	push	ar3
	push	ar4
	lcall	_putchar
;	gets.c:56: putchar ('\n');
	mov	dpl,#0x0A
	lcall	_putchar
	pop	ar4
	pop	ar3
	pop	ar2
;	gets.c:57: *s = 0;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
;	gets.c:58: return s;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
;	gets.c:60: default:
	ret
00106$:
;	gets.c:61: *s++ = c;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r7
	lcall	__gptrput
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
;	gets.c:62: ++count;
	inc	r5
	cjne	r5,#0x00,00124$
	inc	r6
00124$:
;	gets.c:63: putchar (c);
	mov	dpl,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_putchar
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	gets.c:65: }
	ljmp	00109$
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
