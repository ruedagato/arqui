;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _realloc
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _realloc
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
;../_realloc.c:84: void __xdata * realloc (void * p, size_t size)
;	---------------------------------
; Function realloc
; ---------------------------------
_realloc_start::
_realloc:
	lda	sp,-10(sp)
;../_realloc.c:142: }
	di
;../_realloc.c:92: pthis = _sdcc_find_memheader(p);
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__sdcc_find_memheader
	lda	sp,2(sp)
	ld	b,d
	ld	c,e
	ldhl	sp,#8
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_realloc.c:93: if (pthis)
	dec	hl
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00114$
;../_realloc.c:95: if (size > (0xFFFF-HEADER_SIZE))
	ldhl	sp,#14
	ld	a, #0xF9
	sub	a, (hl)
	inc	hl
	ld	a, #0xFF
	sbc	a, (hl)
	jp	NC,00111$
;../_realloc.c:97: ret = (void __xdata *) NULL; //To prevent overflow in next line
	ldhl	sp,#4
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	jp	00115$
00111$:
;../_realloc.c:101: size += HEADER_SIZE; //We need a memory for header too
	ldhl	sp,#15
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0006
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#14
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../_realloc.c:103: if ((((unsigned int)pthis->next) - ((unsigned int)pthis)) >= size)
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#2
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	ld	a,(hl)
	dec	hl
	dec	hl
	ld	(hl),a
	ldhl	sp,#3
	ld	a,(hl)
	dec	hl
	dec	hl
	ld	(hl),a
	ldhl	sp,#8
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
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
	ldhl	sp,#14
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C,00108$
;../_realloc.c:105: pthis->len = size;
	ldhl	sp,#9
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
	ldhl	sp,#14
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../_realloc.c:106: ret = p;
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jp	00115$
00108$:
;../_realloc.c:110: if ((_sdcc_prev_memheader) &&
	ld	hl,#__sdcc_prev_memheader
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00104$
;../_realloc.c:111: ((((unsigned int)pthis->next) -
	ldhl	sp,#3
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_realloc.c:112: ((unsigned int)_sdcc_prev_memheader) -
	ld	hl,#__sdcc_prev_memheader
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
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
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../_realloc.c:113: _sdcc_prev_memheader->len) >= size))
	ld	hl,#__sdcc_prev_memheader + 1
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	e,c
	ld	d,b
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
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
	ldhl	sp,#14
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C,00104$
;../_realloc.c:115: pnew = (MEMHEADER __xdata * )((char __xdata *)_sdcc_prev_memheader + _sdcc_prev_memheader->len);
	ld	hl,#__sdcc_prev_memheader + 1
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	e,c
	ld	d,b
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
	dec	hl
	ld	a,(hl)
	add	a,c
	inc	hl
	ld	c,a
	ld	a,(hl)
	adc	a,b
	ld	b,a
	ldhl	sp,#6
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_realloc.c:116: _sdcc_prev_memheader->next = pnew;
	ld	hl,#__sdcc_prev_memheader + 1
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	e,c
	ld	d,b
	ldhl	sp,#6
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../_realloc.c:119: pthis->next->prev = pnew;
	ldhl	sp,#2
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	ld	e,c
	ld	d,b
	ldhl	sp,#6
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../_realloc.c:122: memmove(pnew, pthis, pthis->len);
	inc	hl
	inc	hl
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
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
	push	bc
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_memmove
	lda	sp,6(sp)
;../_realloc.c:123: pnew->len = size;
	ldhl	sp,#7
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
	ldhl	sp,#14
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../_realloc.c:124: ret = MEM(pnew);
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0006
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	jp	00115$
00104$:
;../_realloc.c:128: ret = malloc(size - HEADER_SIZE);
	ldhl	sp,#15
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0006
	ld	a,e
	sub	a,l
	ld	e,a
	ld	a,d
	sbc	a,h
	ld	b,a
	ld	c,e
	push	bc
	call	_malloc
	lda	sp,2(sp)
	ld	b,d
	ld	c,e
	ldhl	sp,#4
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_realloc.c:129: if (ret)
	dec	hl
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00115$
;../_realloc.c:131: memcpy(ret, MEM(pthis), pthis->len - HEADER_SIZE);
	ldhl	sp,#9
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
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
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
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0006
	add	hl,de
	ld	c,l
	ld	b,h
	ldhl	sp,#0
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_memcpy
	lda	sp,6(sp)
;../_realloc.c:132: free(p);
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_free
	lda	sp,2(sp)
	jr	00115$
00114$:
;../_realloc.c:140: ret = malloc(size);
	ldhl	sp,#14
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_malloc
	lda	sp,2(sp)
	ld	b,d
	ld	c,e
	ldhl	sp,#4
	ld	(hl),c
	inc	hl
	ld	(hl),b
00115$:
	ei
;../_realloc.c:143: return ret;
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00116$:
	lda	sp,10(sp)
	ret
_realloc_end::
	.area _CODE
	.area _CABS
