;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _strcat
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcat
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
;../_strcat.c:31: char * strcat (
;	---------------------------------
; Function strcat
; ---------------------------------
_strcat_start::
_strcat:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_strcat.c:36: char * cp = dst;
;../_strcat.c:38: while( *cp )
	ld	c, 4 (ix)
	ld	b, 5 (ix)
00101$:
	ld	a,(bc)
	or	a,a
	jr	Z,00111$
;../_strcat.c:39: cp++;                   /* find end of dst */
	inc	bc
	jr	00101$
;../_strcat.c:41: while( *cp++ = *src++ ) ;       /* Copy src to end of dst */
00111$:
	ld	e,6 (ix)
	ld	d,7 (ix)
00104$:
	ld	a,(de)
	inc	de
	ld	(bc),a
	inc	bc
	or	a,a
	jr	NZ,00104$
;../_strcat.c:43: return( dst );                  /* return dst */
	ld	l,4 (ix)
	ld	h,5 (ix)
	pop	ix
	ret
_strcat_end::
	.area _CODE
	.area _CABS
