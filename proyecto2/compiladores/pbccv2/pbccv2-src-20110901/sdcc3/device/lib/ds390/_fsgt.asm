;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:16 2015
;--------------------------------------------------------
	.module _fsgt
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
	.globl ___fsgt_PARM_2
	.globl ___fsgt
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
___fsgt_PARM_2:
	.ds 4
___fsgt_fl1_1_1:
	.ds 4
___fsgt_fl2_1_1:
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
;Allocation info for local variables in function '__fsgt'
;------------------------------------------------------------
;a2                        Allocated with name '___fsgt_PARM_2'
;a1                        Allocated to registers r2 r3 r4 r5 
;fl1                       Allocated with name '___fsgt_fl1_1_1'
;fl2                       Allocated with name '___fsgt_fl2_1_1'
;------------------------------------------------------------
;	_fsgt.c:108: char __fsgt (float a1, float a2)
;	-----------------------------------------
;	 function __fsgt
;	-----------------------------------------
___fsgt:
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
;	_fsgt.c:112: fl1.f = a1;
	mov	dptr,#___fsgt_fl1_1_1
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
;	_fsgt.c:113: fl2.f = a2;
	mov	dptr,#___fsgt_fl2_1_1
	mov     dps, #1
	mov     dptr, #___fsgt_PARM_2
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
	inc	dptr
	inc	dps
	inc	dptr
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
	inc	dptr
	inc	dps
	inc	dptr
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
	inc	dptr
	inc	dps
	inc	dptr
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
;	_fsgt.c:115: if (fl1.l<0 && fl2.l<0) {
	mov	dptr,#___fsgt_fl1_1_1
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
	jnb  acc.7,00104$
00114$:
	mov	dptr,#___fsgt_fl2_1_1
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
	jnb  acc.7,00104$
00115$:
;	_fsgt.c:116: if (fl2.l > fl1.l)
	mov	dptr,#___fsgt_fl2_1_1
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
	mov	dptr,#___fsgt_fl1_1_1
	movx	a,@dptr
	inc	dptr
	mov	r6,a
	movx	a,@dptr
	inc	dptr
	mov	r7,a
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	mov	r1,a
	clr	c
	mov	a,r6
	subb	a,r2
	mov	a,r7
	subb	a,r3
	mov	a,r0
	subb	a,r4
	mov	a,r1
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jnc  00102$
00116$:
;	_fsgt.c:117: return (1);
	mov	dpl,#0x01
	sjmp 00108$
00102$:
;	_fsgt.c:118: return (0);
	mov	dpl,#0x00
	sjmp 00108$
00104$:
;	_fsgt.c:121: if (fl1.l > fl2.l)
	mov	dptr,#___fsgt_fl1_1_1
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
	mov	dptr,#___fsgt_fl2_1_1
	movx	a,@dptr
	inc	dptr
	mov	r6,a
	movx	a,@dptr
	inc	dptr
	mov	r7,a
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	mov	r1,a
	clr	c
	mov	a,r6
	subb	a,r2
	mov	a,r7
	subb	a,r3
	mov	a,r0
	subb	a,r4
	mov	a,r1
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jnc  00107$
00117$:
;	_fsgt.c:122: return (1);
	mov	dpl,#0x01
;	_fsgt.c:123: return (0);
	ret
00107$:
	mov     dpl,#0x00
00108$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
