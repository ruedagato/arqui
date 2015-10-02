;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _calloc
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _calloc
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
;../_calloc.c:70: void __xdata * calloc (size_t nmemb, size_t size)
;	---------------------------------
; Function calloc
; ---------------------------------
_calloc_start::
_calloc:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_calloc.c:74: ptr = malloc(nmemb * size);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__mulint_rrx_s
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	push	bc
	push	bc
	call	_malloc
	pop	af
	pop	bc
	ex	de,hl
;../_calloc.c:75: if (ptr)
	ld	a,e
	or	a,d
	jr	Z,00102$
;../_calloc.c:77: memset(ptr, 0, nmemb * size);
	push	de
	push	bc
	ld	a,#0x00
	push	af
	inc	sp
	push	de
	call	_memset
	pop	af
	pop	af
	inc	sp
	pop	de
00102$:
;../_calloc.c:79: return ptr;
	ex	de,hl
	pop	ix
	ret
_calloc_end::
	.area _CODE
	.area _CABS
