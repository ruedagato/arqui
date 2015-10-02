;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _free
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __sdcc_find_memheader
	.globl __sdcc_prev_memheader
	.globl _free
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
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
	push	ix
	ld	ix,#0
	add	ix,sp
;../_free.c:65: if (!p)
	ld	a,4 (ix)
	or	a,5 (ix)
	jr	NZ,00102$
;../_free.c:66: return NULL;
	ld	hl,#0x0000
	jr	00103$
00102$:
;../_free.c:67: pthis = (MEMHEADER * )((char *)  p - HEADER_SIZE); //to start of header
	ld	a, 4 (ix)
	ld	h, 5 (ix)
	add	a,#0xFA
	ld	c,a
	ld	a,h
	adc	a,#0xFF
;../_free.c:68: _sdcc_prev_memheader = pthis->prev;
	ld	b, a
	ld	l, c
	ld	h, a
	inc	hl
	inc	hl
	ld	a,(hl)
	ld	iy,#__sdcc_prev_memheader
	ld	0 (iy),a
	inc	hl
	ld	a,(hl)
	ld	1 (iy),a
;../_free.c:70: return (pthis);
	ld	l,c
	ld	h,b
00103$:
	pop	ix
	ret
__sdcc_find_memheader_end::
;../_free.c:74: free (void *p)
;	---------------------------------
; Function free
; ---------------------------------
_free_start::
_free:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;../_free.c:78: if ( p ) //For allocated pointers only!
	ld	a,4 (ix)
	or	a,5 (ix)
	jr	Z,00108$
;../_free.c:95: }
	ld	a,i
	di
	push	af
;../_free.c:81: pthis = (MEMHEADER * )((char *)  p - HEADER_SIZE); //to start of header
	ld	a, 4 (ix)
	ld	h, 5 (ix)
	add	a,#0xFA
	ld	c,a
	ld	a,h
	adc	a,#0xFF
;../_free.c:82: if ( pthis->prev ) // For the regular header
	ld	b, a
	ld	e, c
	ld	d, a
	inc	de
	inc	de
	ld	l,e
	ld	h,d
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	or	a,h
	jr	Z,00104$
;../_free.c:84: prev_header = pthis->prev;
	ld	-2 (ix),l
	ld	-1 (ix),h
;../_free.c:85: prev_header->next = pthis->next;
	ld	l,c
	ld	h,b
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../_free.c:86: if (pthis->next)
	ld	a,e
	or	a,d
	jr	Z,00105$
;../_free.c:88: pthis->next->prev = prev_header;
	inc	de
	inc	de
	ld	l,e
	ld	h,d
	ld	a,-2 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-1 (ix)
	ld	(hl),a
	jr	00105$
00104$:
;../_free.c:93: pthis->len = 0; //For the first header
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	l,c
	ld	h,b
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
00105$:
	pop	af
	jp	PO,00114$
	ei
00114$:
00108$:
	ld	sp,ix
	pop	ix
	ret
_free_end::
	.area _CODE
	.area _CABS
