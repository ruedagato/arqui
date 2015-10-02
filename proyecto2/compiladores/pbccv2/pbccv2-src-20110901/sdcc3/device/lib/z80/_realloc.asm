;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _realloc
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _realloc
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
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
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;../_realloc.c:142: }
	ld	a,i
	di
	push	af
;../_realloc.c:92: pthis = _sdcc_find_memheader(p);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__sdcc_find_memheader
	pop	af
	ld	e,l
	ld	d,h
;../_realloc.c:93: if (pthis)
	ld	a,e
	or	a,d
	jp	Z,00114$
;../_realloc.c:95: if (size > (0xFFFF-HEADER_SIZE))
	ld	a,#0xF9
	sub	a, 6 (ix)
	ld	a,#0xFF
	sbc	a, 7 (ix)
	jr	NC,00111$
;../_realloc.c:97: ret = (void __xdata *) NULL; //To prevent overflow in next line
	ld	-4 (ix),#0x00
	ld	-3 (ix),#0x00
	jp	00115$
00111$:
;../_realloc.c:101: size += HEADER_SIZE; //We need a memory for header too
	ld	a,6 (ix)
	add	a,#0x06
	ld	6 (ix),a
	ld	a,7 (ix)
	adc	a,#0x00
	ld	7 (ix),a
;../_realloc.c:103: if ((((unsigned int)pthis->next) - ((unsigned int)pthis)) >= size)
	ld	l,e
	ld	h,d
	ld	a,(hl)
	ld	-6 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-5 (ix),a
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	c,e
	ld	b,d
	ld	a,l
	sub	a,c
	ld	l,a
	ld	a,h
	sbc	a,b
	ld	h,a
	ld	a,l
	sub	a, 6 (ix)
	ld	a,h
	sbc	a, 7 (ix)
	jr	C,00108$
;../_realloc.c:105: pthis->len = size;
	ld	hl,#0x0004
	add	hl,de
	ld	c,l
	ld	b,h
	ld	a,6 (ix)
	ld	(hl),a
	inc	hl
	ld	a,7 (ix)
	ld	(hl),a
;../_realloc.c:106: ret = p;
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
	jp	00115$
00108$:
;../_realloc.c:110: if ((_sdcc_prev_memheader) &&
	ld	iy,#__sdcc_prev_memheader
	ld	a,0 (iy)
	or	a,1 (iy)
	jp	Z,00104$
;../_realloc.c:111: ((((unsigned int)pthis->next) -
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	-8 (ix),l
	ld	-7 (ix),h
;../_realloc.c:112: ((unsigned int)_sdcc_prev_memheader) -
	ld	c,0 (iy)
	ld	b,1 (iy)
	ld	a,-8 (ix)
	sub	a,c
	ld	-8 (ix),a
	ld	a,-7 (ix)
	sbc	a,b
	ld	-7 (ix),a
;../_realloc.c:113: _sdcc_prev_memheader->len) >= size))
	ld	hl,(__sdcc_prev_memheader)
	ld	a,l
	add	a,#0x04
	ld	c,a
	ld	a,h
	adc	a,#0x00
	ld	h, a
	ld	l, c
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	a,-8 (ix)
	sub	a,l
	ld	l,a
	ld	a,-7 (ix)
	sbc	a,h
	ld	h,a
	ld	a,l
	sub	a, 6 (ix)
	ld	a,h
	sbc	a, 7 (ix)
	jp	C,00104$
;../_realloc.c:115: pnew = (MEMHEADER __xdata * )((char __xdata *)_sdcc_prev_memheader + _sdcc_prev_memheader->len);
	ld	hl,(__sdcc_prev_memheader)
	ld	a,l
	add	a,#0x04
	ld	c,a
	ld	a,h
	adc	a,#0x00
	ld	h, a
	ld	l, c
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,0 (iy)
	add	a,c
	ld	c,a
	ld	a,1 (iy)
	adc	a,b
	ld	-2 (ix), c
	ld	-1 (ix), a
;../_realloc.c:116: _sdcc_prev_memheader->next = pnew;
	ld	hl,(__sdcc_prev_memheader)
	ld	a,-2 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-1 (ix)
	ld	(hl),a
;../_realloc.c:119: pthis->next->prev = pnew;
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	inc	hl
	inc	hl
	ld	a,-2 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-1 (ix)
	ld	(hl),a
;../_realloc.c:122: memmove(pnew, pthis, pthis->len);
	ld	hl,#0x0004
	add	hl,de
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	de
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	_memmove
	pop	af
	pop	af
	pop	af
;../_realloc.c:123: pnew->len = size;
	ld	a,-2 (ix)
	add	a,#0x04
	ld	c,a
	ld	a,-1 (ix)
	adc	a,#0x00
	ld	b, a
	ld	l, c
	ld	h, a
	ld	a,6 (ix)
	ld	(hl),a
	inc	hl
	ld	a,7 (ix)
	ld	(hl),a
;../_realloc.c:124: ret = MEM(pnew);
	ld	a,-2 (ix)
	add	a,#0x06
	ld	-4 (ix),a
	ld	a,-1 (ix)
	adc	a,#0x00
	ld	-3 (ix),a
	jr	00115$
00104$:
;../_realloc.c:128: ret = malloc(size - HEADER_SIZE);
	ld	a,6 (ix)
	add	a,#0xFA
	ld	l,a
	ld	a,7 (ix)
	adc	a,#0xFF
	ld	h,a
	push	de
	push	hl
	call	_malloc
	pop	af
	pop	de
	ld	-4 (ix),l
	ld	-3 (ix),h
;../_realloc.c:129: if (ret)
	ld	a,-4 (ix)
	or	a,-3 (ix)
	jr	Z,00115$
;../_realloc.c:131: memcpy(ret, MEM(pthis), pthis->len - HEADER_SIZE);
	ld	hl,#0x0006
	add	hl,de
	ld	c,l
	ld	b,h
	ex	de,hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	add	a,#0xFA
	ld	e,a
	ld	a,h
	adc	a,#0xFF
	ld	d,a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	push	bc
	push	de
	call	_memcpy
;../_realloc.c:132: free(p);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_free
	pop	af
	jr	00115$
00114$:
;../_realloc.c:140: ret = malloc(size);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_malloc
	pop	af
	ld	-4 (ix),l
	ld	-3 (ix),h
00115$:
	pop	af
	jp	PO,00125$
	ei
00125$:
;../_realloc.c:143: return ret;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	sp,ix
	pop	ix
	ret
_realloc_end::
	.area _CODE
	.area _CABS
