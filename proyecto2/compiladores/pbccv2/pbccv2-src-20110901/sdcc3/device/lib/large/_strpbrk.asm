;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:29 2015
;--------------------------------------------------------
	.module _strpbrk
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strpbrk_PARM_2
	.globl _strpbrk
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
_strpbrk_sloc0_1_0:
	.ds 3
_strpbrk_sloc1_1_0:
	.ds 3
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
_strpbrk_PARM_2:
	.ds 3
_strpbrk_string_1_1:
	.ds 3
_strpbrk_ret_1_1:
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
;Allocation info for local variables in function 'strpbrk'
;------------------------------------------------------------
;ch                        Allocated to registers r6 
;sloc0                     Allocated with name '_strpbrk_sloc0_1_0'
;sloc1                     Allocated with name '_strpbrk_sloc1_1_0'
;control                   Allocated with name '_strpbrk_PARM_2'
;string                    Allocated with name '_strpbrk_string_1_1'
;ret                       Allocated with name '_strpbrk_ret_1_1'
;p                         Allocated with name '_strpbrk_p_2_2'
;------------------------------------------------------------
;	_strpbrk.c:31: char * strpbrk (
;	-----------------------------------------
;	 function strpbrk
;	-----------------------------------------
_strpbrk:
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
	mov	dptr,#_strpbrk_string_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
;	_strpbrk.c:36: char *ret = NULL;
	mov	dptr,#_strpbrk_ret_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	_strpbrk.c:39: while (ch = *control) {
	mov	dptr,#_strpbrk_PARM_2
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
00105$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	mov	r6,a
	jnz	00115$
	ljmp	00107$
00115$:
;	_strpbrk.c:40: char * p = strchr(string, ch);
	mov	dptr,#_strpbrk_string_1_1
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	mov	dptr,#_strchr_PARM_2
	mov	a,r6
	movx	@dptr,a
	mov	dpl,r5
	mov	dph,r7
	mov	b,r0
	push	ar2
	push	ar3
	push	ar4
	lcall	_strchr
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	pop	ar4
	pop	ar3
	pop	ar2
;	_strpbrk.c:41: if (p != NULL && (ret == NULL || p < ret)) {
	cjne	r5,#0x00,00116$
	cjne	r6,#0x00,00116$
	cjne	r7,#0x00,00116$
	sjmp	00102$
00116$:
	mov	dptr,#_strpbrk_ret_1_1
	movx	a,@dptr
	mov	_strpbrk_sloc0_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_strpbrk_sloc0_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_strpbrk_sloc0_1_0 + 2),a
	clr	a
	cjne	a,_strpbrk_sloc0_1_0,00117$
	clr	a
	cjne	a,(_strpbrk_sloc0_1_0 + 1),00117$
	clr	a
	cjne	a,(_strpbrk_sloc0_1_0 + 2),00117$
	sjmp	00101$
00117$:
	push	ar2
	push	ar3
	push	ar4
	mov	_strpbrk_sloc1_1_0,r5
	mov	(_strpbrk_sloc1_1_0 + 1),r6
	mov	(_strpbrk_sloc1_1_0 + 2),r7
	mov	r3,_strpbrk_sloc0_1_0
	mov	r4,(_strpbrk_sloc0_1_0 + 1)
	mov	r2,(_strpbrk_sloc0_1_0 + 2)
	clr	c
	mov	a,_strpbrk_sloc1_1_0
	subb	a,r3
	mov	a,(_strpbrk_sloc1_1_0 + 1)
	subb	a,r4
	mov	a,(_strpbrk_sloc1_1_0 + 2)
	subb	a,r2
	pop	ar4
	pop	ar3
	pop	ar2
	jnc	00102$
00101$:
;	_strpbrk.c:42: ret = p;
	mov	dptr,#_strpbrk_ret_1_1
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
00102$:
;	_strpbrk.c:44: control++;
	inc	r2
	cjne	r2,#0x00,00119$
	inc	r3
00119$:
	ljmp	00105$
00107$:
;	_strpbrk.c:47: return (ret);
	mov	dptr,#_strpbrk_ret_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
