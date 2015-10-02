;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strncmp
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncmp
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
;../_strncmp.c:31: int strncmp (
;	---------------------------------
; Function strncmp
; ---------------------------------
_strncmp_start::
_strncmp:
	lda	sp,-6(sp)
;../_strncmp.c:37: if (!count)
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00114$
;../_strncmp.c:38: return(0);
	ld	de,#0x0000
	jp	00108$
;../_strncmp.c:40: while (--count && *first && *first == *last) {
00114$:
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),e
00105$:
	ldhl	sp,#3
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
	or	a,(hl)
	jp	Z,00107$
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	b,a
	or	a,a
	jp	Z,00107$
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	a,b
	sub	a,c
	jp	Z,00117$
00116$:
	jr	00107$
00117$:
;../_strncmp.c:41: first++;
	ldhl	sp,#0
	inc	(hl)
	jp	NZ,00118$
	inc	hl
	inc	(hl)
00118$:
;../_strncmp.c:42: last++;
	ldhl	sp,#4
	inc	(hl)
	jp	NZ,00105$
	inc	hl
	inc	(hl)
00119$:
	jp	00105$
00107$:
;../_strncmp.c:45: return( *first - *last );
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	dec	hl
	ld	(hl),c
	ld	a,c
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	rla	
	sbc	a,a
	ld	b,a
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	sub	a,c
	ld	e,a
	ld	a,d
	sbc	a,b
	ld	b,a
	ld	c,e
	ld	e,c
	ld	d,b
00108$:
	lda	sp,6(sp)
	ret
_strncmp_end::
	.area _CODE
	.area _CABS
