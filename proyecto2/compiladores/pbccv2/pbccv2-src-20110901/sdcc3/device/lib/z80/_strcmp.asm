;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _strcmp
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcmp
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
;../_strcmp.c:34: int strcmp (
;	---------------------------------
; Function strcmp
; ---------------------------------
_strcmp_start::
_strcmp:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;../_strcmp.c:43: const char * src = asrc;
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
;../_strcmp.c:44: const char * dst = adst;
	ld	a,6 (ix)
	ld	-4 (ix),a
	ld	a,7 (ix)
	ld	-3 (ix),a
;../_strcmp.c:46: while( ! (*src - *dst) && *dst)
00102$:
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a, (hl)
	ld	e,a
	rla	
	sbc	a,a
	ld	d,a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	l,(hl)
	ld	a,l
	ld	c,a
	rla	
	sbc	a,a
	ld	b,a
	ld	a,e
	sub	a,c
	ld	e,a
	ld	a,d
	sbc	a,b
	or	a,e
	jr	NZ,00104$
	or	a,l
	jr	Z,00104$
;../_strcmp.c:47: ++src, ++dst;
	inc	-2 (ix)
	jr	NZ,00110$
	inc	-1 (ix)
00110$:
	inc	-4 (ix)
	jr	NZ,00102$
	inc	-3 (ix)
	jr	00102$
00104$:
;../_strcmp.c:49: return *src - *dst;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a, (hl)
	ld	c,a
	rla	
	sbc	a,a
	ld	b,a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	l,(hl)
	ld	a,l
	rla	
	sbc	a,a
	ld	h,a
	ld	a,c
	sub	a,l
	ld	l,a
	ld	a,b
	sbc	a,h
	ld	h,a
	ld	sp,ix
	pop	ix
	ret
_strcmp_end::
	.area _CODE
	.area _CABS
