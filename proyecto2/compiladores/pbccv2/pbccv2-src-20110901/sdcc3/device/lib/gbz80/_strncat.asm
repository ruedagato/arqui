;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strncat
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncat
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
;../_strncat.c:31: char * strncat (
;	---------------------------------
; Function strncat
; ---------------------------------
_strncat_start::
_strncat:
	lda	sp,-8(sp)
;../_strncat.c:37: char *start = front;
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_strncat.c:39: while (*front++);
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
00101$:
	ld	a,(bc)
	inc	bc
	or	a,a
	jp	NZ,00101$
;../_strncat.c:41: front--;
	ld	de,#0x0001
	ld	a,c
	sub	a,e
	ld	e,a
	ld	a,b
	sbc	a,d
	ldhl	sp,#11
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../_strncat.c:43: while (count--)
	inc	hl
	inc	hl
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
	ldhl	sp,#14
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),e
00106$:
	ldhl	sp,#3
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
	jp	Z,00108$
;../_strncat.c:44: if (!(*front++ = *back++))
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	dec	hl
	inc	(hl)
	jp	NZ,00117$
	inc	hl
	inc	(hl)
00117$:
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	ld	(de),a
	dec	hl
	inc	(hl)
	jp	NZ,00118$
	inc	hl
	inc	(hl)
00118$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),e
	xor	a,a
	or	a,c
	jp	NZ,00106$
;../_strncat.c:45: return(start);
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	00109$
00108$:
;../_strncat.c:47: *front = '\0';
	ldhl	sp,#11
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x00
	ld	(bc),a
;../_strncat.c:48: return(start);
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00109$:
	lda	sp,8(sp)
	ret
_strncat_end::
	.area _CODE
	.area _CABS
