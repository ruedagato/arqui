;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _strncpy
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
	.globl _strncpy_PARM_3
	.globl _strncpy_PARM_2
	.globl _strncpy
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
_strncpy_PARM_2:
	.ds 4
_strncpy_PARM_3:
	.ds 2
_strncpy_d_1_1:
	.ds 4
_strncpy_sloc0_1_0:
	.ds 4
_strncpy_sloc1_1_0:
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
;Allocation info for local variables in function 'strncpy'
;------------------------------------------------------------
;s                         Allocated with name '_strncpy_PARM_2'
;n                         Allocated with name '_strncpy_PARM_3'
;d                         Allocated with name '_strncpy_d_1_1'
;d1                        Allocated to registers r6 r7 r0 r1 
;sloc0                     Allocated with name '_strncpy_sloc0_1_0'
;sloc1                     Allocated with name '_strncpy_sloc1_1_0'
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
	mov     dps, #1
	mov     dptr, #_strncpy_d_1_1
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
;	_strncpy.c:36: register char * d1 =  d;
	mov	dptr,#_strncpy_d_1_1
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
;	_strncpy.c:38: while ( n && *s )
	mov	dptr,#_strncpy_PARM_3
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_strncpy_PARM_2
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#_strncpy_sloc0_1_0
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
	mov	dptr,#_strncpy_d_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#_strncpy_sloc1_1_0
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
	mov	a,r2
	orl	a,r3
	jnz	00117$
	ljmp	00114$
00117$:
	mov     dps, #1
	mov     dptr, #_strncpy_sloc0_1_0
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
	mov  r4,a
	jz  00114$
00118$:
;	_strncpy.c:40: n-- ;
	dec	r2
	cjne	r2,#0xFF,00119$
	dec	r3
00119$:
;	_strncpy.c:41: *d++ = *s++ ;
	mov	dptr,#_strncpy_sloc0_1_0
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
	mov     dps, #1
	mov     dptr, #_strncpy_sloc1_1_0
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
	mov	a,r4
	lcall	__gptrput
	inc	dptr
	inc	dps
	lcall	__decdptr
	lcall	__decdptr
	lcall	__decdptr
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
	ljmp	00102$
;	_strncpy.c:43: while ( n-- )
00114$:
	mov	dptr,#_strncpy_sloc1_1_0
;	genAssign: resultIsFar = FALSE
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
;	genAssign: resultIsFar = FALSE
00105$:
;	genAssign: resultIsFar = FALSE
	mov	ar4,r2
	mov	ar5,r3
	dec	r2
	cjne	r2,#0xFF,00120$
	dec	r3
00120$:
	mov	a,r4
	orl	a,r5
	jz  00107$
00121$:
;	_strncpy.c:45: *d++ = '\0' ;
	clr  a
	lcall	__gptrput
	inc	dptr
	sjmp 00105$
00107$:
;	_strncpy.c:47: return d1;
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
00108$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
