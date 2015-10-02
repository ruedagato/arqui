;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:16 2015
;--------------------------------------------------------
	.module _divsint
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
	.globl __divsint_PARM_2
	.globl __divsint
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
__divsint_PARM_2:
	.ds 2
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
;Allocation info for local variables in function '_divsint'
;------------------------------------------------------------
;r                         Allocated to registers r2 r3 
;y                         Allocated with name '__divsint_PARM_2'
;x                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	_divsint.c:207: _divsint (int x, int y)
;	-----------------------------------------
;	 function _divsint
;	-----------------------------------------
__divsint:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_divsint.c:211: r = _divuint((x < 0 ? -x : x),
	mov	a,dph
	rlc	a
	clr	a
	rlc	a
	mov  r4,a
	jz  00106$
00113$:
	clr	c
	clr	a
	subb	a,dpl
	mov	r5,a
	clr	a
	subb	a,dph
	mov	r6,a
	sjmp 00107$
00106$:
;	genAssign: resultIsFar = FALSE
	mov	r5,dpl
	mov	r6,dph
00107$:
;	genAssign: resultIsFar = FALSE
	mov	dpl1,r5
	mov	dph1,r6
;	_divsint.c:212: (y < 0 ? -y : y));
	mov	dptr,#__divsint_PARM_2
	inc	dptr
	movx	a,@dptr
	rlc	a
	clr	a
	rlc	a
	mov  r5,a
	jz  00108$
00114$:
	mov	dptr,#__divsint_PARM_2
	movx	a,@dptr
	setb	c
	cpl	a
	addc	a,#0x00
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	mov	r7,a
	sjmp 00109$
00108$:
	mov	dptr,#__divsint_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
00109$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divuint_PARM_2
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	push	ar4
	push	ar5
	mov	dpl,dpl1
	mov	dph,dph1
	lcall	__divuint
	pop	ar5
	pop	ar4
;	genAssign: resultIsFar = FALSE
;	_divsint.c:213: if ( (x < 0) ^ (y < 0))
	mov	a,r4
	xrl	a,r5
	jz  00102$
00115$:
;	_divsint.c:214: return -r;
	clr	c
	clr	a
	subb	a,dpl
	mov	dpl1,a
	clr	a
	subb	a,dph
	mov	dph1,a
	mov	dpl,dpl1
	mov	dph,dph1
;	_divsint.c:216: return r;
00102$:
00104$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
