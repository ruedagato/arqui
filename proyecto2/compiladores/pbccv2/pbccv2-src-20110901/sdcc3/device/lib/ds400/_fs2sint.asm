;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module _fs2sint
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
	.globl ___fs2sint
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
;Allocation info for local variables in function '__fs2sint'
;------------------------------------------------------------
;f                         Allocated to registers r2 r3 r4 r5 
;sl                        Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	_fs2sint.c:81: signed int __fs2sint (float f)
;	-----------------------------------------
;	 function __fs2sint
;	-----------------------------------------
___fs2sint:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_fs2sint.c:83: signed long sl=__fs2slong(f);
	mov     r2,dpl
	mov     r3,dph
	mov     r4,dpx
	mov     r5,b
	mov	b,r5
	lcall	___fs2slong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
;	_fs2sint.c:84: if (sl>=INT_MAX)
	clr	c
	mov	a,r2
	subb	a,#0xFF
	mov	a,r3
	subb	a,#0x7F
	mov	a,r4
	subb	a,#0x00
	mov	a,r5
	xrl	a,#0x80
	subb	a,#0x80
	jc   00102$
00109$:
;	_fs2sint.c:85: return INT_MAX;
	mov  dptr,#0x7FFF
	sjmp 00105$
00102$:
;	_fs2sint.c:86: if (sl<=INT_MIN)
	clr	c
	clr  a
	subb	a,r2
	mov	a,#0x80
	subb	a,r3
	mov	a,#0xFF
	subb	a,r4
	mov  a,#(0xFF ^ 0x80)
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jc   00104$
00110$:
;	_fs2sint.c:87: return -INT_MIN;
	mov  dptr,#0x8000
	sjmp 00105$
00104$:
;	_fs2sint.c:88: return sl;
	mov	dpl,r2
	mov	dph,r3
00105$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
