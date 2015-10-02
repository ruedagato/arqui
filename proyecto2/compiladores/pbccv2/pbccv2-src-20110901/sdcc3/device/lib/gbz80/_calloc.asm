;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _calloc
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _calloc
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
;../_calloc.c:70: void __xdata * calloc (size_t nmemb, size_t size)
;	---------------------------------
; Function calloc
; ---------------------------------
_calloc_start::
_calloc:
	
	push	af
;../_calloc.c:74: ptr = malloc(nmemb * size);
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__mulint_rrx_s
	lda	sp,4(sp)
	ldhl	sp,#1
	ld	(hl),d
	dec	hl
	ld	(hl),e
	ldhl	sp,#0
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_malloc
	lda	sp,2(sp)
	ld	b,d
	ld	c,e
;../_calloc.c:75: if (ptr)
	ld	a,c
	or	a,b
	jp	Z,00102$
;../_calloc.c:77: memset(ptr, 0, nmemb * size);
	push	bc
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x00
	push	af
	inc	sp
	push	bc
	call	_memset
	lda	sp,5(sp)
	pop	bc
00102$:
;../_calloc.c:79: return ptr;
	ld	e,c
	ld	d,b
00103$:
	lda	sp,2(sp)
	ret
_calloc_end::
	.area _CODE
	.area _CABS
