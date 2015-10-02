;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:29 2015
;--------------------------------------------------------
	.module _strstr
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strstr_PARM_2
	.globl _strstr
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
_strstr_sloc0_1_0::
	.ds 3
_strstr_sloc1_1_0::
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
_strstr_PARM_2:
	.ds 3
_strstr_str1_1_1:
	.ds 3
_strstr_cp_1_1:
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
;Allocation info for local variables in function 'strstr'
;------------------------------------------------------------
;str2                      Allocated with name '_strstr_PARM_2'
;str1                      Allocated with name '_strstr_str1_1_1'
;cp                        Allocated with name '_strstr_cp_1_1'
;s1                        Allocated with name '_strstr_s1_1_1'
;s2                        Allocated with name '_strstr_s2_1_1'
;sloc0                     Allocated with name '_strstr_sloc0_1_0'
;sloc1                     Allocated with name '_strstr_sloc1_1_0'
;------------------------------------------------------------
;	_strstr.c:31: char * strstr (
;	-----------------------------------------
;	 function strstr
;	-----------------------------------------
_strstr:
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
	mov	dptr,#_strstr_str1_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
;	_strstr.c:36: const char * cp = str1;
	mov	dptr,#_strstr_str1_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	mov	dptr,#_strstr_cp_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;	_strstr.c:40: if ( !*str2 )
	mov	dptr,#_strstr_PARM_2
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	jnz	00122$
;	_strstr.c:41: return str1;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	ret
;	_strstr.c:43: while (*cp)
00122$:
00110$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	jnz	00125$
	ljmp	00112$
00125$:
;	_strstr.c:48: while ( *s1 && *s2 && !(*s1-*s2) )
	mov	_strstr_sloc0_1_0,r2
	mov	(_strstr_sloc0_1_0 + 1),r3
	mov	(_strstr_sloc0_1_0 + 2),r4
	mov	_strstr_sloc1_1_0,r5
	mov	(_strstr_sloc1_1_0 + 1),r6
	mov	(_strstr_sloc1_1_0 + 2),r7
00105$:
	mov	dpl,_strstr_sloc0_1_0
	mov	dph,(_strstr_sloc0_1_0 + 1)
	mov	b,(_strstr_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	r0,a
	jz	00107$
	mov	dpl,_strstr_sloc1_1_0
	mov	dph,(_strstr_sloc1_1_0 + 1)
	mov	b,(_strstr_sloc1_1_0 + 2)
	lcall	__gptrget
	mov	r1,a
	jz	00107$
	push	ar5
	push	ar6
	push	ar7
	mov	a,r0
	rlc	a
	subb	a,acc
	mov	r5,a
	mov	a,r1
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	a,r0
	clr	c
	subb	a,r1
	mov	r0,a
	mov	a,r5
	subb	a,r6
	orl	a,r0
	pop	ar7
	pop	ar6
	pop	ar5
	jnz	00107$
;	_strstr.c:49: s1++, s2++;
	inc	_strstr_sloc0_1_0
	clr	a
	cjne	a,_strstr_sloc0_1_0,00129$
	inc	(_strstr_sloc0_1_0 + 1)
00129$:
	inc	_strstr_sloc1_1_0
	clr	a
	cjne	a,_strstr_sloc1_1_0,00105$
	inc	(_strstr_sloc1_1_0 + 1)
	sjmp	00105$
00107$:
;	_strstr.c:51: if (!*s2)
	mov	dpl,_strstr_sloc1_1_0
	mov	dph,(_strstr_sloc1_1_0 + 1)
	mov	b,(_strstr_sloc1_1_0 + 2)
	lcall	__gptrget
	jnz	00109$
;	_strstr.c:52: return( (char*)cp );
	mov	dptr,#_strstr_cp_1_1
	movx	a,@dptr
	mov	_strstr_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_strstr_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_strstr_sloc1_1_0 + 2),a
	mov	dpl,_strstr_sloc1_1_0
	mov	dph,(_strstr_sloc1_1_0 + 1)
	mov	b,(_strstr_sloc1_1_0 + 2)
	ret
00109$:
;	_strstr.c:54: cp++;
	inc	r2
	cjne	r2,#0x00,00132$
	inc	r3
00132$:
	mov	dptr,#_strstr_cp_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	ljmp	00110$
00112$:
;	_strstr.c:57: return (NULL) ;
	mov	dptr,#0x0000
	mov	b,#0x00
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
