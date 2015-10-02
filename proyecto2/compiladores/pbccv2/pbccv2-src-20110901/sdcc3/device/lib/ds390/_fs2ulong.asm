;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:15 2015
;--------------------------------------------------------
	.module _fs2ulong
	.optsdcc -mds390 --model-flat24
	
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
	.globl ___fs2ulong
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
___fs2ulong_fl1_1_1:
	.ds 4
___fs2ulong_exp_1_1:
	.ds 2
___fs2ulong_l_1_1:
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
;Allocation info for local variables in function '__fs2ulong'
;------------------------------------------------------------
;a1                        Allocated to registers r2 r3 r4 r5 
;fl1                       Allocated with name '___fs2ulong_fl1_1_1'
;exp                       Allocated with name '___fs2ulong_exp_1_1'
;l                         Allocated with name '___fs2ulong_l_1_1'
;------------------------------------------------------------
;	_fs2ulong.c:103: __fs2ulong (float a1)
;	-----------------------------------------
;	 function __fs2ulong
;	-----------------------------------------
___fs2ulong:
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
;	_fs2ulong.c:109: fl1.f = a1;
	mov	dptr,#___fs2ulong_fl1_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_fs2ulong.c:111: if (!fl1.l || SIGN(fl1.l))
	mov	dptr,#___fs2ulong_fl1_1_1
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	mov	r5,a
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jz  00101$
00107$:
	mov	dptr,#___fs2ulong_fl1_1_1
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	mov  r5,a
	rl	a
	anl	a,#0x01
	mov  r2,a
	jz  00102$
00108$:
00101$:
;	_fs2ulong.c:112: return (0);
	mov  dptr,#0x0000
	mov	b,#0x00
	ljmp	00104$
00102$:
;	_fs2ulong.c:114: exp = EXP (fl1.l) - EXCESS - 24;
	mov	dptr,#___fs2ulong_fl1_1_1
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	mov	r5,a
	mov	ar2,r4
	mov	a,r5
	mov	c,acc.7
	xch	a,r2
	rlc	a
	xch	a,r2
	rlc	a
	xch	a,r2
	anl	a,#0x01
	mov	r3,a
	mov	r4,#0
	mov	r5,#0
	mov	r3,#0
	mov	r4,#0
	mov	r5,#0
	mov	a,r2
	add	a,#0x6A
	mov	r2,a
	mov	a,r3
	addc	a,#0xFF
	mov	r3,a
	mov	a,r4
	addc	a,#0xFF
	mov	r4,a
	mov	a,r5
	addc	a,#0xFF
	mov	r5,a
	mov	dptr,#___fs2ulong_exp_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_fs2ulong.c:115: l = MANT (fl1.l);
	mov	dptr,#___fs2ulong_fl1_1_1
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	mov	r5,a
	anl	ar4,#0x7F
	mov	r5,#0
	mov	dptr,#___fs2ulong_l_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	mov	a,#0x80
	orl	a,r4
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_fs2ulong.c:117: l >>= -exp;
	mov	dptr,#___fs2ulong_exp_1_1
	movx	a,@dptr
	setb	c
	cpl	a
	addc	a,#0x00
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	mov	r3,a
	mov	b,r2
	inc	b
	mov	dptr,#___fs2ulong_l_1_1
	movx	a,@dptr
	mov     r2,a
	inc	dptr
	movx	a,@dptr
	mov     r3,a
	inc	dptr
	movx	a,@dptr
	mov     r4,a
	inc	dptr
	movx	a,@dptr
	mov     r5,a
	movx	a,@dptr
	rlc	a
	mov	ov,c
	sjmp	00110$
00109$:
	mov	c,ov
	mov	a,r5
	rrc	a
	mov	r5,a
	mov	a,r4
	rrc	a
	mov	r4,a
	mov	a,r3
	rrc	a
	mov	r3,a
	mov	a,r2
	rrc	a
	mov	r2,a
00110$:
	djnz	b,00109$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fs2ulong_l_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_fs2ulong.c:119: return l;
	mov	dptr,#___fs2ulong_l_1_1
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
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
00104$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
