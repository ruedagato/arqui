;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module _strcmp
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
	.globl _strcmp_PARM_2
	.globl _strcmp
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
	.area	OSEG    (OVR,DATA)
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
_strcmp_PARM_2:
	.ds 4
_strcmp_sloc0_1_0:
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
;Allocation info for local variables in function 'strcmp'
;------------------------------------------------------------
;adst                      Allocated with name '_strcmp_PARM_2'
;asrc                      Allocated to registers r2 r3 r4 r5 
;sloc0                     Allocated with name '_strcmp_sloc0_1_0'
;ret                       Allocated to registers r4 r5 
;------------------------------------------------------------
;	_strcmp.c:34: int strcmp (
;	-----------------------------------------
;	 function strcmp
;	-----------------------------------------
_strcmp:
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
;	_strcmp.c:53: while( ! (ret = *(unsigned char *)asrc - *(unsigned char *)adst) && *adst)
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strcmp_sloc0_1_0
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
	mov	dptr,#_strcmp_PARM_2
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
00102$:
	mov     dps, #1
	mov     dptr, #_strcmp_sloc0_1_0
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
	mov	r3,#0
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov	r4,a
	mov	r5,#0
	clr	c
	mov	a,r2
	subb	a,r4
	mov	r2,a
	mov	a,r3
	subb	a,r5
	mov	r3,a
;	genAssign: resultIsFar = FALSE
	mov	ar4,r2
	mov	ar5,r3
	mov	a,r2
	orl	a,r3
	jnz  00104$
00111$:
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov  r2,a
	jz  00104$
00112$:
;	_strcmp.c:54: ++asrc, ++adst;
	mov	dptr,#_strcmp_sloc0_1_0
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	r6
	cjne	r6,#0,00113$
	inc	r7
	cjne	r7,#0,00113$
	inc	r0
00113$:
	sjmp 00102$
00104$:
;	_strcmp.c:56: return( ret );
	mov	dpl,r4
	mov	dph,r5
00105$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
