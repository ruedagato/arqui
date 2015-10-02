;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module puts
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _puts
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
;../puts.c:31: int puts (char *s)
;	---------------------------------
; Function puts
; ---------------------------------
_puts_start::
_puts:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;../puts.c:34: while (*s){
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
00101$:
	ld	a,(bc)
	ld	l,a
	or	a,a
	jr	Z,00103$
;../puts.c:35: putchar(*s++);
	ld	e,l
	inc	bc
	push	bc
	ld	a,e
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
;../puts.c:36: i++;
	inc	-2 (ix)
	jr	NZ,00101$
	inc	-1 (ix)
	jr	00101$
00103$:
;../puts.c:38: putchar('\n');
	ld	a,#0x0A
	push	af
	inc	sp
	call	_putchar
	inc	sp
;../puts.c:39: return i+1;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	inc	hl
	ld	sp,ix
	pop	ix
	ret
_puts_end::
	.area _CODE
	.area _CABS
