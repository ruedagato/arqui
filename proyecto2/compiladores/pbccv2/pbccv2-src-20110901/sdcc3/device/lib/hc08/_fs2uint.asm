;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _fs2uint
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
	.globl ___fs2uint_PARM_1
	.globl ___fs2uint
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
___fs2uint_sloc0_1_0:
	.ds 2
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
___fs2uint_PARM_1:
	.ds 4
___fs2uint_ul_1_1:
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
;Allocation info for local variables in function '__fs2uint'
;------------------------------------------------------------
;sloc0                     Allocated with name '___fs2uint_sloc0_1_0'
;f                         Allocated with name '___fs2uint_PARM_1'
;ul                        Allocated with name '___fs2uint_ul_1_1'
;------------------------------------------------------------
;../_fs2uint.c:54: unsigned int __fs2uint (float f)
;	-----------------------------------------
;	 function __fs2uint
;	-----------------------------------------
___fs2uint:
;../_fs2uint.c:56: unsigned long ul=__fs2ulong(f);
	lda	___fs2uint_PARM_1
	sta	___fs2ulong_PARM_1
	lda	(___fs2uint_PARM_1 + 1)
	sta	(___fs2ulong_PARM_1 + 1)
	lda	(___fs2uint_PARM_1 + 2)
	sta	(___fs2ulong_PARM_1 + 2)
	lda	(___fs2uint_PARM_1 + 3)
	sta	(___fs2ulong_PARM_1 + 3)
	jsr	___fs2ulong
	sta	(___fs2uint_ul_1_1 + 3)
	stx	(___fs2uint_ul_1_1 + 2)
	lda	*__ret2
	sta	(___fs2uint_ul_1_1 + 1)
	lda	*__ret3
	sta	___fs2uint_ul_1_1
;../_fs2uint.c:57: if (ul>=UINT_MAX) return UINT_MAX;
	lda	(___fs2uint_ul_1_1 + 3)
	sub	#0xFF
	lda	(___fs2uint_ul_1_1 + 2)
	sbc	#0xFF
	lda	(___fs2uint_ul_1_1 + 1)
	sbc	#0x00
	lda	___fs2uint_ul_1_1
	sbc	#0x00
	bcs	00102$
00106$:
	ldx	#0xFF
	lda	#0xFF
	rts
00102$:
;../_fs2uint.c:58: return ul;
	lda	(___fs2uint_ul_1_1 + 3)
	sta	*(___fs2uint_sloc0_1_0 + 1)
	lda	(___fs2uint_ul_1_1 + 2)
	sta	*___fs2uint_sloc0_1_0
	ldx	*___fs2uint_sloc0_1_0
	lda	*(___fs2uint_sloc0_1_0 + 1)
00103$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
