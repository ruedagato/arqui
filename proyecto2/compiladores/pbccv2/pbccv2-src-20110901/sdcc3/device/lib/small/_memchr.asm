;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module _memchr
	.optsdcc -mmcs51 --model-small
	
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
	.area	OSEG    (OVR,DATA)
_memchr_PARM_2::
	.ds 2
_memchr_PARM_3::
	.ds 2
_memchr_s_1_1::
	.ds 3
_memchr_end_1_1::
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
;Allocation info for local variables in function 'memchr'
;------------------------------------------------------------
;c                         Allocated with name '_memchr_PARM_2'
;n                         Allocated with name '_memchr_PARM_3'
;s                         Allocated with name '_memchr_s_1_1'
;p                         Allocated to registers r5 r6 r7 
;end                       Allocated with name '_memchr_end_1_1'
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
	mov	_memchr_s_1_1,dpl
	mov	(_memchr_s_1_1 + 1),dph
	mov	(_memchr_s_1_1 + 2),b
;	_memchr.c:33: unsigned char *p = (unsigned char *)s;
	mov	r5,_memchr_s_1_1
	mov	r6,(_memchr_s_1_1 + 1)
	mov	r7,(_memchr_s_1_1 + 2)
;	_memchr.c:34: unsigned char *end = p + n;
	mov	a,_memchr_PARM_3
	add	a,_memchr_s_1_1
	mov	_memchr_end_1_1,a
	mov	a,(_memchr_PARM_3 + 1)
	addc	a,(_memchr_s_1_1 + 1)
	mov	(_memchr_end_1_1 + 1),a
	mov	(_memchr_end_1_1 + 2),(_memchr_s_1_1 + 2)
;	_memchr.c:38: return(0);
	mov	r3,_memchr_s_1_1
	mov	r4,(_memchr_s_1_1 + 1)
	mov	r2,(_memchr_s_1_1 + 2)
00103$:
;	_memchr.c:35: for(; p != end; p++)
	mov	a,r3
	cjne	a,_memchr_end_1_1,00112$
	mov	a,r4
	cjne	a,(_memchr_end_1_1 + 1),00112$
	mov	a,r2
	cjne	a,(_memchr_end_1_1 + 2),00112$
	sjmp	00106$
00112$:
;	_memchr.c:36: if(*p == c)
	mov	dpl,r3
	mov	dph,r4
	mov	b,r2
	lcall	__gptrget
	mov	r0,a
	mov	r1,#0x00
	cjne	a,_memchr_PARM_2,00105$
	mov	a,r1
	cjne	a,(_memchr_PARM_2 + 1),00105$
;	_memchr.c:37: return((void *)p);
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	ret
00105$:
;	_memchr.c:35: for(; p != end; p++)
	inc	r3
	cjne	r3,#0x00,00115$
	inc	r4
00115$:
	mov	ar5,r3
	mov	ar6,r4
	mov	ar7,r2
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
