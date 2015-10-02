;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module _strstr
	.optsdcc -mds400 --model-flat24
	
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
	.globl _strstr_PARM_2
	.globl _strstr
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
	.area REG_BANK_3	(REL,OVR,DATA)
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
_strstr_PARM_2:
	.ds 4
_strstr_cp_1_1:
	.ds 4
_strstr_sloc0_1_0:
	.ds 4
_strstr_sloc1_1_0:
	.ds 4
_strstr_sloc2_1_0:
	.ds 1
_strstr_sloc3_1_0:
	.ds 1
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
;Allocation info for local variables in function 'strstr'
;------------------------------------------------------------
;str2                      Allocated with name '_strstr_PARM_2'
;str1                      Allocated to registers r6 r3 r4 r5 
;cp                        Allocated with name '_strstr_cp_1_1'
;s1                        Allocated to registers 
;s2                        Allocated to registers r6 r7 r0 r1 
;sloc0                     Allocated with name '_strstr_sloc0_1_0'
;sloc1                     Allocated with name '_strstr_sloc1_1_0'
;sloc2                     Allocated with name '_strstr_sloc2_1_0'
;sloc3                     Allocated with name '_strstr_sloc3_1_0'
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
	mov	r6,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	_strstr.c:36: const char * cp = str1;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strstr_cp_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_strstr.c:40: if ( !*str2 )
	mov	dptr,#_strstr_PARM_2
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#_strstr_sloc0_1_0
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
	mov     dps, #1
	mov     dptr, #_strstr_sloc0_1_0
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
	lcall	__gptrget
	mov  r2,a
	jnz  00122$
00124$:
;	_strstr.c:41: return str1;
	mov	dpl,r6
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	ljmp	00113$
;	_strstr.c:43: while (*cp)
00122$:
;	genAssign: resultIsFar = FALSE
	mov	ar2,r6
00110$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov  r6,a
	jnz	00125$
	ljmp	00112$
00125$:
;	_strstr.c:46: s2 = str2;
	mov	dptr,#_strstr_sloc0_1_0
;	genAssign: resultIsFar = TRUE
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
;	_strstr.c:48: while ( *s1 && *s2 && !(*s1-*s2) )
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strstr_sloc1_1_0
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	genAssign: resultIsFar = FALSE
00105$:
	mov     dps, #1
	mov     dptr, #_strstr_sloc1_1_0
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
	mov	dps, #1
	mov	dptr, #_strstr_sloc2_1_0
	dec	dps
	lcall	__gptrget
	mov	dps,#1
	movx	@dptr,a
	mov	dps,#0
	mov	dptr,#_strstr_sloc2_1_0
	movx	a,@dptr
	jz   00107$
00126$:
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	dps, #1
	mov	dptr, #_strstr_sloc3_1_0
	dec	dps
	lcall	__gptrget
	mov	dps,#1
	movx	@dptr,a
	mov	dps,#0
	mov	dptr,#_strstr_sloc3_1_0
	movx	a,@dptr
	jz  00107$
00127$:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#_strstr_sloc2_1_0
	movx	a,@dptr
	mov	r2,a
	movx	a,@dptr
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	dptr,#_strstr_sloc3_1_0
	movx	a,@dptr
	mov	r4,a
	movx	a,@dptr
	rlc	a
	subb	a,acc
	mov	r5,a
	clr	c
	mov	a,r2
	subb	a,r4
	mov	r2,a
	mov	a,r3
	subb	a,r5
	mov  r3,a
	orl  a,r2
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jnz  00107$
00128$:
;	_strstr.c:49: s1++, s2++;
	mov	dptr,#_strstr_sloc1_1_0
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	r6
	cjne	r6,#0,00129$
	inc	r7
	cjne	r7,#0,00129$
	inc	r0
00129$:
	ljmp	00105$
00107$:
;	_strstr.c:51: if (!*s2)
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov  r6,a
	jnz  00109$
00130$:
;	_strstr.c:52: return( (char*)cp );
	mov     dps, #1
	mov     dptr, #_strstr_cp_1_1
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
	sjmp 00113$
00109$:
;	_strstr.c:54: cp++;
	inc	r2
	cjne	r2,#0,00131$
	inc	r3
	cjne	r3,#0,00131$
	inc	r4
00131$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strstr_cp_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	ljmp	00110$
00112$:
;	_strstr.c:57: return (NULL) ;
	mov  dptr,#0x0000
	mov	b,#0x00
00113$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
