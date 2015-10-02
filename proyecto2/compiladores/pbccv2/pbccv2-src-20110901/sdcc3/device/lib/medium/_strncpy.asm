;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:26 2015
;--------------------------------------------------------
	.module _strncpy
	.optsdcc -mmcs51 --model-medium
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncpy_PARM_3
	.globl _strncpy_PARM_2
	.globl _strncpy
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
_strncpy_sloc0_1_0::
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
_strncpy_PARM_2:
	.ds 3
_strncpy_PARM_3:
	.ds 2
_strncpy_d_1_1:
	.ds 3
_strncpy_d1_1_1:
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
;Allocation info for local variables in function 'strncpy'
;------------------------------------------------------------
;sloc0                     Allocated with name '_strncpy_sloc0_1_0'
;------------------------------------------------------------
;	_strncpy.c:31: char *strncpy (
;	-----------------------------------------
;	 function strncpy
;	-----------------------------------------
_strncpy:
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
;	_strncpy.c:36: register char * d1 =  d;
	mov	r0,#_strncpy_d1_1_1
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
;	_strncpy.c:38: while ( n && *s )
	mov	r0,#_strncpy_PARM_3
	movx	a,@r0
	mov	r5,a
	inc	r0
	movx	a,@r0
	mov	r6,a
	mov	r0,#_strncpy_PARM_2
	movx	a,@r0
	mov	_strncpy_sloc0_1_0,a
	inc	r0
	movx	a,@r0
	mov	(_strncpy_sloc0_1_0 + 1),a
	inc	r0
	movx	a,@r0
	mov	(_strncpy_sloc0_1_0 + 2),a
00102$:
	mov	a,r5
	orl	a,r6
	jz	00114$
	mov	dpl,_strncpy_sloc0_1_0
	mov	dph,(_strncpy_sloc0_1_0 + 1)
	mov	b,(_strncpy_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	r7,a
	jz	00114$
;	_strncpy.c:40: n-- ;
	dec	r5
	cjne	r5,#0xff,00119$
	dec	r6
00119$:
;	_strncpy.c:41: *d++ = *s++ ;
	inc	_strncpy_sloc0_1_0
	clr	a
	cjne	a,_strncpy_sloc0_1_0,00120$
	inc	(_strncpy_sloc0_1_0 + 1)
00120$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r7
	lcall	__gptrput
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
;	_strncpy.c:43: while ( n-- )
	sjmp	00102$
00114$:
	mov	r0,#_strncpy_d_1_1
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
00105$:
	mov	ar7,r5
	mov	ar2,r6
	dec	r5
	cjne	r5,#0xff,00121$
	dec	r6
00121$:
	mov	a,r7
	orl	a,r2
	jz	00107$
;	_strncpy.c:45: *d++ = '\0' ;
	mov	r0,#_strncpy_d_1_1
	movx	a,@r0
	mov	dpl,a
	inc	r0
	movx	a,@r0
	mov	dph,a
	inc	r0
	movx	a,@r0
	mov	b,a
	clr	a
	lcall	__gptrput
	inc	dptr
	dec	r0
	dec	r0
	mov	a,dpl
	movx	@r0,a
	inc	r0
	mov	a,dph
	movx	@r0,a
	sjmp	00105$
00107$:
;	_strncpy.c:47: return d1;
	mov	r0,#_strncpy_d1_1_1
	movx	a,@r0
	mov	dpl,a
	inc	r0
	movx	a,@r0
	mov	dph,a
	inc	r0
	movx	a,@r0
	mov	b,a
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
