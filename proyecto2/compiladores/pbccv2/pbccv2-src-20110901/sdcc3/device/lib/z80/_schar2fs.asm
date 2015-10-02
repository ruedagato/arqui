;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _schar2fs
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___schar2fs
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
;../_schar2fs.c:55: float __schar2fs (signed char sc) {
;	---------------------------------
; Function __schar2fs
; ---------------------------------
___schar2fs_start::
___schar2fs:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_schar2fs.c:56: return __slong2fs(sc);
	ld	c,4 (ix)
	ld	a,4 (ix)
	rla	
	sbc	a,a
	ld	b,a
	ld	l, a
	ld	h,a
	push	hl
	push	bc
	call	___slong2fs
	pop	af
	pop	af
	pop	ix
	ret
___schar2fs_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
