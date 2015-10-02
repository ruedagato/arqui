;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strncpy
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncpy
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
;../_strncpy.c:31: char *strncpy (
;	---------------------------------
; Function strncpy
; ---------------------------------
_strncpy_start::
_strncpy:
	lda	sp,-7(sp)
;../_strncpy.c:36: register char * d1 =  d;
	ldhl	sp,#9
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#5
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_strncpy.c:38: while ( n && *s )
	ldhl	sp,#14
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ldhl	sp,#11
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#3
	ld	(hl),a
	inc	hl
	ld	(hl),e
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#1
	ld	(hl),a
	inc	hl
	ld	(hl),e
00102$:
	ld	a,c
	or	a,b
	jp	Z,00114$
	ldhl	sp,#4
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#0
	ld	(hl),a
	or	a,a
	jp	Z,00114$
;../_strncpy.c:40: n-- ;
	dec	bc
;../_strncpy.c:41: *d++ = *s++ ;
	ld	a,(hl)
	ldhl	sp,#3
	inc	(hl)
	jp	NZ,00117$
	inc	hl
	inc	(hl)
00117$:
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
	dec	hl
	inc	(hl)
	jp	NZ,00102$
	inc	hl
	inc	(hl)
00118$:
	jr	00102$
;../_strncpy.c:43: while ( n-- )
00114$:
	ldhl	sp,#3
	ld	(hl),c
	inc	hl
	ld	(hl),b
00105$:
	ldhl	sp,#4
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
	jp	Z,00107$
;../_strncpy.c:45: *d++ = '\0' ;
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x00
	ld	(de),a
	dec	hl
	inc	(hl)
	jp	NZ,00105$
	inc	hl
	inc	(hl)
00119$:
	jr	00105$
00107$:
;../_strncpy.c:47: return d1;
	ldhl	sp,#6
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00108$:
	lda	sp,7(sp)
	ret
_strncpy_end::
	.area _CODE
	.area _CABS
