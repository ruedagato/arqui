;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _itoa
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
	.globl __itoa
	.globl __uitoa
	.globl __itoa_PARM_3
	.globl __itoa_PARM_2
	.globl __uitoa_PARM_3
	.globl __uitoa_PARM_2
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
__uitoa_PARM_2:
	.ds 4
__uitoa_PARM_3:
	.ds 1
__uitoa_sloc0_1_0:
	.ds 4
__uitoa_sloc1_1_0:
	.ds 2
__uitoa_sloc2_1_0:
	.ds 4
__uitoa_sloc3_1_0:
	.ds 1
__itoa_PARM_2:
	.ds 4
__itoa_PARM_3:
	.ds 1
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
;Allocation info for local variables in function '_uitoa'
;------------------------------------------------------------
;string                    Allocated with name '__uitoa_PARM_2'
;radix                     Allocated with name '__uitoa_PARM_3'
;value                     Allocated to registers r2 r3 
;index                     Allocated to registers r2 
;i                         Allocated to registers 
;tmp                       Allocated to registers 
;sloc0                     Allocated with name '__uitoa_sloc0_1_0'
;sloc1                     Allocated with name '__uitoa_sloc1_1_0'
;sloc2                     Allocated with name '__uitoa_sloc2_1_0'
;sloc3                     Allocated with name '__uitoa_sloc3_1_0'
;------------------------------------------------------------
;	_itoa.c:40: void _uitoa(unsigned int value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _uitoa
;	-----------------------------------------
__uitoa:
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
;	_itoa.c:45: do {
	mov	dptr,#__uitoa_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
;	genAssign: resultIsFar = FALSE
	mov	r0,#0x00
00103$:
;	_itoa.c:46: string[index] = '0' + (value % radix);
	mov	dptr,#__uitoa_sloc0_1_0
	mov	a,r0
	add	a,r4
	movx	@dptr,a
	clr	a
	addc	a,r5
	inc	dptr
	movx	@dptr,a
	clr	a
	addc	a,r6
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	mov	dptr,#__uitoa_PARM_3
	mov	dps, #1
	mov	dptr, #__uitoa_sloc1_1_0
	dec	dps
	movx	a,@dptr
	inc	dps
	movx	@dptr,a
	mov     dps, #1
	inc	dptr
	clr	a
	movx	@dptr,a
	mov	dps,#0
	mov	dptr,#__uitoa_sloc1_1_0
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#__moduint_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	mov	dpl,r2
	mov	dph,r3
	lcall	__moduint
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	r1,dpl
	mov	a,#0x30
	add	a,r1
	mov	r1,a
	mov     dps, #1
	mov     dptr, #__uitoa_sloc0_1_0
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
	mov	a,r1
	lcall	__gptrput
;	_itoa.c:47: if (string[index] > '9')
	clr	c
	mov  a,#(0x39 ^ 0x80)
	mov	b,r1
	xrl	b,#0x80
	subb	a,b
	jnc  00102$
00118$:
;	_itoa.c:48: string[index] += 'A' - '9' - 1;
	mov     dps, #1
	mov     dptr, #__uitoa_sloc0_1_0
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
	add  a,#0x07
	mov  r1,a
	mov     dps, #1
	mov     dptr, #__uitoa_sloc0_1_0
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
	mov	a,r1
	lcall	__gptrput
00102$:
;	_itoa.c:49: value /= radix;
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	mov	dptr,#__uitoa_sloc1_1_0
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#__divuint_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	mov	dpl,r2
	mov	dph,r3
	lcall	__divuint
	mov	r1,dpl
	mov	r4,dph
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
;	genAssign: resultIsFar = TRUE
	mov	ar2,r1
	mov	ar3,r4
;	_itoa.c:50: ++index;
	inc	r0
;	_itoa.c:51: } while (value != 0);
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r2
	orl	a,r3
	jz	00119$
	ljmp	00103$
00119$:
;	_itoa.c:54: string[index--] = '\0';
	mov	a,r0
	dec	a
;	genAssign: resultIsFar = TRUE
	mov	r2,a
	mov	a,r0
	add	a,r4
	mov	dpl,a
	clr	a
	addc	a,r5
	mov	dph,a
	clr	a
	addc	a,r6
	mov	dpx,a
	mov	b,r7
	clr  a
	lcall	__gptrput
;	_itoa.c:57: while (index > i) {
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__uitoa_sloc0_1_0
	clr  a
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__uitoa_sloc1_1_0
	mov	a,r2
	movx	@dptr,a
00106$:
	mov	dptr,#__uitoa_sloc0_1_0
	mov	dps, #1
	mov	dptr, #__uitoa_sloc1_1_0
	dec	dps
	clr	c
	movx	a,@dptr
	xrl	a,#0x80
	mov	dps,#1
	xch	a, b
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	xrl	b,#0x80
	subb	a,b
	jc	00120$
	ljmp	00109$
00120$:
;	_itoa.c:58: char tmp = string[i];
	mov	dptr,#__uitoa_sloc0_1_0
	mov	dps, #1
	mov	dptr, #__uitoa_sloc2_1_0
	dec	dps
	movx	a,@dptr
	add	a,r4
	inc	dps
	movx	@dptr,a
	clr	a
	addc	a,r5
	inc	dptr
	movx	@dptr,a
	clr	a
	addc	a,r6
	inc	dptr
	movx	@dptr,a
	mov     dps, #1
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	mov     dps, #1
	mov     dptr, #__uitoa_sloc2_1_0
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
	mov	dps, #1
	mov	dptr, #__uitoa_sloc3_1_0
	dec	dps
	lcall	__gptrget
	mov	dps,#1
	movx	@dptr,a
	mov	dps,#0
;	_itoa.c:59: string[i] = string[index];
	mov	dptr,#__uitoa_sloc1_1_0
	movx	a,@dptr
	add	a,r4
	mov	r3,a
	clr	a
	addc	a,r5
	mov	r0,a
	clr	a
	addc	a,r6
	mov	r1,a
	mov	ar2,r7
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	mov	dpl,r3
	mov	dph,r0
	mov	dpx,r1
	mov	b,r2
	lcall	__gptrget
	mov	r4,a
	mov     dps, #1
	mov     dptr, #__uitoa_sloc2_1_0
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
	mov	a,r4
	lcall	__gptrput
;	_itoa.c:60: string[index] = tmp;
	mov	dpl,r3
	mov	dph,r0
	mov	dpx,r1
	mov	b,r2
	mov     dps, #1
	mov     dptr, #__uitoa_sloc3_1_0
	movx	a,@dptr
	dec	dps
	lcall	__gptrput
;	_itoa.c:61: ++i;
	mov	dptr,#__uitoa_sloc0_1_0
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	_itoa.c:62: --index;
	mov	dptr,#__uitoa_sloc1_1_0
	movx	a,@dptr
	dec	a
	movx	@dptr,a
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	ljmp	00106$
00109$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function '_itoa'
;------------------------------------------------------------
;string                    Allocated with name '__itoa_PARM_2'
;radix                     Allocated with name '__itoa_PARM_3'
;value                     Allocated to registers r2 r3 
;------------------------------------------------------------
;	_itoa.c:66: void _itoa(int value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _itoa
;	-----------------------------------------
__itoa:
	mov	r2,dpl
	mov	r3,dph
;	_itoa.c:68: if (value < 0 && radix == 10) {
	mov	a,r3
	jnb  acc.7,00102$
00108$:
	mov	dptr,#__itoa_PARM_3
	movx	a,@dptr
	cjne a,#0x0A,00102$
00110$:
;	_itoa.c:69: *string++ = '-';
	mov	dptr,#__itoa_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r4
	mov	dph,r5
	mov	dpx,r6
	mov	b,r7
	mov	a,#0x2D
	lcall	__gptrput
	mov	dptr,#__itoa_PARM_2
	mov	a,#0x01
	add	a,r4
	movx	@dptr,a
	clr  a
	addc	a,r5
	inc	dptr
	movx	@dptr,a
	clr  a
	addc	a,r6
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_itoa.c:70: value = -value;
	clr	c
	clr	a
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
00102$:
;	_itoa.c:72: _uitoa(value, string, radix);
	mov	dptr,#__itoa_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__uitoa_PARM_2
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
	mov	dptr,#__itoa_PARM_3
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	dptr,#__uitoa_PARM_3
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	lcall	__uitoa
00104$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
