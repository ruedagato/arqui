;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strchr
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strchr
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
	
	push	af
;../_strchr.c:36: while (*string && *string != ch)
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
00102$:
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	or	a,a
	jp	Z,00104$
	ld	a,c
	ldhl	sp,#6
	sub	a,(hl)
	jp	Z,00104$
00114$:
;../_strchr.c:37: string++;
	ldhl	sp,#0
	inc	(hl)
	jp	NZ,00102$
	inc	hl
	inc	(hl)
00115$:
	jr	00102$
00104$:
;../_strchr.c:39: if (*string == ch)
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ldhl	sp,#6
	sub	a,(hl)
	jp	Z,00117$
00116$:
	jr	00106$
00117$:
;../_strchr.c:40: return(string);
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	00107$
00106$:
;../_strchr.c:41: return ( NULL );
	ld	de,#0x0000
00107$:
	lda	sp,2(sp)
	ret
_strchr_end::
	.area _CODE
	.area _CABS
