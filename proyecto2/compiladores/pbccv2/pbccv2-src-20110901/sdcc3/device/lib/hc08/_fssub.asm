;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _fssub
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
	.globl ___fssub_PARM_2
	.globl ___fssub_PARM_1
	.globl ___fssub
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
___fssub_sloc0_1_0:
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
___fssub_PARM_1:
	.ds 4
___fssub_PARM_2:
	.ds 4
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
;Allocation info for local variables in function '__fssub'
;------------------------------------------------------------
;sloc0                     Allocated with name '___fssub_sloc0_1_0'
;a1                        Allocated with name '___fssub_PARM_1'
;a2                        Allocated with name '___fssub_PARM_2'
;neg                       Allocated to registers 
;------------------------------------------------------------
;../_fssub.c:73: float __fssub (float a1, float a2)
;	-----------------------------------------
;	 function __fssub
;	-----------------------------------------
___fssub:
;../_fssub.c:75: float neg = -a1;
	lda	(___fssub_PARM_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	lda	(___fssub_PARM_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(___fssub_PARM_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	___fssub_PARM_1
	eor	#0x80
	sta	___fsadd_PARM_1
;../_fssub.c:76: return -(neg + a2);
	lda	___fssub_PARM_2
	sta	___fsadd_PARM_2
	lda	(___fssub_PARM_2 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	(___fssub_PARM_2 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	(___fssub_PARM_2 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	*(___fssub_sloc0_1_0 + 3)
	stx	*(___fssub_sloc0_1_0 + 2)
	mov	*__ret2,*(___fssub_sloc0_1_0 + 1)
	mov	*__ret3,*___fssub_sloc0_1_0
	lda	*___fssub_sloc0_1_0
	eor	#0x80
	sta	*___fssub_sloc0_1_0
	mov	*___fssub_sloc0_1_0,*__ret3
	mov	*(___fssub_sloc0_1_0 + 1),*__ret2
	ldx	*(___fssub_sloc0_1_0 + 2)
	lda	*(___fssub_sloc0_1_0 + 3)
00101$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
