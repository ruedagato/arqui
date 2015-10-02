;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _malloc
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __sdcc_heap_init
	.globl _malloc
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
;../_malloc.c:59: _sdcc_heap_init(void)
;	---------------------------------
; Function _sdcc_heap_init
; ---------------------------------
__sdcc_heap_init_start::
__sdcc_heap_init:
;../_malloc.c:61: MEMHEADER *pbase = &_sdcc_heap_start;
;../_malloc.c:62: unsigned int size = &_sdcc_heap_end - (char *)pbase;
	ld	a,#<(__sdcc_heap_end)
	sub	a,#<(__sdcc_heap_start)
	ld	l,a
	ld	a,#>(__sdcc_heap_end)
	sbc	a,#>(__sdcc_heap_start)
	ld	h,a
;../_malloc.c:64: pbase->next = (MEMHEADER *)((char *)pbase + size - HEADER_SIZE);
	ld	a,#<(__sdcc_heap_start)
	add	a,l
	ld	c,a
	ld	a,#>(__sdcc_heap_start)
	adc	a,h
	ld	b,a
	ld	a,c
	add	a,#0xFA
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
	ld	hl,#__sdcc_heap_start
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_malloc.c:65: pbase->next->next = NULL; //And mark it as last
	ld	l,c
	ld	h,b
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;../_malloc.c:66: pbase->prev       = NULL; //and mark first as first
	ld	hl,#0x0002 + __sdcc_heap_start
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;../_malloc.c:67: pbase->len        = 0;    //Empty and ready.
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	ret
__sdcc_heap_init_end::
;../_malloc.c:71: malloc (unsigned int size)
;	---------------------------------
; Function malloc
; ---------------------------------
_malloc_start::
_malloc:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;../_malloc.c:77: if (size>(0xFFFF-HEADER_SIZE))
	ld	a,#0xF9
	sub	a, 4 (ix)
	ld	a,#0xFF
	sbc	a, 5 (ix)
	jr	NC,00102$
;../_malloc.c:79: return NULL; //To prevent overflow in next line
	ld	hl,#0x0000
	jp	00117$
00102$:
;../_malloc.c:82: size += HEADER_SIZE; //We need a memory for header too
	ld	a,4 (ix)
	add	a,#0x06
	ld	4 (ix),a
	ld	a,5 (ix)
	adc	a,#0x00
	ld	5 (ix),a
;../_malloc.c:83: current_header = &_sdcc_heap_start;
	ld	-2 (ix),#<(__sdcc_heap_start)
	ld	-1 (ix),#>(__sdcc_heap_start)
;../_malloc.c:132: }
	ld	a,i
	di
	push	af
;../_malloc.c:87: while (1)
00108$:
;../_malloc.c:96: if ((((unsigned int)current_header->next) -
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	l,e
	ld	h,d
;../_malloc.c:97: ((unsigned int)current_header) -
	ld	c,-2 (ix)
	ld	b,-1 (ix)
	ld	a,l
	sub	a,c
	ld	-6 (ix),a
	ld	a,h
	sbc	a,b
	ld	-5 (ix),a
;../_malloc.c:98: current_header->len) >= size)
	ld	a,-2 (ix)
	add	a,#0x04
	ld	l, a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	h, a
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	a,-6 (ix)
	sub	a,l
	ld	l,a
	ld	a,-5 (ix)
	sbc	a,h
	ld	h,a
	ld	a,l
	sub	a, 4 (ix)
	ld	a,h
	sbc	a, 5 (ix)
	jr	C,00104$
;../_malloc.c:100: ret = &current_header->mem;
	ld	a,-2 (ix)
	add	a,#0x06
	ld	c,a
	ld	a,-1 (ix)
	adc	a,#0x00
	ld	b,a
;../_malloc.c:101: break;
	jr	00109$
00104$:
;../_malloc.c:103: current_header = current_header->next;    //else try next
	ld	-2 (ix), e
	ld	-1 (ix), d
;../_malloc.c:104: if (!current_header->next)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	or	a,h
	jr	NZ,00108$
;../_malloc.c:106: ret = NULL;
	ld	bc,#0x0000
;../_malloc.c:107: break;
00109$:
;../_malloc.c:111: if (ret)
	ld	a,c
	or	a,b
	jp	Z,00116$
;../_malloc.c:113: if (!current_header->len)
	ld	a,-2 (ix)
	add	a,#0x04
	ld	e,a
	ld	a,-1 (ix)
	adc	a,#0x00
	ld	d, a
	ld	l, e
	ld	h, a
	ld	a,(hl)
	ld	-6 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-5 (ix),a
	ld	a,-6 (ix)
	or	a,-5 (ix)
	jr	NZ,00113$
;../_malloc.c:115: current_header->len = size; //for first allocation
	ld	l,e
	ld	h,d
	ld	a,4 (ix)
	ld	(hl),a
	inc	hl
	ld	a,5 (ix)
	ld	(hl),a
	jp	00116$
00113$:
;../_malloc.c:120: new_header = (MEMHEADER * )((char *)current_header + current_header->len);
	ld	a,-2 (ix)
	add	a,-6 (ix)
	ld	e,a
	ld	a,-1 (ix)
	adc	a,-5 (ix)
	ld	-4 (ix), e
	ld	-3 (ix), a
;../_malloc.c:121: new_header->next = current_header->next; //and plug it into the chain
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_malloc.c:122: new_header->prev = current_header;
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	inc	hl
	inc	hl
	ld	a,-2 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-1 (ix)
	ld	(hl),a
;../_malloc.c:123: current_header->next  = new_header;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	a,-4 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-3 (ix)
	ld	(hl),a
;../_malloc.c:124: if (new_header->next)
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	a,c
	or	a,b
	jr	Z,00111$
;../_malloc.c:126: new_header->next->prev = new_header;
	inc	hl
	inc	hl
	ld	a,-4 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-3 (ix)
	ld	(hl),a
00111$:
;../_malloc.c:128: new_header->len  = size; //mark as used
	ld	a,-4 (ix)
	add	a,#0x04
	ld	e,a
	ld	a,-3 (ix)
	adc	a,#0x00
	ld	d, a
	ld	l, e
	ld	h, a
	ld	a,4 (ix)
	ld	(hl),a
	inc	hl
	ld	a,5 (ix)
	ld	(hl),a
;../_malloc.c:129: ret = &new_header->mem;
	ld	a,-4 (ix)
	add	a,#0x06
	ld	c,a
	ld	a,-3 (ix)
	adc	a,#0x00
	ld	b,a
00116$:
	pop	af
	jp	PO,00127$
	ei
00127$:
;../_malloc.c:133: return ret;
	ld	l,c
	ld	h,b
00117$:
	ld	sp,ix
	pop	ix
	ret
_malloc_end::
	.area _CODE
	.area _CABS
