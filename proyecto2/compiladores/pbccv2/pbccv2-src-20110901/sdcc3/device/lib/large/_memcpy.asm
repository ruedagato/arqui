;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:29 2015
;--------------------------------------------------------
	.module _memcpy
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcpy_PARM_3
	.globl _memcpy_PARM_2
	.globl _memcpy
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
_memcpy_sloc0_1_0::
	.ds 3
_memcpy_sloc1_1_0::
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
_memcpy_PARM_2:
	.ds 3
_memcpy_PARM_3:
	.ds 2
_memcpy_dst_1_1:
	.ds 3
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
;Allocation info for local variables in function 'memcpy'
;------------------------------------------------------------
;src                       Allocated with name '_memcpy_PARM_2'
;acount                    Allocated with name '_memcpy_PARM_3'
;dst                       Allocated with name '_memcpy_dst_1_1'
;ret                       Allocated with name '_memcpy_ret_1_1'
;d                         Allocated with name '_memcpy_d_1_1'
;s                         Allocated with name '_memcpy_s_1_1'
;sloc0                     Allocated with name '_memcpy_sloc0_1_0'
;sloc1                     Allocated with name '_memcpy_sloc1_1_0'
;------------------------------------------------------------
;	_memcpy.c:36: void * memcpy (
;	-----------------------------------------
;	 function memcpy
;	-----------------------------------------
_memcpy:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,b
	mov	r3,dph
	mov	a,dpl
	mov	dptr,#_memcpy_dst_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
;	_memcpy.c:42: void * ret = dst;
	mov	dptr,#_memcpy_dst_1_1
	movx	a,@dptr
	mov	_memcpy_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_memcpy_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_memcpy_sloc1_1_0 + 2),a
;	_memcpy.c:44: char * s = src;
	mov	dptr,#_memcpy_PARM_2
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
;	_memcpy.c:49: while (acount--) {
	mov	_memcpy_sloc0_1_0,_memcpy_sloc1_1_0
	mov	(_memcpy_sloc0_1_0 + 1),(_memcpy_sloc1_1_0 + 1)
	mov	(_memcpy_sloc0_1_0 + 2),(_memcpy_sloc1_1_0 + 2)
	mov	dptr,#_memcpy_PARM_3
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
00101$:
	mov	ar2,r0
	mov	ar3,r1
	dec	r0
	cjne	r0,#0xff,00109$
	dec	r1
00109$:
	mov	a,r2
	orl	a,r3
	jz	00103$
;	_memcpy.c:50: *d++ = *s++;
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	mov	r5,dpl
	mov	r6,dph
	mov	dpl,_memcpy_sloc0_1_0
	mov	dph,(_memcpy_sloc0_1_0 + 1)
	mov	b,(_memcpy_sloc0_1_0 + 2)
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	_memcpy_sloc0_1_0,dpl
	mov	(_memcpy_sloc0_1_0 + 1),dph
	sjmp	00101$
00103$:
;	_memcpy.c:53: return(ret);
	mov	dpl,_memcpy_sloc1_1_0
	mov	dph,(_memcpy_sloc1_1_0 + 1)
	mov	b,(_memcpy_sloc1_1_0 + 2)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
