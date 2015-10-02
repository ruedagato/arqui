;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module _modslong
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
	.globl __modslong_PARM_2
	.globl __modslong
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
__modslong_PARM_2:
	.ds 4
__modslong_sloc0_1_0:
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
;Allocation info for local variables in function '_modslong'
;------------------------------------------------------------
;b                         Allocated with name '__modslong_PARM_2'
;a                         Allocated to registers r2 r3 r4 r5 
;r                         Allocated to registers r2 r3 r4 r5 
;sloc0                     Allocated with name '__modslong_sloc0_1_0'
;------------------------------------------------------------
;	_modslong.c:259: _modslong (long a, long b)
;	-----------------------------------------
;	 function _modslong
;	-----------------------------------------
__modslong:
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
;	_modslong.c:263: r = _modulong((a < 0 ? -a : a),
	mov	a,r5
	rlc	a
	clr	a
	rlc	a
	mov  r6,a
	jz  00106$
00113$:
	mov	dptr,#__modslong_sloc0_1_0
	clr	c
	clr	a
	subb	a,r2
	movx	@dptr,a
	clr	a
	subb	a,r3
	inc	dptr
	movx	@dptr,a
	clr	a
	subb	a,r4
	inc	dptr
	movx	@dptr,a
	clr	a
	subb	a,r5
	inc	dptr
	movx	@dptr,a
	sjmp 00107$
00106$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__modslong_sloc0_1_0
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
00107$:
	mov	dptr,#__modslong_sloc0_1_0
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
;	_modslong.c:264: (b < 0 ? -b : b));
	mov	dptr,#__modslong_PARM_2
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	jnb  acc.7,00108$
00114$:
	mov	dptr,#__modslong_PARM_2
	mov	dps, #1
	mov	dptr, #__modslong_sloc0_1_0
	dec	dps
	movx	a,@dptr
	setb	c
	cpl	a
	addc	a,#0x00
	inc	dps
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	mov	dps,#0
	sjmp 00109$
00108$:
	mov	dptr,#__modslong_PARM_2
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#__modslong_sloc0_1_0
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
00109$:
	mov	dptr,#__modslong_sloc0_1_0
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#__modulong_PARM_2
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
	push	ar6
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__modulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar6
;	genAssign: resultIsFar = TRUE
;	_modslong.c:265: if (a < 0)
	mov	a,r6
	jz  00102$
00115$:
;	_modslong.c:266: return -r;
	clr	c
	clr	a
	subb	a,r2
	mov	r6,a
	clr	a
	subb	a,r3
	mov	r7,a
	clr	a
	subb	a,r4
	mov	r0,a
	clr	a
	subb	a,r5
	mov	r1,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	sjmp 00104$
00102$:
;	_modslong.c:268: return r;
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
