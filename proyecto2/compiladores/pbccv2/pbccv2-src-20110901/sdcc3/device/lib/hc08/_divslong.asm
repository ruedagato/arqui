;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _divslong
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
	.globl __divslong_PARM_2
	.globl __divslong_PARM_1
	.globl __divslong
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
__divslong_sloc0_1_0:
	.ds 4
__divslong_sloc1_1_0:
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
__divslong_PARM_1:
	.ds 4
__divslong_PARM_2:
	.ds 4
__divslong_r_1_1:
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
;Allocation info for local variables in function '_divslong'
;------------------------------------------------------------
;sloc0                     Allocated with name '__divslong_sloc0_1_0'
;sloc1                     Allocated with name '__divslong_sloc1_1_0'
;x                         Allocated with name '__divslong_PARM_1'
;y                         Allocated with name '__divslong_PARM_2'
;r                         Allocated with name '__divslong_r_1_1'
;------------------------------------------------------------
;../_divslong.c:259: _divslong (long x, long y)
;	-----------------------------------------
;	 function _divslong
;	-----------------------------------------
__divslong:
;../_divslong.c:263: r = _divulong((x < 0 ? -x : x),
	lda	__divslong_PARM_1
	sub	#0x00
	bge	00106$
00113$:
	clra
	sub	(__divslong_PARM_1 + 3)
	sta	*(__divslong_sloc0_1_0 + 3)
	clra
	sbc	(__divslong_PARM_1 + 2)
	sta	*(__divslong_sloc0_1_0 + 2)
	clra
	sbc	(__divslong_PARM_1 + 1)
	sta	*(__divslong_sloc0_1_0 + 1)
	clra
	sbc	__divslong_PARM_1
	sta	*__divslong_sloc0_1_0
	bra	00107$
00106$:
	lda	__divslong_PARM_1
	sta	*__divslong_sloc0_1_0
	lda	(__divslong_PARM_1 + 1)
	sta	*(__divslong_sloc0_1_0 + 1)
	lda	(__divslong_PARM_1 + 2)
	sta	*(__divslong_sloc0_1_0 + 2)
	lda	(__divslong_PARM_1 + 3)
	sta	*(__divslong_sloc0_1_0 + 3)
00107$:
;../_divslong.c:264: (y < 0 ? -y : y));
	lda	__divslong_PARM_2
	sub	#0x00
	bge	00108$
00114$:
	clra
	sub	(__divslong_PARM_2 + 3)
	sta	*(__divslong_sloc1_1_0 + 3)
	clra
	sbc	(__divslong_PARM_2 + 2)
	sta	*(__divslong_sloc1_1_0 + 2)
	clra
	sbc	(__divslong_PARM_2 + 1)
	sta	*(__divslong_sloc1_1_0 + 1)
	clra
	sbc	__divslong_PARM_2
	sta	*__divslong_sloc1_1_0
	bra	00109$
00108$:
	lda	__divslong_PARM_2
	sta	*__divslong_sloc1_1_0
	lda	(__divslong_PARM_2 + 1)
	sta	*(__divslong_sloc1_1_0 + 1)
	lda	(__divslong_PARM_2 + 2)
	sta	*(__divslong_sloc1_1_0 + 2)
	lda	(__divslong_PARM_2 + 3)
	sta	*(__divslong_sloc1_1_0 + 3)
00109$:
	lda	*__divslong_sloc0_1_0
	sta	__divulong_PARM_1
	lda	*(__divslong_sloc0_1_0 + 1)
	sta	(__divulong_PARM_1 + 1)
	lda	*(__divslong_sloc0_1_0 + 2)
	sta	(__divulong_PARM_1 + 2)
	lda	*(__divslong_sloc0_1_0 + 3)
	sta	(__divulong_PARM_1 + 3)
	lda	*__divslong_sloc1_1_0
	sta	__divulong_PARM_2
	lda	*(__divslong_sloc1_1_0 + 1)
	sta	(__divulong_PARM_2 + 1)
	lda	*(__divslong_sloc1_1_0 + 2)
	sta	(__divulong_PARM_2 + 2)
	lda	*(__divslong_sloc1_1_0 + 3)
	sta	(__divulong_PARM_2 + 3)
	jsr	__divulong
	sta	(__divslong_r_1_1 + 3)
	stx	(__divslong_r_1_1 + 2)
	lda	*__ret2
	sta	(__divslong_r_1_1 + 1)
	lda	*__ret3
	sta	__divslong_r_1_1
;../_divslong.c:265: if ( (x < 0) ^ (y < 0))
	lda	__divslong_PARM_1
	sub	#0x00
	blt	00115$
	clra
	bra	00116$
00115$:
	lda	#0x01
00116$:
	sta	*__divslong_sloc1_1_0
	lda	__divslong_PARM_2
	sub	#0x00
	blt	00117$
	clra
	bra	00118$
00117$:
	lda	#0x01
00118$:
	eor	*__divslong_sloc1_1_0
	tsta
	beq	00102$
00119$:
;../_divslong.c:266: return -r;
	clra
	sub	(__divslong_r_1_1 + 3)
	sta	*(__divslong_sloc1_1_0 + 3)
	clra
	sbc	(__divslong_r_1_1 + 2)
	sta	*(__divslong_sloc1_1_0 + 2)
	clra
	sbc	(__divslong_r_1_1 + 1)
	sta	*(__divslong_sloc1_1_0 + 1)
	clra
	sbc	__divslong_r_1_1
	sta	*__divslong_sloc1_1_0
	mov	*__divslong_sloc1_1_0,*__ret3
	mov	*(__divslong_sloc1_1_0 + 1),*__ret2
	ldx	*(__divslong_sloc1_1_0 + 2)
	lda	*(__divslong_sloc1_1_0 + 3)
	rts
00102$:
;../_divslong.c:268: return r;
	lda	__divslong_r_1_1
	sta	*__ret3
	lda	(__divslong_r_1_1 + 1)
	sta	*__ret2
	ldx	(__divslong_r_1_1 + 2)
	lda	(__divslong_r_1_1 + 3)
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
