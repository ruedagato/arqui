;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _strpbrk
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
	.globl _strpbrk_PARM_2
	.globl _strpbrk
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
_strpbrk_PARM_2:
	.ds 4
_strpbrk_string_1_1:
	.ds 4
_strpbrk_ret_1_1:
	.ds 4
_strpbrk_p_2_2:
	.ds 4
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
;Allocation info for local variables in function 'strpbrk'
;------------------------------------------------------------
;ch                        Allocated to registers r7 
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
	mov     dps, #1
	mov     dptr, #_strpbrk_string_1_1
	mov	a,dpl
	movx	@dptr,a
	inc	dptr
	mov	a,dph
	movx	@dptr,a
	inc	dptr
	mov	a,dpx
	movx	@dptr,a
	inc	dptr
	mov	a,b
	movx	@dptr,a
	mov	dps,#0
;	_strpbrk.c:36: char *ret = NULL;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strpbrk_ret_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
;	_strpbrk.c:39: while (ch = *control) {
	mov	dptr,#_strpbrk_PARM_2
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
00105$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
;	genAssign: resultIsFar = FALSE
	mov  r6,a
	mov  ar7,r6 
	jnz	00115$
	ljmp	00107$
00115$:
;	_strpbrk.c:40: char * p = strchr(string, ch);
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strchr_PARM_2
	mov	a,r7
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	inc	dps
	mov	dptr,#_strpbrk_string_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	_strchr
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strpbrk_p_2_2
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
;	_strpbrk.c:41: if (p != NULL && (ret == NULL || p < ret)) {
	mov	dptr,#_strpbrk_p_2_2
	movx	a,@dptr
	cjne	a,#0x00,00116$
	inc	dptr
	movx	a,@dptr
	cjne	a,#0x00,00116$
	inc	dptr
	movx	a,@dptr
	cjne	a,#0x00,00116$
	sjmp 00102$
00116$:
	mov	dptr,#_strpbrk_ret_1_1
	movx	a,@dptr
	cjne	a,#0x00,00117$
	inc	dptr
	movx	a,@dptr
	cjne	a,#0x00,00117$
	inc	dptr
	movx	a,@dptr
	cjne	a,#0x00,00117$
	sjmp 00101$
00117$:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#_strpbrk_p_2_2
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
	mov	dptr,#_strpbrk_ret_1_1
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
	clr	c
	mov	a,r2
	subb	a,r6
	mov	a,r3
	subb	a,r7
	mov	a,r4
	subb	a,r0
	mov	a,r5
	subb	a,r1
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jnc  00102$
00118$:
00101$:
;	_strpbrk.c:42: ret = p;
	mov	dptr,#_strpbrk_p_2_2
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#_strpbrk_ret_1_1
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
00102$:
;	_strpbrk.c:44: control++;
	inc	r2
	cjne	r2,#0,00119$
	inc	r3
	cjne	r3,#0,00119$
	inc	r4
00119$:
	ljmp	00105$
00107$:
;	_strpbrk.c:47: return (ret);
	mov     dps, #1
	mov     dptr, #_strpbrk_ret_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
00108$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
