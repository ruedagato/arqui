;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module vprintf
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _vprintf
	.globl _printf
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
;../vprintf.c:34: put_char_to_stdout (char c, void* p) _REENTRANT
;	---------------------------------
; Function put_char_to_stdout
; ---------------------------------
_put_char_to_stdout:
	
;../vprintf.c:37: putchar (c);
	ldhl	sp,#2
	ld	a,(hl)
	push	af
	inc	sp
	call	_putchar
	lda	sp,1(sp)
00101$:
	
	ret
;../vprintf.c:41: vprintf (const char *format, va_list ap)
;	---------------------------------
; Function vprintf
; ---------------------------------
_vprintf_start::
_vprintf:
	
;../vprintf.c:43: return _print_format (put_char_to_stdout, NULL, format, ap);
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	hl,#_put_char_to_stdout
	push	hl
	call	__print_format
	lda	sp,8(sp)
	ld	b,d
	ld	c,e
	ld	e,c
	ld	d,b
00101$:
	
	ret
_vprintf_end::
;../vprintf.c:47: printf (const char *format, ...)
;	---------------------------------
; Function printf
; ---------------------------------
_printf_start::
_printf:
	
;../vprintf.c:52: va_start (arg, format);
	ldhl	sp,#2
	ld	c,l
	ld	b,h
	inc	bc
	inc	bc
;../vprintf.c:53: i = _print_format (put_char_to_stdout, NULL, format, arg);
	push	bc
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	hl,#_put_char_to_stdout
	push	hl
	call	__print_format
	lda	sp,8(sp)
	ld	b,d
	ld	c,e
;../vprintf.c:56: return i;
	ld	e,c
	ld	d,b
00101$:
	
	ret
_printf_end::
	.area _CODE
	.area _CABS
