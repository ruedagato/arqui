;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module gets
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gets
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
	lda	sp,-5(sp)
;../gets.c:35: unsigned int count = 0;
	ldhl	sp,#2
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;../gets.c:37: while (1)
00109$:
;../gets.c:39: c = getchar ();
	call	_getchar
	ld	c,e
	ldhl	sp,#4
	ld	(hl),c
;../gets.c:40: switch(c)
	ld	a,(hl)
	sub	a,#0x08
	jp	Z,00101$
00118$:
	ld	a,(hl)
	sub	a,#0x0A
	jp	Z,00105$
00119$:
	ld	a,(hl)
	sub	a,#0x0D
	jp	Z,00105$
00120$:
	jp	00106$
;../gets.c:42: case '\b': /* backspace */
00101$:
;../gets.c:43: if (count)
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00109$
;../gets.c:45: putchar ('\b');
	ld	a,#0x08
	push	af
	inc	sp
	call	_putchar
	lda	sp,1(sp)
;../gets.c:46: putchar (' ');
	ld	a,#0x20
	push	af
	inc	sp
	call	_putchar
	lda	sp,1(sp)
;../gets.c:47: putchar ('\b');
	ld	a,#0x08
	push	af
	inc	sp
	call	_putchar
	lda	sp,1(sp)
;../gets.c:48: --s;
	ldhl	sp,#8
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../gets.c:49: --count;
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../gets.c:51: break;
	jp	00109$
;../gets.c:54: case '\r': /* CR or LF */
00105$:
;../gets.c:55: putchar ('\r');
	ld	a,#0x0D
	push	af
	inc	sp
	call	_putchar
	lda	sp,1(sp)
;../gets.c:56: putchar ('\n');
	ld	a,#0x0A
	push	af
	inc	sp
	call	_putchar
	lda	sp,1(sp)
;../gets.c:57: *s = 0;
	ldhl	sp,#7
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x00
	ld	(de),a
;../gets.c:58: return s;
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	00111$
;../gets.c:60: default:
00106$:
;../gets.c:61: *s++ = c;
	ldhl	sp,#8
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ldhl	sp,#4
	ld	a,(hl)
	ld	(bc),a
	ld	hl,#0x0001
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#7
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../gets.c:62: ++count;
	ldhl	sp,#2
	inc	(hl)
	jp	NZ,00121$
	inc	hl
	inc	(hl)
00121$:
;../gets.c:63: putchar (c);
	inc	hl
	ld	a,(hl)
	push	af
	inc	sp
	call	_putchar
	lda	sp,1(sp)
;../gets.c:65: }
	jp	00109$
00111$:
	lda	sp,5(sp)
	ret
_gets_end::
	.area _CODE
	.area _CABS
