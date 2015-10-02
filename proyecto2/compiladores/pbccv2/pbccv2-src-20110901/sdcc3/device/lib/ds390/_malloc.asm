;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _malloc
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
	.globl __sdcc_first_memheader
	.globl _malloc
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
_malloc_size_1_1:
	.ds 2
_malloc_current_header_1_1:
	.ds 3
_malloc_new_header_1_1:
	.ds 3
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
__sdcc_first_memheader::
	.ds 3
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
;Allocation info for local variables in function 'init_dynamic_memory'
;------------------------------------------------------------
;heap                      Allocated to registers r2 r3 r4 
;size                      Allocated to registers r5 r6 
;------------------------------------------------------------
;	_malloc.c:166: static void init_dynamic_memory(void)
;	-----------------------------------------
;	 function init_dynamic_memory
;	-----------------------------------------
_init_dynamic_memory:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_malloc.c:168: char __xdata * heap = (char __xdata *)_sdcc_heap;
;	genAssign: resultIsFar = TRUE
	inc	dps
	mov	dptr,#__sdcc_heap
	dec	dps
;	_malloc.c:169: unsigned int size = _sdcc_heap_size;
	mov	dptr,#__sdcc_heap_size
;	genAssign: resultIsFar = TRUE
	clr	a
	movc	a,@a+dptr
	mov	r5,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r6,a
;	_malloc.c:171: if ( !heap ) //Reserved memory starts at 0x0000 but that's NULL...
	mov	a,dpl1
	orl	a,dph1
	orl	a,dpx1
	jnz  00102$
00106$:
;	_malloc.c:173: heap++;
	mov	dps,#0x01
	inc	dptr
	mov	dps,#0
;	_malloc.c:174: size--;
	mov	a,r5
	add	a,#0xFF
	mov	r7,a
	mov	a,r6
	addc	a,#0xFF
	mov	r0,a
;	genAssign: resultIsFar = TRUE
	mov	ar5,r7
	mov	ar6,r0
00102$:
;	_malloc.c:176: _sdcc_first_memheader = (MEMHEADER __xdata * ) heap;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__sdcc_first_memheader
	mov	a,dpl1
	movx	@dptr,a
	inc	dptr
	mov	a,dph1
	movx	@dptr,a
	inc	dptr
	mov	a,dpx1
	movx	@dptr,a
;	_malloc.c:178: _sdcc_first_memheader->next = (MEMHEADER __xdata * )(heap + size - sizeof(MEMHEADER __xdata *));
	mov	a,r5
	add	a,dpl1
	mov	r5,a
	mov	a,r6
	addc	a,dph1
	mov	r6,a
	clr	a
	addc	a,dpx1
	mov	r7,a
	mov	a,r5
	add	a,#0xFD
	mov	r5,a
	mov	a,r6
	addc	a,#0xFF
	mov	r6,a
	mov	a,r7
	addc	a,#0xFF
	mov	r7,a
	mov	a,r5
	inc	dps
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	mov     dps, #1
	lcall	__decdptr
	lcall	__decdptr
	mov	dps,#0
;	_malloc.c:179: _sdcc_first_memheader->next->next = (MEMHEADER __xdata * ) NULL; //And mark it as last
	mov	dpl,r5
	mov	dph,r6
	mov	dpx,r7
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
;	_malloc.c:180: _sdcc_first_memheader->len        = 0;    //Empty and ready.
	mov	dpx,dpx1
	mov	dph,dph1
	mov	dpl,dpl1
	inc	dptr
	inc	dptr
	inc	dptr
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
00103$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'malloc'
;------------------------------------------------------------
;size                      Allocated with name '_malloc_size_1_1'
;current_header            Allocated with name '_malloc_current_header_1_1'
;new_header                Allocated with name '_malloc_new_header_1_1'
;ret                       Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	_malloc.c:183: void __xdata * malloc (unsigned int size)
;	-----------------------------------------
;	 function malloc
;	-----------------------------------------
_malloc:
	mov     dps, #1
	mov     dptr, #_malloc_size_1_1
	mov	a,dpl
	movx	@dptr,a
	inc	dptr
	mov	a,dph
	movx	@dptr,a
	mov	dps,#0
;	_malloc.c:189: if (size>(0xFFFF-HEADER_SIZE))
	mov	dptr,#_malloc_size_1_1
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
	jnc  00102$
00126$:
;	_malloc.c:190: return (void __xdata *) NULL; //To prevent overflow in next line
	mov  dptr,#0x0000
	ljmp	00117$
00102$:
;	_malloc.c:191: size += HEADER_SIZE; //We need a memory for header too
	mov	dptr,#_malloc_size_1_1
	movx	a,@dptr
	add	a,#0x05
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
;	_malloc.c:193: if (!_sdcc_first_memheader)
	mov	dptr,#__sdcc_first_memheader
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	a,r4
	orl	a,r5
	orl	a,r6
	jnz  00104$
