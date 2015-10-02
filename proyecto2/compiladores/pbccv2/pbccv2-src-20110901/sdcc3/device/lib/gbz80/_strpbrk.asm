;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strpbrk
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strpbrk
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
;../_strpbrk.c:31: char * strpbrk (
;	---------------------------------
; Function strpbrk
; ---------------------------------
_strpbrk_start::
_strpbrk:
	
	push	af
	push	af
;../_strpbrk.c:36: char *ret = NULL;
	ldhl	sp,#2
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;../_strpbrk.c:39: while (ch = *control) {
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
00105$:
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
	jp	Z,00107$
;../_strpbrk.c:40: char * p = strchr(string, ch);
	push	bc
	inc	sp
	ldhl	sp,#7
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_strchr
	lda	sp,3(sp)
	ld	b,d
	ld	c,e
;../_strpbrk.c:41: if (p != NULL && (ret == NULL || p < ret)) {
	ld	a,c
	or	a,b
	jp	Z,00102$
00115$:
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00101$
00116$:
	dec	hl
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jp	Z, 00117$
	bit	7, d
	jp	NZ, 00118$
	cp	a, a
	jr	00118$
00117$:
	bit	7, d
	jp	Z, 00118$
	scf
00118$:
	jp	NC,00102$
00101$:
;../_strpbrk.c:42: ret = p;
	ldhl	sp,#2
	ld	(hl),c
	inc	hl
	ld	(hl),b
00102$:
;../_strpbrk.c:44: control++;
	ldhl	sp,#0
	inc	(hl)
	jp	NZ,00105$
	inc	hl
	inc	(hl)
00119$:
	jp	00105$
00107$:
;../_strpbrk.c:47: return (ret);
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00108$:
	lda	sp,4(sp)
	ret
_strpbrk_end::
	.area _CODE
	.area _CABS
