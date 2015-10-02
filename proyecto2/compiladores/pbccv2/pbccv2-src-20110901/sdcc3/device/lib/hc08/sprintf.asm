;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module sprintf
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
	.globl _vsprintf_PARM_3
	.globl _vsprintf_PARM_2
	.globl _vsprintf
	.globl _sprintf
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area OSEG    (OVR)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG
;--------------------------------------------------------
; extended address mode data
;--------------------------------------------------------
	.area XSEG
_vsprintf_PARM_2:
	.ds 2
_vsprintf_PARM_3:
	.ds 2
_vsprintf_buf_1_1:
	.ds 2
_vsprintf_i_1_1:
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
;Allocation info for local variables in function 'put_char_to_string'
;------------------------------------------------------------
;p                         Allocated to stack - offset 2
;c                         Allocated to stack - offset -1
;buf                       Allocated to registers 
;sloc0                     Allocated to stack - offset -3
;sloc1                     Allocated to stack - offset -5
;------------------------------------------------------------
;../sprintf.c:34: put_char_to_string (char c, void* p) _REENTRANT
;	-----------------------------------------
;	 function put_char_to_string
;	-----------------------------------------
_put_char_to_string:
	psha
	ais	#-4
;../sprintf.c:36: char **buf = (char **)p;
;../sprintf.c:37: *(*buf)++ = c;
	lda	8,s
	ldx	9,s
	psha
	pulh
	lda	,x
	aix	#1
	sta	3,s
	lda	,x
	sta	4,s
	lda	4,s
	add	#0x01
	sta	2,s
	lda	3,s
	adc	#0x00
	sta	1,s
	lda	8,s
	ldx	9,s
	psha
	pulh
	lda	1,s
	sta	,x
	aix	#1
	lda	2,s
	sta	,x
	lda	3,s
	ldx	4,s
	psha
	pulh
	lda	5,s
	sta	,x
00101$:
	ais	#5
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'vsprintf'
;------------------------------------------------------------
;format                    Allocated with name '_vsprintf_PARM_2'
;ap                        Allocated with name '_vsprintf_PARM_3'
;buf                       Allocated with name '_vsprintf_buf_1_1'
;i                         Allocated with name '_vsprintf_i_1_1'
;------------------------------------------------------------
;../sprintf.c:41: vsprintf (char *buf, const char *format, va_list ap)
;	-----------------------------------------
;	 function vsprintf
;	-----------------------------------------
_vsprintf:
	sta	(_vsprintf_buf_1_1 + 1)
	stx	_vsprintf_buf_1_1
;../sprintf.c:44: i = _print_format (put_char_to_string, &buf, format, ap);
	lda	#_vsprintf_buf_1_1
	sta	(__print_format_PARM_2 + 1)
	lda	#>_vsprintf_buf_1_1
	sta	__print_format_PARM_2
	lda	_vsprintf_PARM_2
	sta	__print_format_PARM_3
	lda	(_vsprintf_PARM_2 + 1)
	sta	(__print_format_PARM_3 + 1)
	lda	_vsprintf_PARM_3
	sta	__print_format_PARM_4
	lda	(_vsprintf_PARM_3 + 1)
	sta	(__print_format_PARM_4 + 1)
	ldx	#>_put_char_to_string
	lda	#_put_char_to_string
	jsr	__print_format
	sta	(_vsprintf_i_1_1 + 1)
	stx	_vsprintf_i_1_1
;../sprintf.c:45: *buf = 0;
	ldx	_vsprintf_buf_1_1
	lda	(_vsprintf_buf_1_1 + 1)
	pshx
	pulh
	tax
	clra
	sta	,x
;../sprintf.c:46: return i;
	ldx	_vsprintf_i_1_1
	lda	(_vsprintf_i_1_1 + 1)
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'sprintf'
;------------------------------------------------------------
;buf                       Allocated to stack - offset 2
;format                    Allocated to stack - offset 4
;arg                       Allocated to registers 
;i                         Allocated to stack - offset -2
;sloc0                     Allocated to stack - offset -4
;------------------------------------------------------------
;../sprintf.c:50: sprintf (char *buf, const char *format, ...)
;	-----------------------------------------
;	 function sprintf
;	-----------------------------------------
_sprintf:
	ais	#-4
;../sprintf.c:55: va_start (arg, format);
	tsx
	aix	#8
	pshh
	pula
	sta	1,s
	stx	2,s
	lda	2,s
	add	#0x02
	sta	(__print_format_PARM_4 + 1)
	lda	1,s
	adc	#0x00
	sta	__print_format_PARM_4
;../sprintf.c:56: i = _print_format (put_char_to_string, &buf, format, arg);
	tsx
	aix	#6
	pshh
	pula
	sta	__print_format_PARM_2
	stx	(__print_format_PARM_2 + 1)
	lda	9,s
	sta	__print_format_PARM_3
	lda	10,s
	sta	(__print_format_PARM_3 + 1)
	ldx	#>_put_char_to_string
	lda	#_put_char_to_string
	jsr	__print_format
	sta	4,s
	stx	3,s
;../sprintf.c:57: *buf = 0;
	ldx	7,s
	lda	8,s
	pshx
	pulh
	tax
	clra
	sta	,x
;../sprintf.c:60: return i;
	ldx	3,s
	lda	4,s
00101$:
	ais	#4
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
