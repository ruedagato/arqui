;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strcpy
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcpy
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
	
	push	af
	push	af
;../_strcpy.c:39: register char * to = d;
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_strcpy.c:40: register const char * from = s;
	ldhl	sp,#9
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;../_strcpy.c:42: while (*to++ = *from++) ;
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
00101$:
	ld	a,(bc)
	inc	bc
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
	dec	hl
	inc	(hl)
	jp	NZ,00109$
	inc	hl
	inc	(hl)
00109$:
	or	a,a
	jp	NZ,00101$
;../_strcpy.c:44: return d;
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00104$:
	lda	sp,4(sp)
	ret
_strcpy_end::
	.area _CODE
	.area _CABS
