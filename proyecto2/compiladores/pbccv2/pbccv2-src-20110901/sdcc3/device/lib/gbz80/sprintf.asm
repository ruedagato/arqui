;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module sprintf
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _vsprintf
	.globl _sprintf
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
;../sprintf.c:34: put_char_to_string (char c, void* p) _REENTRANT
;	---------------------------------
; Function put_char_to_string
; ---------------------------------
_put_char_to_string:
	
	push	af
;../sprintf.c:36: char **buf = (char **)p;
;../sprintf.c:37: *(*buf)++ = c;
	ldhl	sp,#6
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#0
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	ldhl	sp,#6
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	ld	a,(hl)
	ld	(de),a
00101$:
	lda	sp,2(sp)
	ret
;../sprintf.c:41: vsprintf (char *buf, const char *format, va_list ap)
;	---------------------------------
; Function vsprintf
; ---------------------------------
_vsprintf_start::
_vsprintf:
	
	push	af
;../sprintf.c:44: i = _print_format (put_char_to_string, &buf, format, ap);
	ldhl	sp,#4
	ld	c,l
	ld	b,h
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	ld	hl,#_put_char_to_string
	push	hl
	call	__print_format
	lda	sp,8(sp)
	ld	b,d
	ld	c,e
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../sprintf.c:45: *buf = 0;
	ldhl	sp,#5
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x00
	ld	(bc),a
;../sprintf.c:46: return i;
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00101$:
	lda	sp,2(sp)
	ret
_vsprintf_end::
;../sprintf.c:50: sprintf (char *buf, const char *format, ...)
;	---------------------------------
; Function sprintf
; ---------------------------------
_sprintf_start::
_sprintf:
	
	push	af
	push	af
;../sprintf.c:55: va_start (arg, format);
	ldhl	sp,#8
	ld	c,l
	ld	b,h
	ld	hl,#0x0002
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../sprintf.c:56: i = _print_format (put_char_to_string, &buf, format, arg);
	ldhl	sp,#6
	ld	c,l
	ld	b,h
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	ld	hl,#_put_char_to_string
	push	hl
	call	__print_format
	lda	sp,8(sp)
	ld	b,d
	ld	c,e
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../sprintf.c:57: *buf = 0;
	ldhl	sp,#7
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x00
	ld	(bc),a
;../sprintf.c:60: return i;
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00101$:
	lda	sp,4(sp)
	ret
_sprintf_end::
	.area _CODE
	.area _CABS
