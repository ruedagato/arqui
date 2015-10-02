;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:29 2015
;--------------------------------------------------------
	.module gets
	.optsdcc -mmcs51 --model-large
	
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
_gets_s_1_1:
	.ds 3
_gets_count_1_1:
	.ds 2
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
;s                         Allocated with name '_gets_s_1_1'
;c                         Allocated with name '_gets_c_1_1'
;count                     Allocated with name '_gets_count_1_1'
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
	mov	r2,b
	mov	r3,dph
	mov	a,dpl
	mov	dptr,#_gets_s_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
;	gets.c:35: unsigned int count = 0;
	mov	dptr,#_gets_count_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	gets.c:37: while (1)
00109$:
;	gets.c:39: c = getchar ();
	lcall	_getchar
	mov	r2,dpl
;	gets.c:40: switch(c)
	cjne	r2,#0x08,00118$
	sjmp	00101$
00118$:
	cjne	r2,#0x0A,00119$
	sjmp	00105$
00119$:
;	gets.c:42: case '\b': /* backspace */
	cjne	r2,#0x0D,00106$
	sjmp	00105$
00101$:
;	gets.c:43: if (count)
	mov	dptr,#_gets_count_1_1
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	orl	a,r3
	jz	00109$
;	gets.c:45: putchar ('\b');
	mov	dpl,#0x08
	push	ar3
	push	ar4
	lcall	_putchar
;	gets.c:46: putchar (' ');
	mov	dpl,#0x20
	lcall	_putchar
;	gets.c:47: putchar ('\b');
	mov	dpl,#0x08
	lcall	_putchar
	pop	ar4
	pop	ar3
;	gets.c:48: --s;
	mov	dptr,#_gets_s_1_1
	movx	a,@dptr
	add	a,#0xff
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xff
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dptr,#_gets_s_1_1
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	gets.c:49: --count;
	dec	r3
	cjne	r3,#0xff,00122$
	dec	r4
00122$:
	mov	dptr,#_gets_count_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;	gets.c:51: break;
;	gets.c:54: case '\r': /* CR or LF */
	sjmp	00109$
00105$:
;	gets.c:55: putchar ('\r');
	mov	dpl,#0x0D
	lcall	_putchar
;	gets.c:56: putchar ('\n');
	mov	dpl,#0x0A
	lcall	_putchar
;	gets.c:57: *s = 0;
	mov	dptr,#_gets_s_1_1
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	clr	a
	lcall	__gptrput
;	gets.c:58: return s;
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
;	gets.c:60: default:
	ret
00106$:
;	gets.c:61: *s++ = c;
	mov	dptr,#_gets_s_1_1
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	mov	a,r2
	lcall	__gptrput
	mov	dptr,#_gets_s_1_1
	mov	a,#0x01
	add	a,r3
	movx	@dptr,a
	clr	a
	addc	a,r4
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	gets.c:62: ++count;
	mov	dptr,#_gets_count_1_1
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
;	gets.c:63: putchar (c);
	mov	dpl,r2
	lcall	_putchar
;	gets.c:65: }
	ljmp	00109$
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
