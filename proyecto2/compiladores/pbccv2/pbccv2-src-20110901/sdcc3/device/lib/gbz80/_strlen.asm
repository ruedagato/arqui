;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strlen
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strlen
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
;../_strlen.c:35: size_t strlen ( const char * str )
;	---------------------------------
; Function strlen
; ---------------------------------
_strlen_start::
_strlen:
	
	push	af
;../_strlen.c:39: while (*str++)
	ldhl	sp,#0
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#5
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
00101$:
	ld	a,(bc)
	inc	bc
	or	a,a
	jp	Z,00103$
;../_strlen.c:40: i++ ;
	ldhl	sp,#0
	inc	(hl)
	jp	NZ,00101$
	inc	hl
	inc	(hl)
00109$:
	jr	00101$
00103$:
;../_strlen.c:42: return i;
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00104$:
	lda	sp,2(sp)
	ret
_strlen_end::
	.area _CODE
	.area _CABS
