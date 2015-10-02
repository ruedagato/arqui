;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:29 2015
;--------------------------------------------------------
	.module _free
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __sdcc_find_memheader
	.globl __sdcc_prev_memheader
	.globl _free
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
__sdcc_prev_memheader::
	.ds 2
__sdcc_find_memheader_p_1_1:
	.ds 2
__sdcc_find_memheader_cur_header_1_1:
	.ds 2
_free_p_1_1:
	.ds 3
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
;Allocation info for local variables in function '_sdcc_find_memheader'
;------------------------------------------------------------
;p                         Allocated with name '__sdcc_find_memheader_p_1_1'
;pthis                     Allocated with name '__sdcc_find_memheader_pthis_1_1'
;cur_header                Allocated with name '__sdcc_find_memheader_cur_header_1_1'
;------------------------------------------------------------
;	_free.c:129: MEMHEADER __xdata * _sdcc_find_memheader(void __xdata * p)
;	-----------------------------------------
;	 function _sdcc_find_memheader
;	-----------------------------------------
__sdcc_find_memheader:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_free.c:134: if (!p)
	mov	r2,dph
	mov	a,dpl
	mov	dptr,#__sdcc_find_memheader_p_1_1
	movx	@dptr,a
	inc	dptr
	xch	a,r2
	movx	@dptr,a
	mov	r3,a
	orl	a,r2
	jnz	00102$
;	_free.c:135: return NULL;
	mov	dptr,#0x0000
	ret
00102$:
;	_free.c:137: pthis -= 1; //to start of header
	mov	a,r2
	add	a,#0xfc
	mov	r2,a
	mov	a,r3
	addc	a,#0xff
	mov	r3,a
;	_free.c:138: cur_header = _sdcc_first_memheader;
	mov	dptr,#__sdcc_first_memheader
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dptr,#__sdcc_find_memheader_cur_header_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_free.c:139: _sdcc_prev_memheader = NULL;
	mov	dptr,#__sdcc_prev_memheader
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	_free.c:140: while (cur_header && pthis != cur_header)
00104$:
	mov	dptr,#__sdcc_find_memheader_cur_header_1_1
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	orl	a,r4
	jz	00106$
	mov	a,r2
	cjne	a,ar4,00115$
	mov	a,r3
	cjne	a,ar5,00115$
	sjmp	00106$
00115$:
;	_free.c:142: _sdcc_prev_memheader = cur_header;
	mov	dptr,#__sdcc_prev_memheader
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_free.c:143: cur_header = cur_header->next;
	mov	dpl,r4
	mov	dph,r5
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dptr,#__sdcc_find_memheader_cur_header_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	sjmp	00104$
00106$:
;	_free.c:145: return (cur_header);
	mov	dptr,#__sdcc_find_memheader_cur_header_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	dpl,r2
	mov	dph,a
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'free'
;------------------------------------------------------------
;p                         Allocated with name '_free_p_1_1'
;pthis                     Allocated with name '_free_pthis_1_1'
;------------------------------------------------------------
;	_free.c:148: void free (void * p)
;	-----------------------------------------
;	 function free
;	-----------------------------------------
_free:
	mov	r2,b
	mov	r3,dph
	mov	a,dpl
	mov	dptr,#_free_p_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
;	_free.c:154: pthis = _sdcc_find_memheader(p);
	mov	dptr,#_free_p_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	dpl,r2
	mov	dph,r3
	lcall	__sdcc_find_memheader
	mov	r2,dpl
	mov	r3,dph
;	_free.c:155: if (pthis) //For allocated pointers only!
	mov	a,r2
	orl	a,r3
	jz	00106$
;	_free.c:157: if (!_sdcc_prev_memheader)
	mov	dptr,#__sdcc_prev_memheader
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	orl	a,r4
	jnz	00102$
;	_free.c:159: pthis->len = 0;
	mov	dpl,r2
	mov	dph,r3
	inc	dptr
	inc	dptr
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	ret
00102$:
;	_free.c:163: _sdcc_prev_memheader->next = pthis->next;
	mov	dpl,r2
	mov	dph,r3
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r4
	mov	dph,r5
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
00106$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
