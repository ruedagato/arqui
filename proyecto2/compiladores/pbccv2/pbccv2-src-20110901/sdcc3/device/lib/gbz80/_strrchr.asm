;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strrchr
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strrchr
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
;../_strrchr.c:31: char * strrchr (
;	---------------------------------
; Function strrchr
; ---------------------------------
_strrchr_start::
_strrchr:
	
	push	af
	push	af
;../_strrchr.c:36: const char * start = string;
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_strrchr.c:38: while (*string++)                       /* find end of string */
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
00101$:
	ld	a,(bc)
	inc	bc
	or	a,a
	jp	NZ,00101$
;../_strrchr.c:41: while (--string != start && *string != ch)
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
00105$:
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	dec	hl
	ld	a,(hl)
	inc	hl
	inc	hl
	sub	a,(hl)
	jp	NZ,00118$
	dec	hl
	ld	a,(hl)
	inc	hl
	inc	hl
	sub	a,(hl)
	jp	Z,00107$
00118$:
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ldhl	sp,#8
	sub	a,(hl)
	jp	Z,00120$
00119$:
	jr	00105$
00120$:
00107$:
;../_strrchr.c:44: if (*string == ch)                /* char found ? */
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ldhl	sp,#8
	sub	a,(hl)
	jp	Z,00122$
00121$:
	jr	00109$
00122$:
;../_strrchr.c:45: return( (char *)string );
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	00110$
00109$:
;../_strrchr.c:47: return (NULL) ;
	ld	de,#0x0000
00110$:
	lda	sp,4(sp)
	ret
_strrchr_end::
	.area _CODE
	.area _CABS
