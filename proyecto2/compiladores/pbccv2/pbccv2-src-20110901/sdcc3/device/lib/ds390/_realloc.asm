;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _realloc
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
	.globl _realloc_PARM_2
	.globl _realloc
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
_realloc_PARM_2:
	.ds 2
_realloc_p_1_1:
	.ds 4
_realloc_pthis_1_1:
	.ds 3
_realloc_pnew_1_1:
	.ds 3
_realloc_sloc0_1_0:
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
;Allocation info for local variables in function 'realloc'
;------------------------------------------------------------
;size                      Allocated with name '_realloc_PARM_2'
;p                         Allocated with name '_realloc_p_1_1'
;pthis                     Allocated with name '_realloc_pthis_1_1'
;pnew                      Allocated with name '_realloc_pnew_1_1'
;ret                       Allocated to registers r2 r3 r4 
;sloc0                     Allocated with name '_realloc_sloc0_1_0'
;------------------------------------------------------------
;	_realloc.c:84: void __xdata * realloc (void * p, size_t size)
;	-----------------------------------------
;	 function realloc
;	-----------------------------------------
_realloc:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov     dps, #1
	mov     dptr, #_realloc_p_1_1
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
;	_realloc.c:92: pthis = _sdcc_find_memheader(p);
	mov	dptr,#_realloc_p_1_1
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
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	lcall	__sdcc_find_memheader
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_realloc_pthis_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
;	_realloc.c:93: if (pthis)
	mov	dptr,#_realloc_pthis_1_1
	movx	a,@dptr
	mov	b,a
	inc	dptr
	movx	a,@dptr
	orl	b,a
	inc	dptr
	movx	a,@dptr
	orl	a,b
	jnz	00124$
	ljmp	00114$
00124$:
;	_realloc.c:95: if (size > (0xFFFF-HEADER_SIZE))
	mov	dptr,#_realloc_PARM_2
	clr	c
	mov	a,#0xFA
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	a,#0xFF
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jnc  00111$
00125$:
;	_realloc.c:97: ret = (void __xdata *) NULL; //To prevent overflow in next line
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	ljmp	00115$
00111$:
;	_realloc.c:101: size += HEADER_SIZE; //We need a memory for header too
	mov	dptr,#_realloc_PARM_2
	movx	a,@dptr
	add	a,#0x05
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
;	_realloc.c:103: if ((((unsigned int)pthis->next) - ((unsigned int)pthis)) >= size)
	mov	dptr,#_realloc_pthis_1_1
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	pop	dph
	pop	dpl
	movx	a,@dptr
	inc	dptr
	mov	r1,a
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	mov	r3,a
	mov	ar4,r1
	mov	ar5,r2
	mov	dptr,#_realloc_pthis_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	clr	c
	mov	a,r4
	subb	a,r6
	mov	r4,a
	mov	a,r5
	subb	a,r7
	mov	r5,a
	mov	dptr,#_realloc_PARM_2
	clr	c
	mov	a,r4
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	a,r5
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jc   00108$
00126$:
;	_realloc.c:105: pthis->len = size;
	mov	dptr,#_realloc_pthis_1_1
	movx	a,@dptr
	add	a,#0x03
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	dph1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	dpx1,a
	mov	dptr,#_realloc_PARM_2
	movx	a,@dptr
	mov	dps,#1
	movx	@dptr,a
	inc	dptr
	mov	dps,#0
	inc	dptr
	movx	a,@dptr
	mov	dps,#1
	movx	@dptr,a
	mov	dps,#0
;	_realloc.c:106: ret = p;
	mov	dptr,#_realloc_p_1_1
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
	ljmp	00115$
00108$:
;	_realloc.c:110: if ((_sdcc_prev_memheader) &&
	mov	dptr,#__sdcc_prev_memheader
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	mov	dph1,a
	inc	dptr
	movx	a,@dptr
	mov	dpx1,a
	mov	a,dpl1
	orl	a,dph1
	orl	a,dpx1
	jnz	00127$
	ljmp	00104$
00127$:
;	_realloc.c:111: ((((unsigned int)pthis->next) -
;	genAssign: resultIsFar = FALSE
;	_realloc.c:112: ((unsigned int)_sdcc_prev_memheader) -
;	genAssign: resultIsFar = FALSE
	mov	r3,dpl1
	mov	r7,dph1
	mov	r0,dpx1
	clr	c
	mov	a,r1
	subb	a,r3
	mov	r1,a
	mov	a,r2
	subb	a,r7
	mov	r2,a
;	_realloc.c:113: _sdcc_prev_memheader->len) >= size))
	mov	dpx,dpx1
	mov	dph,dph1
	mov	dpl,dpl1
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	mov	r7,a
	clr	c
	mov	a,r1
	subb	a,r3
	mov	r1,a
	mov	a,r2
	subb	a,r7
	mov	r2,a
	mov	dptr,#_realloc_PARM_2
	clr	c
	mov	a,r1
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	a,r2
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jnc	00128$
	ljmp	00104$
