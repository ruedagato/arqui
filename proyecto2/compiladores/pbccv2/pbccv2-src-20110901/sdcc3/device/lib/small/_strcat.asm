;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module _strcat
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcat_PARM_2
	.globl _strcat
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
_strcat_PARM_2::
	.ds 3
_strcat_dst_1_1::
	.ds 3
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
;Allocation info for local variables in function 'strcat'
;------------------------------------------------------------
;src                       Allocated with name '_strcat_PARM_2'
;dst                       Allocated with name '_strcat_dst_1_1'
;cp                        Allocated to registers r5 r6 r7 
;------------------------------------------------------------
;	_strcat.c:31: char * strcat (
;	-----------------------------------------
;	 function strcat
;	-----------------------------------------
_strcat:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	_strcat_dst_1_1,dpl
	mov	(_strcat_dst_1_1 + 1),dph
	mov	(_strcat_dst_1_1 + 2),b
;	_strcat.c:38: while( *cp )
	mov	r5,_strcat_dst_1_1
	mov	r6,(_strcat_dst_1_1 + 1)
	mov	r7,(_strcat_dst_1_1 + 2)
00101$:
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	jz	00111$
;	_strcat.c:39: cp++;                   /* find end of dst */
	inc	r5
	cjne	r5,#0x00,00101$
	inc	r6
;	_strcat.c:41: while( *cp++ = *src++ ) ;       /* Copy src to end of dst */
	sjmp	00101$
00111$:
	mov	r0,_strcat_PARM_2
	mov	r1,(_strcat_PARM_2 + 1)
	mov	r2,(_strcat_PARM_2 + 2)
	mov	ar4,r6
	mov	ar3,r7
00104$:
	mov	dpl,r0
	mov	dph,r1
	mov	b,r2
	lcall	__gptrget
	mov	r6,a
	inc	dptr
	mov	r0,dpl
	mov	r1,dph
	mov	dpl,r5
	mov	dph,r4
	mov	b,r3
	mov	a,r6
	lcall	__gptrput
	inc	dptr
	mov	r5,dpl
	mov	r4,dph
	mov	a,r6
	jnz	00104$
;	_strcat.c:43: return( dst );                  /* return dst */
	mov	dpl,_strcat_dst_1_1
	mov	dph,(_strcat_dst_1_1 + 1)
	mov	b,(_strcat_dst_1_1 + 2)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
