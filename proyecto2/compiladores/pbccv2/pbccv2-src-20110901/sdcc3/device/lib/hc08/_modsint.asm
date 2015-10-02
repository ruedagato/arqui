;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _modsint
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
	.globl __modsint_PARM_2
	.globl __modsint
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
__modsint_r_1_1:
	.ds 2
__modsint_sloc0_1_0:
	.ds 2
__modsint_sloc1_1_0:
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
__modsint_PARM_2:
	.ds 2
__modsint_a_1_1:
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
;Allocation info for local variables in function '_modsint'
;------------------------------------------------------------
;r                         Allocated with name '__modsint_r_1_1'
;sloc0                     Allocated with name '__modsint_sloc0_1_0'
;sloc1                     Allocated with name '__modsint_sloc1_1_0'
;b                         Allocated with name '__modsint_PARM_2'
;a                         Allocated with name '__modsint_a_1_1'
;------------------------------------------------------------
;../_modsint.c:203: int _modsint (int a, int b)
;	-----------------------------------------
;	 function _modsint
;	-----------------------------------------
__modsint:
	sta	(__modsint_a_1_1 + 1)
	stx	__modsint_a_1_1
;../_modsint.c:207: r = _moduint((a < 0 ? -a : a),
	lda	__modsint_a_1_1
	sub	#0x00
	bge	00106$
00113$:
	clra
	sub	(__modsint_a_1_1 + 1)
	sta	*(__modsint_sloc0_1_0 + 1)
	clra
	sbc	__modsint_a_1_1
	sta	*__modsint_sloc0_1_0
	bra	00107$
00106$:
	lda	__modsint_a_1_1
	sta	*__modsint_sloc0_1_0
	lda	(__modsint_a_1_1 + 1)
	sta	*(__modsint_sloc0_1_0 + 1)
00107$:
;../_modsint.c:208: (b < 0 ? -b : b));
	lda	__modsint_PARM_2
	sub	#0x00
	bge	00108$
00114$:
	clra
	sub	(__modsint_PARM_2 + 1)
	sta	*(__modsint_sloc1_1_0 + 1)
	clra
	sbc	__modsint_PARM_2
	sta	*__modsint_sloc1_1_0
	bra	00109$
00108$:
	lda	__modsint_PARM_2
	sta	*__modsint_sloc1_1_0
	lda	(__modsint_PARM_2 + 1)
	sta	*(__modsint_sloc1_1_0 + 1)
00109$:
	lda	*__modsint_sloc1_1_0
	sta	__moduint_PARM_2
	lda	*(__modsint_sloc1_1_0 + 1)
	sta	(__moduint_PARM_2 + 1)
	ldx	*__modsint_sloc0_1_0
	lda	*(__modsint_sloc0_1_0 + 1)
	jsr	__moduint
	sta	*(__modsint_r_1_1 + 1)
	stx	*__modsint_r_1_1
;../_modsint.c:210: if (a < 0)
	lda	__modsint_a_1_1
	sub	#0x00
	bge	00102$
00115$:
;../_modsint.c:211: return -r;
	clra
	sub	*(__modsint_r_1_1 + 1)
	sta	*(__modsint_sloc1_1_0 + 1)
	clra
	sbc	*__modsint_r_1_1
	sta	*__modsint_sloc1_1_0
	ldx	*__modsint_sloc1_1_0
	lda	*(__modsint_sloc1_1_0 + 1)
	rts
00102$:
;../_modsint.c:213: return r;
	ldx	*__modsint_r_1_1
	lda	*(__modsint_r_1_1 + 1)
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
