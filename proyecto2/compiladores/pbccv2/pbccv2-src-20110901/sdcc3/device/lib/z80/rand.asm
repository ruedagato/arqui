;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module rand
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _rand
	.globl _srand
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
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
	ld	iy,#_next
	ld	0 (iy),#0x01
	xor	a,a
	ld	1 (iy),a
	ld	2 (iy),a
	ld	3 (iy),a
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
;../rand.c:35: next = next * 1103515245UL + 12345;
	ld	hl,(_next + 2)
	push	hl
	ld	hl,(_next)
	push	hl
	ld	hl,#0x41C6
	push	hl
	ld	hl,#0x41C64E6D
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	a, l
	ld	hl, #_next
	add	a,#0x39
	ld	(hl),a
	ld	a,b
	adc	a,#0x30
	inc	hl
	ld	(hl),a
	ld	a,e
	adc	a,#0x00
	inc	hl
	ld	(hl),a
	ld	a,d
	adc	a,#0x00
	inc	hl
	ld	(hl),a
;../rand.c:36: return (unsigned int)(next/65536) % (RAND_MAX + 1U);
	ld	a,#0x10
	push	af
	inc	sp
	ld	hl,(_next + 2)
	push	hl
	ld	hl,(_next)
	push	hl
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	a, h
	and	a,#0x7F
	ld	h,a
	ret
_rand_end::
;../rand.c:39: void srand(unsigned int seed)
;	---------------------------------
; Function srand
; ---------------------------------
_srand_start::
_srand:
	push	ix
	ld	ix,#0
	add	ix,sp
;../rand.c:41: next = seed;
	ld	a,4 (ix)
	ld	iy,#_next
	ld	0 (iy),a
	ld	a,5 (ix)
	ld	1 (iy),a
	ld	2 (iy),#0x00
	ld	3 (iy),#0x00
	pop	ix
	ret
_srand_end::
	.area _CODE
	.area _CABS
