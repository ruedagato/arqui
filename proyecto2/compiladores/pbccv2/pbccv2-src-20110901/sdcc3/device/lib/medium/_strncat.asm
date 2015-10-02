;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:26 2015
;--------------------------------------------------------
	.module _strncat
	.optsdcc -mmcs51 --model-medium
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncat_PARM_3
	.globl _strncat_PARM_2
	.globl _strncat
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
	.area	OSEG    (OVR,DATA)
_strncat_sloc0_1_0::
	.ds 3
_strncat_sloc1_1_0::
	.ds 2
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
_strncat_PARM_2:
	.ds 3
_strncat_PARM_3:
	.ds 2
_strncat_front_1_1:
	.ds 3
_strncat_start_1_1:
	.ds 3
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
;Allocation info for local variables in function 'strncat'
;------------------------------------------------------------
;sloc0                     Allocated with name '_strncat_sloc0_1_0'
;sloc1                     Allocated with name '_strncat_sloc1_1_0'
;------------------------------------------------------------
;	_strncat.c:31: char * strncat (
;	-----------------------------------------
;	 function strncat
;	-----------------------------------------
_strncat:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,b
	mov	r3,dph
	mov	a,dpl
	mov	r0,#_strncat_front_1_1
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r2
	movx	@r0,a
;	_strncat.c:37: char *start = front;
	mov	r0,#_strncat_front_1_1
	mov	r1,#_strncat_start_1_1
	movx	a,@r0
	movx	@r1,a
	inc	r0
	movx	a,@r0
	inc	r1
	movx	@r1,a
	inc	r0
	movx	a,@r0
	inc	r1
	movx	@r1,a
;	_strncat.c:39: while (*front++);
	mov	r0,#_strncat_front_1_1
	movx	a,@r0
	mov	_strncat_sloc0_1_0,a
	inc	r0
	movx	a,@r0
	mov	(_strncat_sloc0_1_0 + 1),a
	inc	r0
	movx	a,@r0
	mov	(_strncat_sloc0_1_0 + 2),a
00101$:
	mov	dpl,_strncat_sloc0_1_0
	mov	dph,(_strncat_sloc0_1_0 + 1)
	mov	b,(_strncat_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	mov	_strncat_sloc0_1_0,dpl
	mov	(_strncat_sloc0_1_0 + 1),dph
	mov	a,r5
	jnz	00101$
;	_strncat.c:41: front--;
	mov	r0,#_strncat_front_1_1
	mov	a,_strncat_sloc0_1_0
	add	a,#0xff
	movx	@r0,a
	mov	a,(_strncat_sloc0_1_0 + 1)
	addc	a,#0xff
	inc	r0
	movx	@r0,a
	inc	r0
	mov	a,(_strncat_sloc0_1_0 + 2)
	movx	@r0,a
;	_strncat.c:43: while (count--)
	mov	r0,#_strncat_PARM_2
	movx	a,@r0
	mov	r5,a
	inc	r0
	movx	a,@r0
	mov	r6,a
	inc	r0
	movx	a,@r0
	mov	r7,a
	mov	r0,#_strncat_front_1_1
	movx	a,@r0
	mov	_strncat_sloc0_1_0,a
	inc	r0
	movx	a,@r0
	mov	(_strncat_sloc0_1_0 + 1),a
	inc	r0
	movx	a,@r0
	mov	(_strncat_sloc0_1_0 + 2),a
	mov	r0,#_strncat_PARM_3
	movx	a,@r0
	mov	_strncat_sloc1_1_0,a
	inc	r0
	movx	a,@r0
	mov	(_strncat_sloc1_1_0 + 1),a
00106$:
	mov	r2,_strncat_sloc1_1_0
	mov	r3,(_strncat_sloc1_1_0 + 1)
	dec	_strncat_sloc1_1_0
	mov	a,#0xff
	cjne	a,_strncat_sloc1_1_0,00118$
	dec	(_strncat_sloc1_1_0 + 1)
00118$:
	mov	a,r2
	orl	a,r3
	jz	00108$
;	_strncat.c:44: if (!(*front++ = *back++))
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	mov	r5,dpl
	mov	r6,dph
	mov	dpl,_strncat_sloc0_1_0
	mov	dph,(_strncat_sloc0_1_0 + 1)
	mov	b,(_strncat_sloc0_1_0 + 2)
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	_strncat_sloc0_1_0,dpl
	mov	(_strncat_sloc0_1_0 + 1),dph
	mov	r0,#_strncat_front_1_1
	mov	a,_strncat_sloc0_1_0
	movx	@r0,a
	inc	r0
	mov	a,(_strncat_sloc0_1_0 + 1)
	movx	@r0,a
	inc	r0
	mov	a,(_strncat_sloc0_1_0 + 2)
	movx	@r0,a
	mov	a,r2
	jnz	00106$
;	_strncat.c:45: return(start);
	mov	r0,#_strncat_start_1_1
	movx	a,@r0
	mov	dpl,a
	inc	r0
	movx	a,@r0
	mov	dph,a
	inc	r0
	movx	a,@r0
	mov	b,a
	ret
00108$:
;	_strncat.c:47: *front = '\0';
	mov	r0,#_strncat_front_1_1
	movx	a,@r0
	mov	dpl,a
	inc	r0
	movx	a,@r0
	mov	dph,a
	inc	r0
	movx	a,@r0
	mov	b,a
	clr	a
	lcall	__gptrput
;	_strncat.c:48: return(start);
	mov	r0,#_strncat_start_1_1
	movx	a,@r0
	mov	dpl,a
	inc	r0
	movx	a,@r0
	mov	dph,a
	inc	r0
	movx	a,@r0
	mov	b,a
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
