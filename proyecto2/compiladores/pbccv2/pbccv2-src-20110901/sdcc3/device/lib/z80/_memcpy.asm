;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _memcpy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcpy
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
;../_memcpy.c:36: void * memcpy (
;	---------------------------------
; Function memcpy
; ---------------------------------
_memcpy_start::
_memcpy:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;../_memcpy.c:42: void * ret = dst;
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
;../_memcpy.c:44: char * s = src;
	ld	l,6 (ix)
	ld	h,7 (ix)
;../_memcpy.c:49: while (acount--) {
	ld	-4 (ix),l
	ld	-3 (ix),h
	ld	c,-2 (ix)
	ld	b,-1 (ix)
	ld	e,8 (ix)
	ld	d,9 (ix)
00101$:
	ld	l,e
	ld	h,d
	dec	de
	ld	a,l
	or	a,h
	jr	Z,00103$
;../_memcpy.c:50: *d++ = *s++;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	inc	-4 (ix)
	jr	NZ,00109$
	inc	-3 (ix)
00109$:
	ld	(bc),a
	inc	bc
	jr	00101$
00103$:
;../_memcpy.c:53: return(ret);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	sp,ix
	pop	ix
	ret
_memcpy_end::
	.area _CODE
	.area _CABS
