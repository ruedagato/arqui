;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module _ulong2fs
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
	.globl ___ulong2fs
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
___ulong2fs_a_1_1:
	.ds 4
___ulong2fs_fl_1_1:
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
;Allocation info for local variables in function '__ulong2fs'
;------------------------------------------------------------
;a                         Allocated with name '___ulong2fs_a_1_1'
;exp                       Allocated to registers r4 r5 
;fl                        Allocated with name '___ulong2fs_fl_1_1'
;------------------------------------------------------------
;	_ulong2fs.c:83: float __ulong2fs (unsigned long a )
;	-----------------------------------------
;	 function __ulong2fs
;	-----------------------------------------
___ulong2fs:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov     dps, #1
	mov     dptr, #___ulong2fs_a_1_1
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
;	_ulong2fs.c:88: if (!a)
	mov	dptr,#___ulong2fs_a_1_1
	movx	a,@dptr
	mov	b,a
	inc	dptr
	movx	a,@dptr
	orl	b,a
	inc	dptr
	movx	a,@dptr
	orl	b,a
	inc	dptr
	movx	a,@dptr
	orl	a,b
	jnz  00115$
00121$:
;	_ulong2fs.c:90: return 0.0;
	mov  dptr,#0x0000
	mov	b,#0x00
	ljmp	00111$
;	_ulong2fs.c:93: while (a & NORM) 
00115$:
;	genAssign: resultIsFar = FALSE
	mov	r6,#0x96
	mov	r7,#0x00
00103$:
	mov	dptr,#___ulong2fs_a_1_1
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	jz  00117$
00122$:
;	_ulong2fs.c:96: a >>= 1;
	mov	dptr,#___ulong2fs_a_1_1
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	clr	c
	rrc	a
	mov	r3,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
	mov	r2,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
	mov	r1,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
;	genAssign: resultIsFar = TRUE
	mov  r0,a
	mov  dptr,#___ulong2fs_a_1_1
	movx @dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_ulong2fs.c:97: exp++;
	inc	r6
	cjne	r6,#0,00103$
	inc	r7
;	_ulong2fs.c:100: while (a < HIDDEN)
	sjmp 00103$
00117$:
;	genAssign: resultIsFar = FALSE
	mov	ar2,r6
	mov	ar3,r7
00106$:
	mov	dptr,#___ulong2fs_a_1_1
	clr	c
	movx	a,@dptr
	subb	a,#0x00
	inc	dptr
	movx	a,@dptr
	subb	a,#0x00
	inc	dptr
	movx	a,@dptr
	subb	a,#0x80
	inc	dptr
	movx	a,@dptr
	subb	a,#0x00
	jnc  00120$
00123$:
;	_ulong2fs.c:102: a <<= 1;
	mov	b,#0x02
	mov	dptr,#___ulong2fs_a_1_1
	movx	a,@dptr
	mov     r4,a
	inc	dptr
	movx	a,@dptr
	mov     r5,a
	inc	dptr
	movx	a,@dptr
	mov     r6,a
	inc	dptr
	movx	a,@dptr
	mov     r7,a
	sjmp	00125$
00124$:
	mov	a,r4
	add	a,acc
	mov	r4,a
	mov	a,r5
	rlc	a
	mov	r5,a
	mov	a,r6
	rlc	a
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
00125$:
	djnz	b,00124$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___ulong2fs_a_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_ulong2fs.c:103: exp--;
	dec	r2
	cjne	r2,#0xFF,00106$
	dec	r3
	sjmp 00106$
00120$:
;	genAssign: resultIsFar = TRUE
	mov	ar4,r2
	mov	ar5,r3
;	_ulong2fs.c:107: if ((a&0x7fffff)==0x7fffff) {
	mov	dptr,#___ulong2fs_a_1_1
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	anl	a,#0x7F
	mov	r0,a
	mov	r1,#0
	mov	a,r6
	cjne a,#0xFF,00110$
	mov  a,r7
	cjne a,#0xFF,00110$
	mov  a,r0
	cjne a,#0x7F,00110$
	mov  a,r1
	cjne a,#0x00,00110$
00127$:
;	_ulong2fs.c:108: a=0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___ulong2fs_a_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	_ulong2fs.c:109: exp++;
	mov	a,#0x01
	add	a,r2
	mov	r4,a
	clr  a
	addc	a,r3
	mov	r5,a
00110$:
;	_ulong2fs.c:113: a &= ~HIDDEN ;
	mov	dptr,#___ulong2fs_a_1_1
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	anl	a,#0x7F
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
;	_ulong2fs.c:115: fl.l = PACK(0,(unsigned long)exp, a);
	mov	a,r5
	rlc	a
	subb	a,acc
	mov	r2,a
	mov	r3,a
	mov	b,#0x18
	sjmp	00129$
00128$:
	mov	a,r4
	add	a,acc
	mov	r4,a
	mov	a,r5
	rlc	a
	mov	r5,a
	mov	a,r2
	rlc	a
	mov	r2,a
	mov	a,r3
	rlc	a
	mov	r3,a
00129$:
	djnz	b,00128$
	mov	dptr,#___ulong2fs_a_1_1
	movx	a,@dptr
	orl	ar4,a
	inc	dptr
	movx	a,@dptr
	orl	ar5,a
	inc	dptr
	movx	a,@dptr
	orl	ar2,a
	inc	dptr
	movx	a,@dptr
	orl	ar3,a
	mov	dptr,#___ulong2fs_fl_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_ulong2fs.c:117: return (fl.f);
	mov	dptr,#___ulong2fs_fl_1_1
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
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
00111$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
