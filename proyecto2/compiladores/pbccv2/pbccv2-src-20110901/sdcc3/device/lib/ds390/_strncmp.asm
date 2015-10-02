;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _strncmp
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
	.globl _strncmp_PARM_3
	.globl _strncmp_PARM_2
	.globl _strncmp
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
_strncmp_PARM_2:
	.ds 4
_strncmp_PARM_3:
	.ds 2
_strncmp_sloc0_1_0:
	.ds 2
_strncmp_sloc1_1_0:
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
;Allocation info for local variables in function 'strncmp'
;------------------------------------------------------------
;last                      Allocated with name '_strncmp_PARM_2'
;count                     Allocated with name '_strncmp_PARM_3'
;first                     Allocated to registers r2 r3 r4 r5 
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
	mov	r4,dpx
	mov	r5,b
;	_strncmp.c:37: if (!count)
	mov	dptr,#_strncmp_PARM_3
	movx	a,@dptr
	mov	b,a
	inc	dptr
	movx	a,@dptr
	orl	a,b
	jnz  00114$
00116$:
;	_strncmp.c:38: return(0);
	mov  dptr,#0x0000
	ljmp	00108$
;	_strncmp.c:40: while (--count && *first && *first == *last) {
00114$:
;	genAssign: resultIsFar = FALSE
	mov	dptr,#_strncmp_PARM_2
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
	mov	dptr,#_strncmp_PARM_3
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#_strncmp_sloc0_1_0
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
00105$:
	mov	dptr,#_strncmp_sloc0_1_0
	movx	a,@dptr
	add	a,#0xFF
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	movx	@dptr,a
	mov	dptr,#_strncmp_sloc0_1_0
	movx	a,@dptr
	mov	b,a
	inc	dptr
	movx	a,@dptr
	orl	a,b
	jz  00107$
00117$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	mov	dps, #1
	mov	dptr, #_strncmp_sloc1_1_0
	dec	dps
	lcall	__gptrget
	mov	dps,#1
	movx	@dptr,a
	mov	dps,#0
	mov	dptr,#_strncmp_sloc1_1_0
	movx	a,@dptr
	jz  00107$
00118$:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov	r2,a
	mov	dptr,#_strncmp_sloc1_1_0
	movx	a,@dptr
	cjne	a,ar2,00119$
	sjmp	00120$
00119$:
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp 00107$
00120$:
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	_strncmp.c:41: first++;
	inc	r2
	cjne	r2,#0,00121$
	inc	r3
	cjne	r3,#0,00121$
	inc	r4
00121$:
;	_strncmp.c:42: last++;
	inc	r6
	cjne	r6,#0,00122$
	inc	r7
	cjne	r7,#0,00122$
	inc	r0
00122$:
	ljmp	00105$
00107$:
;	_strncmp.c:45: return( *first - *last );
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov  r2,a
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov  r6,a
	rlc	a
	subb	a,acc
	mov	r4,a
	clr	c
	mov	a,r2
	subb	a,r6
	mov	dpl,a
	mov	a,r3
	subb	a,r4
	mov	dph,a
00108$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
