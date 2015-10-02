/* auto-host.h.  Generated from config.in by configure.  */
/* config.in.  Generated automatically from configure.in by autoheader.  */

/* Define if using alloca.c.  */
/* #undef C_ALLOCA */

/* Define to empty if the keyword does not work.  */
/* #undef const */

/* Define to one of _getb67, GETB67, getb67 for Cray-2 and Cray-YMP systems.
   This function is required for alloca.c support on those systems.  */
/* #undef CRAY_STACKSEG_END */

/* Define if you have alloca, as a function or macro.  */
/* #undef HAVE_ALLOCA */

/* Define if you have <alloca.h> and it should be used (not on Ultrix).  */
/* #undef HAVE_ALLOCA_H */

/* Define if you have the ANSI # stringizing operator in cpp. */
#define HAVE_STRINGIZE 1

/* Define if you have <sys/wait.h> that is POSIX.1 compatible.  */
#define HAVE_SYS_WAIT_H 1

/* Define as __inline if that's what the C compiler calls it.  */
/* #undef inline */

/* Define if your C compiler doesn't accept -c and -o together.  */
/* #undef NO_MINUS_C_MINUS_O */

/* Define to `long' if <sys/types.h> doesn't define.  */
/* #undef off_t */

/* Define to `unsigned' if <sys/types.h> doesn't define.  */
/* #undef size_t */

/* If using the C implementation of alloca, define if you know the
   direction of stack growth for your system; otherwise it will be
   automatically deduced at run-time.
 STACK_DIRECTION > 0 => grows toward higher addresses
 STACK_DIRECTION < 0 => grows toward lower addresses
 STACK_DIRECTION = 0 => direction of growth unknown
 */
/* #undef STACK_DIRECTION */

/* Define if you have the ANSI C header files.  */
#define STDC_HEADERS 1

/* Define if you can safely include both <sys/time.h> and <time.h>.  */
#define TIME_WITH_SYS_TIME 1

/* Define to `int' if <sys/types.h> doesn't define.  */
/* #undef ssize_t */

/* Define if cpp should also search $prefix/include.  */
/* #undef PREFIX_INCLUDE_DIR */

/* Define if you have the dcgettext function.  */
/* #undef HAVE_DCGETTEXT */

/* Define if you have the dup2 function.  */
/* #undef HAVE_DUP2 */

/* Define if you have the getegid function.  */
/* #undef HAVE_GETEGID */

/* Define if you have the geteuid function.  */
/* #undef HAVE_GETEUID */

/* Define if you have the getgid function.  */
/* #undef HAVE_GETGID */

/* Define if you have the getpagesize function.  */
#define HAVE_GETPAGESIZE 1

/* Define if you have the getuid function.  */
/* #undef HAVE_GETUID */

/* Define if you have the kill function.  */
/* #undef HAVE_KILL */

/* Define if you have the lstat function.  */
#define HAVE_LSTAT 1

/* Define if you have the mempcpy function.  */
/* #undef HAVE_MEMPCPY */

/* Define if you have the munmap function.  */
/* #undef HAVE_MUNMAP */

/* Define if you have the setlocale function.  */
/* #undef HAVE_SETLOCALE */

/* Define if you have the stpcpy function.  */
/* #undef HAVE_STPCPY */

/* Define if you have the strcasecmp function.  */
/* #undef HAVE_STRCASECMP */

/* Define if you have the strchr function.  */
#define HAVE_STRCHR 1

/* Define to 1 if you have the `strsignal' function. */
#define HAVE_STRSIGNAL 1

/* Define if you have the strdup function.  */
/* #undef HAVE_STRDUP */

/* Define if you have the tsearch function.  */
/* #undef HAVE_TSEARCH */

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_STRSIGNAL 0

/* Define if you have the <fcntl.h> header file.  */
#define HAVE_FCNTL_H 1

/* Define if you have the <langinfo.h> header file.  */
/* #undef HAVE_LANGINFO_H */

/* Define if you have the <limits.h> header file.  */
#define HAVE_LIMITS_H 1

/* Define if you have the <locale.h> header file.  */
/* #undef HAVE_LOCALE_H */

/* Define if you have the <malloc.h> header file.  */
#define HAVE_MALLOC_H 1

/* Define if you have the <nl_types.h> header file.  */
/* #undef HAVE_NL_TYPES_H */

/* Define if you have the <stddef.h> header file.  */
#define HAVE_STDDEF_H 1

/* Define if you have the <stdlib.h> header file.  */
#define HAVE_STDLIB_H 1

/* Define if you have the <string.h> header file.  */
#define HAVE_STRING_H 1

/* Define if you have the <strings.h> header file.  */
#define HAVE_STRINGS_H 1

/* Define if you have the <sys/file.h> header file.  */
#define HAVE_SYS_FILE_H 1

/* Define if you have the <sys/param.h> header file.  */
#define HAVE_SYS_PARAM_H 1

/* Define if you have the <sys/stat.h> header file.  */
#define HAVE_SYS_STAT_H 1

/* Define if you have the <sys/time.h> header file.  */
#define HAVE_SYS_TIME_H 1

/* Define if you have the <time.h> header file.  */
#define HAVE_TIME_H 1

/* Define if you have the <unistd.h> header file.  */
#define HAVE_UNISTD_H 1

/* Define to enable the use of a default linker. */
/* #undef DEFAULT_LINKER */

