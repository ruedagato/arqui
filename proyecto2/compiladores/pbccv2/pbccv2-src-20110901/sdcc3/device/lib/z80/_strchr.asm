;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _strchr
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strchr
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
;../_strchr.c:31: char * strchr (
;	---------------------------------
; Function strchr
; ---------------------------------
_strchr_start::
_strchr:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_strchr.c:36: while (*string && *string != ch)
	ld	c,4 (ix)
	ld	b,5 (ix)
00102$:
	ld	a,(bc)
	or	a,a
	jr	Z,00104$
	sub	a,6 (ix)
	jr	Z,00104$
;../_strchr.c:37: string++;
	inc	bc
	jr	00102$
00104$:
;../_strchr.c:39: if (*string == ch)
	ld	a,(bc)
	sub	a,6 (ix)
	jr	NZ,00106$
;../_strchr.c:40: return(string);
	ld	l,c
	ld	h,b
	jr	00107$
00106$:
;../_strchr.c:41: return ( NULL );
	ld	hl,#0x0000
00107$:
	pop	ix
	ret
_strchr_end::
	.area _CODE
	.area _CABS
