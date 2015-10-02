;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _strcpy
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcpy
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
;../_strcpy.c:34: char * strcpy (
;	---------------------------------
; Function strcpy
; ---------------------------------
_strcpy_start::
_strcpy:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_strcpy.c:39: register char * to = d;
	ld	l,4 (ix)
	ld	h,5 (ix)
;../_strcpy.c:40: register const char * from = s;
	ld	c,6 (ix)
	ld	b,7 (ix)
;../_strcpy.c:42: while (*to++ = *from++) ;
	ex	de,hl
00101$:
	ld	a,(bc)
	inc	bc
	ld	(de),a
	inc	de
	or	a,a
	jr	NZ,00101$
;../_strcpy.c:44: return d;
	ld	l,4 (ix)
	ld	h,5 (ix)
	pop	ix
	ret
_strcpy_end::
	.area _CODE
	.area _CABS
