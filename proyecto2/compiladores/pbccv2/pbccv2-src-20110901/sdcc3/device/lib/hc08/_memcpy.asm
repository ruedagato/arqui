;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _memcpy
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
	.globl _memcpy_PARM_3
	.globl _memcpy_PARM_2
	.globl _memcpy
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_memcpy_sloc0_1_0::
	.ds 2
_memcpy_sloc1_1_0::
	.ds 2
_memcpy_sloc2_1_0::
	.ds 2
_memcpy_sloc3_1_0::
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
_memcpy_PARM_2:
	.ds 2
_memcpy_PARM_3:
	.ds 2
_memcpy_dst_1_1:
	.ds 2
_memcpy_ret_1_1:
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
;Allocation info for local variables in function 'memcpy'
;------------------------------------------------------------
;src                       Allocated with name '_memcpy_PARM_2'
;acount                    Allocated with name '_memcpy_PARM_3'
;dst                       Allocated with name '_memcpy_dst_1_1'
;ret                       Allocated with name '_memcpy_ret_1_1'
;d                         Allocated to registers 
;s                         Allocated to registers 
;sloc0                     Allocated with name '_memcpy_sloc0_1_0'
;sloc1                     Allocated with name '_memcpy_sloc1_1_0'
;sloc2                     Allocated with name '_memcpy_sloc2_1_0'
;sloc3                     Allocated with name '_memcpy_sloc3_1_0'
;------------------------------------------------------------
;../_memcpy.c:36: void * memcpy (
;	-----------------------------------------
;	 function memcpy
;	-----------------------------------------
_memcpy:
	sta	(_memcpy_dst_1_1 + 1)
	stx	_memcpy_dst_1_1
;../_memcpy.c:42: void * ret = dst;
	lda	_memcpy_dst_1_1
	sta	_memcpy_ret_1_1
	lda	(_memcpy_dst_1_1 + 1)
	sta	(_memcpy_ret_1_1 + 1)
;../_memcpy.c:44: char * s = src;
;../_memcpy.c:49: while (acount--) {
	lda	_memcpy_PARM_2
	sta	*_memcpy_sloc0_1_0
	lda	(_memcpy_PARM_2 + 1)
	sta	*(_memcpy_sloc0_1_0 + 1)
	lda	_memcpy_dst_1_1
	sta	*_memcpy_sloc1_1_0
	lda	(_memcpy_dst_1_1 + 1)
	sta	*(_memcpy_sloc1_1_0 + 1)
	lda	_memcpy_PARM_3
	sta	*_memcpy_sloc2_1_0
	lda	(_memcpy_PARM_3 + 1)
	sta	*(_memcpy_sloc2_1_0 + 1)
00101$:
	mov	*_memcpy_sloc2_1_0,*_memcpy_sloc3_1_0
	mov	*(_memcpy_sloc2_1_0 + 1),*(_memcpy_sloc3_1_0 + 1)
	lda	*(_memcpy_sloc2_1_0 + 1)
	sub	#0x01
	sta	*(_memcpy_sloc2_1_0 + 1)
	lda	*_memcpy_sloc2_1_0
	sbc	#0x00
	sta	*_memcpy_sloc2_1_0
	lda	*(_memcpy_sloc3_1_0 + 1)
	ora	*_memcpy_sloc3_1_0
	beq	00103$
00109$:
;../_memcpy.c:50: *d++ = *s++;
	ldhx	*_memcpy_sloc0_1_0
	lda	,x
	aix	#1
	sta	*_memcpy_sloc3_1_0
	sthx	*_memcpy_sloc0_1_0
	ldhx	*_memcpy_sloc1_1_0
	lda	*_memcpy_sloc3_1_0
	sta	,x
	aix	#1
	sthx	*_memcpy_sloc1_1_0
	bra	00101$
00103$:
;../_memcpy.c:53: return(ret);
	ldx	_memcpy_ret_1_1
	lda	(_memcpy_ret_1_1 + 1)
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
