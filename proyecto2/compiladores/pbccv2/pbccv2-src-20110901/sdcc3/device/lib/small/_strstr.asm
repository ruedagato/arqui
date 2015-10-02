;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module _strstr
	.optsdcc -mmcs51 --model-small
	
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
_strstr_PARM_2::
	.ds 3
_strstr_cp_1_1::
	.ds 3
_strstr_s1_1_1::
	.ds 3
_strstr_s2_1_1::
	.ds 3
_strstr_sloc0_1_0::
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
;Allocation info for local variables in function 'strstr'
;------------------------------------------------------------
;str2                      Allocated with name '_strstr_PARM_2'
;str1                      Allocated to registers r2 r3 r4 
;cp                        Allocated with name '_strstr_cp_1_1'
;s1                        Allocated with name '_strstr_s1_1_1'
;s2                        Allocated with name '_strstr_s2_1_1'
;sloc0                     Allocated with name '_strstr_sloc0_1_0'
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
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	_strstr.c:36: const char * cp = str1;
	mov	_strstr_cp_1_1,r2
	mov	(_strstr_cp_1_1 + 1),r3
	mov	(_strstr_cp_1_1 + 2),r4
;	_strstr.c:40: if ( !*str2 )
	mov	_strstr_s2_1_1,_strstr_PARM_2
	mov	(_strstr_s2_1_1 + 1),(_strstr_PARM_2 + 1)
	mov	(_strstr_s2_1_1 + 2),(_strstr_PARM_2 + 2)
	mov	dpl,_strstr_s2_1_1
	mov	dph,(_strstr_s2_1_1 + 1)
	mov	b,(_strstr_s2_1_1 + 2)
	lcall	__gptrget
	jnz	00122$
;	_strstr.c:41: return str1;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	ret
;	_strstr.c:43: while (*cp)
00122$:
	mov	_strstr_s1_1_1,r2
	mov	(_strstr_s1_1_1 + 1),r3
	mov	(_strstr_s1_1_1 + 2),r4
00110$:
	mov	dpl,_strstr_s1_1_1
	mov	dph,(_strstr_s1_1_1 + 1)
	mov	b,(_strstr_s1_1_1 + 2)
	lcall	__gptrget
	jz	00112$
;	_strstr.c:46: s2 = str2;
	mov	r6,_strstr_s2_1_1
	mov	r7,(_strstr_s2_1_1 + 1)
	mov	r5,(_strstr_s2_1_1 + 2)
;	_strstr.c:48: while ( *s1 && *s2 && !(*s1-*s2) )
	mov	_strstr_sloc0_1_0,_strstr_s1_1_1
	mov	(_strstr_sloc0_1_0 + 1),(_strstr_s1_1_1 + 1)
	mov	(_strstr_sloc0_1_0 + 2),(_strstr_s1_1_1 + 2)
00105$:
	mov	dpl,_strstr_sloc0_1_0
	mov	dph,(_strstr_sloc0_1_0 + 1)
	mov	b,(_strstr_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	r0,a
	jz	00107$
	mov	dpl,r6
	mov	dph,r7
	mov	b,r5
	lcall	__gptrget
	mov	r1,a
	jz	00107$
	mov	a,r0
	rlc	a
	subb	a,acc
	mov	r2,a
	mov	a,r1
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	a,r0
	clr	c
	subb	a,r1
	mov	r0,a
	mov	a,r2
	subb	a,r3
	mov	r2,a
	orl	a,r0
	jnz	00107$
;	_strstr.c:49: s1++, s2++;
	inc	_strstr_sloc0_1_0
	clr	a
	cjne	a,_strstr_sloc0_1_0,00129$
	inc	(_strstr_sloc0_1_0 + 1)
00129$:
	inc	r6
	cjne	r6,#0x00,00105$
	inc	r7
	sjmp	00105$
00107$:
;	_strstr.c:51: if (!*s2)
	mov	dpl,r6
	mov	dph,r7
	mov	b,r5
	lcall	__gptrget
	jnz	00109$
;	_strstr.c:52: return( (char*)cp );
	mov	dpl,_strstr_cp_1_1
	mov	dph,(_strstr_cp_1_1 + 1)
	mov	b,(_strstr_cp_1_1 + 2)
	ret
00109$:
;	_strstr.c:54: cp++;
	inc	_strstr_s1_1_1
	clr	a
	cjne	a,_strstr_s1_1_1,00131$
	inc	(_strstr_s1_1_1 + 1)
00131$:
	mov	_strstr_cp_1_1,_strstr_s1_1_1
	mov	(_strstr_cp_1_1 + 1),(_strstr_s1_1_1 + 1)
	mov	(_strstr_cp_1_1 + 2),(_strstr_s1_1_1 + 2)
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
