;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module vprintf
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
	.globl _vprintf_PARM_2
	.globl _vprintf
	.globl _printf
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_vprintf_sloc0_1_0:
	.ds 2
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
_vprintf_PARM_2:
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
;Allocation info for local variables in function 'put_char_to_stdout'
;------------------------------------------------------------
;p                         Allocated to stack - offset 2
;c                         Allocated to registers 
;------------------------------------------------------------
;../vprintf.c:34: put_char_to_stdout (char c, void* p) _REENTRANT
;	-----------------------------------------
;	 function put_char_to_stdout
;	-----------------------------------------
_put_char_to_stdout:
;../vprintf.c:37: putchar (c);
	jsr	_putchar
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'vprintf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_vprintf_sloc0_1_0'
;ap                        Allocated with name '_vprintf_PARM_2'
;format                    Allocated to registers 
;------------------------------------------------------------
;../vprintf.c:41: vprintf (const char *format, va_list ap)
;	-----------------------------------------
;	 function vprintf
;	-----------------------------------------
_vprintf:
	sta	(__print_format_PARM_3 + 1)
	stx	__print_format_PARM_3
;../vprintf.c:43: return _print_format (put_char_to_stdout, NULL, format, ap);
	clra
	sta	__print_format_PARM_2
	sta	(__print_format_PARM_2 + 1)
	lda	_vprintf_PARM_2
	sta	__print_format_PARM_4
	lda	(_vprintf_PARM_2 + 1)
	sta	(__print_format_PARM_4 + 1)
	ldx	#>_put_char_to_stdout
	lda	#_put_char_to_stdout
	jsr	__print_format
	sta	*(_vprintf_sloc0_1_0 + 1)
	stx	*_vprintf_sloc0_1_0
	ldx	*_vprintf_sloc0_1_0
	lda	*(_vprintf_sloc0_1_0 + 1)
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'printf'
;------------------------------------------------------------
;format                    Allocated to stack - offset 2
;arg                       Allocated to registers 
;i                         Allocated to stack - offset -2
;sloc0                     Allocated to stack - offset -4
;------------------------------------------------------------
;../vprintf.c:47: printf (const char *format, ...)
;	-----------------------------------------
;	 function printf
;	-----------------------------------------
_printf:
	ais	#-4
;../vprintf.c:52: va_start (arg, format);
	tsx
	aix	#6
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
;../vprintf.c:53: i = _print_format (put_char_to_stdout, NULL, format, arg);
	clra
	sta	__print_format_PARM_2
	sta	(__print_format_PARM_2 + 1)
	lda	7,s
	sta	__print_format_PARM_3
	lda	8,s
	sta	(__print_format_PARM_3 + 1)
	ldx	#>_put_char_to_stdout
	lda	#_put_char_to_stdout
	jsr	__print_format
	sta	4,s
	stx	3,s
;../vprintf.c:56: return i;
	ldx	3,s
	lda	4,s
00101$:
	ais	#4
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
