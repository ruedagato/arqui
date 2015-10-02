;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strspn
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strspn
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
;../_strspn.c:31: size_t strspn (
;	---------------------------------
; Function strspn
; ---------------------------------
_strspn_start::
_strspn:
	
	push	af
	push	af
;../_strspn.c:39: while (ch = *string) {
	ldhl	sp,#2
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
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
	ld	c,a
	ld	b,c
	xor	a,a
	or	a,c
	jp	Z,00106$
;../_strspn.c:40: if ( strchr(control,ch) )
	push	bc
	inc	sp
	ldhl	sp,#9
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_strchr
	lda	sp,3(sp)
	ld	b,d
	ld	c,e
	ld	a,c
	or	a,b
	jp	Z,00106$
;../_strspn.c:41: count++ ;
	ldhl	sp,#2
	inc	(hl)
	jp	NZ,00113$
	inc	hl
	inc	(hl)
00113$:
;../_strspn.c:44: string++ ;
	ldhl	sp,#0
	inc	(hl)
	jp	NZ,00104$
	inc	hl
	inc	(hl)
00114$:
	jr	00104$
00106$:
;../_strspn.c:47: return count ;
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00107$:
	lda	sp,4(sp)
	ret
_strspn_end::
	.area _CODE
	.area _CABS
