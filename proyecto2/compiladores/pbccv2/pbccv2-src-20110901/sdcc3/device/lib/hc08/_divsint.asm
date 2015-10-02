;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _divsint
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
	.globl __divsint_PARM_2
	.globl __divsint
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
__divsint_r_1_1:
	.ds 2
__divsint_sloc0_1_0:
	.ds 2
__divsint_sloc1_1_0:
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
__divsint_PARM_2:
	.ds 2
__divsint_x_1_1:
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
;Allocation info for local variables in function '_divsint'
;------------------------------------------------------------
;r                         Allocated with name '__divsint_r_1_1'
;sloc0                     Allocated with name '__divsint_sloc0_1_0'
;sloc1                     Allocated with name '__divsint_sloc1_1_0'
;y                         Allocated with name '__divsint_PARM_2'
;x                         Allocated with name '__divsint_x_1_1'
;------------------------------------------------------------
;../_divsint.c:207: _divsint (int x, int y)
;	-----------------------------------------
;	 function _divsint
;	-----------------------------------------
__divsint:
	sta	(__divsint_x_1_1 + 1)
	stx	__divsint_x_1_1
;../_divsint.c:211: r = _divuint((x < 0 ? -x : x),
	lda	__divsint_x_1_1
	sub	#0x00
	bge	00106$
00113$:
	clra
	sub	(__divsint_x_1_1 + 1)
	sta	*(__divsint_sloc0_1_0 + 1)
	clra
	sbc	__divsint_x_1_1
	sta	*__divsint_sloc0_1_0
	bra	00107$
00106$:
	lda	__divsint_x_1_1
	sta	*__divsint_sloc0_1_0
	lda	(__divsint_x_1_1 + 1)
	sta	*(__divsint_sloc0_1_0 + 1)
00107$:
;../_divsint.c:212: (y < 0 ? -y : y));
	lda	__divsint_PARM_2
	sub	#0x00
	bge	00108$
00114$:
	clra
	sub	(__divsint_PARM_2 + 1)
	sta	*(__divsint_sloc1_1_0 + 1)
	clra
	sbc	__divsint_PARM_2
	sta	*__divsint_sloc1_1_0
	bra	00109$
00108$:
	lda	__divsint_PARM_2
	sta	*__divsint_sloc1_1_0
	lda	(__divsint_PARM_2 + 1)
	sta	*(__divsint_sloc1_1_0 + 1)
00109$:
	lda	*__divsint_sloc1_1_0
	sta	__divuint_PARM_2
	lda	*(__divsint_sloc1_1_0 + 1)
	sta	(__divuint_PARM_2 + 1)
	ldx	*__divsint_sloc0_1_0
	lda	*(__divsint_sloc0_1_0 + 1)
	jsr	__divuint
	sta	*(__divsint_r_1_1 + 1)
	stx	*__divsint_r_1_1
;../_divsint.c:213: if ( (x < 0) ^ (y < 0))
	lda	__divsint_x_1_1
	sub	#0x00
	blt	00115$
	clra
	bra	00116$
00115$:
	lda	#0x01
00116$:
	sta	*__divsint_sloc1_1_0
	lda	__divsint_PARM_2
	sub	#0x00
	blt	00117$
	clra
	bra	00118$
00117$:
	lda	#0x01
00118$:
	eor	*__divsint_sloc1_1_0
	tsta
	beq	00102$
00119$:
;../_divsint.c:214: return -r;
	clra
	sub	*(__divsint_r_1_1 + 1)
	sta	*(__divsint_sloc1_1_0 + 1)
	clra
	sbc	*__divsint_r_1_1
	sta	*__divsint_sloc1_1_0
	ldx	*__divsint_sloc1_1_0
	lda	*(__divsint_sloc1_1_0 + 1)
	rts
00102$:
;../_divsint.c:216: return r;
	ldx	*__divsint_r_1_1
	lda	*(__divsint_r_1_1 + 1)
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
