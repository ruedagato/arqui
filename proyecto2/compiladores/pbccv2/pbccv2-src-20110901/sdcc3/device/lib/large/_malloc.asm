;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:29 2015
;--------------------------------------------------------
	.module _malloc
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __sdcc_first_memheader
	.globl _malloc
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
_malloc_sloc0_1_0:
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
_init_dynamic_memory_heap_1_1:
	.ds 2
_init_dynamic_memory_size_1_1:
	.ds 2
_malloc_size_1_1:
	.ds 2
_malloc_current_header_1_1:
	.ds 2
_malloc_ret_1_1:
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
__sdcc_first_memheader::
	.ds 2
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
;Allocation info for local variables in function 'init_dynamic_memory'
;------------------------------------------------------------
;heap                      Allocated with name '_init_dynamic_memory_heap_1_1'
;size                      Allocated with name '_init_dynamic_memory_size_1_1'
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
	mov	dptr,#_init_dynamic_memory_heap_1_1
	mov	a,#__sdcc_heap
	movx	@dptr,a
	inc	dptr
	mov	a,#(__sdcc_heap >> 8)
	movx	@dptr,a
;	_malloc.c:169: unsigned int size = _sdcc_heap_size;
	mov	dptr,#__sdcc_heap_size
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	mov	a,#0x01
	movc	a,@a+dptr
	mov	r3,a
	mov	dptr,#_init_dynamic_memory_size_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_malloc.c:171: if ( !heap ) //Reserved memory starts at 0x0000 but that's NULL...
	mov	a,#__sdcc_heap
	orl	a,#(__sdcc_heap >> 8)
	jnz	00102$
;	_malloc.c:173: heap++;
	mov	dptr,#_init_dynamic_memory_heap_1_1
	mov	a,#0x01
	add	a,#__sdcc_heap
	movx	@dptr,a
	clr	a
	addc	a,#(__sdcc_heap >> 8)
	inc	dptr
	movx	@dptr,a
;	_malloc.c:174: size--;
	dec	r2
	cjne	r2,#0xff,00107$
	dec	r3
00107$:
	mov	dptr,#_init_dynamic_memory_size_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
00102$:
;	_malloc.c:176: _sdcc_first_memheader = (MEMHEADER __xdata * ) heap;
	mov	dptr,#_init_dynamic_memory_heap_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#__sdcc_first_memheader
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_malloc.c:178: _sdcc_first_memheader->next = (MEMHEADER __xdata * )(heap + size - sizeof(MEMHEADER __xdata *));
	mov	dptr,#_init_dynamic_memory_size_1_1
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	a,r4
	add	a,r2
	mov	r4,a
	mov	a,r5
	addc	a,r3
	mov	r5,a
	mov	a,r4
	add	a,#0xfe
	mov	r4,a
	mov	a,r5
	addc	a,#0xff
	mov	r5,a
	mov	dpl,r2
	mov	dph,r3
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_malloc.c:179: _sdcc_first_memheader->next->next = (MEMHEADER __xdata * ) NULL; //And mark it as last
	mov	dpl,r4
	mov	dph,r5
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	_malloc.c:180: _sdcc_first_memheader->len        = 0;    //Empty and ready.
	mov	dpl,r2
	mov	dph,r3
	inc	dptr
	inc	dptr
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'malloc'
;------------------------------------------------------------
;sloc0                     Allocated with name '_malloc_sloc0_1_0'
;size                      Allocated with name '_malloc_size_1_1'
;current_header            Allocated with name '_malloc_current_header_1_1'
;new_header                Allocated with name '_malloc_new_header_1_1'
;ret                       Allocated with name '_malloc_ret_1_1'
;------------------------------------------------------------
;	_malloc.c:183: void __xdata * malloc (unsigned int size)
;	-----------------------------------------
;	 function malloc
;	-----------------------------------------
_malloc:
;	_malloc.c:189: if (size>(0xFFFF-HEADER_SIZE))
	mov	r2,dph
	mov	a,dpl
	mov	dptr,#_malloc_size_1_1
	movx	@dptr,a
	inc	dptr
	xch	a,r2
	movx	@dptr,a
	mov	r3,a
	clr	c
	mov	a,#0xFB
	subb	a,r2
	mov	a,#0xFF
	subb	a,r3
	jnc	00102$
;	_malloc.c:190: return (void __xdata *) NULL; //To prevent overflow in next line
	mov	dptr,#0x0000
	ret
