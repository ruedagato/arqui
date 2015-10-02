;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:32 2015
;--------------------------------------------------------
	.module _memmove
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
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
	.area OSEG    (OVR,DATA)
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
;src                       Allocated to stack - offset -5
;acount                    Allocated to stack - offset -7
;dst                       Allocated to registers r2 r3 r4 
;ret                       Allocated to stack - offset 1
;d                         Allocated to stack - offset 4
;s                         Allocated to stack - offset 7
;sloc0                     Allocated to stack - offset 10
;sloc1                     Allocated to stack - offset 12
;sloc2                     Allocated to stack - offset 15
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
	push	_bp
	mov	a,sp
	mov	_bp,a
	add	a,#0x11
	mov	sp,a
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	_memmove.c:45: void * ret = dst;
	mov	r0,_bp
	inc	r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
;	_memmove.c:49: if (((int)src < (int)dst) && ((((int)src)+acount) > (int)dst)) {
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	clr	c
	mov	a,r5
	subb	a,@r0
	mov	a,r6
	xrl	a,#0x80
	inc	r0
	mov	b,@r0
	xrl	b,#0x80
	subb	a,b
	jc	00121$
	ljmp	00108$
00121$:
	push	ar2
	push	ar3
	push	ar4
	mov	a,_bp
	add	a,#0xf9
	mov	r0,a
	mov	a,@r0
	add	a,r5
	mov	r5,a
	inc	r0
	mov	a,@r0
	addc	a,r6
	mov	r6,a
	mov	a,_bp
	add	a,#0x0a
	mov	r0,a
	mov	ar7,@r0
	inc	r0
	mov	ar2,@r0
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
	mov	a,_bp
	add	a,#0xf9
	mov	r0,a
	mov	a,@r0
	add	a,r2
	mov	r5,a
	inc	r0
	mov	a,@r0
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
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
	inc	r0
	mov	ar7,@r0
	mov	a,_bp
	add	a,#0xf9
	mov	r0,a
	mov	a,@r0
	add	a,r5
	mov	r5,a
	inc	r0
	mov	a,@r0
	addc	a,r6
	mov	r6,a
	dec	r5
	cjne	r5,#0xff,00123$
	dec	r6
00123$:
;	_memmove.c:55: while (acount--) {
	mov	a,_bp
	add	a,#0x0f
	mov	r0,a
	mov	@r0,ar5
	inc	r0
	mov	@r0,ar6
	inc	r0
	mov	@r0,ar7
	mov	a,_bp
	add	a,#0x0c
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	mov	a,_bp
	add	a,#0xf9
	mov	r0,a
	mov	ar2,@r0
	inc	r0
	mov	ar3,@r0
00101$:
	mov	ar5,r2
	mov	ar6,r3
	dec	r2
	cjne	r2,#0xff,00124$
	dec	r3
00124$:
	mov	a,r5
	orl	a,r6
	jnz	00125$
	ljmp	00109$
00125$:
;	_memmove.c:56: *d-- = *s--;
	mov	a,_bp
	add	a,#0x0f
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
	mov	a,_bp
	add	a,#0x0f
	mov	r0,a
	dec	@r0
	cjne	@r0,#0xff,00126$
	inc	r0
	dec	@r0
00126$:
	mov	a,_bp
	add	a,#0x0c
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	mov	a,r5
	lcall	__gptrput
	mov	a,_bp
	add	a,#0x0c
	mov	r0,a
	dec	@r0
	cjne	@r0,#0xff,00101$
	inc	r0
	dec	@r0
	sjmp	00101$
00108$:
;	_memmove.c:64: s = src;
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
	inc	r0
	mov	ar7,@r0
;	_memmove.c:65: while (acount--) {
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
	mov	@r0,ar5
	inc	r0
	mov	@r0,ar6
	inc	r0
	mov	@r0,ar7
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	mov	a,_bp
	add	a,#0xf9
	mov	r0,a
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
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
	mov	a,_bp
	add	a,#0x07
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	dec	r0
	dec	r0
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	mov	a,_bp
	add	a,#0x04
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	dec	r0
	dec	r0
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	sjmp	00104$
00109$:
;	_memmove.c:70: return(ret);
	mov	r0,_bp
	inc	r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	mov	sp,_bp
	pop	_bp
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
