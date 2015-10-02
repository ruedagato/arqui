;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:20 2015
;--------------------------------------------------------
	.module _gptrput
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
	.globl __gptrputWord
	.globl __gptrput
	.globl __gptrput_PARM_2
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_B_7	=	0x00f7
_B_6	=	0x00f6
_B_5	=	0x00f5
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
__gptrput_PARM_2:
	.ds 1
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
;Allocation info for local variables in function '_gptrput'
;------------------------------------------------------------
;c                         Allocated with name '__gptrput_PARM_2'
;gptr                      Allocated to registers 
;------------------------------------------------------------
;	_gptrput.c:142: _gptrput (char *gptr, char c) __naked
;	-----------------------------------------
;	 function _gptrput
;	-----------------------------------------
__gptrput:
;	naked function: no prologue.
;	_gptrput.c:185: __endasm;
	
    ;
    ; depending on the pointer type according to SDCCsymt.h
    ;
	        jb _B_7,codeptr$ ; >0x80 code ; 3
	        jnb _B_6,xdataptr$ ; <0x40 far ; 3
	
	        mov dph,r0 ; save r0 independant of regbank ; 2
	        mov r0,dpl ; use only low order address ; 2
	
	        jb _B_5,pdataptr$ ; >0x60 pdata ; 3
    ;
    ; store into near/idata space
    ;
	        mov @r0,a ; 1
	 dataptrrestore$:
	        mov r0,dph ; restore r0 ; 2
	        mov dph,#0 ; restore dph ; 2
	
	 codeptr$:
	        ret ; 1
    ;
    ; store into external stack/pdata space
    ;
	 pdataptr$:
	        movx @r0,a ; 1
	        sjmp dataptrrestore$ ; 2
    ;
    ; store into far space
    ;
	 xdataptr$:
	        movx @dptr,a ; 1
	        ret ; 1
	
                                                        ;===
                                                        ;24 bytes
	    
00101$:
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function '_gptrputWord'
;------------------------------------------------------------
;------------------------------------------------------------
;	_gptrput.c:193: _gptrputWord ()
;	-----------------------------------------
;	 function _gptrputWord
;	-----------------------------------------
__gptrputWord:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_gptrput.c:243: __endasm;
	
    ;
    ; depending on the pointer type acc. to SDCCsymt.h
    ;
	        jb _B_7,00013$ ; >0x80 code
	        jnb _B_6,00012$ ; <0x40 far
	
	        mov dph,r0 ; save r0 independant of regbank
	        mov r0,dpl ; use only low order address
	
	        jb _B_5,00014$ ; >0x60 pdata
;
; store into near space
;
	        mov @r0,_ap
	        inc r0
	        mov @r0,a
	        sjmp 00015$
;
; store into far space
;
	 00012$:
	        xch a,_ap
	        movx @dptr,a
	        inc dptr
	        xch a,_ap
	        movx @dptr,a
	        sjmp 00016$
;
; store into code space
;
	 00013$:
	        inc dptr ; do nothing
	        sjmp 00016$
;
; store into xstack space
;
	 00014$:
	        xch a,_ap
	        movx @r0,a
	        inc r0
	        xch a,_ap
	        movx @r0, a
	 00015$:
	        mov dpl,r0
	        mov r0,dph ; restore r0
	        mov dph,#0 ; restore dph
	 00016$:
	    
00101$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
