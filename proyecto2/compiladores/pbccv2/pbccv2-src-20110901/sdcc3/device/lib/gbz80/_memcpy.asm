;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _memcpy
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcpy
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
	lda	sp,-8(sp)
;../_memcpy.c:42: void * ret = dst;
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_memcpy.c:44: char * s = src;
	ldhl	sp,#13
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;../_memcpy.c:49: while (acount--) {
	ldhl	sp,#2
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#14
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
00101$:
	ldhl	sp,#1
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ld	a,c
	or	a,b
	jp	Z,00103$
;../_memcpy.c:50: *d++ = *s++;
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	inc	(hl)
	jp	NZ,00109$
	inc	hl
	inc	(hl)
00109$:
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
	dec	hl
	inc	(hl)
	jp	NZ,00101$
	inc	hl
	inc	(hl)
00110$:
	jr	00101$
00103$:
;../_memcpy.c:53: return(ret);
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00104$:
	lda	sp,8(sp)
	ret
_memcpy_end::
	.area _CODE
	.area _CABS
