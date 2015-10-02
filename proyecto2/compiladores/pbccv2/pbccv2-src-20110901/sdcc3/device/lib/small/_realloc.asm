;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module _realloc
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _realloc_PARM_2
	.globl _realloc
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
_realloc_PARM_2:
	.ds 2
_realloc_p_1_1:
	.ds 3
_realloc_pthis_1_1:
	.ds 2
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
;Allocation info for local variables in function 'realloc'
;------------------------------------------------------------
;size                      Allocated with name '_realloc_PARM_2'
;p                         Allocated with name '_realloc_p_1_1'
;pthis                     Allocated with name '_realloc_pthis_1_1'
;pnew                      Allocated to registers r2 r3 
;ret                       Allocated to registers r7 r0 
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
	mov	_realloc_p_1_1,dpl
	mov	(_realloc_p_1_1 + 1),dph
	mov	(_realloc_p_1_1 + 2),b
;	_realloc.c:92: pthis = _sdcc_find_memheader(p);
	mov	dpl,_realloc_p_1_1
	mov	dph,(_realloc_p_1_1 + 1)
	lcall	__sdcc_find_memheader
	mov	_realloc_pthis_1_1,dpl
	mov	(_realloc_pthis_1_1 + 1),dph
;	_realloc.c:93: if (pthis)
	mov	a,_realloc_pthis_1_1
	orl	a,(_realloc_pthis_1_1 + 1)
	jnz	00124$
	ljmp	00114$
00124$:
;	_realloc.c:95: if (size > (0xFFFF-HEADER_SIZE))
	clr	c
	mov	a,#0xFB
	subb	a,_realloc_PARM_2
	mov	a,#0xFF
	subb	a,(_realloc_PARM_2 + 1)
	jnc	00111$
;	_realloc.c:97: ret = (void __xdata *) NULL; //To prevent overflow in next line
	mov	r7,#0x00
	mov	r0,#0x00
	ljmp	00115$
00111$:
;	_realloc.c:101: size += HEADER_SIZE; //We need a memory for header too
	mov	a,#0x04
	add	a,_realloc_PARM_2
	mov	_realloc_PARM_2,a
	clr	a
	addc	a,(_realloc_PARM_2 + 1)
	mov	(_realloc_PARM_2 + 1),a
;	_realloc.c:103: if ((((unsigned int)pthis->next) - ((unsigned int)pthis)) >= size)
	mov	dpl,_realloc_pthis_1_1
	mov	dph,(_realloc_pthis_1_1 + 1)
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	mov	ar3,r1
	mov	ar4,r2
	mov	r5,_realloc_pthis_1_1
	mov	r6,(_realloc_pthis_1_1 + 1)
	mov	a,r3
	clr	c
	subb	a,r5
	mov	r3,a
	mov	a,r4
	subb	a,r6
	mov	r4,a
	clr	c
	mov	a,r3
	subb	a,_realloc_PARM_2
	mov	a,r4
	subb	a,(_realloc_PARM_2 + 1)
	jc	00108$
;	_realloc.c:105: pthis->len = size;
	mov	dpl,_realloc_pthis_1_1
	mov	dph,(_realloc_pthis_1_1 + 1)
	inc	dptr
	inc	dptr
	mov	a,_realloc_PARM_2
	movx	@dptr,a
	inc	dptr
	mov	a,(_realloc_PARM_2 + 1)
	movx	@dptr,a
;	_realloc.c:106: ret = p;
	mov	r7,_realloc_p_1_1
	mov	r0,(_realloc_p_1_1 + 1)
	ljmp	00115$
00108$:
;	_realloc.c:110: if ((_sdcc_prev_memheader) &&
	mov	a,__sdcc_prev_memheader
	orl	a,(__sdcc_prev_memheader + 1)
	jnz	00127$
	ljmp	00104$
00127$:
;	_realloc.c:111: ((((unsigned int)pthis->next) -
;	_realloc.c:112: ((unsigned int)_sdcc_prev_memheader) -
	mov	r3,__sdcc_prev_memheader
	mov	r4,(__sdcc_prev_memheader + 1)
	mov	a,r1
	clr	c
	subb	a,r3
	mov	r1,a
	mov	a,r2
	subb	a,r4
	mov	r2,a
;	_realloc.c:113: _sdcc_prev_memheader->len) >= size))
	mov	dpl,__sdcc_prev_memheader
	mov	dph,(__sdcc_prev_memheader + 1)
	inc	dptr
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	mov	a,r1
	clr	c
	subb	a,r3
	mov	r1,a
	mov	a,r2
	subb	a,r4
	mov	r2,a
	clr	c
	mov	a,r1
	subb	a,_realloc_PARM_2
	mov	a,r2
	subb	a,(_realloc_PARM_2 + 1)
	jc	00104$
