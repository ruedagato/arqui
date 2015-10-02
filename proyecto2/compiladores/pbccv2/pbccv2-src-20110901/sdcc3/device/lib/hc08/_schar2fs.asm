;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _schar2fs
	.optsdcc -mhc08
	
	.area HOME (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area CSEG (CODE)
	.area XINIT
	.area CONST   (CODE)
	.area DSEG
	.area OSEG    (OVR)
	.area BSEG
	.area XSEG
	.area XISEG
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___schar2fs
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
___schar2fs_sloc0_1_0:
	.ds 4
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area OSEG    (OVR)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG
;--------------------------------------------------------
; extended address mode data
;--------------------------------------------------------
	.area XSEG
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area GSINIT (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME (CODE)
	.area HOME (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function '__schar2fs'
;------------------------------------------------------------
;sloc0                     Allocated with name '___schar2fs_sloc0_1_0'
;sc                        Allocated to registers 
;------------------------------------------------------------
;../_schar2fs.c:55: float __schar2fs (signed char sc) {
;	-----------------------------------------
;	 function __schar2fs
;	-----------------------------------------
___schar2fs:
;../_schar2fs.c:56: return __slong2fs(sc);
	sta	(___slong2fs_PARM_1 + 3)
	rola	
	clra	
	sbc	#0x00
	sta	(___slong2fs_PARM_1 + 2)
	sta	(___slong2fs_PARM_1 + 1)
	sta	___slong2fs_PARM_1
	jsr	___slong2fs
	sta	*(___schar2fs_sloc0_1_0 + 3)
	stx	*(___schar2fs_sloc0_1_0 + 2)
	mov	*__ret2,*(___schar2fs_sloc0_1_0 + 1)
	mov	*__ret3,*___schar2fs_sloc0_1_0
	mov	*___schar2fs_sloc0_1_0,*__ret3
	mov	*(___schar2fs_sloc0_1_0 + 1),*__ret2
	ldx	*(___schar2fs_sloc0_1_0 + 2)
	lda	*(___schar2fs_sloc0_1_0 + 3)
00101$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