00128$:
;	_realloc.c:115: pnew = (MEMHEADER __xdata * )((char __xdata *)_sdcc_prev_memheader + _sdcc_prev_memheader->len);
	mov	dptr,#_realloc_pnew_1_1
	mov	a,r3
	add	a,dpl1
	movx	@dptr,a
	mov	a,r7
	addc	a,dph1
	inc	dptr
	movx	@dptr,a
	clr	a
	addc	a,dpx1
	inc	dptr
	movx	@dptr,a
;	_realloc.c:116: _sdcc_prev_memheader->next = pnew;
	mov	dptr,#_realloc_pnew_1_1
	movx	a,@dptr
	mov	dps,#1
	movx	@dptr,a
	inc	dptr
	mov	dps,#0
	inc	dptr
	movx	a,@dptr
	mov	dps,#1
	movx	@dptr,a
	inc	dptr
	mov	dps,#0
	inc	dptr
	movx	a,@dptr
	mov	dps,#1
	movx	@dptr,a
	mov	dps,#0
;	_realloc.c:122: memmove(pnew, pthis, pthis->len);
	mov	dptr,#_realloc_pnew_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	r0,#0x00
	mov	dptr,#_realloc_pthis_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_realloc_sloc0_1_0
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
	mov	dptr,#_realloc_pthis_1_1
	movx	a,@dptr
	add	a,#0x03
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	dph1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	dpx1,a
	inc	dps
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	mov	r3,a
	mov	dps,#0
	mov	dptr,#_realloc_sloc0_1_0
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#_memmove_PARM_2
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
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_memmove_PARM_3
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	mov	dpl,r4
	mov	dph,r5
	mov	dpx,r6
	mov	b,r0
	lcall	_memmove
;	_realloc.c:123: pnew->len = size;
	mov	dptr,#_realloc_pnew_1_1
	movx	a,@dptr
	add	a,#0x03
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	dph1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	dpx1,a
	mov	dptr,#_realloc_PARM_2
	movx	a,@dptr
	mov	dps,#1
	movx	@dptr,a
	inc	dptr
	mov	dps,#0
	inc	dptr
	movx	a,@dptr
	mov	dps,#1
	movx	@dptr,a
	mov	dps,#0
;	_realloc.c:124: ret = MEM(pnew);
	mov	dptr,#_realloc_pnew_1_1
	movx	a,@dptr
	add	a,#0x05
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r4,a
	ljmp	00115$
00104$:
;	_realloc.c:128: ret = malloc(size - HEADER_SIZE);
	mov	dptr,#_realloc_PARM_2
	movx	a,@dptr
	add	a,#0xFB
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	lcall	_malloc
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
;	genAssign: resultIsFar = TRUE
;	_realloc.c:129: if (ret)
	mov	a,r2
	orl	a,r3
	orl	a,r4
	jnz	00129$
	ljmp	00115$
00129$:
;	_realloc.c:131: memcpy(ret, MEM(pthis), pthis->len - HEADER_SIZE);
;	genAssign: resultIsFar = FALSE
	mov	r5,#0x00
	mov	dptr,#_realloc_pthis_1_1
	movx	a,@dptr
	add	a,#0x05
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r0,a
	mov	r1,#0x00
	push	ar2
	push	ar3
	push	ar4
	mov	dptr,#_realloc_pthis_1_1
	movx	a,@dptr
	add	a,#0x03
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	dph1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	dpx1,a
	inc	dps
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	mov	r3,a
	mov	dps,#0
	mov	a,r2
	add	a,#0xFB
	mov	r2,a
	mov	a,r3
	addc	a,#0xFF
	mov	r3,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_memcpy_PARM_2
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
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_memcpy_PARM_3
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	_memcpy
	pop	ar4
	pop	ar3
	pop	ar2
;	_realloc.c:132: free(p);
	push	ar2
	push	ar3
	push	ar4
	inc	dps
	mov	dptr,#_realloc_p_1_1
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
	lcall	_free
	pop	ar4
	pop	ar3
	pop	ar2
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp 00115$
00114$:
;	_realloc.c:140: ret = malloc(size);
	inc	dps
	mov	dptr,#_realloc_PARM_2
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	mov	dps,#0
	lcall	_malloc
	mov	r5,dpl
	mov	r6,dph
	mov	r7,dpx
;	genAssign: resultIsFar = TRUE
	mov	ar2,r5
	mov	ar3,r6
	mov	ar4,r7
00115$:
;	_realloc.c:143: return ret;
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
00116$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
