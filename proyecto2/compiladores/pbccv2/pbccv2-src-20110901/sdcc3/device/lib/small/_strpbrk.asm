;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module _strpbrk
	.optsdcc -mmcs51 --model-small
	
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
_strpbrk_PARM_2:
	.ds 3
_strpbrk_string_1_1:
	.ds 3
_strpbrk_ret_1_1:
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
;control                   Allocated with name '_strpbrk_PARM_2'
;string                    Allocated with name '_strpbrk_string_1_1'
;ret                       Allocated with name '_strpbrk_ret_1_1'
;ch                        Allocated to registers r4 
;p                         Allocated to registers r3 r4 r5 
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
	mov	_strpbrk_string_1_1,dpl
	mov	(_strpbrk_string_1_1 + 1),dph
	mov	(_strpbrk_string_1_1 + 2),b
;	_strpbrk.c:36: char *ret = NULL;
	clr	a
	mov	_strpbrk_ret_1_1,a
	mov	(_strpbrk_ret_1_1 + 1),a
	mov	(_strpbrk_ret_1_1 + 2),a
;	_strpbrk.c:39: while (ch = *control) {
	mov	r0,_strpbrk_PARM_2
	mov	r1,(_strpbrk_PARM_2 + 1)
	mov	r2,(_strpbrk_PARM_2 + 2)
00105$:
	mov	dpl,r0
	mov	dph,r1
	mov	b,r2
	lcall	__gptrget
	mov	r3,a
	mov	r4,a
	jz	00107$
;	_strpbrk.c:40: char * p = strchr(string, ch);
	mov	_strchr_PARM_2,r4
	mov	dpl,_strpbrk_string_1_1
	mov	dph,(_strpbrk_string_1_1 + 1)
	mov	b,(_strpbrk_string_1_1 + 2)
	push	ar2
	push	ar0
	push	ar1
	lcall	_strchr
	mov	r3,dpl
	mov	r4,dph
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar2
;	_strpbrk.c:41: if (p != NULL && (ret == NULL || p < ret)) {
	cjne	r3,#0x00,00116$
	cjne	r4,#0x00,00116$
	cjne	r5,#0x00,00116$
	sjmp	00102$
00116$:
	clr	a
	cjne	a,_strpbrk_ret_1_1,00117$
	clr	a
	cjne	a,(_strpbrk_ret_1_1 + 1),00117$
	clr	a
	cjne	a,(_strpbrk_ret_1_1 + 2),00117$
	sjmp	00101$
00117$:
	clr	c
	mov	a,r3
	subb	a,_strpbrk_ret_1_1
	mov	a,r4
	subb	a,(_strpbrk_ret_1_1 + 1)
	mov	a,r5
	subb	a,(_strpbrk_ret_1_1 + 2)
	jnc	00102$
00101$:
;	_strpbrk.c:42: ret = p;
	mov	_strpbrk_ret_1_1,r3
	mov	(_strpbrk_ret_1_1 + 1),r4
	mov	(_strpbrk_ret_1_1 + 2),r5
00102$:
;	_strpbrk.c:44: control++;
	inc	r0
	cjne	r0,#0x00,00105$
	inc	r1
	sjmp	00105$
00107$:
;	_strpbrk.c:47: return (ret);
	mov	dpl,_strpbrk_ret_1_1
	mov	dph,(_strpbrk_ret_1_1 + 1)
	mov	b,(_strpbrk_ret_1_1 + 2)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
