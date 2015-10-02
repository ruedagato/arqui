;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module frexpf
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _frexpf_PARM_2
	.globl _frexpf
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
_frexpf_PARM_2::
	.ds 3
_frexpf_fl_1_1::
	.ds 4
_frexpf_i_1_1::
	.ds 4
_frexpf_sloc0_1_0::
	.ds 4
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'frexpf'
;------------------------------------------------------------
;pw2                       Allocated with name '_frexpf_PARM_2'
;x                         Allocated to registers r2 r3 r4 r5 
;fl                        Allocated with name '_frexpf_fl_1_1'
;i                         Allocated with name '_frexpf_i_1_1'
;sloc0                     Allocated with name '_frexpf_sloc0_1_0'
;------------------------------------------------------------
;	frexpf.c:34: float frexpf(const float x, int *pw2)
;	-----------------------------------------
;	 function frexpf
;	-----------------------------------------
_frexpf:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	frexpf.c:39: fl.f=x;
	mov	(_frexpf_fl_1_1 + 0),r2
	mov	(_frexpf_fl_1_1 + 1),r3
	mov	(_frexpf_fl_1_1 + 2),r4
	mov	(_frexpf_fl_1_1 + 3),r5
;	frexpf.c:41: i  = ( fl.l >> 23) & 0x000000ff;
	mov	_frexpf_sloc0_1_0,_frexpf_fl_1_1
	mov	(_frexpf_sloc0_1_0 + 1),(_frexpf_fl_1_1 + 1)
	mov	(_frexpf_sloc0_1_0 + 2),(_frexpf_fl_1_1 + 2)
	mov	(_frexpf_sloc0_1_0 + 3),(_frexpf_fl_1_1 + 3)
	mov	r6,(_frexpf_sloc0_1_0 + 2)
	mov	a,(_frexpf_sloc0_1_0 + 3)
	mov	c,acc.7
	xch	a,r6
	rlc	a
	xch	a,r6
	rlc	a
	xch	a,r6
	anl	a,#0x01
	jnb	acc.0,00103$
	orl	a,#0xfe
00103$:
	rlc	a
	subb	a,acc
	mov	_frexpf_i_1_1,r6
;	frexpf.c:42: i -= 0x7e;
	clr	a
	mov	(_frexpf_i_1_1 + 1),a
	mov	(_frexpf_i_1_1 + 2),a
	mov	(_frexpf_i_1_1 + 3),a
	mov	a,_frexpf_i_1_1
	add	a,#0x82
	mov	_frexpf_i_1_1,a
	mov	a,(_frexpf_i_1_1 + 1)
	addc	a,#0xff
	mov	(_frexpf_i_1_1 + 1),a
	mov	a,(_frexpf_i_1_1 + 2)
	addc	a,#0xff
	mov	(_frexpf_i_1_1 + 2),a
	mov	a,(_frexpf_i_1_1 + 3)
	addc	a,#0xff
	mov	(_frexpf_i_1_1 + 3),a
;	frexpf.c:43: *pw2 = i;
	mov	r4,_frexpf_PARM_2
	mov	r5,(_frexpf_PARM_2 + 1)
	mov	r2,(_frexpf_PARM_2 + 2)
	mov	r6,_frexpf_i_1_1
	mov	r7,(_frexpf_i_1_1 + 1)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r6
	lcall	__gptrput
	inc	dptr
	mov	a,r7
	lcall	__gptrput
;	frexpf.c:44: fl.l &= 0x807fffff; /* strip all exponent bits */
	mov	r2,_frexpf_sloc0_1_0
	mov	r3,(_frexpf_sloc0_1_0 + 1)
	mov	a,#0x7F
	anl	a,(_frexpf_sloc0_1_0 + 2)
	mov	r4,a
	mov	a,#0x80
	anl	a,(_frexpf_sloc0_1_0 + 3)
	mov	r5,a
	mov	(_frexpf_fl_1_1 + 0),r2
;	frexpf.c:45: fl.l |= 0x3f000000; /* mantissa between 0.5 and 1 */
	mov	(_frexpf_fl_1_1 + 1),r3
	mov	(_frexpf_fl_1_1 + 2),r4
	mov	(_frexpf_fl_1_1 + 3),r5
	mov	r2,_frexpf_fl_1_1
	mov	a,#0x3F
	orl	a,(_frexpf_fl_1_1 + 3)
	mov	r5,a
	mov	(_frexpf_fl_1_1 + 0),r2
	mov	(_frexpf_fl_1_1 + 1),r3
	mov	(_frexpf_fl_1_1 + 2),r4
	mov	(_frexpf_fl_1_1 + 3),r5
;	frexpf.c:46: return(fl.f);
	mov	dpl,_frexpf_fl_1_1
	mov	dph,(_frexpf_fl_1_1 + 1)
	mov	b,(_frexpf_fl_1_1 + 2)
	mov	a,(_frexpf_fl_1_1 + 3)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
