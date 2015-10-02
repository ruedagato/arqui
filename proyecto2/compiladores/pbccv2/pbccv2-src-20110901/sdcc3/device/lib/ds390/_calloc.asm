;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _calloc
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
	.globl _calloc_PARM_2
	.globl _calloc
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
_calloc_PARM_2:
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
;Allocation info for local variables in function 'calloc'
;------------------------------------------------------------
;size                      Allocated with name '_calloc_PARM_2'
;nmemb                     Allocated to registers r2 r3 
;ptr                       Allocated to registers r4 r5 r6 
;------------------------------------------------------------
;	_calloc.c:70: void __xdata * calloc (size_t nmemb, size_t size)
;	-----------------------------------------
;	 function calloc
;	-----------------------------------------
_calloc:
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
;	_calloc.c:74: ptr = malloc(nmemb * size);
	mov	dptr,#_calloc_PARM_2
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#__mulint_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	mov	dpl,r2
	mov	dph,r3
	lcall	__mulint
	mov	r2,dpl
	mov	r3,dph
	push	ar2
	push	ar3
	mov	dpl,r2
	mov	dph,r3
	lcall	_malloc
	mov	r4,dpl
	mov	r5,dph
	mov	r6,dpx
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
;	_calloc.c:75: if (ptr)
	mov	a,r4
	orl	a,r5
	orl	a,r6
	jz  00102$
00106$:
;	_calloc.c:77: memset(ptr, 0, nmemb * size);
;	genAssign: resultIsFar = FALSE
	mov	ar7,r4
	mov	ar0,r5
	mov	ar1,r6
	push	ar4
	push	ar5
	push	ar6
	mov	r4,#0x00
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_memset_PARM_2
	clr  a
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_memset_PARM_3
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	push	ar4
	push	ar5
	push	ar6
	mov	dpl,r7
	mov	dph,r0
	mov	dpx,r1
	mov	b,r4
	lcall	_memset
	pop	ar6
	pop	ar5
	pop	ar4
;	_calloc.c:79: return ptr;
	pop	ar6
	pop	ar5
	pop	ar4
;	_calloc.c:77: memset(ptr, 0, nmemb * size);
00102$:
;	_calloc.c:79: return ptr;
	mov	dpl,r4
	mov	dph,r5
	mov	dpx,r6
00103$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
