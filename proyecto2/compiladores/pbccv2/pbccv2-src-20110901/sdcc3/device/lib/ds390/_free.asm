;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _free
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
	.globl __sdcc_find_memheader
	.globl __sdcc_prev_memheader
	.globl _free
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
__sdcc_prev_memheader::
	.ds 3
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
;Allocation info for local variables in function '_sdcc_find_memheader'
;------------------------------------------------------------
;p                         Allocated to registers r2 r3 r4 
;pthis                     Allocated to registers r2 r3 r4 
;cur_header                Allocated to registers r5 r6 r7 
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
	mov	dpl1,dpl
	mov	dph1,dph
	mov	dpx1,dpx
;	_free.c:134: if (!p)
	mov	a,dpl1
	orl	a,dph1
	orl	a,dpx1
	jnz  00102$
00113$:
;	_free.c:135: return NULL;
	mov  dptr,#0x0000
	ljmp	00107$
00102$:
;	_free.c:137: pthis -= 1; //to start of header
	mov	a,dpl1
	add	a,#0xFB
	mov	r2,a
	mov	a,dph1
	addc	a,#0xFF
	mov	r3,a
	mov	a,dpx1
	addc	a,#0xFF
	mov	r4,a
;	genAssign: resultIsFar = TRUE
;	_free.c:138: cur_header = _sdcc_first_memheader;
	mov	dptr,#__sdcc_first_memheader
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
;	genAssign: resultIsFar = TRUE
	mov	dpl1,r5
	mov	dph1,r6
	mov	dpx1,r7
;	_free.c:139: _sdcc_prev_memheader = NULL;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__sdcc_prev_memheader
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	_free.c:140: while (cur_header && pthis != cur_header)
00104$:
	mov	a,dpl1
	orl	a,dph1
	orl	a,dpx1
	jz  00106$
00114$:
	mov	b,r2
	mov	a,dpl1
	cjne	a,b,00115$
	mov	b,r3
	mov	a,dph1
	cjne	a,b,00115$
	mov	b,r4
	mov	a,dpx1
	cjne	a,b,00115$
	sjmp 00106$
00115$:
;	_free.c:142: _sdcc_prev_memheader = cur_header;
	push	ar2
	push	ar3
	push	ar4
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__sdcc_prev_memheader
	mov	a,dpl1
	movx	@dptr,a
	inc	dptr
	mov	a,dph1
	movx	@dptr,a
	inc	dptr
	mov	a,dpx1
	movx	@dptr,a
;	_free.c:143: cur_header = cur_header->next;
	inc	dps
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	inc	dptr
	mov	r1,a
	movx	a,@dptr
	mov	r2,a
	mov     dps, #1
	lcall	__decdptr
	lcall	__decdptr
	mov	dps,#0
;	genAssign: resultIsFar = TRUE
	mov	dpl1,r0
	mov	dph1,r1
	mov	dpx1,r2
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp 00104$
00106$:
;	_free.c:145: return (cur_header);
	mov	dpl,dpl1
	mov	dph,dph1
	mov	dpx,dpx1
00107$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'free'
;------------------------------------------------------------
;p                         Allocated to registers 
;pthis                     Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	_free.c:148: void free (void * p)
;	-----------------------------------------
;	 function free
;	-----------------------------------------
_free:
;	_free.c:154: pthis = _sdcc_find_memheader(p);
	mov     r2,dpl
	mov     r3,dph
	mov     r4,dpx
	mov     r5,b
	lcall	__sdcc_find_memheader
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
;	genAssign: resultIsFar = FALSE
	mov	dpl1,r2
	mov	dph1,r3
	mov	dpx1,r4
;	_free.c:155: if (pthis) //For allocated pointers only!
	mov	a,dpl1
	orl	a,dph1
	orl	a,dpx1
	jz  00106$
00110$:
;	_free.c:157: if (!_sdcc_prev_memheader)
	mov	dptr,#__sdcc_prev_memheader
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	a,r5
	orl	a,r6
	orl	a,r7
	jnz  00102$
00111$:
;	_free.c:159: pthis->len = 0;
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
	sjmp 00106$
00102$:
;	_free.c:163: _sdcc_prev_memheader->next = pthis->next;
	inc	dps
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	mov	r4,a
	mov	dps,#0
	mov	dpl,r5
	mov	dph,r6
	mov	dpx,r7
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
00106$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
