;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _free
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __sdcc_find_memheader
	.globl __sdcc_prev_memheader
	.globl _free
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
__sdcc_prev_memheader::
	.ds 2
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
;../_free.c:62: _sdcc_find_memheader(void * p)
;	---------------------------------
; Function _sdcc_find_memheader
; ---------------------------------
__sdcc_find_memheader_start::
__sdcc_find_memheader:
	
	push	af
;../_free.c:65: if (!p)
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00102$
;../_free.c:66: return NULL;
	ld	de,#0x0000
	jr	00103$
00102$:
;../_free.c:67: pthis = (MEMHEADER * )((char *)  p - HEADER_SIZE); //to start of header
	ldhl	sp,#5
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	de,#0x0006
	ld	a,c
	sub	a,e
	ld	e,a
	ld	a,b
	sbc	a,d
	ldhl	sp,#1
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../_free.c:68: _sdcc_prev_memheader = pthis->prev;
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	ld	e,c
	ld	d,b
	ld	a,(de)
	ld	hl,#__sdcc_prev_memheader
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
;../_free.c:70: return (pthis);
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00103$:
	lda	sp,2(sp)
	ret
__sdcc_find_memheader_end::
;../_free.c:74: free (void *p)
;	---------------------------------
; Function free
; ---------------------------------
_free_start::
_free:
	
	push	af
	push	af
;../_free.c:78: if ( p ) //For allocated pointers only!
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00108$
;../_free.c:95: }
	di
;../_free.c:81: pthis = (MEMHEADER * )((char *)  p - HEADER_SIZE); //to start of header
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	de,#0x0006
	ld	a,c
	sub	a,e
	ld	e,a
	ld	a,b
	sbc	a,d
	ldhl	sp,#1
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../_free.c:82: if ( pthis->prev ) // For the regular header
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	ld	e,c
	ld	d,b
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
	or	a,c
	jp	Z,00104$
;../_free.c:84: prev_header = pthis->prev;
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_free.c:85: prev_header->next = pthis->next;
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
;../_free.c:86: if (pthis->next)
	ld	a,c
	or	a,b
	jp	Z,00105$
;../_free.c:88: pthis->next->prev = prev_header;
	inc	bc
	inc	bc
	ld	e,c
	ld	d,b
	dec	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	jr	00105$
00104$:
;../_free.c:93: pthis->len = 0; //For the first header
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x00
	ld	(de),a
00105$:
	ei
00108$:
	lda	sp,4(sp)
	ret
_free_end::
	.area _CODE
	.area _CABS
