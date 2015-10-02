;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module puts
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _puts
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
	
	push	af
	push	af
;../puts.c:34: while (*s){
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
00101$:
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	or	a,a
	jp	Z,00103$
;../puts.c:35: putchar(*s++);
	dec	hl
	inc	(hl)
	jp	NZ,00109$
	inc	hl
	inc	(hl)
00109$:
	ld	a,c
	push	af
	inc	sp
	call	_putchar
	lda	sp,1(sp)
;../puts.c:36: i++;
	ldhl	sp,#2
	inc	(hl)
	jp	NZ,00101$
	inc	hl
	inc	(hl)
00110$:
	jr	00101$
00103$:
;../puts.c:38: putchar('\n');
	ld	a,#0x0A
	push	af
	inc	sp
	call	_putchar
	lda	sp,1(sp)
;../puts.c:39: return i+1;
	ldhl	sp,#2
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	ld	e,c
	ld	d,b
00104$:
	lda	sp,4(sp)
	ret
_puts_end::
	.area _CODE
	.area _CABS
