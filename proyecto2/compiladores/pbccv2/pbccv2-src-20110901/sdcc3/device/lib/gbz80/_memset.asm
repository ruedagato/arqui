;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _memset
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memset
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
;../_memset.c:36: void * memset (
;	---------------------------------
; Function memset
; ---------------------------------
_memset_start::
_memset:
	
	push	af
	push	af
;../_memset.c:41: register unsigned char * ret = buf;
;../_memset.c:43: while (count--) {
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#9
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
;../_memset.c:44: *(unsigned char *) ret = ch;
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#8
	ld	a,(hl)
	ld	(de),a
;../_memset.c:45: ret = ((unsigned char *) ret) + 1;
	ldhl	sp,#2
	inc	(hl)
	jp	NZ,00101$
	inc	hl
	inc	(hl)
00109$:
	jr	00101$
00103$:
;../_memset.c:48: return buf ;
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00104$:
	lda	sp,4(sp)
	ret
_memset_end::
	.area _CODE
	.area _CABS
