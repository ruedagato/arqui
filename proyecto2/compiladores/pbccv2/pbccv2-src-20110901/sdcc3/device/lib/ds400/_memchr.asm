;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module _memchr
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
	.globl _memchr_PARM_3
	.globl _memchr_PARM_2
	.globl _memchr
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
_memchr_PARM_2:
	.ds 2
_memchr_PARM_3:
	.ds 2
_memchr_s_1_1:
	.ds 4
_memchr_end_1_1:
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
;Allocation info for local variables in function 'memchr'
;------------------------------------------------------------
;c                         Allocated with name '_memchr_PARM_2'
;n                         Allocated with name '_memchr_PARM_3'
;s                         Allocated with name '_memchr_s_1_1'
;p                         Allocated to registers r6 r7 r0 r1 
;end                       Allocated with name '_memchr_end_1_1'
;------------------------------------------------------------
;	_memchr.c:31: void *memchr(const void *s, int c, size_t n)
;	-----------------------------------------
;	 function memchr
;	-----------------------------------------
_memchr:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov     dps, #1
	mov     dptr, #_memchr_s_1_1
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
;	_memchr.c:33: unsigned char *p = (unsigned char *)s;
	mov	dptr,#_memchr_s_1_1
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
;	_memchr.c:34: unsigned char *end = p + n;
	mov	dptr,#_memchr_PARM_3
	mov	dps, #1
	mov	dptr, #_memchr_s_1_1
	dec	dps
	movx	a,@dptr
	xch	a, _ap
	inc	dps
	movx	a,@dptr
	xch	a, _ap
	add	a,_ap
	mov	r2,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	inc	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	addc	a,_ap
	mov	r3,a
	clr	a
	xch	a, _ap
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	addc	a,_ap
	mov	r4,a
	mov     dps, #1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	mov	r5,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_memchr_end_1_1
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
;	_memchr.c:38: return(0);
	mov	dptr,#_memchr_s_1_1
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
00103$:
;	_memchr.c:35: for(; p != end; p++)
	mov	dptr,#_memchr_end_1_1
	mov	b,r2
	movx	a,@dptr
	cjne	a,b,00112$
	mov	b,r3
	inc	dptr
	movx	a,@dptr
	cjne	a,b,00112$
	mov	b,r4
	inc	dptr
	movx	a,@dptr
	cjne	a,b,00112$
	sjmp 00106$
00112$:
;	_memchr.c:36: if(*p == c)
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	mov	r7,#0
	mov	dptr,#_memchr_PARM_2
	mov	b,r6
	movx	a,@dptr
	cjne	a,b,00113$
	mov	b,r7
	inc	dptr
	movx	a,@dptr
	cjne	a,b,00113$
	sjmp	00114$
00113$:
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	sjmp 00105$
00114$:
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	_memchr.c:37: return((void *)p);
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	sjmp 00107$
00105$:
;	_memchr.c:35: for(; p != end; p++)
	inc	r2
	cjne	r2,#0,00115$
	inc	r3
	cjne	r3,#0,00115$
	inc	r4
00115$:
;	genAssign: resultIsFar = TRUE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
	sjmp 00103$
00106$:
;	_memchr.c:38: return(0);
	mov  dptr,#0x0000
	mov	b,#0x00
00107$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
