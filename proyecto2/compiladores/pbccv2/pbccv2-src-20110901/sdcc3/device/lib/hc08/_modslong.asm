;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _modslong
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
	.globl __modslong_PARM_2
	.globl __modslong_PARM_1
	.globl __modslong
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
__modslong_sloc0_1_0:
	.ds 4
__modslong_sloc1_1_0:
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
__modslong_PARM_1:
	.ds 4
__modslong_PARM_2:
	.ds 4
__modslong_r_1_1:
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
;Allocation info for local variables in function '_modslong'
;------------------------------------------------------------
;sloc0                     Allocated with name '__modslong_sloc0_1_0'
;sloc1                     Allocated with name '__modslong_sloc1_1_0'
;a                         Allocated with name '__modslong_PARM_1'
;b                         Allocated with name '__modslong_PARM_2'
;r                         Allocated with name '__modslong_r_1_1'
;------------------------------------------------------------
;../_modslong.c:259: _modslong (long a, long b)
;	-----------------------------------------
;	 function _modslong
;	-----------------------------------------
__modslong:
;../_modslong.c:263: r = _modulong((a < 0 ? -a : a),
	lda	__modslong_PARM_1
	sub	#0x00
	bge	00106$
00113$:
	clra
	sub	(__modslong_PARM_1 + 3)
	sta	*(__modslong_sloc0_1_0 + 3)
	clra
	sbc	(__modslong_PARM_1 + 2)
	sta	*(__modslong_sloc0_1_0 + 2)
	clra
	sbc	(__modslong_PARM_1 + 1)
	sta	*(__modslong_sloc0_1_0 + 1)
	clra
	sbc	__modslong_PARM_1
	sta	*__modslong_sloc0_1_0
	bra	00107$
00106$:
	lda	__modslong_PARM_1
	sta	*__modslong_sloc0_1_0
	lda	(__modslong_PARM_1 + 1)
	sta	*(__modslong_sloc0_1_0 + 1)
	lda	(__modslong_PARM_1 + 2)
	sta	*(__modslong_sloc0_1_0 + 2)
	lda	(__modslong_PARM_1 + 3)
	sta	*(__modslong_sloc0_1_0 + 3)
00107$:
;../_modslong.c:264: (b < 0 ? -b : b));
	lda	__modslong_PARM_2
	sub	#0x00
	bge	00108$
00114$:
	clra
	sub	(__modslong_PARM_2 + 3)
	sta	*(__modslong_sloc1_1_0 + 3)
	clra
	sbc	(__modslong_PARM_2 + 2)
	sta	*(__modslong_sloc1_1_0 + 2)
	clra
	sbc	(__modslong_PARM_2 + 1)
	sta	*(__modslong_sloc1_1_0 + 1)
	clra
	sbc	__modslong_PARM_2
	sta	*__modslong_sloc1_1_0
	bra	00109$
00108$:
	lda	__modslong_PARM_2
	sta	*__modslong_sloc1_1_0
	lda	(__modslong_PARM_2 + 1)
	sta	*(__modslong_sloc1_1_0 + 1)
	lda	(__modslong_PARM_2 + 2)
	sta	*(__modslong_sloc1_1_0 + 2)
	lda	(__modslong_PARM_2 + 3)
	sta	*(__modslong_sloc1_1_0 + 3)
00109$:
	lda	*__modslong_sloc0_1_0
	sta	__modulong_PARM_1
	lda	*(__modslong_sloc0_1_0 + 1)
	sta	(__modulong_PARM_1 + 1)
	lda	*(__modslong_sloc0_1_0 + 2)
	sta	(__modulong_PARM_1 + 2)
	lda	*(__modslong_sloc0_1_0 + 3)
	sta	(__modulong_PARM_1 + 3)
	lda	*__modslong_sloc1_1_0
	sta	__modulong_PARM_2
	lda	*(__modslong_sloc1_1_0 + 1)
	sta	(__modulong_PARM_2 + 1)
	lda	*(__modslong_sloc1_1_0 + 2)
	sta	(__modulong_PARM_2 + 2)
	lda	*(__modslong_sloc1_1_0 + 3)
	sta	(__modulong_PARM_2 + 3)
	jsr	__modulong
	sta	(__modslong_r_1_1 + 3)
	stx	(__modslong_r_1_1 + 2)
	lda	*__ret2
	sta	(__modslong_r_1_1 + 1)
	lda	*__ret3
	sta	__modslong_r_1_1
;../_modslong.c:265: if (a < 0)
	lda	__modslong_PARM_1
	sub	#0x00
	bge	00102$
00115$:
;../_modslong.c:266: return -r;
	clra
	sub	(__modslong_r_1_1 + 3)
	sta	*(__modslong_sloc1_1_0 + 3)
	clra
	sbc	(__modslong_r_1_1 + 2)
	sta	*(__modslong_sloc1_1_0 + 2)
	clra
	sbc	(__modslong_r_1_1 + 1)
	sta	*(__modslong_sloc1_1_0 + 1)
	clra
	sbc	__modslong_r_1_1
	sta	*__modslong_sloc1_1_0
	mov	*__modslong_sloc1_1_0,*__ret3
	mov	*(__modslong_sloc1_1_0 + 1),*__ret2
	ldx	*(__modslong_sloc1_1_0 + 2)
	lda	*(__modslong_sloc1_1_0 + 3)
	rts
00102$:
;../_modslong.c:268: return r;
	lda	__modslong_r_1_1
	sta	*__ret3
	lda	(__modslong_r_1_1 + 1)
	sta	*__ret2
	ldx	(__modslong_r_1_1 + 2)
	lda	(__modslong_r_1_1 + 3)
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
