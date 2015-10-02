;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module _memcmp
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcmp_PARM_3
	.globl _memcmp_PARM_2
	.globl _memcmp
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
	.area	OSEG    (OVR,DATA)
_memcmp_PARM_2::
	.ds 3
_memcmp_PARM_3::
	.ds 2
_memcmp_buf1_1_1::
	.ds 3
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
;Allocation info for local variables in function 'memcmp'
;------------------------------------------------------------
;buf2                      Allocated with name '_memcmp_PARM_2'
;count                     Allocated with name '_memcmp_PARM_3'
;buf1                      Allocated with name '_memcmp_buf1_1_1'
;------------------------------------------------------------
;	_memcmp.c:31: int memcmp (
;	-----------------------------------------
;	 function memcmp
;	-----------------------------------------
_memcmp:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	_memcmp_buf1_1_1,dpl
	mov	(_memcmp_buf1_1_1 + 1),dph
	mov	(_memcmp_buf1_1_1 + 2),b
;	_memcmp.c:37: if (!count)
	mov	a,_memcmp_PARM_3
	orl	a,(_memcmp_PARM_3 + 1)
	jnz	00112$
;	_memcmp.c:38: return(0);
	mov	dptr,#0x0000
;	_memcmp.c:40: while ( --count && *((char *)buf1) == *((char *)buf2) ) {
	ret
00112$:
	mov	r5,_memcmp_PARM_3
	mov	r6,(_memcmp_PARM_3 + 1)
00104$:
	dec	r5
	cjne	r5,#0xff,00115$
	dec	r6
00115$:
	mov	a,r5
	orl	a,r6
	jz	00106$
	mov	dpl,_memcmp_buf1_1_1
	mov	dph,(_memcmp_buf1_1_1 + 1)
	mov	b,(_memcmp_buf1_1_1 + 2)
	lcall	__gptrget
	mov	r7,a
	mov	r0,_memcmp_PARM_2
	mov	r1,(_memcmp_PARM_2 + 1)
	mov	r2,(_memcmp_PARM_2 + 2)
	mov	dpl,r0
	mov	dph,r1
	mov	b,r2
	lcall	__gptrget
	mov	r3,a
	mov	a,r7
	cjne	a,ar3,00106$
;	_memcmp.c:41: buf1 = (char *)buf1 + 1;
	inc	_memcmp_buf1_1_1
	clr	a
	cjne	a,_memcmp_buf1_1_1,00119$
	inc	(_memcmp_buf1_1_1 + 1)
00119$:
;	_memcmp.c:42: buf2 = (char *)buf2 + 1;
	mov	a,#0x01
	add	a,r0
	mov	_memcmp_PARM_2,a
	clr	a
	addc	a,r1
	mov	(_memcmp_PARM_2 + 1),a
	mov	(_memcmp_PARM_2 + 2),r2
	sjmp	00104$
00106$:
;	_memcmp.c:45: return( *((unsigned char *)buf1) - *((unsigned char *)buf2) );
	mov	dpl,_memcmp_buf1_1_1
	mov	dph,(_memcmp_buf1_1_1 + 1)
	mov	b,(_memcmp_buf1_1_1 + 2)
	lcall	__gptrget
	mov	r2,a
	mov	r3,#0x00
	mov	r4,_memcmp_PARM_2
	mov	r5,(_memcmp_PARM_2 + 1)
	mov	r6,(_memcmp_PARM_2 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	lcall	__gptrget
	mov	r4,a
	mov	r5,#0x00
	mov	a,r2
	clr	c
	subb	a,r4
	mov	dpl,a
	mov	a,r3
	subb	a,r5
	mov	dph,a
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
