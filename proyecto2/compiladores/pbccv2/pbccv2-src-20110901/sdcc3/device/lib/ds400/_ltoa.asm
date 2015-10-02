;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:20 2015
;--------------------------------------------------------
	.module _ltoa
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
	.globl __ltoa
	.globl __ultoa
	.globl __ltoa_PARM_3
	.globl __ltoa_PARM_2
	.globl __ultoa_PARM_3
	.globl __ultoa_PARM_2
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
__ultoa_PARM_2:
	.ds 4
__ultoa_PARM_3:
	.ds 1
__ultoa_buffer_1_1:
	.ds 32
__ultoa_sloc0_1_0:
	.ds 4
__ultoa_sloc1_1_0:
	.ds 1
__ltoa_PARM_2:
	.ds 4
__ltoa_PARM_3:
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
;Allocation info for local variables in function '_ultoa'
;------------------------------------------------------------
;string                    Allocated with name '__ultoa_PARM_2'
;radix                     Allocated with name '__ultoa_PARM_3'
;value                     Allocated to registers r2 r3 r4 r5 
;buffer                    Allocated with name '__ultoa_buffer_1_1'
;index                     Allocated to registers 
;c                         Allocated to registers r6 
;sloc0                     Allocated with name '__ultoa_sloc0_1_0'
;sloc1                     Allocated with name '__ultoa_sloc1_1_0'
;------------------------------------------------------------
;	_ltoa.c:56: void _ultoa(unsigned long value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _ultoa
;	-----------------------------------------
__ultoa:
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
;	_ltoa.c:61: do {
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__ultoa_sloc1_1_0
	mov	a,#0x20
	movx	@dptr,a
00103$:
;	_ltoa.c:62: unsigned char c = '0' + (value % radix);
	mov	dptr,#__ultoa_PARM_3
	mov	dps, #1
	mov	dptr, #__ultoa_sloc0_1_0
	dec	dps
	movx	a,@dptr
	inc	dps
	movx	@dptr,a
	mov     dps, #1
	inc	dptr
	clr	a
	movx	@dptr,a
	mov     dps, #1
	inc	dptr
	clr	a
	movx	@dptr,a
	mov     dps, #1
	inc	dptr
	clr	a
	movx	@dptr,a
	mov	dps,#0
	mov	dptr,#__ultoa_sloc0_1_0
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__modulong
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	r7,dpl
	mov	a,#0x30
	add	a,r7
	mov	r6,a
;	_ltoa.c:63: if (c > (unsigned char)'9')
	clr	c
	mov	a,#0x39
	subb	a,r6
	jnc  00102$
00117$:
;	_ltoa.c:64: c += 'A' - '9' - 1;
	mov	a,#0x07
	add	a,r6
	mov	r6,a
00102$:
;	_ltoa.c:65: buffer[--index] = c;
	mov	dptr,#__ultoa_sloc1_1_0
	movx	a,@dptr
	dec	a
	movx	@dptr,a
	mov	dptr,#__ultoa_sloc1_1_0
	movx	a,@dptr
	add	a,#__ultoa_buffer_1_1
	mov	dpl1,a
	clr	a
	addc	a,#(__ultoa_buffer_1_1 >> 8)
	mov	dph1,a
	clr	a
	addc	a,#(__ultoa_buffer_1_1 >> 16)
	mov	dpx1,a
	mov	a,r6
	inc	dps
	movx	@dptr,a
	mov	dps,#0
;	_ltoa.c:66: value /= radix;
	mov	dptr,#__ultoa_sloc0_1_0
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#__divulong_PARM_2
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
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__divulong
	mov	r7,dpl
	mov	r0,dph
	mov	r1,dpx
	mov	r6,b
;	genAssign: resultIsFar = TRUE
	mov	ar2,r7
	mov	ar3,r0
	mov	ar4,r1
	mov	ar5,r6
;	_ltoa.c:67: } while (value);
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jz	00118$
	ljmp	00103$
00118$:
;	_ltoa.c:69: do {
	mov	dptr,#__ultoa_PARM_2
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
	mov	dptr,#__ultoa_sloc1_1_0
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
00106$:
;	_ltoa.c:70: *string++ = buffer[index];
	mov	a,r6
	add	a,#__ultoa_buffer_1_1
	mov	dpl,a
	clr	a
	addc	a,#(__ultoa_buffer_1_1 >> 8)
	mov	dph,a
	clr	a
	addc	a,#(__ultoa_buffer_1_1 >> 16)
	mov	dpx,a
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	mov	a,r7
	lcall	__gptrput
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	_ltoa.c:71: } while ( ++index != NUMBER_OF_DIGITS );
	inc	r6
	mov	a,r6
	cjne a,#0x20,00106$
00120$:
;	_ltoa.c:73: *string = 0;  /* string terminator */
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	clr  a
	lcall	__gptrput
00109$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function '_ltoa'
;------------------------------------------------------------
;string                    Allocated with name '__ltoa_PARM_2'
;radix                     Allocated with name '__ltoa_PARM_3'
;value                     Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	_ltoa.c:76: void _ltoa(long value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _ltoa
;	-----------------------------------------
__ltoa:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	_ltoa.c:78: if (value < 0 && radix == 10) {
	mov	a,r5
	jnb  acc.7,00102$
00108$:
	mov	dptr,#__ltoa_PARM_3
	movx	a,@dptr
	cjne a,#0x0A,00102$
00110$:
;	_ltoa.c:79: *string++ = '-';
	mov	dptr,#__ltoa_PARM_2
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
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	a,#0x2D
	lcall	__gptrput
	mov	dptr,#__ltoa_PARM_2
	mov	a,#0x01
	add	a,r6
	movx	@dptr,a
	clr  a
	addc	a,r7
	inc	dptr
	movx	@dptr,a
	clr  a
	addc	a,r0
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	_ltoa.c:80: value = -value;
	clr	c
	clr	a
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
	clr	a
	subb	a,r4
	mov	r4,a
	clr	a
	subb	a,r5
	mov	r5,a
00102$:
;	_ltoa.c:82: _ultoa(value, string, radix);
	mov	dptr,#__ltoa_PARM_2
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
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__ultoa_PARM_2
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
	mov	dptr,#__ltoa_PARM_3
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	dptr,#__ultoa_PARM_3
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__ultoa
00104$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
