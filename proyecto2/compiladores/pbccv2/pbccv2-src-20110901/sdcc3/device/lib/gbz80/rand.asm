;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module rand
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _rand
	.globl _srand
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
_next:
	.ds 4
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
;../rand.c:31: static unsigned long int next = 1;
	ld	hl,#_next
	ld	(hl),#0x01
	xor	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;../rand.c:33: int rand(void)
;	---------------------------------
; Function rand
; ---------------------------------
_rand_start::
_rand:
	
	push	af
	push	af
;../rand.c:35: next = next * 1103515245UL + 12345;
	ld	hl,#_next + 2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#_next
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x41C6
	push	hl
	ld	hl,#0x41C64E6D
	push	hl
	call	__mullong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#2
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	add	a,#0x39
	ld	e,a
	ld	a,d
	adc	a,#0x30
	push	af
	ld	hl,#_next + 1
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	af
	ld	a,e
	adc	a,#0x00
	ld	e,a
	ld	a,d
	adc	a,#0x00
	ld	hl,#_next + 3
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../rand.c:36: return (unsigned int)(next/65536) % (RAND_MAX + 1U);
	ld	a,#0x10
	push	af
	inc	sp
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#_next
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rrulong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#2
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#0
	ld	c,(hl)
	inc	hl
	ld	a,(hl)
	and	a,#0x7F
	ld	b,a
	ld	e,c
	ld	d,b
00101$:
	lda	sp,4(sp)
	ret
_rand_end::
;../rand.c:39: void srand(unsigned int seed)
;	---------------------------------
; Function srand
; ---------------------------------
_srand_start::
_srand:
	
;../rand.c:41: next = seed;
	ldhl	sp,#2
	ld	a,(hl)
	ld	hl,#_next
	ld	(hl),a
	ldhl	sp,#3
	ld	a,(hl)
	ld	hl,#_next + 1
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
00101$:
	
	ret
_srand_end::
	.area _CODE
	.area _CABS