00127$:
;	_malloc.c:194: init_dynamic_memory();
	lcall	_init_dynamic_memory
00104$:
;	_malloc.c:196: current_header = _sdcc_first_memheader;
	mov	dptr,#__sdcc_first_memheader
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_malloc_current_header_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_malloc.c:199: while (1)
00110$:
;	_malloc.c:209: if ((((unsigned int)current_header->next) -
	mov	dptr,#_malloc_current_header_1_1
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
	mov	r7,a
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	mov	r1,a
	mov	ar2,r7
	mov	ar3,r0
;	_malloc.c:210: ((unsigned int)current_header) -
	mov	dptr,#_malloc_current_header_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	clr	c
	mov	a,r2
	subb	a,r4
	mov	r2,a
	mov	a,r3
	subb	a,r5
	mov	r3,a
;	_malloc.c:211: current_header->len) >= size)
	mov	dptr,#_malloc_current_header_1_1
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
	mov	r4,a
	movx	a,@dptr
	mov	r5,a
	mov     dps, #1
	lcall	__decdptr
	mov	dps,#0
	clr	c
	mov	a,r2
	subb	a,r4
	mov	r2,a
	mov	a,r3
	subb	a,r5
	mov	r3,a
	mov	dptr,#_malloc_size_1_1
	clr	c
	mov	a,r2
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	a,r3
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jc   00106$
00128$:
;	_malloc.c:213: ret = current_header->mem;
	mov	dptr,#_malloc_current_header_1_1
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
;	_malloc.c:214: break;
	sjmp 00111$
00106$:
;	_malloc.c:216: current_header = current_header->next;    //else try next
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_malloc_current_header_1_1
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	_malloc.c:217: if (!current_header->next)
	mov	dptr,#_malloc_current_header_1_1
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
	mov	r5,a
	movx	a,@dptr
	inc	dptr
	mov	r6,a
	movx	a,@dptr
	mov	r7,a
	mov	a,r5
	orl	a,r6
	orl	a,r7
	jz	00129$
	ljmp	00110$
00129$:
;	_malloc.c:219: ret = (void __xdata *) NULL;
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
;	_malloc.c:220: break;
00111$:
;	_malloc.c:223: if (ret)
	mov	a,r2
	orl	a,r3
	orl	a,r4
	jnz	00130$
	ljmp	00116$
00130$:
;	_malloc.c:225: if (!current_header->len)
	mov	dptr,#_malloc_current_header_1_1
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
	mov	r0,a
	movx	a,@dptr
	mov	r1,a
	mov     dps, #1
	lcall	__decdptr
	mov	dps,#0
	mov	a,r0
	orl	a,r1
	jnz  00113$
00131$:
;	_malloc.c:227: current_header->len = size; //for first allocation
	mov	dptr,#_malloc_size_1_1
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
	ljmp	00116$
00113$:
;	_malloc.c:231: new_header = (MEMHEADER __xdata * )((char __xdata *)current_header + current_header->len);
	mov	dptr,#_malloc_current_header_1_1
	mov	dps, #1
	mov	dptr, #_malloc_new_header_1_1
	dec	dps
	movx	a,@dptr
	add	a,r0
	inc	dps
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	addc	a,r1
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	addc	a,#0
	inc	dps
	inc	dptr
	movx	@dptr,a
	mov	dps,#0
;	_malloc.c:232: new_header->next = current_header->next; //and plug it into the chain
	mov	dptr,#_malloc_current_header_1_1
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
	mov	r6,a
	movx	a,@dptr
	inc	dptr
	mov	r7,a
	movx	a,@dptr
	mov	r5,a
	mov	dptr,#_malloc_new_header_1_1
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
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_malloc.c:233: current_header->next  = new_header;
	mov	dptr,#_malloc_current_header_1_1
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
	mov     dps, #1
	mov     dptr, #_malloc_new_header_1_1
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
	inc	dptr
	inc	dps
	inc	dptr
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
	inc	dptr
	inc	dps
	inc	dptr
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
;	_malloc.c:234: new_header->len  = size; //mark as used
	mov	dptr,#_malloc_new_header_1_1
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
	mov	dptr,#_malloc_size_1_1
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
;	_malloc.c:235: ret = new_header->mem;
	mov	dptr,#_malloc_new_header_1_1
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
00116$:
;	_malloc.c:239: return ret;
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
00117$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
__xinit___sdcc_first_memheader:
; generic printIvalPtr
	.byte #0x00,#0x00,#0x00
	.area CABS    (ABS,CODE)
