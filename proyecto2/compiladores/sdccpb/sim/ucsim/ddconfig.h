/* ddconfig.h.  Generated from ddconfig_in.h by configure.  */
/*
 * Simulator of microcontrollers (ddconfig.h)
 *
 * Copyright (C) 1999,99 Drotos Daniel, Talker Bt.
 *
 * To contact author send email to drdani@mazsola.iit.uni-miskolc.hu
 *
 */

/* This file is part of microcontroller simulator: ucsim.

UCSIM is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

UCSIM is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with UCSIM; see the file COPYING.  If not, write to the Free
Software Foundation, 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA. */
/*@1@*/

#ifndef DDCONFIG_HEADER
#define DDCONFIG_HEADER

#define DD_TRUE  1
#define DD_FALSE 0
#define NIL     0

#define STDC_HEADERS 1
#define HAVE_GETOPT_H 1
#define HAVE_UNISTD_H 1
#define HAVE_DIRENT_H 1
/* #undef HAVE_SYS_NDIR_H */
/* #undef HAVE_SYS_DIR_H */
/* #undef HAVE_NDIR_H */
#define HAVE_SYS_SOCKET_H 1
/* #undef HAVE_WINSOCK2_H */
#define HAVE_DLFCN_H 1
/* #undef HAVE_CURSES_H */
#define HAVE_TERMIOS_H 1

#define SOCKET_AVAIL 1
#define SOCKLEN_T uint
#define UCSOCKET_T int
#define HEADER_SOCKET <sys/socket.h>

#define FD_NEED_TIME_H 0
#define FD_NEED_TYPES_H 0
#define FD_NEED_SELECT_H 1
#define FD_NEED_WINSOCK2_H 0
#define HEADER_FD <sys/select.h>
#define FD_HEADER_OK 1

/* #undef SCANF_A */
/* #undef GNU_GETCWD */

#define HAVE_STRLEN 1
#define HAVE_STRCPY 1
#define HAVE_STRCAT 1
#define HAVE_STRSTR 1
#define HAVE_STRCMP 1
#define HAVE_STRERROR 1
#define HAVE_STRTOK 1
#define HAVE_STRDUP 1
#define HAVE_STRCHR 1

#define HAVE_MEMCPY 1

#define HAVE_VPRINTF 1
/* #undef HAVE_DOPRNT */
#define HAVE_VSNPRINTF 1
/* #undef HAVE__VSNPRINTF */
#define HAVE_VASPRINTF 1

/* #undef HAVE_GETLINE */
/* #undef HAVE_GETDELIM */
#define HAVE_FGETS 1

/* #undef HAVE_YYLEX */
#define HAVE_FLEX 1
#define YYTEXT_POINTER 1

#define RETSIGTYPE void
#define SIZEOF_CHAR 1
#define SIZEOF_SHORT 2
#define SIZEOF_INT 4
#define SIZEOF_LONG 8
#define SIZEOF_LONG_LONG 8
#define TYPE_BYTE char
#define TYPE_WORD short
#define TYPE_DWORD int
#define TYPE_UBYTE unsigned TYPE_BYTE
#define TYPE_UWORD unsigned TYPE_WORD
#define TYPE_UDWORD unsigned TYPE_DWORD
#define _M_ "h"
#define _A_ ""

/*
 * find out the endianess of host machine
 * in order to be able to make Mac OS X unified binaries
 */
#if __BIG_ENDIAN__ || _BIG_ENDIAN
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

#define VERSIONSTR "0.5.4"
#define VERSIONHI 0
#define VERSIONLO 5
#define VERSIONP 4

#define ACCEPT_SOCKLEN_T socklen_t

#define STATISTIC no

#endif

/* End of ddconfig.h */
