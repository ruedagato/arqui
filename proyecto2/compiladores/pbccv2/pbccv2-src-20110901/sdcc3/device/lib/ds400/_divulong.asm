;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module _divulong
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
	.globl __divulong_PARM_2
	.globl __divulong
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
__divulong_c_1_1:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
__divulong_PARM_2:
	.ds 4
__divulong_reste_1_1:
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
;Allocation info for local variables in function '_divulong'
;------------------------------------------------------------
;y                         Allocated with name '__divulong_PARM_2'
;x                         Allocated to registers r2 r3 r4 r5 
;reste                     Allocated with name '__divulong_reste_1_1'
;count                     Allocated to registers 
;------------------------------------------------------------
;	_divulong.c:331: _divulong (unsigned long x, unsigned long y)
;	-----------------------------------------
;	 function _divulong
;	-----------------------------------------
__divulong:
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
	mov	r4,dpx
	mov	r5,b
;	_divulong.c:333: unsigned long reste = 0L;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divulong_reste_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	_divulong.c:337: do
;	genAssign: resultIsFar = FALSE
	mov	r6,#0x20
00105$:
;	_divulong.c:340: c = MSB_SET(x);
	push	ar6
	mov	a,r5
	rlc	a
	mov	__divulong_c_1_1,c
;	_divulong.c:341: x <<= 1;
	mov	b,#0x02
	mov	r7,ar2
	mov	r0,ar3
	mov	r1,ar4
	mov	r6,ar5
	sjmp	00116$
00115$:
	mov	a,r7
	add	a,acc
	mov	r7,a
	mov	a,r0
	rlc	a
	mov	r0,a
	mov	a,r1
	rlc	a
	mov	r1,a
	mov	a,r6
	rlc	a
	mov	r6,a
00116$:
	djnz	b,00115$
;	genAssign: resultIsFar = TRUE
	mov	ar2,r7
	mov	ar3,r0
	mov	ar4,r1
	mov	ar5,r6
;	_divulong.c:342: reste <<= 1;
	mov	b,#0x02
	mov	dptr,#__divulong_reste_1_1
	movx	a,@dptr
	mov     r6,a
	inc	dptr
	movx	a,@dptr
	mov     r7,a
	inc	dptr
	movx	a,@dptr
	mov     r0,a
	inc	dptr
	movx	a,@dptr
	mov     r1,a
	sjmp	00118$
00117$:
	mov	a,r6
	add	a,acc
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
	mov	a,r0
	rlc	a
	mov	r0,a
	mov	a,r1
	rlc	a
	mov	r1,a
00118$:
	djnz	b,00117$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divulong_reste_1_1
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
;	_divulong.c:343: if (c)
	pop	ar6
	jnb  __divulong_c_1_1,00102$
00119$:
;	_divulong.c:344: reste |= 1L;
	mov	dptr,#__divulong_reste_1_1
	movx	a,@dptr
	orl	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
00102$:
;	_divulong.c:346: if (reste >= y)
	mov	dptr,#__divulong_PARM_2
	mov	dps, #1
	mov	dptr, #__divulong_reste_1_1
	dec	dps
	clr	c
	mov	dps,#1
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jc   00106$
00120$:
;	_divulong.c:348: reste -= y;
	push	ar6
	mov	dptr,#__divulong_PARM_2
	mov	dps, #1
	mov	dptr, #__divulong_reste_1_1
	dec	dps
	clr	c
	movx	a,@dptr
	mov	b,a
	inc	dps
	movx	a,@dptr
	subb	a,b
	mov	r7,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	mov	b,a
	inc	dps
	inc	dptr
	movx	a,@dptr
	subb	a,b
	mov	r0,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	mov	b,a
	inc	dps
	inc	dptr
	movx	a,@dptr
	subb	a,b
	mov	r1,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	mov	b,a
	inc	dps
	inc	dptr
	movx	a,@dptr
	subb	a,b
	mov	r6,a
	mov	dps,#0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divulong_reste_1_1
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_divulong.c:350: x |= 1L;
	orl	ar2,#0x01
;	_divulong.c:354: return x;
	pop	ar6
;	_divulong.c:350: x |= 1L;
00106$:
;	_divulong.c:353: while (--count);
	djnz  r6,00121$
	sjmp	00122$
00121$:
	ljmp	00105$
00122$:
;	_divulong.c:354: return x;
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
00108$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
