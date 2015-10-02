;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:20 2015
;--------------------------------------------------------
	.module _memmove
	.optsdcc -mds400 --model-flat24
	
;--------------------------------------------------------
; CPU specific extensions
;--------------------------------------------------------
.flat24 on		; 24 bit flat addressing
dpl1	=	0x84
dph1	=	0x85
dps	=	0x86
dpx	=	0x93
dpx1	=	0x95
esp	=	0x9B
ap	=	0x9C
_ap	=	0x9C
mcnt0	=	0xD1
mcnt1	=	0xD2
ma	=	0xD3
mb	=	0xD4
mc	=	0xD5
F1	=	0xD1	; user flag
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memmove_PARM_3
	.globl _memmove_PARM_2
	.globl _memmove
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
	.area REG_BANK_3	(REL,OVR,DATA)
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
_memmove_PARM_2:
	.ds 4
_memmove_PARM_3:
	.ds 2
_memmove_dst_1_1:
	.ds 4
_memmove_ret_1_1:
	.ds 4
_memmove_d_1_1:
	.ds 4
_memmove_sloc0_1_0:
	.ds 2
_memmove_sloc1_1_0:
	.ds 4
_memmove_sloc2_1_0:
	.ds 4
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
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
;s                         Allocated to registers r6 r7 r0 r1 
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
	mov     dps, #1
	mov     dptr, #_memmove_dst_1_1
	mov	a,dpl
	movx	@dptr,a
	inc	dptr
	mov	a,dph
	movx	@dptr,a
	inc	dptr
	mov	a,dpx
	movx	@dptr,a
	inc	dptr
	mov	a,b
	movx	@dptr,a
	mov	dps,#0
;	_memmove.c:45: void * ret = dst;
	mov	dptr,#_memmove_dst_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#_memmove_ret_1_1
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
;	_memmove.c:49: if (((int)src < (int)dst) && ((((int)src)+acount) > (int)dst)) {
	mov	dptr,#_memmove_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dptr,#_memmove_sloc0_1_0
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	mov	dptr,#_memmove_dst_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dptr,#_memmove_sloc0_1_0
	clr	c
	movx	a,@dptr
	subb	a,r0
	inc	dptr
	movx	a,@dptr
	xrl	a,#0x80
	mov	b,r1
	xrl	b,#0x80
	subb	a,b
	jc	00121$
	ljmp	00108$
00121$:
;	genAssign: resultIsFar = FALSE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
	mov	dptr,#_memmove_PARM_3
	movx	a,@dptr
	add	a,r6
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	addc	a,r7
	mov	r7,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#_memmove_dst_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	clr	c
	mov	a,r0
	subb	a,r6
	mov	a,r1
	subb	a,r7
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jc	00122$
	ljmp	00108$
00122$:
;	_memmove.c:53: d = ((char *)dst)+acount-1;
	mov	dptr,#_memmove_PARM_3
	mov	dps, #1
	mov	dptr, #_memmove_dst_1_1
	dec	dps
	movx	a,@dptr
	xch	a, _ap
	inc	dps
	movx	a,@dptr
	xch	a, _ap
	add	a,_ap
	mov	r6,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	inc	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	addc	a,_ap
	mov	r7,a
	clr	a
	xch	a, _ap
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	addc	a,_ap
	mov	r0,a
	mov     dps, #1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	mov	r1,a
	dec	r6
	cjne	r6,#0xFF,00123$
	dec	r7
	cjne	r7,#0xFF,00123$
	dec	r0
00123$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_memmove_d_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	_memmove.c:54: s = ((char *)src)+acount-1;
	mov	dptr,#_memmove_PARM_3
	movx	a,@dptr
	add	a,r2
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	addc	a,r3
	mov	r7,a
	clr	a
	addc	a,r4
	mov	r0,a
	mov	ar1,r5
	dec	r6
	cjne	r6,#0xFF,00124$
	dec	r7
	cjne	r7,#0xFF,00124$
	dec	r0
00124$:
;	genAssign: resultIsFar = FALSE
;	_memmove.c:55: while (acount--) {
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_memmove_sloc2_1_0
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	mov	dptr,#_memmove_d_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	dptr,#_memmove_PARM_3
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
00101$:
;	genAssign: resultIsFar = FALSE
	mov	ar6,r2
	mov	ar7,r3
	dec	r2
	cjne	r2,#0xFF,00125$
	dec	r3
00125$:
	mov	a,r6
	orl	a,r7
	jnz	00126$
	ljmp	00109$
00126$:
;	_memmove.c:56: *d-- = *s--;
	mov     dps, #1
	mov     dptr, #_memmove_sloc2_1_0
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	__gptrget
	mov	r6,a
	mov	dptr,#_memmove_sloc2_1_0
	movx	a,@dptr
	add	a,#0xFF
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dpl,r4
	mov	dph,r5
	mov	dpx,r0
	mov	b,r1
	mov	a,r6
	lcall	__gptrput
	dec	r4
	cjne	r4,#0xFF,00127$
	dec	r5
	cjne	r5,#0xFF,00127$
	dec	r0
00127$:
	sjmp 00101$
00108$:
;	_memmove.c:64: s = src;
;	genAssign: resultIsFar = FALSE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
;	_memmove.c:65: while (acount--) {
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_memmove_sloc1_1_0
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	mov	dptr,#_memmove_dst_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	dptr,#_memmove_PARM_3
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
00104$:
;	genAssign: resultIsFar = FALSE
	mov	ar2,r4
	mov	ar3,r5
	dec	r4
	cjne	r4,#0xFF,00128$
	dec	r5
00128$:
	mov	a,r2
	orl	a,r3
	jz  00109$
00129$:
;	_memmove.c:66: *d++ = *s++;
	mov     dps, #1
	mov     dptr, #_memmove_sloc1_1_0
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	inc	dps
	lcall	__decdptr
	lcall	__decdptr
	lcall	__decdptr
	mov	a,dpl
	movx	@dptr,a
	inc	dptr
	mov	a,dph
	movx	@dptr,a
	inc	dptr
	mov	a,dpx
	movx	@dptr,a
	inc	dptr
	mov	a,b
	movx	@dptr,a
	mov	dps,#0
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	sjmp 00104$
00109$:
;	_memmove.c:70: return(ret);
	mov     dps, #1
	mov     dptr, #_memmove_ret_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
00111$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
