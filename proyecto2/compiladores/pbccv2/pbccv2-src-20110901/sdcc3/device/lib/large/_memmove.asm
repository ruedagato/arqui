;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:29 2015
;--------------------------------------------------------
	.module _memmove
	.optsdcc -mmcs51 --model-large
	
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
_memmove_sloc3_1_0::
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
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_memmove_PARM_2:
	.ds 3
_memmove_PARM_3:
	.ds 2
_memmove_dst_1_1:
	.ds 3
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
;src                       Allocated with name '_memmove_PARM_2'
;acount                    Allocated with name '_memmove_PARM_3'
;dst                       Allocated with name '_memmove_dst_1_1'
;ret                       Allocated with name '_memmove_ret_1_1'
;d                         Allocated with name '_memmove_d_1_1'
;s                         Allocated with name '_memmove_s_1_1'
;sloc0                     Allocated with name '_memmove_sloc0_1_0'
;sloc1                     Allocated with name '_memmove_sloc1_1_0'
;sloc2                     Allocated with name '_memmove_sloc2_1_0'
;sloc3                     Allocated with name '_memmove_sloc3_1_0'
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
	mov	r2,b
	mov	r3,dph
	mov	a,dpl
	mov	dptr,#_memmove_dst_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
;	_memmove.c:45: void * ret = dst;
	mov	dptr,#_memmove_dst_1_1
	movx	a,@dptr
	mov	_memmove_sloc3_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_memmove_sloc3_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_memmove_sloc3_1_0 + 2),a
;	_memmove.c:49: if (((int)src < (int)dst) && ((((int)src)+acount) > (int)dst)) {
	mov	dptr,#_memmove_PARM_2
	movx	a,@dptr
	mov	_memmove_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_memmove_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_memmove_sloc1_1_0 + 2),a
	mov	_memmove_sloc0_1_0,_memmove_sloc1_1_0
	mov	(_memmove_sloc0_1_0 + 1),(_memmove_sloc1_1_0 + 1)
	mov	r0,_memmove_sloc3_1_0
	mov	r1,(_memmove_sloc3_1_0 + 1)
	mov	r5,(_memmove_sloc3_1_0 + 2)
	clr	c
	mov	a,_memmove_sloc0_1_0
	subb	a,r0
	mov	a,(_memmove_sloc0_1_0 + 1)
	xrl	a,#0x80
	mov	b,r1
	xrl	b,#0x80
	subb	a,b
	jc	00121$
	ljmp	00118$
00121$:
	mov	r5,_memmove_sloc1_1_0
	mov	r6,(_memmove_sloc1_1_0 + 1)
	mov	dptr,#_memmove_PARM_3
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	mov	a,r7
	add	a,r5
	mov	_memmove_sloc0_1_0,a
	mov	a,r0
	addc	a,r6
	mov	(_memmove_sloc0_1_0 + 1),a
	mov	r1,_memmove_sloc3_1_0
	mov	r5,(_memmove_sloc3_1_0 + 1)
	mov	r6,(_memmove_sloc3_1_0 + 2)
	clr	c
	mov	a,r1
	subb	a,_memmove_sloc0_1_0
	mov	a,r5
	subb	a,(_memmove_sloc0_1_0 + 1)
	jnc	00118$
;	_memmove.c:53: d = ((char *)dst)+acount-1;
	mov	a,r7
	add	a,_memmove_sloc3_1_0
	mov	r5,a
	mov	a,r0
	addc	a,(_memmove_sloc3_1_0 + 1)
	mov	r6,a
	mov	r1,(_memmove_sloc3_1_0 + 2)
	mov	a,r5
	add	a,#0xff
	mov	_memmove_sloc2_1_0,a
	mov	a,r6
	addc	a,#0xff
	mov	(_memmove_sloc2_1_0 + 1),a
	mov	(_memmove_sloc2_1_0 + 2),r1
;	_memmove.c:54: s = ((char *)src)+acount-1;
	mov	a,r7
	add	a,_memmove_sloc1_1_0
	mov	r5,a
	mov	a,r0
	addc	a,(_memmove_sloc1_1_0 + 1)
	mov	r6,a
	mov	r1,(_memmove_sloc1_1_0 + 2)
	dec	r5
	cjne	r5,#0xff,00123$
	dec	r6
00123$:
;	_memmove.c:55: while (acount--) {
00101$:
	mov	ar2,r7
	mov	ar3,r0
	dec	r7
	cjne	r7,#0xff,00124$
	dec	r0
00124$:
	mov	a,r2
	orl	a,r3
	jz	00109$
;	_memmove.c:56: *d-- = *s--;
	mov	dpl,r5
	mov	dph,r6
	mov	b,r1
	lcall	__gptrget
	mov	r2,a
	dec	r5
	cjne	r5,#0xff,00126$
	dec	r6
00126$:
	mov	dpl,_memmove_sloc2_1_0
	mov	dph,(_memmove_sloc2_1_0 + 1)
	mov	b,(_memmove_sloc2_1_0 + 2)
	mov	a,r2
	lcall	__gptrput
	dec	_memmove_sloc2_1_0
	mov	a,#0xff
	cjne	a,_memmove_sloc2_1_0,00101$
	dec	(_memmove_sloc2_1_0 + 1)
;	_memmove.c:65: while (acount--) {
	sjmp	00101$
00118$:
	mov	r2,_memmove_sloc1_1_0
	mov	r3,(_memmove_sloc1_1_0 + 1)
	mov	r4,(_memmove_sloc1_1_0 + 2)
	mov	r5,_memmove_sloc3_1_0
	mov	r6,(_memmove_sloc3_1_0 + 1)
	mov	r7,(_memmove_sloc3_1_0 + 2)
	mov	dptr,#_memmove_PARM_3
	movx	a,@dptr
	mov	_memmove_sloc2_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_memmove_sloc2_1_0 + 1),a
00104$:
	mov	r0,_memmove_sloc2_1_0
	mov	r1,(_memmove_sloc2_1_0 + 1)
	dec	_memmove_sloc2_1_0
	mov	a,#0xff
	cjne	a,_memmove_sloc2_1_0,00127$
	dec	(_memmove_sloc2_1_0 + 1)
00127$:
	mov	a,r0
	orl	a,r1
	jz	00109$
;	_memmove.c:66: *d++ = *s++;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r0,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	__gptrput
	inc	dptr
	mov	r5,dpl
	mov	r6,dph
	sjmp	00104$
00109$:
;	_memmove.c:70: return(ret);
	mov	dpl,_memmove_sloc3_1_0
	mov	dph,(_memmove_sloc3_1_0 + 1)
	mov	b,(_memmove_sloc3_1_0 + 2)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