/* Define to enable the use of a default assembler. */
/* #undef DEFAULT_ASSEMBLER */

/* Define if you want more run-time sanity checks.  This one gets a grab
   bag of miscellaneous but relatively cheap checks. */
/* #undef ENABLE_CHECKING */

/* Define if you want all operations on trees (the basic data
   structure of the front ends) to be checked for dynamic type safety
   at runtime.  This is moderately expensive. */
/* #undef ENABLE_TREE_CHECKING */

/* Define if you want all operations on RTL (the basic data structure
   of the optimizer and back end) to be checked for dynamic type safety
   at runtime.  This is quite expensive. */
/* #undef ENABLE_RTL_CHECKING */

/* Define if you want the garbage collector to do object poisoning and
   other memory allocation checks.  This is quite expensive. */
/* #undef ENABLE_GC_CHECKING */

/* Define if you want the garbage collector to operate in maximally
   paranoid mode, validating the entire heap and collecting garbage at
   every opportunity.  This is extremely expensive. */
/* #undef ENABLE_GC_ALWAYS_COLLECT */

/* Define if you want the C and C++ compilers to support multibyte
   character sets for source code. */
/* #undef MULTIBYTE_CHARS */

/* Define if your compiler understands volatile. */
/* #undef HAVE_VOLATILE */

/* Define if your compiler supports the `long double' type. */
/* #undef HAVE_LONG_DOUBLE */

/* Define if the `_Bool' type is built-in. */
#define HAVE__BOOL 1

/* The number of bytes in type short */
#define SIZEOF_SHORT 2

/* The number of bytes in type int */
#define SIZEOF_INT 4

/* The number of bytes in type long */
#define SIZEOF_LONG 8

/* Define if the host execution character set is EBCDIC. */
/* #undef HOST_EBCDIC */

/* Define if you have a working <stdbool.h> header file. */
#define HAVE_STDBOOL_H 1

/* Define if you can safely include both <string.h> and <strings.h>. */
#define STRING_WITH_STRINGS 1

/* Define as the number of bits in a byte, if `limits.h' doesn't. */
/* #undef CHAR_BIT */

/* Define if the host machine stores words of multi-word integers in
   big-endian order. */
/* #undef HOST_WORDS_BIG_ENDIAN */

/* Define to the floating point format of the host machine, if not IEEE. */
/* #undef HOST_FLOAT_FORMAT */

/* Define to 1 if the host machine stores floating point numbers in
   memory with the word containing the sign bit at the lowest address,
   or to 0 if it does it the other way around.

   This macro should not be defined if the ordering is the same as for
   multi-word integers. */
/* #undef HOST_FLOAT_WORDS_BIG_ENDIAN */

/* Define if you have a working <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define if printf supports %p. */
/* #undef HAVE_PRINTF_PTR */

/* Define if mmap can get us zeroed pages from /dev/zero. */
#define HAVE_MMAP_DEV_ZERO 1

/* Define if mmap can get us zeroed pages using MAP_ANON(YMOUS). */
#define HAVE_MMAP_ANON 1

/* Define if read-only mmap of a plain file works. */
#define HAVE_MMAP_FILE 1

/* Define if you have the iconv() function. */
/* #undef HAVE_ICONV */

/* Define as const if the declaration of iconv() needs const. */
/* #undef ICONV_CONST */

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_GETENV 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_ABORT 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_ERRNO 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_MALLOC 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_REALLOC 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_CALLOC 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_FREE 0

/* Define to 1 if we found this declaration otherwise define to 0. */
/* #undef HAVE_DECL_BASENAME */

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_CLOCK 0

/* Define to 1 if we found this declaration otherwise define to 0. */
/* #undef HAVE_DECL_TIMES */

/* Define if host mkdir takes a single argument. */
/* #undef MKDIR_TAKES_ONE_ARG */

/* Define if you have the iconv() function. */
/* #undef HAVE_ICONV */

/* Define as const if the declaration of iconv() needs const. */
/* #undef ICONV_CONST */

/* Define if you have <langinfo.h> and nl_langinfo(CODESET). */
/* #undef HAVE_LANGINFO_CODESET */

/* Define if your <locale.h> file defines LC_MESSAGES. */
/* #undef HAVE_LC_MESSAGES */

/* Define to 1 if translation of program messages to the user's native language
   is requested. */
/* #undef ENABLE_NLS */

/* Define if you have the <libintl.h> header file. */
/* #undef HAVE_LIBINTL_H */

/* Define if the GNU gettext() function is already present or preinstalled. */
/* #undef HAVE_GETTEXT */

/* Define to use the libintl included with this package instead of any
   version in the system libraries. */
/* #undef USE_INCLUDED_LIBINTL */

/* Define to 1 if installation paths should be looked up in Windows32
   Registry. Ignored on non windows32 hosts. */
/* #undef ENABLE_WIN32_REGISTRY */

/* Define to be the last portion of registry key on windows hosts. */
/* #undef WIN32_REGISTRY_KEY */


/* Bison unconditionally undefines `const' if neither `__STDC__' nor
   __cplusplus are defined.  That's a problem since we use `const' in
   the GCC headers, and the resulting bison code is therefore type
   unsafe.  Thus, we must match the bison behavior here.  */

#ifndef __STDC__
#ifndef __cplusplus
/* #undef const */
#define const
#endif
#endif