00102$:
;	_malloc.c:191: size += HEADER_SIZE; //We need a memory for header too
	mov	dptr,#_malloc_size_1_1
	mov	a,#0x04
	add	a,r2
	movx	@dptr,a
	clr	a
	addc	a,r3
	inc	dptr
	movx	@dptr,a
;	_malloc.c:193: if (!_sdcc_first_memheader)
	mov	dptr,#__sdcc_first_memheader
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	orl	a,r2
	jnz	00104$
;	_malloc.c:194: init_dynamic_memory();
	lcall	_init_dynamic_memory
00104$:
;	_malloc.c:196: current_header = _sdcc_first_memheader;
	mov	dptr,#__sdcc_first_memheader
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_malloc_current_header_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_malloc.c:199: while (1)
	mov	dptr,#_malloc_size_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
00110$:
;	_malloc.c:209: if ((((unsigned int)current_header->next) -
	mov	dptr,#_malloc_current_header_1_1
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r4
	mov	dph,r5
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	_malloc_sloc0_1_0,r6
	mov	(_malloc_sloc0_1_0 + 1),r7
;	_malloc.c:210: ((unsigned int)current_header) -
	mov	ar0,r4
	mov	ar1,r5
	mov	a,_malloc_sloc0_1_0
	clr	c
	subb	a,r0
	mov	_malloc_sloc0_1_0,a
	mov	a,(_malloc_sloc0_1_0 + 1)
	subb	a,r1
	mov	(_malloc_sloc0_1_0 + 1),a
;	_malloc.c:211: current_header->len) >= size)
	mov	dpl,r4
	mov	dph,r5
	inc	dptr
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	a,_malloc_sloc0_1_0
	clr	c
	subb	a,r0
	mov	r0,a
	mov	a,(_malloc_sloc0_1_0 + 1)
	subb	a,r1
	mov	r1,a
	clr	c
	mov	a,r0
	subb	a,r2
	mov	a,r1
	subb	a,r3
	jc	00106$
;	_malloc.c:213: ret = current_header->mem;
	mov	dptr,#_malloc_ret_1_1
	mov	a,#0x04
	add	a,r4
	movx	@dptr,a
	clr	a
	addc	a,r5
	inc	dptr
	movx	@dptr,a
;	_malloc.c:214: break;
	sjmp	00111$
00106$:
;	_malloc.c:216: current_header = current_header->next;    //else try next
	mov	dptr,#_malloc_current_header_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_malloc.c:217: if (!current_header->next)
	mov	dptr,#_malloc_current_header_1_1
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r4
	mov	dph,r5
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	orl	a,r4
	jnz	00110$
;	_malloc.c:219: ret = (void __xdata *) NULL;
	mov	dptr,#_malloc_ret_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	_malloc.c:220: break;
00111$:
;	_malloc.c:223: if (ret)
	mov	dptr,#_malloc_ret_1_1
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	orl	a,r4
	jz	00116$
;	_malloc.c:225: if (!current_header->len)
	mov	dptr,#_malloc_current_header_1_1
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	a,#0x02
	add	a,r4
	mov	r6,a
	clr	a
	addc	a,r5
	mov	r7,a
	mov	dpl,r6
	mov	dph,r7
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	orl	a,r0
	jnz	00113$
;	_malloc.c:227: current_header->len = size; //for first allocation
	mov	dpl,r6
	mov	dph,r7
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	sjmp	00116$
00113$:
;	_malloc.c:231: new_header = (MEMHEADER __xdata * )((char __xdata *)current_header + current_header->len);
	mov	a,r0
	add	a,r4
	mov	r0,a
	mov	a,r1
	addc	a,r5
	mov	r1,a
;	_malloc.c:232: new_header->next = current_header->next; //and plug it into the chain
	mov	dpl,r4
	mov	dph,r5
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r0
	mov	dph,r1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_malloc.c:233: current_header->next  = new_header;
	mov	dpl,r4
	mov	dph,r5
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	_malloc.c:234: new_header->len  = size; //mark as used
	mov	dpl,r0
	mov	dph,r1
	inc	dptr
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_malloc.c:235: ret = new_header->mem;
	mov	dptr,#_malloc_ret_1_1
	mov	a,#0x04
	add	a,r0
	movx	@dptr,a
	clr	a
	addc	a,r1
	inc	dptr
	movx	@dptr,a
00116$:
;	_malloc.c:239: return ret;
	mov	dptr,#_malloc_ret_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	dpl,r2
	mov	dph,a
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
__xinit___sdcc_first_memheader:
	.byte #0x00,#0x00
	.area CABS    (ABS,CODE)
