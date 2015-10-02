;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _sint2fs
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
	.globl ___sint2fs
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
___sint2fs_sloc0_1_0:
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
___sint2fs_si_1_1:
	.ds 2
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
;Allocation info for local variables in function '__sint2fs'
;------------------------------------------------------------
;sloc0                     Allocated with name '___sint2fs_sloc0_1_0'
;si                        Allocated with name '___sint2fs_si_1_1'
;------------------------------------------------------------
;../_sint2fs.c:54: float __sint2fs (signed int si) {
;	-----------------------------------------
;	 function __sint2fs
;	-----------------------------------------
___sint2fs:
	sta	(___sint2fs_si_1_1 + 1)
	stx	___sint2fs_si_1_1
;../_sint2fs.c:55: return __slong2fs(si);
	lda	(___sint2fs_si_1_1 + 1)
	sta	(___slong2fs_PARM_1 + 3)
	lda	___sint2fs_si_1_1
	sta	(___slong2fs_PARM_1 + 2)
	lda	___sint2fs_si_1_1
	rola	
	clra	
	sbc	#0x00
	sta	(___slong2fs_PARM_1 + 1)
	sta	___slong2fs_PARM_1
	jsr	___slong2fs
	sta	*(___sint2fs_sloc0_1_0 + 3)
	stx	*(___sint2fs_sloc0_1_0 + 2)
	mov	*__ret2,*(___sint2fs_sloc0_1_0 + 1)
	mov	*__ret3,*___sint2fs_sloc0_1_0
	mov	*___sint2fs_sloc0_1_0,*__ret3
	mov	*(___sint2fs_sloc0_1_0 + 1),*__ret2
	ldx	*(___sint2fs_sloc0_1_0 + 2)
	lda	*(___sint2fs_sloc0_1_0 + 3)
00101$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
