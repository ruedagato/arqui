;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:26 2015
;--------------------------------------------------------
	.module _memmove
	.optsdcc -mmcs51 --model-medium
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memmove_PARM_3
	.globl _memmove_PARM_2
	.globl _memmove
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
_memmove_sloc0_1_0::
	.ds 2
_memmove_sloc1_1_0::
	.ds 3
_memmove_sloc2_1_0::
	.ds 3
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
_memmove_PARM_2:
	.ds 3
_memmove_PARM_3:
	.ds 2
_memmove_ret_1_1:
	.ds 3
_memmove_d_1_1:
	.ds 3
_memmove_s_1_1:
	.ds 3
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
;Allocation info for local variables in function 'memmove'
;------------------------------------------------------------
;sloc0                     Allocated with name '_memmove_sloc0_1_0'
;sloc1                     Allocated with name '_memmove_sloc1_1_0'
;sloc2                     Allocated with name '_memmove_sloc2_1_0'
;------------------------------------------------------------
;	_memmove.c:39: void * memmove (
;	-----------------------------------------
;	 function memmove
;	-----------------------------------------
_memmove:
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
;	_memmove.c:45: void * ret = dst;
	mov	r0,#_memmove_ret_1_1
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
;	_memmove.c:49: if (((int)src < (int)dst) && ((((int)src)+acount) > (int)dst)) {
	mov	r0,#_memmove_PARM_2
	movx	a,@r0
	mov	r5,a
	inc	r0
	movx	a,@r0
	mov	r6,a
	mov	_memmove_sloc0_1_0,r2
	mov	(_memmove_sloc0_1_0 + 1),r3
	clr	c
	mov	a,r5
	subb	a,_memmove_sloc0_1_0
	mov	a,r6
	xrl	a,#0x80
	mov	b,(_memmove_sloc0_1_0 + 1)
	xrl	b,#0x80
	subb	a,b
	jc	00121$
	ljmp	00108$
00121$:
	push	ar2
	push	ar3
	push	ar4
	mov	r0,#_memmove_PARM_3
	movx	a,@r0
	add	a,r5
	mov	r5,a
	inc	r0
	movx	a,@r0
	addc	a,r6
	mov	r6,a
	mov	r7,_memmove_sloc0_1_0
	mov	r2,(_memmove_sloc0_1_0 + 1)
	clr	c
	mov	a,r7
	subb	a,r5
	mov	a,r2
	subb	a,r6
	pop	ar4
	pop	ar3
	pop	ar2
	jc	00122$
	ljmp	00108$
00122$:
;	_memmove.c:53: d = ((char *)dst)+acount-1;
	mov	r0,#_memmove_PARM_3
	movx	a,@r0
	add	a,r2
	mov	r5,a
	inc	r0
	movx	a,@r0
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	a,r5
	add	a,#0xff
	mov	r2,a
	mov	a,r6
	addc	a,#0xff
	mov	r3,a
	mov	ar4,r7
;	_memmove.c:54: s = ((char *)src)+acount-1;
	mov	r0,#_memmove_PARM_2
	mov	r1,#_memmove_PARM_3
	movx	a,@r1
	xch	a,b
	movx	a,@r0
	add	a,b
	mov	r5,a
	inc	r1
	movx	a,@r1
	xch	a,b
	inc	r0
	movx	a,@r0
	addc	a,b
	mov	r6,a
	inc	r0
	movx	a,@r0
	mov	r7,a
	dec	r5
	cjne	r5,#0xff,00123$
	dec	r6
00123$:
;	_memmove.c:55: while (acount--) {
	mov	_memmove_sloc2_1_0,r5
	mov	(_memmove_sloc2_1_0 + 1),r6
	mov	(_memmove_sloc2_1_0 + 2),r7
	mov	_memmove_sloc1_1_0,r2
	mov	(_memmove_sloc1_1_0 + 1),r3
	mov	(_memmove_sloc1_1_0 + 2),r4
	mov	r0,#_memmove_PARM_3
	movx	a,@r0
	mov	_memmove_sloc0_1_0,a
	inc	r0
	movx	a,@r0
	mov	(_memmove_sloc0_1_0 + 1),a
00101$:
	mov	r5,_memmove_sloc0_1_0
	mov	r6,(_memmove_sloc0_1_0 + 1)
	dec	_memmove_sloc0_1_0
	mov	a,#0xff
	cjne	a,_memmove_sloc0_1_0,00124$
	dec	(_memmove_sloc0_1_0 + 1)
00124$:
	mov	a,r5
	orl	a,r6
	jnz	00125$
	ljmp	00109$
00125$:
;	_memmove.c:56: *d-- = *s--;
	mov	dpl,_memmove_sloc2_1_0
	mov	dph,(_memmove_sloc2_1_0 + 1)
	mov	b,(_memmove_sloc2_1_0 + 2)
	lcall	__gptrget
	mov	r5,a
	dec	_memmove_sloc2_1_0
	mov	a,#0xff
	cjne	a,_memmove_sloc2_1_0,00126$
	dec	(_memmove_sloc2_1_0 + 1)
00126$:
	mov	dpl,_memmove_sloc1_1_0
	mov	dph,(_memmove_sloc1_1_0 + 1)
	mov	b,(_memmove_sloc1_1_0 + 2)
	mov	a,r5
	lcall	__gptrput
	dec	_memmove_sloc1_1_0
	mov	a,#0xff
	cjne	a,_memmove_sloc1_1_0,00101$
	dec	(_memmove_sloc1_1_0 + 1)
	sjmp	00101$
00108$:
;	_memmove.c:64: s = src;
	mov	r0,#_memmove_PARM_2
	movx	a,@r0
	mov	r5,a
	inc	r0
	movx	a,@r0
	mov	r6,a
	inc	r0
	movx	a,@r0
	mov	r7,a
;	_memmove.c:65: while (acount--) {
	mov	r0,#_memmove_s_1_1
	mov	a,r5
	movx	@r0,a
	inc	r0
	mov	a,r6
	movx	@r0,a
	inc	r0
	mov	a,r7
	movx	@r0,a
	mov	r0,#_memmove_d_1_1
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
	mov	r0,#_memmove_PARM_3
	movx	a,@r0
	mov	r5,a
	inc	r0
	movx	a,@r0
	mov	r6,a
00104$:
	mov	ar7,r5
	mov	ar2,r6
	dec	r5
	cjne	r5,#0xff,00127$
	dec	r6
00127$:
	mov	a,r7
	orl	a,r2
	jz	00109$
;	_memmove.c:66: *d++ = *s++;
	mov	r0,#_memmove_s_1_1
	movx	a,@r0
	mov	dpl,a
	inc	r0
	movx	a,@r0
	mov	dph,a
	inc	r0
	movx	a,@r0
	mov	b,a
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	dec	r0
	dec	r0
	mov	a,dpl
	movx	@r0,a
	inc	r0
	mov	a,dph
	movx	@r0,a
	mov	r0,#_memmove_d_1_1
	movx	a,@r0
	mov	dpl,a
	inc	r0
	movx	a,@r0
	mov	dph,a
	inc	r0
	movx	a,@r0
	mov	b,a
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	dec	r0
	dec	r0
	mov	a,dpl
	movx	@r0,a
	inc	r0
	mov	a,dph
	movx	@r0,a
	sjmp	00104$
00109$:
;	_memmove.c:70: return(ret);
	mov	r0,#_memmove_ret_1_1
	movx	a,@r0
	mov	dpl,a
	inc	r0
	movx	a,@r0
	mov	dph,a
	inc	r0
	movx	a,@r0
	mov	b,a
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
