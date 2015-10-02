;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module sprintf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _vsprintf
	.globl _sprintf
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
;../sprintf.c:34: put_char_to_string (char c, void* p) _REENTRANT
;	---------------------------------
; Function put_char_to_string
; ---------------------------------
_put_char_to_string:
	push	ix
	ld	ix,#0
	add	ix,sp
;../sprintf.c:36: char **buf = (char **)p;
	ld	c,5 (ix)
	ld	b,6 (ix)
	push	bc
	pop	iy
;../sprintf.c:37: *(*buf)++ = c;
	ld	c,0 (iy)
	ld	b,1 (iy)
	ld	e,c
	ld	d,b
	inc	de
	ld	0 (iy),e
	ld	1 (iy),d
	ld	a,4 (ix)
	ld	(bc),a
	pop	ix
	ret
;../sprintf.c:41: vsprintf (char *buf, const char *format, va_list ap)
;	---------------------------------
; Function vsprintf
; ---------------------------------
_vsprintf_start::
_vsprintf:
	push	ix
	ld	ix,#0
	add	ix,sp
;../sprintf.c:44: i = _print_format (put_char_to_string, &buf, format, ap);
	ld	hl,#0x0004
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	ld	hl,#_put_char_to_string
	push	hl
	call	__print_format
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c,l
	ld	b,h
;../sprintf.c:45: *buf = 0;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	(hl),#0x00
;../sprintf.c:46: return i;
	ld	l,c
	ld	h,b
	pop	ix
	ret
_vsprintf_end::
;../sprintf.c:50: sprintf (char *buf, const char *format, ...)
;	---------------------------------
; Function sprintf
; ---------------------------------
_sprintf_start::
_sprintf:
	push	ix
	ld	ix,#0
	add	ix,sp
;../sprintf.c:55: va_start (arg, format);
	ld	hl,#0x0006+1+1
	add	hl,sp
	ld	c,l
	ld	b,h
;../sprintf.c:56: i = _print_format (put_char_to_string, &buf, format, arg);
	ld	hl,#0x0004
	add	hl,sp
	ex	de,hl
	push	bc
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	de
	ld	hl,#_put_char_to_string
	push	hl
	call	__print_format
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c,l
	ld	b,h
;../sprintf.c:57: *buf = 0;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	(hl),#0x00
;../sprintf.c:60: return i;
	ld	l,c
	ld	h,b
	pop	ix
	ret
_sprintf_end::
	.area _CODE
	.area _CABS
