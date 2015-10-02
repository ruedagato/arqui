/* sdccconf.h.  Generated from sdccconf_in.h by configure.  */
/*
 */

#ifndef SDCCCONF_HEADER
#define SDCCCONF_HEADER


#define SDCC_VERSION_HI 2
#define SDCC_VERSION_LO 8
#define SDCC_VERSION_P 4
#define SDCC_VERSION_STR "2.8.4"

#define DIR_SEPARATOR_STRING "/"
#define DIR_SEPARATOR_CHAR '/'

#define PREFIX "/usr/local"
#define EXEC_PREFIX "/usr/local"
#define BINDIR "/usr/local/bin"
#define DATADIR "/usr/local/share"

#define INCLUDE_DIR_SUFFIX DIR_SEPARATOR_STRING "sdcc/include"
#define LIB_DIR_SUFFIX DIR_SEPARATOR_STRING "sdcc/lib"

#define BIN2DATA_DIR DIR_SEPARATOR_STRING "../share"
#define PREFIX2BIN_DIR DIR_SEPARATOR_STRING "bin"
#define PREFIX2DATA_DIR DIR_SEPARATOR_STRING "share"

/* environment variables */
#define SDCC_DIR_NAME "SDCC_HOME"
#define SDCC_INCLUDE_NAME "SDCC_INCLUDE"
#define SDCC_LIB_NAME "SDCC_LIB"

/* standard libraries */
#define STD_LIB "libsdcc"
#define STD_INT_LIB "libint"
#define STD_LONG_LIB "liblong"
#define STD_FP_LIB "libfloat"
#define STD_DS390_LIB "libds390"
#define STD_DS400_LIB "libds400"
#define STD_XA51_LIB "libxa51"

#define HAVE_STRERROR 1
#define HAVE_VSNPRINTF 1
#define HAVE_SNPRINTF 1
#define HAVE_VSPRINTF 1
#define HAVE_MKSTEMP 1

#define RETSIGTYPE void

#define TYPE_BYTE char
#define TYPE_WORD short
#define TYPE_DWORD int
#define TYPE_UBYTE unsigned char
#define TYPE_UWORD unsigned short
#define TYPE_UDWORD unsigned int

/*
 * find out the endianess of host machine
 * in order to be able to make Mac OS X unified binaries
 */
/* This is tricky since these might be defined with a blank replacement list */
/* such as on SPARC Solaris. However, configure gets it right, so it's ok */
/* that (_BIG_ENDIAN+0) is false, even though it is defined. */
#if (__BIG_ENDIAN__+0) || (_BIG_ENDIAN+0)
/* 1) trust the compiler */
# define WORDS_BIGENDIAN 1
#elif __LITTLE_ENDIAN__
/* do nothing */
#elif (defined BYTE_ORDER && defined BIG_ENDIAN && defined LITTLE_ENDIAN && BYTE_ORDER && BIG_ENDIAN && LITTLE_ENDIAN)
/* 2) trust the header files */
# if BYTE_ORDER == BIG_ENDIAN 
#   define WORDS_BIGENDIAN 1
# endif
#else 
/* 3) trust the configure; this actually doesn't work for unified Mac OS X binaries :-( */
/* # undef BUILD_WORDS_BIGENDIAN */
# if (defined BUILD_WORDS_BIGENDIAN && BUILD_WORDS_BIGENDIAN)
#   define WORDS_BIGENDIAN  1
# endif
/* 4) assume that host is a little endian machine */
#endif

#define OPT_DISABLE_MCS51 0
#define OPT_DISABLE_GBZ80 0
#define OPT_DISABLE_Z80 0
#define OPT_DISABLE_AVR 0
#define OPT_DISABLE_DS390 0
#define OPT_DISABLE_DS400 0
#define OPT_DISABLE_TININative 0
#define OPT_DISABLE_PIC 0
#define OPT_DISABLE_PIC16 0
#define OPT_DISABLE_XA51 0
#define OPT_DISABLE_HC08 0

#define OPT_ENABLE_LIBGC 0

#endif

/* End of config.h */
