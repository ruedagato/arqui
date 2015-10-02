;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:24 2015
;--------------------------------------------------------
	.module frexpf
	.optsdcc -mmcs51 --model-medium
	
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
_frexpf_PARM_2:
	.ds 3
_frexpf_fl_1_1:
	.ds 4
_frexpf_i_1_1:
	.ds 4
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
	mov	r0,#_frexpf_fl_1_1
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
	inc	r0
	mov	a,r5
	movx	@r0,a
;	frexpf.c:41: i  = ( fl.l >> 23) & 0x000000ff;
	mov	r0,#_frexpf_fl_1_1
	movx	a,@r0
	mov	_frexpf_sloc0_1_0,a
	inc	r0
	movx	a,@r0
	mov	(_frexpf_sloc0_1_0 + 1),a
	inc	r0
	movx	a,@r0
	mov	(_frexpf_sloc0_1_0 + 2),a
	inc	r0
	movx	a,@r0
	mov	(_frexpf_sloc0_1_0 + 3),a
	mov	r6,(_frexpf_sloc0_1_0 + 2)
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
	mov	r0,#_frexpf_i_1_1
	mov	a,r6
	movx	@r0,a
	inc	r0
	clr	a
	movx	@r0,a
	inc	r0
	movx	@r0,a
	inc	r0
	movx	@r0,a
;	frexpf.c:42: i -= 0x7e;
	mov	r0,#_frexpf_i_1_1
	movx	a,@r0
	add	a,#0x82
	movx	@r0,a
	inc	r0
	movx	a,@r0
	addc	a,#0xff
	movx	@r0,a
	inc	r0
	movx	a,@r0
	addc	a,#0xff
	movx	@r0,a
	inc	r0
	movx	a,@r0
	addc	a,#0xff
	movx	@r0,a
;	frexpf.c:43: *pw2 = i;
	mov	r0,#_frexpf_PARM_2
	movx	a,@r0
	mov	r4,a
	inc	r0
	movx	a,@r0
	mov	r5,a
	inc	r0
	movx	a,@r0
	mov	r2,a
	mov	r0,#_frexpf_i_1_1
	movx	a,@r0
	mov	r6,a
	inc	r0
	movx	a,@r0
	mov	r7,a
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
	mov	r0,#_frexpf_fl_1_1
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
	inc	r0
	mov	a,r5
	movx	@r0,a
;	frexpf.c:45: fl.l |= 0x3f000000; /* mantissa between 0.5 and 1 */
	mov	r0,#_frexpf_fl_1_1
	movx	a,@r0
	mov	r2,a
	inc	r0
	movx	a,@r0
	mov	r3,a
	inc	r0
	movx	a,@r0
	mov	r4,a
	inc	r0
	movx	a,@r0
	mov	r5,a
	orl	ar5,#0x3F
	mov	r0,#_frexpf_fl_1_1
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
	inc	r0
	mov	a,r5
	movx	@r0,a
;	frexpf.c:46: return(fl.f);
	mov	r0,#_frexpf_fl_1_1
	movx	a,@r0
	mov	r2,a
	inc	r0
	movx	a,@r0
	mov	r3,a
	inc	r0
	movx	a,@r0
	mov	r4,a
	inc	r0
	movx	a,@r0
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
