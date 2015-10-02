;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:26 2015
;--------------------------------------------------------
	.module _strncmp
	.optsdcc -mmcs51 --model-medium
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncmp_PARM_3
	.globl _strncmp_PARM_2
	.globl _strncmp
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
_strncmp_sloc0_1_0::
	.ds 2
_strncmp_sloc1_1_0::
	.ds 1
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
_strncmp_PARM_2:
	.ds 3
_strncmp_PARM_3:
	.ds 2
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
;Allocation info for local variables in function 'strncmp'
;------------------------------------------------------------
;sloc0                     Allocated with name '_strncmp_sloc0_1_0'
;sloc1                     Allocated with name '_strncmp_sloc1_1_0'
;------------------------------------------------------------
;	_strncmp.c:31: int strncmp (
;	-----------------------------------------
;	 function strncmp
;	-----------------------------------------
_strncmp:
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
;	_strncmp.c:37: if (!count)
	mov	r0,#_strncmp_PARM_3
	movx	a,@r0
	mov	b,a
	inc	r0
	movx	a,@r0
	orl	a,b
	jnz	00114$
;	_strncmp.c:38: return(0);
	mov	dptr,#0x0000
	ret
;	_strncmp.c:40: while (--count && *first && *first == *last) {
00114$:
	mov	r0,#_strncmp_PARM_2
	movx	a,@r0
	mov	r5,a
	inc	r0
	movx	a,@r0
	mov	r6,a
	inc	r0
	movx	a,@r0
	mov	r7,a
	mov	r0,#_strncmp_PARM_3
	movx	a,@r0
	mov	_strncmp_sloc0_1_0,a
	inc	r0
	movx	a,@r0
	mov	(_strncmp_sloc0_1_0 + 1),a
00105$:
	dec	_strncmp_sloc0_1_0
	mov	a,#0xff
	cjne	a,_strncmp_sloc0_1_0,00117$
	dec	(_strncmp_sloc0_1_0 + 1)
00117$:
	mov	a,_strncmp_sloc0_1_0
	orl	a,(_strncmp_sloc0_1_0 + 1)
	jz	00107$
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	_strncmp_sloc1_1_0,a
	jz	00107$
	push	ar2
	push	ar3
	push	ar4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r2,a
	cjne	a,_strncmp_sloc1_1_0,00120$
	sjmp	00121$
00120$:
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp	00107$
00121$:
	pop	ar4
	pop	ar3
	pop	ar2
;	_strncmp.c:41: first++;
	inc	r2
	cjne	r2,#0x00,00122$
	inc	r3
00122$:
;	_strncmp.c:42: last++;
	inc	r5
	cjne	r5,#0x00,00105$
	inc	r6
	sjmp	00105$
00107$:
;	_strncmp.c:45: return( *first - *last );
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r5,a
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	a,r2
	clr	c
	subb	a,r5
	mov	dpl,a
	mov	a,r3
	subb	a,r4
	mov	dph,a
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
