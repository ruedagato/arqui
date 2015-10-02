;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:24 2015
;--------------------------------------------------------
	.module _memmove
	.optsdcc -mmcs51 --model-small
	
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
_memmove_PARM_2::
	.ds 3
_memmove_PARM_3::
	.ds 2
_memmove_ret_1_1::
	.ds 3
_memmove_d_1_1::
	.ds 3
_memmove_s_1_1::
	.ds 3
_memmove_sloc0_1_0::
	.ds 2
_memmove_sloc1_1_0::
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
;dst                       Allocated to registers r2 r3 r4 
;ret                       Allocated with name '_memmove_ret_1_1'
;d                         Allocated with name '_memmove_d_1_1'
;s                         Allocated with name '_memmove_s_1_1'
;sloc0                     Allocated with name '_memmove_sloc0_1_0'
;sloc1                     Allocated with name '_memmove_sloc1_1_0'
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
	mov	_memmove_ret_1_1,r2
	mov	(_memmove_ret_1_1 + 1),r3
	mov	(_memmove_ret_1_1 + 2),r4
;	_memmove.c:49: if (((int)src < (int)dst) && ((((int)src)+acount) > (int)dst)) {
	mov	r0,_memmove_PARM_2
	mov	r1,(_memmove_PARM_2 + 1)
	mov	_memmove_sloc0_1_0,r2
	mov	(_memmove_sloc0_1_0 + 1),r3
	clr	c
	mov	a,r0
	subb	a,_memmove_sloc0_1_0
	mov	a,r1
	xrl	a,#0x80
	mov	b,(_memmove_sloc0_1_0 + 1)
	xrl	b,#0x80
	subb	a,b
	jc	00121$
	ljmp	00108$
00121$:
	mov	a,_memmove_PARM_3
	add	a,r0
	mov	r0,a
	mov	a,(_memmove_PARM_3 + 1)
	addc	a,r1
	mov	r1,a
	mov	r5,_memmove_sloc0_1_0
	mov	r6,(_memmove_sloc0_1_0 + 1)
	clr	c
	mov	a,r5
	subb	a,r0
	mov	a,r6
	subb	a,r1
	jnc	00108$
;	_memmove.c:53: d = ((char *)dst)+acount-1;
	mov	a,_memmove_PARM_3
	add	a,r2
	mov	r5,a
	mov	a,(_memmove_PARM_3 + 1)
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	a,r5
	add	a,#0xff
	mov	_memmove_d_1_1,a
	mov	a,r6
	addc	a,#0xff
	mov	(_memmove_d_1_1 + 1),a
	mov	(_memmove_d_1_1 + 2),r7
;	_memmove.c:54: s = ((char *)src)+acount-1;
	mov	a,_memmove_PARM_3
	add	a,_memmove_PARM_2
	mov	r0,a
	mov	a,(_memmove_PARM_3 + 1)
	addc	a,(_memmove_PARM_2 + 1)
	mov	r1,a
	mov	r5,(_memmove_PARM_2 + 2)
	mov	a,r0
	add	a,#0xff
	mov	r7,a
	mov	a,r1
	addc	a,#0xff
	mov	r6,a
;	_memmove.c:55: while (acount--) {
	mov	_memmove_sloc1_1_0,_memmove_d_1_1
	mov	(_memmove_sloc1_1_0 + 1),(_memmove_d_1_1 + 1)
	mov	(_memmove_sloc1_1_0 + 2),(_memmove_d_1_1 + 2)
	mov	_memmove_sloc0_1_0,_memmove_PARM_3
	mov	(_memmove_sloc0_1_0 + 1),(_memmove_PARM_3 + 1)
00101$:
	mov	r0,_memmove_sloc0_1_0
	mov	r1,(_memmove_sloc0_1_0 + 1)
	dec	_memmove_sloc0_1_0
	mov	a,#0xff
	cjne	a,_memmove_sloc0_1_0,00123$
	dec	(_memmove_sloc0_1_0 + 1)
00123$:
	mov	a,r0
	orl	a,r1
	jz	00109$
;	_memmove.c:56: *d-- = *s--;
	mov	dpl,r7
	mov	dph,r6
	mov	b,r5
	lcall	__gptrget
	mov	r0,a
	dec	r7
	cjne	r7,#0xff,00125$
	dec	r6
00125$:
	mov	dpl,_memmove_sloc1_1_0
	mov	dph,(_memmove_sloc1_1_0 + 1)
	mov	b,(_memmove_sloc1_1_0 + 2)
	mov	a,r0
	lcall	__gptrput
	dec	_memmove_sloc1_1_0
	mov	a,#0xff
	cjne	a,_memmove_sloc1_1_0,00101$
	dec	(_memmove_sloc1_1_0 + 1)
	sjmp	00101$
00108$:
;	_memmove.c:64: s = src;
	mov	r5,_memmove_PARM_2
	mov	r6,(_memmove_PARM_2 + 1)
	mov	r7,(_memmove_PARM_2 + 2)
;	_memmove.c:65: while (acount--) {
	mov	_memmove_s_1_1,r5
	mov	(_memmove_s_1_1 + 1),r6
	mov	(_memmove_s_1_1 + 2),r7
	mov	r0,_memmove_PARM_3
	mov	r1,(_memmove_PARM_3 + 1)
00104$:
	mov	ar5,r0
	mov	ar6,r1
	dec	r0
	cjne	r0,#0xff,00126$
	dec	r1
00126$:
	mov	a,r5
	orl	a,r6
	jz	00109$
;	_memmove.c:66: *d++ = *s++;
	mov	dpl,_memmove_s_1_1
	mov	dph,(_memmove_s_1_1 + 1)
	mov	b,(_memmove_s_1_1 + 2)
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	mov	_memmove_s_1_1,dpl
	mov	(_memmove_s_1_1 + 1),dph
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	sjmp	00104$
00109$:
;	_memmove.c:70: return(ret);
	mov	dpl,_memmove_ret_1_1
	mov	dph,(_memmove_ret_1_1 + 1)
	mov	b,(_memmove_ret_1_1 + 2)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
