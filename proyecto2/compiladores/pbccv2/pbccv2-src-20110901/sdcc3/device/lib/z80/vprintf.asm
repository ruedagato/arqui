;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module vprintf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _vprintf
	.globl _printf
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
;../vprintf.c:34: put_char_to_stdout (char c, void* p) _REENTRANT
;	---------------------------------
; Function put_char_to_stdout
; ---------------------------------
_put_char_to_stdout:
	push	ix
	ld	ix,#0
	add	ix,sp
;../vprintf.c:37: putchar (c);
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	ix
	ret
;../vprintf.c:41: vprintf (const char *format, va_list ap)
;	---------------------------------
; Function vprintf
; ---------------------------------
_vprintf_start::
_vprintf:
	push	ix
	ld	ix,#0
	add	ix,sp
;../vprintf.c:43: return _print_format (put_char_to_stdout, NULL, format, ap);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	hl,#_put_char_to_stdout
	push	hl
	call	__print_format
	pop	af
	pop	af
	pop	af
	pop	af
	pop	ix
	ret
_vprintf_end::
;../vprintf.c:47: printf (const char *format, ...)
;	---------------------------------
; Function printf
; ---------------------------------
_printf_start::
_printf:
	push	ix
	ld	ix,#0
	add	ix,sp
;../vprintf.c:52: va_start (arg, format);
	ld	hl,#0x0004+1+1
	add	hl,sp
;../vprintf.c:53: i = _print_format (put_char_to_stdout, NULL, format, arg);
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	hl,#_put_char_to_stdout
	push	hl
	call	__print_format
	pop	af
	pop	af
	pop	af
	pop	af
;../vprintf.c:56: return i;
	pop	ix
	ret
_printf_end::
	.area _CODE
	.area _CABS
