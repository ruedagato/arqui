;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:26 2015
;--------------------------------------------------------
	.module _memchr
	.optsdcc -mmcs51 --model-medium
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memchr_PARM_3
	.globl _memchr_PARM_2
	.globl _memchr
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
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
_memchr_PARM_2:
	.ds 2
_memchr_PARM_3:
	.ds 2
_memchr_end_1_1:
	.ds 3
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
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
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
;Allocation info for local variables in function 'memchr'
;------------------------------------------------------------
;------------------------------------------------------------
;	_memchr.c:31: void *memchr(const void *s, int c, size_t n)
;	-----------------------------------------
;	 function memchr
;	-----------------------------------------
_memchr:
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
	mov	r4,b
;	_memchr.c:33: unsigned char *p = (unsigned char *)s;
	mov	ar5,r2
	mov	ar6,r3
	mov	ar7,r4
;	_memchr.c:34: unsigned char *end = p + n;
	mov	r0,#_memchr_PARM_3
	mov	r1,#_memchr_end_1_1
	movx	a,@r0
	add	a,r2
	movx	@r1,a
	inc	r0
	movx	a,@r0
	addc	a,r3
	inc	r1
	movx	@r1,a
	inc	r1
	mov	a,r4
	movx	@r1,a
;	_memchr.c:38: return(0);
00103$:
;	_memchr.c:35: for(; p != end; p++)
	mov	r0,#_memchr_end_1_1
	movx	a,@r0
	cjne	a,ar2,00112$
	inc	r0
	movx	a,@r0
	cjne	a,ar3,00112$
	inc	r0
	movx	a,@r0
	cjne	a,ar4,00112$
	sjmp	00106$
00112$:
;	_memchr.c:36: if(*p == c)
	push	ar5
	push	ar6
	push	ar7
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	mov	r6,#0x00
	mov	r0,#_memchr_PARM_2
	movx	a,@r0
	cjne	a,ar5,00113$
	inc	r0
	movx	a,@r0
	cjne	a,ar6,00113$
	sjmp	00114$
00113$:
	pop	ar7
	pop	ar6
	pop	ar5
	sjmp	00105$
00114$:
	pop	ar7
	pop	ar6
	pop	ar5
;	_memchr.c:37: return((void *)p);
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	ret
00105$:
;	_memchr.c:35: for(; p != end; p++)
	inc	r2
	cjne	r2,#0x00,00115$
	inc	r3
00115$:
	mov	ar5,r2
	mov	ar6,r3
	mov	ar7,r4
	sjmp	00103$
00106$:
;	_memchr.c:38: return(0);
	mov	dptr,#0x0000
	mov	b,#0x00
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
