;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _memset
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memset
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
;../_memset.c:36: void * memset (
;	---------------------------------
; Function memset
; ---------------------------------
_memset_start::
_memset:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_memset.c:41: register unsigned char * ret = buf;
;../_memset.c:43: while (count--) {
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	c,7 (ix)
	ld	b,8 (ix)
00101$:
	ld	l,c
	ld	h,b
	dec	bc
	ld	a,l
	or	a,h
	jr	Z,00103$
;../_memset.c:44: *(unsigned char *) ret = ch;
	ld	a,6 (ix)
	ld	(de),a
;../_memset.c:45: ret = ((unsigned char *) ret) + 1;
	inc	de
	jr	00101$
00103$:
;../_memset.c:48: return buf ;
	ld	l,4 (ix)
	ld	h,5 (ix)
	pop	ix
	ret
_memset_end::
	.area _CODE
	.area _CABS
