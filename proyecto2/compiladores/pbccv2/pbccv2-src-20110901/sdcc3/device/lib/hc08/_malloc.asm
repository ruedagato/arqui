;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _malloc
	.optsdcc -mhc08
	
	.area HOME (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area CSEG (CODE)
	.area XINIT
	.area CONST   (CODE)
	.area DSEG
	.area OSEG    (OVR)
	.area BSEG
	.area XSEG
	.area XISEG
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __sdcc_first_memheader
	.globl _malloc
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_malloc_sloc0_1_0:
	.ds 2
_malloc_sloc1_1_0:
	.ds 2
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_init_dynamic_memory_sloc0_1_0::
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG
__sdcc_first_memheader::
	.ds 2
;--------------------------------------------------------
; extended address mode data
;--------------------------------------------------------
	.area XSEG
_init_dynamic_memory_heap_1_1:
	.ds 2
_init_dynamic_memory_size_1_1:
	.ds 2
_malloc_size_1_1:
	.ds 2
_malloc_current_header_1_1:
	.ds 2
_malloc_new_header_1_1:
	.ds 2
_malloc_ret_1_1:
	.ds 2
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area GSINIT (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME (CODE)
	.area HOME (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'init_dynamic_memory'
;------------------------------------------------------------
;heap                      Allocated with name '_init_dynamic_memory_heap_1_1'
;size                      Allocated with name '_init_dynamic_memory_size_1_1'
;sloc0                     Allocated with name '_init_dynamic_memory_sloc0_1_0'
;------------------------------------------------------------
;../_malloc.c:166: static void init_dynamic_memory(void)
;	-----------------------------------------
;	 function init_dynamic_memory
;	-----------------------------------------
_init_dynamic_memory:
;../_malloc.c:168: char __xdata * heap = (char __xdata *)_sdcc_heap;
	lda	#__sdcc_heap
	sta	(_init_dynamic_memory_heap_1_1 + 1)
	lda	#>__sdcc_heap
	sta	_init_dynamic_memory_heap_1_1
;../_malloc.c:169: unsigned int size = _sdcc_heap_size;
	lda	__sdcc_heap_size
	sta	_init_dynamic_memory_size_1_1
	lda	(__sdcc_heap_size + 1)
	sta	(_init_dynamic_memory_size_1_1 + 1)
;../_malloc.c:171: if ( !heap ) //Reserved memory starts at 0x0000 but that's NULL...
	lda	(_init_dynamic_memory_heap_1_1 + 1)
	ora	_init_dynamic_memory_heap_1_1
	bne	00102$
00106$:
;../_malloc.c:173: heap++;
	lda	(_init_dynamic_memory_heap_1_1 + 1)
	inca
	sta	(_init_dynamic_memory_heap_1_1 + 1)
	bne	00107$
	lda	_init_dynamic_memory_heap_1_1
	inca
	sta	_init_dynamic_memory_heap_1_1
00107$:
;../_malloc.c:174: size--;
	lda	(_init_dynamic_memory_size_1_1 + 1)
	sub	#0x01
	sta	(_init_dynamic_memory_size_1_1 + 1)
	lda	_init_dynamic_memory_size_1_1
	sbc	#0x00
	sta	_init_dynamic_memory_size_1_1
00102$:
;../_malloc.c:176: _sdcc_first_memheader = (MEMHEADER __xdata * ) heap;
	lda	_init_dynamic_memory_heap_1_1
	sta	__sdcc_first_memheader
	lda	(_init_dynamic_memory_heap_1_1 + 1)
	sta	(__sdcc_first_memheader + 1)
;../_malloc.c:178: _sdcc_first_memheader->next = (MEMHEADER __xdata * )(heap + size - sizeof(MEMHEADER __xdata *));
	lda	(_init_dynamic_memory_heap_1_1 + 1)
	add	(_init_dynamic_memory_size_1_1 + 1)
	sta	*(_init_dynamic_memory_sloc0_1_0 + 1)
	lda	_init_dynamic_memory_heap_1_1
	adc	_init_dynamic_memory_size_1_1
	sta	*_init_dynamic_memory_sloc0_1_0
	lda	*(_init_dynamic_memory_sloc0_1_0 + 1)
	sub	#0x02
	sta	*(_init_dynamic_memory_sloc0_1_0 + 1)
	lda	*_init_dynamic_memory_sloc0_1_0
	sbc	#0x00
	sta	*_init_dynamic_memory_sloc0_1_0
	lda	_init_dynamic_memory_heap_1_1
	ldx	(_init_dynamic_memory_heap_1_1 + 1)
	psha
	pulh
	lda	*_init_dynamic_memory_sloc0_1_0
	sta	,x
	aix	#1
	lda	*(_init_dynamic_memory_sloc0_1_0 + 1)
	sta	,x
;../_malloc.c:179: _sdcc_first_memheader->next->next = (MEMHEADER __xdata * ) NULL; //And mark it as last
	ldhx	*_init_dynamic_memory_sloc0_1_0
	clra
	sta	,x
	aix	#1
	clra
	sta	,x
;../_malloc.c:180: _sdcc_first_memheader->len        = 0;    //Empty and ready.
	lda	(_init_dynamic_memory_heap_1_1 + 1)
	add	#0x02
	sta	*(_init_dynamic_memory_sloc0_1_0 + 1)
	lda	_init_dynamic_memory_heap_1_1
	adc	#0x00
	sta	*_init_dynamic_memory_sloc0_1_0
	ldhx	*_init_dynamic_memory_sloc0_1_0
	clra
	sta	,x
	aix	#1
	clra
	sta	,x
00103$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'malloc'
;------------------------------------------------------------
;sloc0                     Allocated with name '_malloc_sloc0_1_0'
;sloc1                     Allocated with name '_malloc_sloc1_1_0'
;size                      Allocated with name '_malloc_size_1_1'
;current_header            Allocated with name '_malloc_current_header_1_1'
;new_header                Allocated with name '_malloc_new_header_1_1'
;ret                       Allocated with name '_malloc_ret_1_1'
;------------------------------------------------------------
;../_malloc.c:183: void __xdata * malloc (unsigned int size)
;	-----------------------------------------
;	 function malloc
;	-----------------------------------------
_malloc:
	sta	(_malloc_size_1_1 + 1)
	stx	_malloc_size_1_1
;../_malloc.c:189: if (size>(0xFFFF-HEADER_SIZE))
	lda	#0xFB
	sub	(_malloc_size_1_1 + 1)
	lda	#0xFF
	sbc	_malloc_size_1_1
	bcc	00102$
00126$:
;../_malloc.c:190: return (void __xdata *) NULL; //To prevent overflow in next line
	clrx
	clra
	rts
00102$:
;../_malloc.c:191: size += HEADER_SIZE; //We need a memory for header too
	lda	(_malloc_size_1_1 + 1)
	add	#0x04
	sta	(_malloc_size_1_1 + 1)
	bcc	00127$
	lda	_malloc_size_1_1
	inca
	sta	_malloc_size_1_1
00127$:
;../_malloc.c:193: if (!_sdcc_first_memheader)
	lda	(__sdcc_first_memheader + 1)
	ora	__sdcc_first_memheader
	bne	00104$
00128$:
;../_malloc.c:194: init_dynamic_memory();
	jsr	_init_dynamic_memory
00104$:
;../_malloc.c:196: current_header = _sdcc_first_memheader;
	lda	__sdcc_first_memheader
	sta	_malloc_current_header_1_1
	lda	(__sdcc_first_memheader + 1)
	sta	(_malloc_current_header_1_1 + 1)
;../_malloc.c:199: while (1)
00110$:
;../_malloc.c:209: if ((((unsigned int)current_header->next) -
	lda	_malloc_current_header_1_1
	ldx	(_malloc_current_header_1_1 + 1)
	psha
	pulh
	lda	,x
	aix	#1
	sta	*_malloc_sloc0_1_0
	lda	,x
	sta	*(_malloc_sloc0_1_0 + 1)
;../_malloc.c:210: ((unsigned int)current_header) -
	lda	(_malloc_current_header_1_1 + 1)
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	_malloc_current_header_1_1
	sta	*_malloc_sloc1_1_0
	lda	*(_malloc_sloc0_1_0 + 1)
	sub	*(_malloc_sloc1_1_0 + 1)
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	*_malloc_sloc0_1_0
	sbc	*_malloc_sloc1_1_0
	sta	*_malloc_sloc1_1_0
;../_malloc.c:211: current_header->len) >= size)
	lda	(_malloc_current_header_1_1 + 1)
	add	#0x02
	sta	*(_malloc_sloc0_1_0 + 1)
	lda	_malloc_current_header_1_1
	adc	#0x00
	sta	*_malloc_sloc0_1_0
	ldhx	*_malloc_sloc0_1_0
	lda	,x
	aix	#1
	sta	*_malloc_sloc0_1_0
	lda	,x
	sta	*(_malloc_sloc0_1_0 + 1)
	lda	*(_malloc_sloc1_1_0 + 1)
	sub	*(_malloc_sloc0_1_0 + 1)
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	*_malloc_sloc1_1_0
	sbc	*_malloc_sloc0_1_0
	sta	*_malloc_sloc1_1_0
	lda	*(_malloc_sloc1_1_0 + 1)
	sub	(_malloc_size_1_1 + 1)
	lda	*_malloc_sloc1_1_0
	sbc	_malloc_size_1_1
	bcs	00106$
00129$:
;../_malloc.c:213: ret = current_header->mem;
	lda	(_malloc_current_header_1_1 + 1)
	add	#0x04
	sta	(_malloc_ret_1_1 + 1)
	lda	_malloc_current_header_1_1
	adc	#0x00
	sta	_malloc_ret_1_1
;../_malloc.c:214: break;
	bra	00111$
00106$:
;../_malloc.c:216: current_header = current_header->next;    //else try next
	lda	_malloc_current_header_1_1
	ldx	(_malloc_current_header_1_1 + 1)
	psha
	pulh
	lda	,x
	aix	#1
	sta	_malloc_current_header_1_1
	lda	,x
	sta	(_malloc_current_header_1_1 + 1)
;../_malloc.c:217: if (!current_header->next)
	lda	_malloc_current_header_1_1
	ldx	(_malloc_current_header_1_1 + 1)
	psha
	pulh
	lda	,x
	aix	#1
	sta	*_malloc_sloc1_1_0
	lda	,x
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	*(_malloc_sloc1_1_0 + 1)
	ora	*_malloc_sloc1_1_0
	beq	00130$
	jmp	00110$
00130$:
;../_malloc.c:219: ret = (void __xdata *) NULL;
	clra
	sta	_malloc_ret_1_1
	sta	(_malloc_ret_1_1 + 1)
;../_malloc.c:220: break;
00111$:
;../_malloc.c:223: if (ret)
	lda	(_malloc_ret_1_1 + 1)
	ora	_malloc_ret_1_1
	bne	00131$
	jmp	00116$
00131$:
;../_malloc.c:225: if (!current_header->len)
	lda	(_malloc_current_header_1_1 + 1)
	add	#0x02
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	_malloc_current_header_1_1
	adc	#0x00
	sta	*_malloc_sloc1_1_0
	ldhx	*_malloc_sloc1_1_0
	lda	,x
	aix	#1
	sta	*_malloc_sloc1_1_0
	lda	,x
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	*(_malloc_sloc1_1_0 + 1)
	ora	*_malloc_sloc1_1_0
	bne	00113$
00132$:
;../_malloc.c:227: current_header->len = size; //for first allocation
	lda	(_malloc_current_header_1_1 + 1)
	add	#0x02
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	_malloc_current_header_1_1
	adc	#0x00
	sta	*_malloc_sloc1_1_0
	ldhx	*_malloc_sloc1_1_0
	lda	_malloc_size_1_1
	sta	,x
	aix	#1
	lda	(_malloc_size_1_1 + 1)
	sta	,x
	jmp	00116$
00113$:
;../_malloc.c:231: new_header = (MEMHEADER __xdata * )((char __xdata *)current_header + current_header->len);
	lda	(_malloc_current_header_1_1 + 1)
	add	#0x02
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	_malloc_current_header_1_1
	adc	#0x00
	sta	*_malloc_sloc1_1_0
	ldhx	*_malloc_sloc1_1_0
	lda	,x
	aix	#1
	sta	*_malloc_sloc1_1_0
	lda	,x
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	(_malloc_current_header_1_1 + 1)
	add	*(_malloc_sloc1_1_0 + 1)
	sta	(_malloc_new_header_1_1 + 1)
	lda	_malloc_current_header_1_1
	adc	*_malloc_sloc1_1_0
	sta	_malloc_new_header_1_1
;../_malloc.c:232: new_header->next = current_header->next; //and plug it into the chain
	lda	_malloc_current_header_1_1
	ldx	(_malloc_current_header_1_1 + 1)
	psha
	pulh
	lda	,x
	aix	#1
	sta	*_malloc_sloc1_1_0
	lda	,x
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	_malloc_new_header_1_1
	ldx	(_malloc_new_header_1_1 + 1)
	psha
	pulh
	lda	*_malloc_sloc1_1_0
	sta	,x
	aix	#1
	lda	*(_malloc_sloc1_1_0 + 1)
	sta	,x
;../_malloc.c:233: current_header->next  = new_header;
	lda	_malloc_current_header_1_1
	ldx	(_malloc_current_header_1_1 + 1)
	psha
	pulh
	lda	_malloc_new_header_1_1
	sta	,x
	aix	#1
	lda	(_malloc_new_header_1_1 + 1)
	sta	,x
;../_malloc.c:234: new_header->len  = size; //mark as used
	lda	(_malloc_new_header_1_1 + 1)
	add	#0x02
	sta	*(_malloc_sloc1_1_0 + 1)
	lda	_malloc_new_header_1_1
	adc	#0x00
	sta	*_malloc_sloc1_1_0
	ldhx	*_malloc_sloc1_1_0
	lda	_malloc_size_1_1
	sta	,x
	aix	#1
	lda	(_malloc_size_1_1 + 1)
	sta	,x
;../_malloc.c:235: ret = new_header->mem;
	lda	(_malloc_new_header_1_1 + 1)
	add	#0x04
	sta	(_malloc_ret_1_1 + 1)
	lda	_malloc_new_header_1_1
	adc	#0x00
	sta	_malloc_ret_1_1
00116$:
;../_malloc.c:239: return ret;
	ldx	_malloc_ret_1_1
	lda	(_malloc_ret_1_1 + 1)
00117$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
__xinit___sdcc_first_memheader:
	.dw #0x0000
	.area CABS    (ABS,CODE)
