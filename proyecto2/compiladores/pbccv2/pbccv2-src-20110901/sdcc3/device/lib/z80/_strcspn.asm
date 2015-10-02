;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _strcspn
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcspn
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
;../_strcspn.c:31: size_t strcspn ( 
;	---------------------------------
; Function strcspn
; ---------------------------------
_strcspn_start::
_strcspn:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;../_strcspn.c:39: while (ch = *string) {
	ld	bc,#0x0000
	ld	e,4 (ix)
	ld	d,5 (ix)
00104$:
	ld	a,(de)
	ld	l,a
	ld	-1 (ix),l
	xor	a,a
	or	a,l
	jr	Z,00106$
;../_strcspn.c:40: if (strchr(control,ch))
	push	bc
	push	de
	ld	a,-1 (ix)
	push	af
	inc	sp
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_strchr
	pop	af
	inc	sp
	pop	de
	pop	bc
	ld	a,l
	or	a,h
	jr	NZ,00106$
;../_strcspn.c:43: count++ ;
	inc	bc
;../_strcspn.c:44: string++ ;
	inc	de
	jr	00104$
00106$:
;../_strcspn.c:47: return count ;
	ld	l,c
	ld	h,b
	ld	sp,ix
	pop	ix
	ret
_strcspn_end::
	.area _CODE
	.area _CABS
