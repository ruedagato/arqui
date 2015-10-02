;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module _strrchr
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
	.globl _strrchr_PARM_2
	.globl _strrchr
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
_strrchr_PARM_2:
	.ds 1
_strrchr_start_1_1:
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
;Allocation info for local variables in function 'strrchr'
;------------------------------------------------------------
;ch                        Allocated with name '_strrchr_PARM_2'
;string                    Allocated to registers r2 r3 r4 r5 
;start                     Allocated with name '_strrchr_start_1_1'
;------------------------------------------------------------
;	_strrchr.c:31: char * strrchr (
;	-----------------------------------------
;	 function strrchr
;	-----------------------------------------
_strrchr:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	_strrchr.c:36: const char * start = string;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strrchr_start_1_1
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
;	_strrchr.c:38: while (*string++)                       /* find end of string */
;	genAssign: resultIsFar = FALSE
00101$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	mov	a,r6
	jnz  00101$
00118$:
;	_strrchr.c:41: while (--string != start && *string != ch)
;	genAssign: resultIsFar = FALSE
00105$:
	dec	r2
	cjne	r2,#0xFF,00119$
	dec	r3
	cjne	r3,#0xFF,00119$
	dec	r4
00119$:
	mov	dptr,#_strrchr_start_1_1
	mov	b,r2
	movx	a,@dptr
	cjne	a,b,00120$
	mov	b,r3
	inc	dptr
	movx	a,@dptr
	cjne	a,b,00120$
	mov	b,r4
	inc	dptr
	movx	a,@dptr
	cjne	a,b,00120$
	sjmp 00107$
00120$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	mov	dptr,#_strrchr_PARM_2
	mov	b,r6
	movx	a,@dptr
	cjne a,b,00105$
00122$:
00107$:
;	_strrchr.c:44: if (*string == ch)                /* char found ? */
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	mov	dptr,#_strrchr_PARM_2
	mov	b,r6
	movx	a,@dptr
	cjne a,b,00109$
00124$:
;	_strrchr.c:45: return( (char *)string );
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	sjmp 00110$
00109$:
;	_strrchr.c:47: return (NULL) ;
	mov  dptr,#0x0000
	mov	b,#0x00
00110$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
