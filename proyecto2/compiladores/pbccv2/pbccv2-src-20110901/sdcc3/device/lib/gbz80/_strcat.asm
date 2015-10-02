;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strcat
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcat
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
;../_strcat.c:31: char * strcat (
;	---------------------------------
; Function strcat
; ---------------------------------
_strcat_start::
_strcat:
	
	push	af
;../_strcat.c:36: char * cp = dst;
	ldhl	sp,#5
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;../_strcat.c:38: while( *cp )
00101$:
	ld	a,(bc)
	or	a,a
	jp	Z,00111$
;../_strcat.c:39: cp++;                   /* find end of dst */
	inc	bc
	jr	00101$
;../_strcat.c:41: while( *cp++ = *src++ ) ;       /* Copy src to end of dst */
00111$:
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
00104$:
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	inc	(hl)
	jp	NZ,00115$
	inc	hl
	inc	(hl)
00115$:
	ld	(bc),a
	inc	bc
	or	a,a
	jp	NZ,00104$
;../_strcat.c:43: return( dst );                  /* return dst */
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00107$:
	lda	sp,2(sp)
	ret
_strcat_end::
	.area _CODE
	.area _CABS