;	_realloc.c:115: pnew = (MEMHEADER __xdata * )((char __xdata *)_sdcc_prev_memheader + _sdcc_prev_memheader->len);
	mov	dpl,__sdcc_prev_memheader
	mov	dph,(__sdcc_prev_memheader + 1)
	inc	dptr
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	a,r2
	add	a,__sdcc_prev_memheader
	mov	r2,a
	mov	a,r3
	addc	a,(__sdcc_prev_memheader + 1)
	mov	r3,a
;	_realloc.c:116: _sdcc_prev_memheader->next = pnew;
	mov	dpl,__sdcc_prev_memheader
	mov	dph,(__sdcc_prev_memheader + 1)
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_realloc.c:122: memmove(pnew, pthis, pthis->len);
	mov	ar4,r2
	mov	ar5,r3
	mov	r6,#0x00
	mov	_memmove_PARM_2,_realloc_pthis_1_1
	mov	(_memmove_PARM_2 + 1),(_realloc_pthis_1_1 + 1)
	mov	(_memmove_PARM_2 + 2),#0x00
	mov	dpl,_realloc_pthis_1_1
	mov	dph,(_realloc_pthis_1_1 + 1)
	inc	dptr
	inc	dptr
	movx	a,@dptr
	mov	_memmove_PARM_3,a
	inc	dptr
	movx	a,@dptr
	mov	(_memmove_PARM_3 + 1),a
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	push	ar2
	push	ar3
	lcall	_memmove
	pop	ar3
	pop	ar2
;	_realloc.c:123: pnew->len = size;
	mov	dpl,r2
	mov	dph,r3
	inc	dptr
	inc	dptr
	mov	a,_realloc_PARM_2
	movx	@dptr,a
	inc	dptr
	mov	a,(_realloc_PARM_2 + 1)
	movx	@dptr,a
;	_realloc.c:124: ret = MEM(pnew);
	mov	a,#0x04
	add	a,r2
	mov	r7,a
	clr	a
	addc	a,r3
	mov	r0,a
	sjmp	00115$
00104$:
;	_realloc.c:128: ret = malloc(size - HEADER_SIZE);
	mov	a,_realloc_PARM_2
	add	a,#0xfc
	mov	dpl,a
	mov	a,(_realloc_PARM_2 + 1)
	addc	a,#0xff
	mov	dph,a
	lcall	_malloc
	mov	r7,dpl
	mov	r0,dph
;	_realloc.c:129: if (ret)
	mov	a,r7
	orl	a,r0
	jz	00115$
;	_realloc.c:131: memcpy(ret, MEM(pthis), pthis->len - HEADER_SIZE);
	mov	ar2,r7
	mov	ar3,r0
	mov	r4,#0x00
	mov	a,#0x04
	add	a,_realloc_pthis_1_1
	mov	r5,a
	clr	a
	addc	a,(_realloc_pthis_1_1 + 1)
	mov	r6,a
	mov	_memcpy_PARM_2,r5
	mov	(_memcpy_PARM_2 + 1),r6
	mov	(_memcpy_PARM_2 + 2),#0x00
	mov	dpl,_realloc_pthis_1_1
	mov	dph,(_realloc_pthis_1_1 + 1)
	inc	dptr
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	a,r5
	add	a,#0xfc
	mov	_memcpy_PARM_3,a
	mov	a,r6
	addc	a,#0xff
	mov	(_memcpy_PARM_3 + 1),a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	push	ar7
	push	ar0
	lcall	_memcpy
;	_realloc.c:132: free(p);
	mov	dpl,_realloc_p_1_1
	mov	dph,(_realloc_p_1_1 + 1)
	mov	b,(_realloc_p_1_1 + 2)
	lcall	_free
	pop	ar0
	pop	ar7
	sjmp	00115$
00114$:
;	_realloc.c:140: ret = malloc(size);
	mov	dpl,_realloc_PARM_2
	mov	dph,(_realloc_PARM_2 + 1)
	lcall	_malloc
	mov	r7,dpl
	mov	r0,dph
00115$:
;	_realloc.c:143: return ret;
	mov	dpl,r7
	mov	dph,r0
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
