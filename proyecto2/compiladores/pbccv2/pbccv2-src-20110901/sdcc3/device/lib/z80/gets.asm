;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module gets
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gets
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area _OVERLAY
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;../gets.c:32: gets (char *s)
;	---------------------------------
; Function gets
; ---------------------------------
_gets_start::
_gets:
	push	ix
	ld	ix,#0
	add	ix,sp
;../gets.c:35: unsigned int count = 0;
	ld	bc,#0x0000
;../gets.c:37: while (1)
00109$:
;../gets.c:39: c = getchar ();
	push	bc
	call	_getchar
	pop	bc
	ld	e,l
;../gets.c:40: switch(c)
	ld	a,e
	cp	a,#0x08
	jr	Z,00101$
	cp	a,##0x0A
	jr	Z,00105$
	sub	a,#0x0D
	jr	Z,00105$
	jr	00106$
;../gets.c:42: case '\b': /* backspace */
00101$:
;../gets.c:43: if (count)
	ld	a,c
	or	a,b
	jr	Z,00109$
;../gets.c:45: putchar ('\b');
	push	bc
	ld	a,#0x08
	push	af
	inc	sp
	call	_putchar
	inc	sp
	ld	a,#0x20
	push	af
	inc	sp
	call	_putchar
	inc	sp
	ld	a,#0x08
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
;../gets.c:48: --s;
	ld	l,4 (ix)
	ld	h,5 (ix)
	dec	hl
	ld	4 (ix),l
	ld	5 (ix),h
;../gets.c:49: --count;
	dec	bc
;../gets.c:51: break;
	jr	00109$
;../gets.c:54: case '\r': /* CR or LF */
00105$:
;../gets.c:55: putchar ('\r');
	ld	a,#0x0D
	push	af
	inc	sp
	call	_putchar
	inc	sp
;../gets.c:56: putchar ('\n');
	ld	a,#0x0A
	push	af
	inc	sp
	call	_putchar
	inc	sp
;../gets.c:57: *s = 0;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	(hl),#0x00
;../gets.c:58: return s;
	jr	00111$
;../gets.c:60: default:
00106$:
;../gets.c:61: *s++ = c;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	(hl),e
	ld	a,l
	add	a,#0x01
	ld	4 (ix),a
	ld	a,h
	adc	a,#0x00
	ld	5 (ix),a
;../gets.c:62: ++count;
	inc	bc
;../gets.c:63: putchar (c);
	push	bc
	ld	a,e
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
;../gets.c:65: }
	jp	00109$
00111$:
	pop	ix
	ret
_gets_end::
	.area _CODE
	.area _CABS
