;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module frexpf
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
	.globl _frexpf_PARM_2
	.globl _frexpf_PARM_1
	.globl _frexpf
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_frexpf_sloc0_1_0::
	.ds 4
_frexpf_sloc1_1_0::
	.ds 2
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
_frexpf_PARM_1:
	.ds 4
_frexpf_PARM_2:
	.ds 2
_frexpf_fl_1_1:
	.ds 4
_frexpf_i_1_1:
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
;Allocation info for local variables in function 'frexpf'
;------------------------------------------------------------
;x                         Allocated with name '_frexpf_PARM_1'
;pw2                       Allocated with name '_frexpf_PARM_2'
;fl                        Allocated with name '_frexpf_fl_1_1'
;i                         Allocated with name '_frexpf_i_1_1'
;sloc0                     Allocated with name '_frexpf_sloc0_1_0'
;sloc1                     Allocated with name '_frexpf_sloc1_1_0'
;------------------------------------------------------------
;../frexpf.c:34: float frexpf(const float x, int *pw2)
;	-----------------------------------------
;	 function frexpf
;	-----------------------------------------
_frexpf:
;../frexpf.c:39: fl.f=x;
	lda	_frexpf_PARM_1
	sta	_frexpf_fl_1_1
	lda	(_frexpf_PARM_1 + 1)
	sta	(_frexpf_fl_1_1 + 1)
	lda	(_frexpf_PARM_1 + 2)
	sta	(_frexpf_fl_1_1 + 2)
	lda	(_frexpf_PARM_1 + 3)
	sta	(_frexpf_fl_1_1 + 3)
;../frexpf.c:41: i  = ( fl.l >> 23) & 0x000000ff;
	lda	_frexpf_fl_1_1
	sta	*_frexpf_sloc0_1_0
	lda	(_frexpf_fl_1_1 + 1)
	sta	*(_frexpf_sloc0_1_0 + 1)
	lda	(_frexpf_fl_1_1 + 2)
	sta	*(_frexpf_sloc0_1_0 + 2)
	lda	(_frexpf_fl_1_1 + 3)
	sta	*(_frexpf_sloc0_1_0 + 3)
	lda	*(_frexpf_sloc0_1_0 + 1)
	ldx	*_frexpf_sloc0_1_0
	asrx
	rora
	asrx
	rora
	asrx
	rora
	asrx
	rora
	asrx
	rora
	asrx
	rora
	asrx
	rora
	sta	*(_frexpf_sloc0_1_0 + 3)
	stx	*(_frexpf_sloc0_1_0 + 2)
	txa
	rola
	clra
	sbc	#0
	sta	*(_frexpf_sloc0_1_0 + 1)
	sta	*_frexpf_sloc0_1_0
	lda	*(_frexpf_sloc0_1_0 + 3)
	sta	(_frexpf_i_1_1 + 3)
	clra
	sta	(_frexpf_i_1_1 + 2)
	sta	(_frexpf_i_1_1 + 1)
	sta	_frexpf_i_1_1
;../frexpf.c:42: i -= 0x7e;
	lda	(_frexpf_i_1_1 + 3)
	sub	#0x7E
	sta	(_frexpf_i_1_1 + 3)
	lda	(_frexpf_i_1_1 + 2)
	sbc	#0x00
	sta	(_frexpf_i_1_1 + 2)
	lda	(_frexpf_i_1_1 + 1)
	sbc	#0x00
	sta	(_frexpf_i_1_1 + 1)
	lda	_frexpf_i_1_1
	sbc	#0x00
	sta	_frexpf_i_1_1
;../frexpf.c:43: *pw2 = i;
	lda	_frexpf_PARM_2
	sta	*_frexpf_sloc0_1_0
	lda	(_frexpf_PARM_2 + 1)
	sta	*(_frexpf_sloc0_1_0 + 1)
	lda	(_frexpf_i_1_1 + 3)
	sta	*(_frexpf_sloc1_1_0 + 1)
	lda	(_frexpf_i_1_1 + 2)
	sta	*_frexpf_sloc1_1_0
	ldhx	*_frexpf_sloc0_1_0
	lda	*_frexpf_sloc1_1_0
	sta	,x
	aix	#1
	lda	*(_frexpf_sloc1_1_0 + 1)
	sta	,x
;../frexpf.c:44: fl.l &= 0x807fffff; /* strip all exponent bits */
	lda	_frexpf_fl_1_1
	sta	*_frexpf_sloc0_1_0
	lda	(_frexpf_fl_1_1 + 1)
	sta	*(_frexpf_sloc0_1_0 + 1)
	lda	(_frexpf_fl_1_1 + 2)
	sta	*(_frexpf_sloc0_1_0 + 2)
	lda	(_frexpf_fl_1_1 + 3)
	sta	*(_frexpf_sloc0_1_0 + 3)
	lda	*(_frexpf_sloc0_1_0 + 1)
	and	#0x7F
	sta	*(_frexpf_sloc0_1_0 + 1)
	lda	*_frexpf_sloc0_1_0
	and	#0x80
	sta	*_frexpf_sloc0_1_0
	lda	*_frexpf_sloc0_1_0
	sta	_frexpf_fl_1_1
	lda	*(_frexpf_sloc0_1_0 + 1)
	sta	(_frexpf_fl_1_1 + 1)
	lda	*(_frexpf_sloc0_1_0 + 2)
	sta	(_frexpf_fl_1_1 + 2)
	lda	*(_frexpf_sloc0_1_0 + 3)
	sta	(_frexpf_fl_1_1 + 3)
;../frexpf.c:45: fl.l |= 0x3f000000; /* mantissa between 0.5 and 1 */
	lda	_frexpf_fl_1_1
	sta	*_frexpf_sloc0_1_0
	lda	(_frexpf_fl_1_1 + 1)
	sta	*(_frexpf_sloc0_1_0 + 1)
	lda	(_frexpf_fl_1_1 + 2)
	sta	*(_frexpf_sloc0_1_0 + 2)
	lda	(_frexpf_fl_1_1 + 3)
	sta	*(_frexpf_sloc0_1_0 + 3)
	lda	*_frexpf_sloc0_1_0
	ora	#0x3F
	sta	*_frexpf_sloc0_1_0
	lda	*_frexpf_sloc0_1_0
	sta	_frexpf_fl_1_1
	lda	*(_frexpf_sloc0_1_0 + 1)
	sta	(_frexpf_fl_1_1 + 1)
	lda	*(_frexpf_sloc0_1_0 + 2)
	sta	(_frexpf_fl_1_1 + 2)
	lda	*(_frexpf_sloc0_1_0 + 3)
	sta	(_frexpf_fl_1_1 + 3)
;../frexpf.c:46: return(fl.f);
	lda	_frexpf_fl_1_1
	sta	*_frexpf_sloc0_1_0
	lda	(_frexpf_fl_1_1 + 1)
	sta	*(_frexpf_sloc0_1_0 + 1)
	lda	(_frexpf_fl_1_1 + 2)
	sta	*(_frexpf_sloc0_1_0 + 2)
	lda	(_frexpf_fl_1_1 + 3)
	sta	*(_frexpf_sloc0_1_0 + 3)
	mov	*_frexpf_sloc0_1_0,*__ret3
	mov	*(_frexpf_sloc0_1_0 + 1),*__ret2
	ldx	*(_frexpf_sloc0_1_0 + 2)
	lda	*(_frexpf_sloc0_1_0 + 3)
00101$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
