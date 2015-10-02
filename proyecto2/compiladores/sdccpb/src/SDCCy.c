/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 24 "SDCC.y" /* yacc.c:339  */

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include "SDCCglobl.h"
#include "SDCCsymt.h"
#include "SDCChasht.h"
#include "SDCCval.h"
#include "SDCCmem.h"
#include "SDCCast.h"
#include "port.h"
#include "newalloc.h"
#include "SDCCerr.h"
#include "SDCCutil.h"

extern int yyerror (char *);
extern FILE     *yyin;
int NestLevel = 0 ;     /* current NestLevel       */
int stackPtr  = 1 ;     /* stack pointer           */
int xstackPtr = 0 ;     /* xstack pointer          */
int reentrant = 0 ;
int blockNo   = 0 ;     /* sequential block number  */
int currBlockno=0 ;
int inCritical= 0 ;
int seqPointNo= 1 ;     /* sequence point number */
int ignoreTypedefType=0;
extern int yylex();
int yyparse(void);
extern int noLineno ;
char lbuff[1024];      /* local buffer */

/* break & continue stacks */
STACK_DCL(continueStack  ,symbol *,MAX_NEST_LEVEL)
STACK_DCL(breakStack  ,symbol *,MAX_NEST_LEVEL)
STACK_DCL(forStack  ,symbol *,MAX_NEST_LEVEL)
STACK_DCL(swStk   ,ast   *,MAX_NEST_LEVEL)
STACK_DCL(blockNum,int,MAX_NEST_LEVEL*3)

value *cenum = NULL  ;  /* current enumeration  type chain*/
bool uselessDecl = TRUE;

#define YYDEBUG 1


#line 111 "SDCCy.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "SDCCy.h".  */
#ifndef YY_YY_SDCCY_H_INCLUDED
# define YY_YY_SDCCY_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENTIFIER = 258,
    TYPE_NAME = 259,
    CONSTANT = 260,
    STRING_LITERAL = 261,
    SIZEOF = 262,
    TYPEOF = 263,
    PTR_OP = 264,
    INC_OP = 265,
    DEC_OP = 266,
    LEFT_OP = 267,
    RIGHT_OP = 268,
    LE_OP = 269,
    GE_OP = 270,
    EQ_OP = 271,
    NE_OP = 272,
    AND_OP = 273,
    OR_OP = 274,
    MUL_ASSIGN = 275,
    DIV_ASSIGN = 276,
    MOD_ASSIGN = 277,
    ADD_ASSIGN = 278,
    SUB_ASSIGN = 279,
    LEFT_ASSIGN = 280,
    RIGHT_ASSIGN = 281,
    AND_ASSIGN = 282,
    XOR_ASSIGN = 283,
    OR_ASSIGN = 284,
    TYPEDEF = 285,
    EXTERN = 286,
    STATIC = 287,
    AUTO = 288,
    REGISTER = 289,
    CODE = 290,
    EEPROM = 291,
    INTERRUPT = 292,
    SFR = 293,
    SFR16 = 294,
    SFR32 = 295,
    AT = 296,
    SBIT = 297,
    REENTRANT = 298,
    USING = 299,
    XDATA = 300,
    DATA = 301,
    IDATA = 302,
    PDATA = 303,
    VAR_ARGS = 304,
    CRITICAL = 305,
    NONBANKED = 306,
    BANKED = 307,
    SHADOWREGS = 308,
    WPARAM = 309,
    CHAR = 310,
    SHORT = 311,
    INT = 312,
    LONG = 313,
    SIGNED = 314,
    UNSIGNED = 315,
    FLOAT = 316,
    DOUBLE = 317,
    FIXED16X16 = 318,
    CONST = 319,
    VOLATILE = 320,
    VOID = 321,
    BIT = 322,
    STRUCT = 323,
    UNION = 324,
    ENUM = 325,
    RANGE = 326,
    FAR = 327,
    CASE = 328,
    DEFAULT = 329,
    IF = 330,
    ELSE = 331,
    SWITCH = 332,
    WHILE = 333,
    DO = 334,
    FOR = 335,
    GOTO = 336,
    CONTINUE = 337,
    BREAK = 338,
    RETURN = 339,
    NAKED = 340,
    JAVANATIVE = 341,
    OVERLAY = 342,
    INLINEASM = 343,
    IFX = 344,
    ADDRESS_OF = 345,
    GET_VALUE_AT_ADDRESS = 346,
    SPIL = 347,
    UNSPIL = 348,
    GETHBIT = 349,
    GETABIT = 350,
    GETBYTE = 351,
    GETWORD = 352,
    BITWISEAND = 353,
    UNARYMINUS = 354,
    IPUSH = 355,
    IPOP = 356,
    PCALL = 357,
    ENDFUNCTION = 358,
    JUMPTABLE = 359,
    RRC = 360,
    RLC = 361,
    CAST = 362,
    CALL = 363,
    PARAM = 364,
    NULLOP = 365,
    BLOCK = 366,
    LABEL = 367,
    RECEIVE = 368,
    SEND = 369,
    ARRAYINIT = 370,
    DUMMY_READ_VOLATILE = 371,
    ENDCRITICAL = 372,
    SWAP = 373,
    INLINE = 374,
    RESTRICT = 375
  };
#endif
/* Tokens.  */
#define IDENTIFIER 258
#define TYPE_NAME 259
#define CONSTANT 260
#define STRING_LITERAL 261
#define SIZEOF 262
#define TYPEOF 263
#define PTR_OP 264
#define INC_OP 265
#define DEC_OP 266
#define LEFT_OP 267
#define RIGHT_OP 268
#define LE_OP 269
#define GE_OP 270
#define EQ_OP 271
#define NE_OP 272
#define AND_OP 273
#define OR_OP 274
#define MUL_ASSIGN 275
#define DIV_ASSIGN 276
#define MOD_ASSIGN 277
#define ADD_ASSIGN 278
#define SUB_ASSIGN 279
#define LEFT_ASSIGN 280
#define RIGHT_ASSIGN 281
#define AND_ASSIGN 282
#define XOR_ASSIGN 283
#define OR_ASSIGN 284
#define TYPEDEF 285
#define EXTERN 286
#define STATIC 287
#define AUTO 288
#define REGISTER 289
#define CODE 290
#define EEPROM 291
#define INTERRUPT 292
#define SFR 293
#define SFR16 294
#define SFR32 295
#define AT 296
#define SBIT 297
#define REENTRANT 298
#define USING 299
#define XDATA 300
#define DATA 301
#define IDATA 302
#define PDATA 303
#define VAR_ARGS 304
#define CRITICAL 305
#define NONBANKED 306
#define BANKED 307
#define SHADOWREGS 308
#define WPARAM 309
#define CHAR 310
#define SHORT 311
#define INT 312
#define LONG 313
#define SIGNED 314
#define UNSIGNED 315
#define FLOAT 316
#define DOUBLE 317
#define FIXED16X16 318
#define CONST 319
#define VOLATILE 320
#define VOID 321
#define BIT 322
#define STRUCT 323
#define UNION 324
#define ENUM 325
#define RANGE 326
#define FAR 327
#define CASE 328
#define DEFAULT 329
#define IF 330
#define ELSE 331
#define SWITCH 332
#define WHILE 333
#define DO 334
#define FOR 335
#define GOTO 336
#define CONTINUE 337
#define BREAK 338
#define RETURN 339
#define NAKED 340
#define JAVANATIVE 341
#define OVERLAY 342
#define INLINEASM 343
#define IFX 344
#define ADDRESS_OF 345
#define GET_VALUE_AT_ADDRESS 346
#define SPIL 347
#define UNSPIL 348
#define GETHBIT 349
#define GETABIT 350
#define GETBYTE 351
#define GETWORD 352
#define BITWISEAND 353
#define UNARYMINUS 354
#define IPUSH 355
#define IPOP 356
#define PCALL 357
#define ENDFUNCTION 358
#define JUMPTABLE 359
#define RRC 360
#define RLC 361
#define CAST 362
#define CALL 363
#define PARAM 364
#define NULLOP 365
#define BLOCK 366
#define LABEL 367
#define RECEIVE 368
#define SEND 369
#define ARRAYINIT 370
#define DUMMY_READ_VOLATILE 371
#define ENDCRITICAL 372
#define SWAP 373
#define INLINE 374
#define RESTRICT 375

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 70 "SDCC.y" /* yacc.c:355  */

    symbol     *sym ;      /* symbol table pointer       */
    structdef  *sdef;      /* structure definition       */
    char       yychar[SDCC_NAME_MAX+1];
    sym_link   *lnk ;      /* declarator  or specifier   */
    int        yyint;      /* integer value returned     */
    value      *val ;      /* for integer constant       */
    initList   *ilist;     /* initial list               */
    const char *yyinline;  /* inlined assembler code     */
    ast        *asts;      /* expression tree            */

#line 403 "SDCCy.c" /* yacc.c:355  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SDCCY_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 418 "SDCCy.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  67
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   1646

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  145
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  103
/* YYNRULES -- Number of rules.  */
#define YYNRULES  282
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  420

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   375

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,   132,     2,     2,     2,   134,   127,     2,
     121,   122,   128,   129,   126,   130,   125,   133,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,   140,   142,
     135,   141,   136,   139,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,   123,     2,   124,   137,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,   143,   138,   144,   131,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93,    94,
      95,    96,    97,    98,    99,   100,   101,   102,   103,   104,
     105,   106,   107,   108,   109,   110,   111,   112,   113,   114,
     115,   116,   117,   118,   119,   120
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   137,   137,   140,   144,   145,   149,   152,   178,   183,
     194,   195,   199,   203,   206,   209,   212,   215,   218,   224,
     227,   230,   239,   248,   249,   257,   258,   259,   260,   264,
     268,   269,   270,   272,   276,   276,   284,   284,   291,   293,
     298,   299,   303,   304,   305,   306,   307,   308,   309,   313,
     314,   315,   316,   317,   318,   322,   323,   327,   328,   329,
     330,   334,   335,   336,   340,   341,   342,   346,   347,   348,
     349,   350,   354,   355,   356,   360,   361,   365,   366,   370,
     371,   375,   376,   376,   381,   382,   382,   387,   388,   388,
     396,   397,   445,   446,   447,   448,   449,   450,   451,   452,
     453,   454,   455,   459,   460,   460,   464,   468,   475,   495,
     496,   509,   510,   523,   524,   540,   541,   545,   546,   551,
     555,   559,   563,   567,   574,   581,   582,   595,   596,   606,
     611,   616,   621,   626,   631,   636,   641,   645,   649,   653,
     658,   663,   667,   671,   675,   679,   683,   687,   696,   701,
     707,   716,   720,   728,   732,   740,   751,   762,   775,   774,
     823,   842,   843,   847,   848,   855,   866,   867,   880,   908,
     909,   917,   918,   930,   946,   951,   956,   976,   990,   991,
     992,  1000,  1023,  1036,  1049,  1050,  1058,  1059,  1063,  1064,
    1072,  1073,  1105,  1106,  1107,  1116,  1148,  1149,  1149,  1175,
    1185,  1186,  1198,  1204,  1243,  1251,  1253,  1269,  1270,  1278,
    1279,  1283,  1284,  1292,  1304,  1315,  1316,  1333,  1334,  1335,
    1342,  1343,  1348,  1354,  1360,  1368,  1369,  1370,  1382,  1382,
    1406,  1407,  1408,  1412,  1413,  1417,  1418,  1419,  1420,  1421,
    1422,  1423,  1424,  1435,  1444,  1454,  1456,  1463,  1463,  1472,
    1480,  1484,  1485,  1486,  1487,  1490,  1494,  1507,  1533,  1534,
    1538,  1539,  1543,  1544,  1549,  1549,  1557,  1557,  1582,  1596,
    1611,  1630,  1630,  1639,  1649,  1677,  1678,  1682,  1687,  1700,
    1710,  1719,  1731
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IDENTIFIER", "TYPE_NAME", "CONSTANT",
  "STRING_LITERAL", "SIZEOF", "TYPEOF", "PTR_OP", "INC_OP", "DEC_OP",
  "LEFT_OP", "RIGHT_OP", "LE_OP", "GE_OP", "EQ_OP", "NE_OP", "AND_OP",
  "OR_OP", "MUL_ASSIGN", "DIV_ASSIGN", "MOD_ASSIGN", "ADD_ASSIGN",
  "SUB_ASSIGN", "LEFT_ASSIGN", "RIGHT_ASSIGN", "AND_ASSIGN", "XOR_ASSIGN",
  "OR_ASSIGN", "TYPEDEF", "EXTERN", "STATIC", "AUTO", "REGISTER", "CODE",
  "EEPROM", "INTERRUPT", "SFR", "SFR16", "SFR32", "AT", "SBIT",
  "REENTRANT", "USING", "XDATA", "DATA", "IDATA", "PDATA", "VAR_ARGS",
  "CRITICAL", "NONBANKED", "BANKED", "SHADOWREGS", "WPARAM", "CHAR",
  "SHORT", "INT", "LONG", "SIGNED", "UNSIGNED", "FLOAT", "DOUBLE",
  "FIXED16X16", "CONST", "VOLATILE", "VOID", "BIT", "STRUCT", "UNION",
  "ENUM", "RANGE", "FAR", "CASE", "DEFAULT", "IF", "ELSE", "SWITCH",
  "WHILE", "DO", "FOR", "GOTO", "CONTINUE", "BREAK", "RETURN", "NAKED",
  "JAVANATIVE", "OVERLAY", "INLINEASM", "IFX", "ADDRESS_OF",
  "GET_VALUE_AT_ADDRESS", "SPIL", "UNSPIL", "GETHBIT", "GETABIT",
  "GETBYTE", "GETWORD", "BITWISEAND", "UNARYMINUS", "IPUSH", "IPOP",
  "PCALL", "ENDFUNCTION", "JUMPTABLE", "RRC", "RLC", "CAST", "CALL",
  "PARAM", "NULLOP", "BLOCK", "LABEL", "RECEIVE", "SEND", "ARRAYINIT",
  "DUMMY_READ_VOLATILE", "ENDCRITICAL", "SWAP", "INLINE", "RESTRICT",
  "'('", "')'", "'['", "']'", "'.'", "','", "'&'", "'*'", "'+'", "'-'",
  "'~'", "'!'", "'/'", "'%'", "'<'", "'>'", "'^'", "'|'", "'?'", "':'",
  "'='", "';'", "'{'", "'}'", "$accept", "file", "program",
  "external_definition", "function_definition", "function_attribute",
  "function_attributes", "function_body", "primary_expr", "string_literal",
  "postfix_expr", "$@1", "$@2", "argument_expr_list", "unary_expr",
  "unary_operator", "cast_expr", "multiplicative_expr", "additive_expr",
  "shift_expr", "relational_expr", "equality_expr", "and_expr",
  "exclusive_or_expr", "inclusive_or_expr", "logical_and_expr", "$@3",
  "logical_or_expr", "$@4", "conditional_expr", "$@5", "assignment_expr",
  "assignment_operator", "expr", "$@6", "constant_expr", "declaration",
  "declaration_specifiers", "init_declarator_list", "init_declarator",
  "storage_class_specifier", "function_specifier", "Interrupt_storage",
  "type_specifier", "type_specifier2", "sfr_reg_bit", "sfr_attributes",
  "struct_or_union_specifier", "$@7", "struct_or_union", "opt_stag",
  "stag", "struct_declaration_list", "struct_declaration",
  "struct_declarator_list", "struct_declarator", "enum_specifier",
  "enumerator_list", "enumerator", "opt_assign_expr", "declarator",
  "declarator3", "function_declarator", "declarator2_function_attributes",
  "declarator2", "function_declarator2", "$@8", "pointer",
  "unqualified_pointer", "type_specifier_list", "identifier_list",
  "parameter_type_list", "parameter_list", "parameter_declaration",
  "type_name", "abstract_declarator", "abstract_declarator2", "$@9",
  "initializer", "initializer_list", "statement", "critical",
  "critical_statement", "labeled_statement", "@10", "start_block",
  "end_block", "compound_statement", "declaration_list", "statement_list",
  "expression_statement", "else_statement", "selection_statement", "$@11",
  "@12", "while", "do", "for", "iteration_statement", "$@13", "expr_opt",
  "jump_statement", "identifier", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,   323,   324,
     325,   326,   327,   328,   329,   330,   331,   332,   333,   334,
     335,   336,   337,   338,   339,   340,   341,   342,   343,   344,
     345,   346,   347,   348,   349,   350,   351,   352,   353,   354,
     355,   356,   357,   358,   359,   360,   361,   362,   363,   364,
     365,   366,   367,   368,   369,   370,   371,   372,   373,   374,
     375,    40,    41,    91,    93,    46,    44,    38,    42,    43,
      45,   126,    33,    47,    37,    60,    62,    94,   124,    63,
      58,    61,    59,   123,   125
};
# endif

#define YYPACT_NINF -335

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-335)))

#define YYTABLE_NINF -187

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
    1045,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,
     -16,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,
    -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,
    -335,  -335,     7,  -335,  -335,    13,  -335,    39,  1045,  -335,
    -335,  -335,    12,  1440,  1440,  1440,    28,  -335,  -335,  -335,
      79,  -335,   -30,   677,   -56,   -12,   156,    27,  1395,  -335,
    -335,    79,   -31,    30,   -30,  -335,    27,  -335,  -335,  -335,
     -53,  -335,    18,   677,    27,  -335,  -335,  -335,  1002,  -335,
      26,  -335,   346,    35,  -335,  -335,  -335,    12,   478,  -335,
     677,    16,  1002,  -335,  1002,  -335,  -335,  -335,  -335,  -335,
    -335,  -335,  -335,  -335,   156,  -335,   -56,  -335,  -335,  1395,
     -82,  -335,    46,    79,  -335,   -30,    13,  -335,   458,  -335,
    -335,  -335,  1014,  1027,  1027,  1027,   934,  -335,  -335,  -335,
    -335,  -335,  -335,  -335,  -335,    45,  -335,  1002,  -335,   -26,
      -2,   119,    37,   181,    74,    68,    82,   193,     6,  -335,
    -335,  -335,    85,  -335,   113,  -335,  -335,  1002,  -335,   118,
     124,  -335,  -335,  -335,    79,    98,   104,   496,   106,  -335,
    -335,    97,  -335,  -335,   -48,  -335,   748,  -335,  -335,  -335,
    -335,   478,   562,  -335,  -335,   128,   748,   130,  -335,  -335,
     115,  -335,  -335,  -335,  1526,    29,  -335,  -335,  -335,  -335,
    -335,  -335,    79,  -335,  1002,  -335,   -80,  -335,   458,  -335,
    -335,   934,  -335,  1002,  -335,  -335,  -335,    36,  1304,   138,
    -335,  -335,  -335,   646,  1002,  -335,  -335,  1002,  1002,  1002,
    1002,  1002,  1002,  1002,  1002,  1002,  1002,  1002,  1002,  1002,
    1002,  1002,  1002,  -335,  -335,  -335,  1526,  -335,   121,   122,
    1002,  1002,   125,  -335,  -335,  -335,   -47,  -335,  -335,  -335,
    -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  1002,
    -335,  -335,  -335,  -335,   562,  -335,  -335,  1002,   185,  1002,
    -335,  1176,   144,   143,  -335,  -335,  -335,    79,  -335,  -335,
    -335,  -335,   -54,   148,  -335,  1267,   832,    67,  -335,    73,
    1002,    79,  -335,   154,   152,    88,    79,  -335,  -335,  -335,
     -26,   -26,    -2,    -2,   119,   119,   119,   119,    37,    37,
     181,    74,    68,  1002,  1002,  1002,   744,  -335,   847,  -335,
    -335,    49,    52,  -335,  -335,  -335,  1002,  -335,    57,   158,
     157,   140,  1136,  -335,    23,  -335,  1486,  -335,   309,  -335,
    -335,  -335,   163,   166,  -335,   165,    73,   168,   915,  -335,
    -335,  -335,  1002,  -335,  -335,    82,   193,    -5,  -335,  -335,
    1002,   -42,  -335,   159,  -335,  -335,  -335,  -335,  1002,  1002,
    -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  1526,  -335,
     174,  -335,  1002,  -335,    21,  -335,  1002,   748,   748,   748,
      58,   160,   182,  -335,  -335,  -335,  -335,   204,  -335,  -335,
     161,  1002,  -335,   748,  -335,  -335,   187,  -335,   748,  -335
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint16 yydefact[] =
{
       2,   282,   150,   119,   120,   121,   122,   123,   142,   143,
     154,   156,   157,   152,   141,   144,   145,   146,   129,   130,
     131,   132,   133,   134,   139,   140,   136,   137,   135,   147,
     161,   162,     0,   124,   138,     0,   204,     0,     3,     4,
       6,     7,     0,   109,   113,   111,   127,   151,   153,   148,
     164,   149,     0,     0,   188,   187,   190,     0,   200,   192,
     155,     0,   177,     0,   184,   186,     0,     1,     5,   107,
       0,   115,   117,     0,     0,   110,   114,   112,     0,   158,
     160,   165,     0,     0,   249,     8,   256,     0,     0,    23,
       0,   197,   125,    13,     0,    14,    18,    21,    19,    20,
      15,    16,    17,   191,    10,    22,   189,   205,   202,   201,
       0,   178,   183,     0,   193,   185,     0,   108,     0,     9,
      26,    29,     0,     0,     0,     0,     0,    49,    50,    51,
      52,    53,    54,    30,    27,    42,    55,     0,    57,    61,
      64,    67,    72,    75,    77,    79,    81,    84,    87,   106,
     128,    25,     0,   194,     0,   255,   243,     0,   247,     0,
       0,   268,   269,   270,     0,     0,     0,     0,     0,   260,
     250,    57,    90,   103,     0,   258,     0,   241,   235,   251,
     236,     0,     0,   237,   238,     0,     0,     0,   239,   240,
      25,   257,    24,   196,     0,     0,   207,   126,    12,    11,
     206,   203,   179,   175,     0,   181,     0,   116,     0,   230,
     118,     0,    46,     0,    48,    43,    44,     0,   215,     0,
      36,    38,    39,     0,     0,    34,    45,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    82,    85,    88,     0,   195,     0,     0,
       0,     0,     0,   278,   279,   280,     0,   242,    93,    94,
      95,    96,    97,    98,    99,   100,   101,   102,    92,     0,
     104,   261,   244,   253,     0,   259,   252,     0,     0,   275,
     245,   215,     0,   209,   211,   214,   199,     0,   180,   182,
     176,   233,     0,     0,    28,     0,     0,   217,   216,   218,
       0,     0,    32,     0,    40,     0,     0,    58,    59,    60,
      62,    63,    65,    66,    70,    71,    68,    69,    73,    74,
      76,    78,    80,     0,     0,     0,     0,   166,   174,   246,
     248,     0,     0,   277,   281,    91,     0,   254,     0,     0,
     276,     0,     0,   213,   217,   198,     0,   208,     0,   231,
      47,   225,     0,     0,   221,     0,   219,   228,     0,    56,
      37,    33,     0,    31,    35,    83,    86,     0,   159,   167,
       0,     0,   169,   171,   264,   266,   105,   271,     0,   275,
     210,   212,   232,   234,   226,   220,   222,   227,     0,   223,
       0,    41,     0,   172,   174,   168,     0,     0,     0,     0,
       0,     0,     0,   224,    89,   170,   173,   263,   267,   272,
       0,   275,   229,     0,   265,   273,     0,   262,     0,   274
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -335,  -335,  -335,   269,  -335,   206,  -335,   238,  -335,  -335,
    -335,  -335,  -335,   -49,   110,  -335,   135,   -15,   -14,    22,
     -13,    81,    83,    84,     4,    -1,  -335,     8,  -335,   -74,
    -335,  -112,  -335,  -114,  -335,   -65,    11,    60,  -335,   209,
    -335,  -335,  -335,   -51,  -335,  -335,  -335,  -335,  -335,  -335,
    -335,  -335,  -335,     3,  -335,   -64,  -335,   219,   132,  -335,
     -34,     2,   293,   147,  -335,  -335,  -335,     5,  -335,   -55,
    -335,  -185,  -335,   -10,  -105,  -262,  -263,  -335,  -195,  -335,
    -145,  -335,  -335,  -335,  -335,  -335,  -159,   -25,   250,   162,
    -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,  -335,
    -334,  -335,     0
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    37,    38,    39,    40,   103,   104,    85,   133,   134,
     135,   306,   301,   303,   136,   137,   171,   139,   140,   141,
     142,   143,   144,   145,   146,   147,   323,   148,   324,   172,
     325,   173,   269,   174,   336,   150,    86,    87,    70,    71,
      43,    44,   105,    45,    46,    47,    48,    49,   152,    50,
      79,    80,   326,   327,   371,   372,    51,   110,   111,   205,
      72,    64,    53,    65,    55,    56,   194,    66,    58,   281,
     195,   352,   283,   284,   285,   298,   299,   388,   210,   292,
     175,   176,   177,   178,   249,    88,   179,   180,    90,   182,
     183,   414,   184,   397,   398,   185,   186,   187,   188,   399,
     341,   189,   151
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      59,    63,    52,   109,   149,    57,   209,   107,   149,   282,
       1,    41,   217,   291,   244,     1,     1,   154,   149,     1,
     149,   219,   273,   276,     1,   244,     1,   197,    89,   198,
       1,   272,    62,   353,   356,    59,    60,   275,    59,    67,
      52,   278,    59,    57,   202,   401,   202,    74,    89,    41,
      81,   234,   235,   256,   220,   221,   222,    59,   200,    52,
      42,   112,   203,   108,   290,   192,    59,  -186,   115,    78,
    -186,   218,   348,   116,    59,   107,   115,   416,   270,   270,
     353,   356,     1,   149,   394,  -186,  -186,    59,   190,   117,
     349,   196,   248,    82,   271,   334,   209,   217,    42,   217,
     395,   191,   227,    75,    76,    77,   293,   228,   229,    91,
     305,   304,   113,   112,   201,   337,    59,   258,   259,   260,
     261,   262,   263,   264,   265,   266,   267,   230,   231,   275,
     149,   232,   233,    35,    35,   392,   331,   332,   193,   289,
      36,    36,    35,   107,   342,   245,   296,    54,    35,    36,
      61,   286,   114,   383,    69,   287,   218,   335,   294,   118,
     107,   370,   270,   338,   252,   340,   223,   200,   224,  -163,
     225,   374,   236,   237,   375,   270,   190,   155,   270,   377,
     410,   190,   190,   270,   270,    54,   190,   204,   295,    54,
     296,   328,   191,    92,   357,   107,   358,   238,   239,    93,
      94,   240,   112,   402,   106,   241,    95,    96,    97,    98,
      99,   243,   363,   138,   270,   310,   311,   138,   312,   313,
     242,   106,   149,   297,   376,   318,   319,   138,   246,   138,
     200,   355,   212,   214,   215,   216,   209,   247,   268,   250,
     253,   100,   101,   102,   107,   251,   254,   343,   257,   277,
     304,   279,   407,   408,   409,   280,   314,   315,   316,   317,
     300,   329,   330,   339,   400,   340,   345,   333,   417,   346,
     350,   328,   226,   419,   190,   107,   361,   200,   362,   378,
     413,    59,   379,   270,   149,   384,   344,   347,   385,   386,
     387,   107,   138,   390,   373,   107,   149,   340,   403,   396,
     297,   360,   411,   415,   412,   393,   364,    68,    63,   418,
     199,   119,     1,   391,   120,   121,   122,   123,   404,   124,
     125,   320,   149,   366,   321,   207,   322,   365,    59,   369,
     405,   406,   206,   367,   288,    73,   381,   107,   181,   138,
       0,     0,    59,   274,    59,     0,   115,   344,     0,     1,
       0,   120,   121,   122,   123,     0,   124,   125,     0,     0,
     373,     0,   307,   308,   309,   138,   138,   138,   138,   138,
     138,   138,   138,   138,   138,   138,   138,   138,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    59,     0,     0,   190,   190,   190,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   190,     0,     0,     0,     0,   190,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     126,   138,     0,     0,     0,   359,   127,   128,   129,   130,
     131,   132,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   208,   382,     0,     0,     0,     0,   138,   138,
     138,     1,     0,   120,   121,   122,   123,   126,   124,   125,
     153,     0,     0,   127,   128,   129,   130,   131,   132,    83,
       0,     1,     2,   120,   121,   122,   123,     0,   124,   125,
       0,     0,     0,   138,     0,     0,     0,     0,     0,     1,
       0,   120,   121,   122,   123,   138,   124,   125,     3,     4,
       5,     6,     7,     8,     9,     0,    10,    11,    12,     0,
      13,     0,     0,    14,    15,    16,    17,   138,   156,     0,
       0,   138,     0,    18,    19,    20,    21,    22,    23,    24,
       0,    25,    26,    27,    28,    29,    30,    31,    32,     0,
       0,   157,   158,   159,     0,   160,   161,   162,   163,   164,
     165,   166,   167,    83,     0,     1,   168,   120,   121,   122,
     123,     0,   124,   125,     0,     0,     0,     0,     0,   126,
       0,     0,     0,     0,     0,   127,   128,   129,   130,   131,
     132,     0,     0,     0,     0,     0,     0,    33,    34,   126,
       0,   208,     0,     0,     0,   127,   128,   129,   130,   131,
     132,     0,   156,     0,     0,     0,     0,   126,     0,     0,
     169,    84,   170,   127,   128,   129,   130,   131,   132,     0,
       0,     0,     0,     0,     0,   157,   158,   159,   255,   160,
     161,   162,   163,   164,   165,   166,   167,     0,     0,     1,
     168,   120,   121,   122,   123,     0,   124,   125,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    83,     0,
       0,     2,     0,   126,     0,     0,     0,     0,     0,   127,
     128,   129,   130,   131,   132,     0,     0,     0,     0,     0,
       0,     0,     0,     0,   169,    84,   170,     3,     4,     5,
       6,     7,     8,     9,     0,    10,    11,    12,     0,    13,
       0,     0,    14,    15,    16,    17,     0,     0,     0,     0,
       0,     0,    18,    19,    20,    21,    22,    23,    24,     0,
      25,    26,    27,    28,    29,    30,    31,    32,     2,    83,
       0,     1,     0,   120,   121,   122,   123,     0,   124,   125,
       0,     0,     0,     0,     0,     0,     0,   126,   302,     0,
       0,     0,     0,   127,   128,   129,   130,   131,   132,     8,
       9,     0,    10,    11,    12,     0,    13,     0,     0,    14,
      15,    16,    17,     0,     0,     0,    33,    34,   156,    18,
      19,    20,    21,    22,    23,    24,     0,    25,    26,    27,
      28,    29,    30,    31,    32,     0,     0,     0,     0,     0,
      84,   157,   158,   159,     0,   160,   161,   162,   163,   164,
     165,   166,   167,     0,     0,     1,   168,   120,   121,   122,
     123,     0,   124,   125,     0,     0,     0,     0,     0,     0,
       1,     2,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    34,     0,     0,     0,     0,   126,
       0,     0,     0,     0,     0,   127,   128,   129,   130,   131,
     132,     0,     8,     9,     0,    10,    11,    12,   368,    13,
     169,    84,    14,    15,    16,    17,     0,     0,     0,     0,
       0,     0,    18,    19,    20,    21,    22,    23,    24,     0,
      25,    26,    27,    28,    29,    30,    31,    32,     1,     0,
     120,   121,   122,   123,     0,   124,   125,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     1,     2,   120,
     121,   122,   123,     0,   124,   125,     0,     0,     0,     0,
       0,     0,     0,   126,     0,     0,   354,     0,     0,   127,
     128,   129,   130,   131,   132,     0,     0,    34,    35,     8,
       9,     0,    10,    11,    12,    36,    13,     0,     0,    14,
      15,    16,    17,     0,     0,     0,     0,   370,     0,    18,
      19,    20,    21,    22,    23,    24,     0,    25,    26,    27,
      28,    29,    30,    31,    32,     1,     0,   120,   121,   122,
     123,     0,   124,   125,     0,     0,     0,     1,     0,   120,
     121,   122,   123,     0,   124,   125,     0,     0,     0,     0,
       1,     0,   120,   121,   122,   123,   126,   124,   125,   389,
       0,     0,   127,   128,   129,   130,   131,   132,     1,     2,
       0,     0,     0,     0,    34,   126,     0,     0,     0,     0,
       0,   127,   128,   129,   130,   131,   132,     0,     0,     0,
       0,     0,     0,     0,     0,     3,     4,     5,     6,     7,
       8,     9,     0,    10,    11,    12,     0,    13,     0,     0,
      14,    15,    16,    17,     0,     0,     0,     0,     0,     0,
      18,    19,    20,    21,    22,    23,    24,     0,    25,    26,
      27,    28,    29,    30,    31,    32,     0,     0,     0,     0,
       0,     0,     0,   126,     0,     0,     0,     0,     0,   127,
     128,   129,   130,   131,   132,   211,     0,     0,     0,     1,
       2,   127,   128,   129,   130,   131,   132,     0,   213,     0,
       0,     0,     0,     0,   127,   128,   129,   130,   131,   132,
       0,     0,     0,     0,    33,    34,    35,     0,     0,     0,
       0,     8,     9,    36,    10,    11,    12,     0,    13,     1,
       2,    14,    15,    16,    17,     0,     0,     0,     0,     0,
       0,    18,    19,    20,    21,    22,    23,    24,     0,    25,
      26,    27,    28,    29,    30,    31,    32,     0,     0,     0,
       0,     8,     9,     0,    10,    11,    12,     0,    13,     0,
       0,    14,    15,    16,    17,     0,     0,     0,     0,     0,
       0,    18,    19,    20,    21,    22,    23,    24,     0,    25,
      26,    27,    28,    29,    30,    31,    32,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    34,   342,   351,   296,
       0,     0,     0,     0,    36,     0,     0,     0,     0,     0,
       0,     2,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    34,   342,     0,   296,
       0,     0,     8,     9,    36,    10,    11,    12,     2,    13,
       0,     0,    14,    15,    16,    17,     0,     0,     0,     0,
       0,     0,    18,    19,    20,    21,    22,    23,    24,     0,
      25,    26,    27,    28,    29,    30,    31,    32,     0,     8,
       9,     0,    10,    11,    12,     0,    13,     0,     0,    14,
      15,    16,    17,     0,     0,     0,     0,     0,     0,    18,
      19,    20,    21,    22,    23,    24,     0,    25,    26,    27,
      28,    29,    30,    31,    32,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    34,   295,   351,
     296,     0,     0,     0,     0,    36,     0,     0,     0,     2,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    34,   295,     0,   296,     0,     0,
       8,     9,    36,    10,    11,    12,     0,    13,     0,     0,
      14,    15,    16,    17,     2,     0,     0,     0,     0,     0,
      18,    19,    20,    21,    22,    23,    24,     0,    25,    26,
      27,    28,    29,    30,    31,    32,     0,     0,     0,     0,
       3,     4,     5,     6,     7,     8,     9,     0,    10,    11,
      12,     0,    13,     0,     0,    14,    15,    16,    17,     0,
       2,     0,     0,     0,     0,    18,    19,    20,    21,    22,
      23,    24,     0,    25,    26,    27,    28,    29,    30,    31,
      32,     0,     0,     0,     0,    34,     0,     0,     0,     0,
       0,     8,     9,    36,    10,    11,    12,     0,    13,     0,
       2,    14,    15,    16,    17,   380,     0,     0,     0,     0,
       0,    18,    19,    20,    21,    22,    23,    24,     0,    25,
      26,    27,    28,    29,    30,    31,    32,     0,     0,    33,
      34,     8,     9,     0,    10,    11,    12,     0,    13,     0,
       0,    14,    15,    16,    17,     0,     0,     0,     0,     0,
       0,    18,    19,    20,    21,    22,    23,    24,     0,    25,
      26,    27,    28,    29,    30,    31,    32,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    34,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    34
};

static const yytype_int16 yycheck[] =
{
       0,    35,     0,    58,    78,     0,   118,    58,    82,   194,
       3,     0,   126,   208,    19,     3,     3,    82,    92,     3,
      94,   126,   181,   182,     3,    19,     3,    92,    53,    94,
       3,   176,    32,   295,   297,    35,    52,   182,    38,     0,
      38,   186,    42,    38,   126,   379,   126,    42,    73,    38,
      50,    14,    15,   167,     9,    10,    11,    57,   109,    57,
       0,    61,   144,    58,   144,    90,    66,   123,    66,    41,
     126,   126,   126,   126,    74,   126,    74,   411,   126,   126,
     342,   344,     3,   157,   126,   141,   142,    87,    88,   142,
     144,    91,   157,   123,   142,   142,   208,   211,    38,   213,
     142,    90,   128,    43,    44,    45,   211,   133,   134,   121,
     224,   223,   143,   113,   109,   274,   116,    20,    21,    22,
      23,    24,    25,    26,    27,    28,    29,   129,   130,   274,
     204,    12,    13,   121,   121,   140,   250,   251,   122,   204,
     128,   128,   121,   194,   121,   139,   123,     0,   121,   128,
     143,   122,   122,   348,   142,   126,   211,   269,   122,   141,
     211,   140,   126,   277,   164,   279,   121,   218,   123,   143,
     125,   122,   135,   136,   122,   126,   176,   142,   126,   122,
     122,   181,   182,   126,   126,    38,   186,   141,   121,    42,
     123,   246,   181,    37,   121,   246,   123,    16,    17,    43,
      44,   127,   202,   388,    57,   137,    50,    51,    52,    53,
      54,    18,   124,    78,   126,   230,   231,    82,   232,   233,
     138,    74,   296,   218,   336,   238,   239,    92,   143,    94,
     281,   296,   122,   123,   124,   125,   348,   124,   141,   121,
     142,    85,    86,    87,   295,   121,   142,   281,   142,   121,
     362,   121,   397,   398,   399,   140,   234,   235,   236,   237,
     122,   140,   140,    78,   378,   379,   122,   142,   413,   126,
     122,   326,   137,   418,   274,   326,   122,   328,   126,   121,
      76,   281,   142,   126,   358,   122,   281,   287,   122,   124,
     122,   342,   157,   358,   328,   346,   370,   411,   124,   140,
     295,   301,   142,   142,   122,   370,   306,    38,   342,   122,
     104,    73,     3,   362,     5,     6,     7,     8,   392,    10,
      11,   240,   396,   324,   241,   116,   242,   323,   328,   326,
     394,   396,   113,   325,   202,    42,   346,   388,    88,   204,
      -1,    -1,   342,   181,   344,    -1,   344,   342,    -1,     3,
      -1,     5,     6,     7,     8,    -1,    10,    11,    -1,    -1,
     394,    -1,   227,   228,   229,   230,   231,   232,   233,   234,
     235,   236,   237,   238,   239,   240,   241,   242,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,   394,    -1,    -1,   397,   398,   399,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,   413,    -1,    -1,    -1,    -1,   418,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
     121,   296,    -1,    -1,    -1,   300,   127,   128,   129,   130,
     131,   132,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,   143,   144,    -1,    -1,    -1,    -1,   323,   324,
     325,     3,    -1,     5,     6,     7,     8,   121,    10,    11,
     124,    -1,    -1,   127,   128,   129,   130,   131,   132,     1,
      -1,     3,     4,     5,     6,     7,     8,    -1,    10,    11,
      -1,    -1,    -1,   358,    -1,    -1,    -1,    -1,    -1,     3,
      -1,     5,     6,     7,     8,   370,    10,    11,    30,    31,
      32,    33,    34,    35,    36,    -1,    38,    39,    40,    -1,
      42,    -1,    -1,    45,    46,    47,    48,   392,    50,    -1,
      -1,   396,    -1,    55,    56,    57,    58,    59,    60,    61,
      -1,    63,    64,    65,    66,    67,    68,    69,    70,    -1,
      -1,    73,    74,    75,    -1,    77,    78,    79,    80,    81,
      82,    83,    84,     1,    -1,     3,    88,     5,     6,     7,
       8,    -1,    10,    11,    -1,    -1,    -1,    -1,    -1,   121,
      -1,    -1,    -1,    -1,    -1,   127,   128,   129,   130,   131,
     132,    -1,    -1,    -1,    -1,    -1,    -1,   119,   120,   121,
      -1,   143,    -1,    -1,    -1,   127,   128,   129,   130,   131,
     132,    -1,    50,    -1,    -1,    -1,    -1,   121,    -1,    -1,
     142,   143,   144,   127,   128,   129,   130,   131,   132,    -1,
      -1,    -1,    -1,    -1,    -1,    73,    74,    75,   142,    77,
      78,    79,    80,    81,    82,    83,    84,    -1,    -1,     3,
      88,     5,     6,     7,     8,    -1,    10,    11,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,     1,    -1,
      -1,     4,    -1,   121,    -1,    -1,    -1,    -1,    -1,   127,
     128,   129,   130,   131,   132,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,   142,   143,   144,    30,    31,    32,
      33,    34,    35,    36,    -1,    38,    39,    40,    -1,    42,
      -1,    -1,    45,    46,    47,    48,    -1,    -1,    -1,    -1,
      -1,    -1,    55,    56,    57,    58,    59,    60,    61,    -1,
      63,    64,    65,    66,    67,    68,    69,    70,     4,     1,
      -1,     3,    -1,     5,     6,     7,     8,    -1,    10,    11,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,   121,   122,    -1,
      -1,    -1,    -1,   127,   128,   129,   130,   131,   132,    35,
      36,    -1,    38,    39,    40,    -1,    42,    -1,    -1,    45,
      46,    47,    48,    -1,    -1,    -1,   119,   120,    50,    55,
      56,    57,    58,    59,    60,    61,    -1,    63,    64,    65,
      66,    67,    68,    69,    70,    -1,    -1,    -1,    -1,    -1,
     143,    73,    74,    75,    -1,    77,    78,    79,    80,    81,
      82,    83,    84,    -1,    -1,     3,    88,     5,     6,     7,
       8,    -1,    10,    11,    -1,    -1,    -1,    -1,    -1,    -1,
       3,     4,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,   120,    -1,    -1,    -1,    -1,   121,
      -1,    -1,    -1,    -1,    -1,   127,   128,   129,   130,   131,
     132,    -1,    35,    36,    -1,    38,    39,    40,   144,    42,
     142,   143,    45,    46,    47,    48,    -1,    -1,    -1,    -1,
      -1,    -1,    55,    56,    57,    58,    59,    60,    61,    -1,
      63,    64,    65,    66,    67,    68,    69,    70,     3,    -1,
       5,     6,     7,     8,    -1,    10,    11,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,     3,     4,     5,
       6,     7,     8,    -1,    10,    11,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,   121,    -1,    -1,   124,    -1,    -1,   127,
     128,   129,   130,   131,   132,    -1,    -1,   120,   121,    35,
      36,    -1,    38,    39,    40,   128,    42,    -1,    -1,    45,
      46,    47,    48,    -1,    -1,    -1,    -1,   140,    -1,    55,
      56,    57,    58,    59,    60,    61,    -1,    63,    64,    65,
      66,    67,    68,    69,    70,     3,    -1,     5,     6,     7,
       8,    -1,    10,    11,    -1,    -1,    -1,     3,    -1,     5,
       6,     7,     8,    -1,    10,    11,    -1,    -1,    -1,    -1,
       3,    -1,     5,     6,     7,     8,   121,    10,    11,   124,
      -1,    -1,   127,   128,   129,   130,   131,   132,     3,     4,
      -1,    -1,    -1,    -1,   120,   121,    -1,    -1,    -1,    -1,
      -1,   127,   128,   129,   130,   131,   132,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    30,    31,    32,    33,    34,
      35,    36,    -1,    38,    39,    40,    -1,    42,    -1,    -1,
      45,    46,    47,    48,    -1,    -1,    -1,    -1,    -1,    -1,
      55,    56,    57,    58,    59,    60,    61,    -1,    63,    64,
      65,    66,    67,    68,    69,    70,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,   121,    -1,    -1,    -1,    -1,    -1,   127,
     128,   129,   130,   131,   132,   121,    -1,    -1,    -1,     3,
       4,   127,   128,   129,   130,   131,   132,    -1,   121,    -1,
      -1,    -1,    -1,    -1,   127,   128,   129,   130,   131,   132,
      -1,    -1,    -1,    -1,   119,   120,   121,    -1,    -1,    -1,
      -1,    35,    36,   128,    38,    39,    40,    -1,    42,     3,
       4,    45,    46,    47,    48,    -1,    -1,    -1,    -1,    -1,
      -1,    55,    56,    57,    58,    59,    60,    61,    -1,    63,
      64,    65,    66,    67,    68,    69,    70,    -1,    -1,    -1,
      -1,    35,    36,    -1,    38,    39,    40,    -1,    42,    -1,
      -1,    45,    46,    47,    48,    -1,    -1,    -1,    -1,    -1,
      -1,    55,    56,    57,    58,    59,    60,    61,    -1,    63,
      64,    65,    66,    67,    68,    69,    70,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,   120,   121,   122,   123,
      -1,    -1,    -1,    -1,   128,    -1,    -1,    -1,    -1,    -1,
      -1,     4,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,   120,   121,    -1,   123,
      -1,    -1,    35,    36,   128,    38,    39,    40,     4,    42,
      -1,    -1,    45,    46,    47,    48,    -1,    -1,    -1,    -1,
      -1,    -1,    55,    56,    57,    58,    59,    60,    61,    -1,
      63,    64,    65,    66,    67,    68,    69,    70,    -1,    35,
      36,    -1,    38,    39,    40,    -1,    42,    -1,    -1,    45,
      46,    47,    48,    -1,    -1,    -1,    -1,    -1,    -1,    55,
      56,    57,    58,    59,    60,    61,    -1,    63,    64,    65,
      66,    67,    68,    69,    70,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,   120,   121,   122,
     123,    -1,    -1,    -1,    -1,   128,    -1,    -1,    -1,     4,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,   120,   121,    -1,   123,    -1,    -1,
      35,    36,   128,    38,    39,    40,    -1,    42,    -1,    -1,
      45,    46,    47,    48,     4,    -1,    -1,    -1,    -1,    -1,
      55,    56,    57,    58,    59,    60,    61,    -1,    63,    64,
      65,    66,    67,    68,    69,    70,    -1,    -1,    -1,    -1,
      30,    31,    32,    33,    34,    35,    36,    -1,    38,    39,
      40,    -1,    42,    -1,    -1,    45,    46,    47,    48,    -1,
       4,    -1,    -1,    -1,    -1,    55,    56,    57,    58,    59,
      60,    61,    -1,    63,    64,    65,    66,    67,    68,    69,
      70,    -1,    -1,    -1,    -1,   120,    -1,    -1,    -1,    -1,
      -1,    35,    36,   128,    38,    39,    40,    -1,    42,    -1,
       4,    45,    46,    47,    48,    49,    -1,    -1,    -1,    -1,
      -1,    55,    56,    57,    58,    59,    60,    61,    -1,    63,
      64,    65,    66,    67,    68,    69,    70,    -1,    -1,   119,
     120,    35,    36,    -1,    38,    39,    40,    -1,    42,    -1,
      -1,    45,    46,    47,    48,    -1,    -1,    -1,    -1,    -1,
      -1,    55,    56,    57,    58,    59,    60,    61,    -1,    63,
      64,    65,    66,    67,    68,    69,    70,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,   120,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,   120
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     4,    30,    31,    32,    33,    34,    35,    36,
      38,    39,    40,    42,    45,    46,    47,    48,    55,    56,
      57,    58,    59,    60,    61,    63,    64,    65,    66,    67,
      68,    69,    70,   119,   120,   121,   128,   146,   147,   148,
     149,   181,   182,   185,   186,   188,   189,   190,   191,   192,
     194,   201,   206,   207,   208,   209,   210,   212,   213,   247,
      52,   143,   247,   205,   206,   208,   212,     0,   148,   142,
     183,   184,   205,   207,   212,   182,   182,   182,    41,   195,
     196,   247,   123,     1,   143,   152,   181,   182,   230,   232,
     233,   121,    37,    43,    44,    50,    51,    52,    53,    54,
      85,    86,    87,   150,   151,   187,   208,   188,   212,   214,
     202,   203,   247,   143,   122,   206,   126,   142,   141,   152,
       5,     6,     7,     8,    10,    11,   121,   127,   128,   129,
     130,   131,   132,   153,   154,   155,   159,   160,   161,   162,
     163,   164,   165,   166,   167,   168,   169,   170,   172,   174,
     180,   247,   193,   124,   180,   142,    50,    73,    74,    75,
      77,    78,    79,    80,    81,    82,    83,    84,    88,   142,
     144,   161,   174,   176,   178,   225,   226,   227,   228,   231,
     232,   233,   234,   235,   237,   240,   241,   242,   243,   246,
     247,   181,   232,   122,   211,   215,   247,   180,   180,   150,
     188,   212,   126,   144,   141,   204,   202,   184,   143,   176,
     223,   121,   159,   121,   159,   159,   159,   178,   214,   219,
       9,    10,    11,   121,   123,   125,   161,   128,   133,   134,
     129,   130,    12,    13,    14,    15,   135,   136,    16,    17,
     127,   137,   138,    18,    19,   139,   143,   124,   180,   229,
     121,   121,   247,   142,   142,   142,   178,   142,    20,    21,
      22,    23,    24,    25,    26,    27,    28,    29,   141,   177,
     126,   142,   225,   231,   234,   225,   231,   121,   225,   121,
     140,   214,   216,   217,   218,   219,   122,   126,   203,   180,
     144,   223,   224,   219,   122,   121,   123,   212,   220,   221,
     122,   157,   122,   158,   176,   178,   156,   161,   161,   161,
     162,   162,   163,   163,   164,   164,   164,   164,   165,   165,
     166,   167,   168,   171,   173,   175,   197,   198,   214,   140,
     140,   178,   178,   142,   142,   176,   179,   231,   178,    78,
     178,   245,   121,   205,   212,   122,   126,   247,   126,   144,
     122,   122,   216,   220,   124,   180,   221,   121,   123,   161,
     247,   122,   126,   124,   247,   169,   170,   172,   144,   198,
     140,   199,   200,   205,   122,   122,   176,   122,   121,   142,
      49,   218,   144,   223,   122,   122,   124,   122,   222,   124,
     180,   158,   140,   180,   126,   142,   140,   238,   239,   244,
     178,   245,   216,   124,   174,   200,   180,   225,   225,   225,
     122,   142,   122,    76,   236,   142,   245,   225,   122,   225
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,   145,   146,   146,   147,   147,   148,   148,   149,   149,
     150,   150,   151,   151,   151,   151,   151,   151,   151,   151,
     151,   151,   151,   152,   152,   153,   153,   153,   153,   154,
     155,   155,   155,   155,   156,   155,   157,   155,   155,   155,
     158,   158,   159,   159,   159,   159,   159,   159,   159,   160,
     160,   160,   160,   160,   160,   161,   161,   162,   162,   162,
     162,   163,   163,   163,   164,   164,   164,   165,   165,   165,
     165,   165,   166,   166,   166,   167,   167,   168,   168,   169,
     169,   170,   171,   170,   172,   173,   172,   174,   175,   174,
     176,   176,   177,   177,   177,   177,   177,   177,   177,   177,
     177,   177,   177,   178,   179,   178,   180,   181,   181,   182,
     182,   182,   182,   182,   182,   183,   183,   184,   184,   185,
     185,   185,   185,   185,   186,   187,   187,   188,   188,   189,
     189,   189,   189,   189,   189,   189,   189,   189,   189,   189,
     189,   189,   189,   189,   189,   189,   189,   189,   189,   189,
     189,   189,   190,   190,   191,   191,   191,   191,   193,   192,
     192,   194,   194,   195,   195,   196,   197,   197,   198,   199,
     199,   200,   200,   200,   200,   201,   201,   201,   202,   202,
     202,   203,   204,   204,   205,   205,   206,   206,   207,   207,
     208,   208,   209,   209,   209,   209,   210,   211,   210,   210,
     212,   212,   212,   212,   213,   214,   214,   215,   215,   216,
     216,   217,   217,   218,   218,   219,   219,   220,   220,   220,
     221,   221,   221,   221,   221,   221,   221,   221,   222,   221,
     223,   223,   223,   224,   224,   225,   225,   225,   225,   225,
     225,   225,   225,   226,   227,   228,   228,   229,   228,   230,
     231,   232,   232,   232,   232,   232,   233,   233,   234,   234,
     235,   235,   236,   236,   238,   237,   239,   237,   240,   241,
     242,   244,   243,   243,   243,   245,   245,   246,   246,   246,
     246,   246,   247
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     1,     1,     2,     1,     1,     2,     3,
       1,     2,     2,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     2,     1,     1,     1,     3,     1,
       1,     4,     3,     4,     0,     4,     0,     4,     2,     2,
       1,     3,     1,     2,     2,     2,     2,     4,     2,     1,
       1,     1,     1,     1,     1,     1,     4,     1,     3,     3,
       3,     1,     3,     3,     1,     3,     3,     1,     3,     3,
       3,     3,     1,     3,     3,     1,     3,     1,     3,     1,
       3,     1,     0,     4,     1,     0,     4,     1,     0,     6,
       1,     3,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     0,     4,     1,     2,     3,     1,
       2,     1,     2,     1,     2,     1,     3,     1,     3,     1,
       1,     1,     1,     1,     1,     1,     2,     1,     3,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     2,     1,     1,     0,     6,
       2,     1,     1,     1,     0,     1,     1,     2,     3,     1,
       3,     1,     2,     3,     0,     4,     5,     2,     1,     2,
       3,     2,     2,     0,     1,     2,     1,     1,     1,     2,
       1,     2,     1,     3,     3,     4,     3,     0,     5,     4,
       1,     2,     2,     3,     1,     1,     2,     1,     3,     1,
       3,     1,     3,     2,     1,     1,     2,     1,     1,     2,
       3,     2,     3,     3,     4,     2,     3,     3,     0,     5,
       1,     3,     4,     1,     3,     1,     1,     1,     1,     1,
       1,     1,     2,     1,     2,     2,     3,     0,     3,     1,
       1,     2,     3,     3,     4,     2,     1,     2,     1,     2,
       1,     2,     2,     0,     0,     7,     0,     6,     1,     1,
       1,     0,     6,     7,     9,     0,     1,     3,     2,     2,
       2,     3,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 137 "SDCC.y" /* yacc.c:1646  */
    { if (!options.lessPedantic)
                    werror(W_EMPTY_SOURCE_FILE);
        }
#line 2112 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 6:
#line 149 "SDCC.y" /* yacc.c:1646  */
    {
                               blockNo=0;
                             }
#line 2120 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 7:
#line 152 "SDCC.y" /* yacc.c:1646  */
    {
                               ignoreTypedefType = 0;
                               if ((yyvsp[0].sym) && (yyvsp[0].sym)->type
                                && IS_FUNC((yyvsp[0].sym)->type))
                               {
                                   /* The only legal storage classes for
                                    * a function prototype (declaration)
                                    * are extern and static. extern is the
                                    * default. Thus, if this function isn't
                                    * explicitly marked static, mark it
                                    * extern.
                                    */
                                   if ((yyvsp[0].sym)->etype
                                    && IS_SPEC((yyvsp[0].sym)->etype)
                                    && !SPEC_STAT((yyvsp[0].sym)->etype))
                                   {
                                        SPEC_EXTR((yyvsp[0].sym)->etype) = 1;
                                   }
                               }
                               addSymChain (&(yyvsp[0].sym));
                               allocVariables ((yyvsp[0].sym)) ;
                               cleanUpLevel (SymbolTab,1);
                             }
#line 2148 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 8:
#line 178 "SDCC.y" /* yacc.c:1646  */
    {   /* function type not specified */
                                   /* assume it to be 'int'       */
                                   addDecl((yyvsp[-1].sym),0,newIntLink());
                                   (yyval.asts) = createFunction((yyvsp[-1].sym),(yyvsp[0].asts));
                               }
#line 2158 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 9:
#line 184 "SDCC.y" /* yacc.c:1646  */
    {
                                    pointerTypes((yyvsp[-1].sym)->type,copyLinkChain((yyvsp[-2].lnk)));
                                    if (options.unsigned_char && SPEC_NOUN((yyvsp[-2].lnk)) == V_CHAR && !((yyvsp[-2].lnk))->select.s.b_signed)
                                      SPEC_USIGN((yyvsp[-2].lnk)) = 1;
                                    addDecl((yyvsp[-1].sym),0,(yyvsp[-2].lnk));
                                    (yyval.asts) = createFunction((yyvsp[-1].sym),(yyvsp[0].asts));
                                }
#line 2170 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 11:
#line 195 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = mergeSpec((yyvsp[-1].lnk),(yyvsp[0].lnk),"function_attribute"); }
#line 2176 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 12:
#line 199 "SDCC.y" /* yacc.c:1646  */
    {
                        (yyval.lnk) = newLink(SPECIFIER) ;
                        FUNC_REGBANK((yyval.lnk)) = (int) ulFromVal(constExprValue((yyvsp[0].asts),TRUE));
                     }
#line 2185 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 13:
#line 203 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.lnk) = newLink (SPECIFIER);
                        FUNC_ISREENT((yyval.lnk))=1;
                     }
#line 2193 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 14:
#line 206 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.lnk) = newLink (SPECIFIER);
                        FUNC_ISCRITICAL((yyval.lnk)) = 1;
                     }
#line 2201 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 15:
#line 209 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.lnk) = newLink (SPECIFIER);
                        FUNC_ISNAKED((yyval.lnk))=1;
                     }
#line 2209 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 16:
#line 212 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.lnk) = newLink (SPECIFIER);
                        FUNC_ISJAVANATIVE((yyval.lnk))=1;
                     }
#line 2217 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 17:
#line 215 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.lnk) = newLink (SPECIFIER);
                        FUNC_ISOVERLAY((yyval.lnk))=1;
                     }
#line 2225 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 18:
#line 218 "SDCC.y" /* yacc.c:1646  */
    {(yyval.lnk) = newLink (SPECIFIER);
                        FUNC_NONBANKED((yyval.lnk)) = 1;
                        if (FUNC_BANKED((yyval.lnk))) {
                            werror(W_BANKED_WITH_NONBANKED);
                        }
                     }
#line 2236 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 19:
#line 224 "SDCC.y" /* yacc.c:1646  */
    {(yyval.lnk) = newLink (SPECIFIER);
                        FUNC_ISSHADOWREGS((yyval.lnk)) = 1;
                     }
#line 2244 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 20:
#line 227 "SDCC.y" /* yacc.c:1646  */
    {(yyval.lnk) = newLink (SPECIFIER);
                        FUNC_ISWPARAM((yyval.lnk)) = 1;
                     }
#line 2252 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 21:
#line 230 "SDCC.y" /* yacc.c:1646  */
    {(yyval.lnk) = newLink (SPECIFIER);
                        FUNC_BANKED((yyval.lnk)) = 1;
                        if (FUNC_NONBANKED((yyval.lnk))) {
                            werror(W_BANKED_WITH_NONBANKED);
                        }
                        if (SPEC_STAT((yyval.lnk))) {
                            werror(W_BANKED_WITH_STATIC);
                        }
                     }
#line 2266 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 22:
#line 240 "SDCC.y" /* yacc.c:1646  */
    {
                        (yyval.lnk) = newLink (SPECIFIER) ;
                        FUNC_INTNO((yyval.lnk)) = (yyvsp[0].yyint) ;
                        FUNC_ISISR((yyval.lnk)) = 1;
                     }
#line 2276 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 24:
#line 250 "SDCC.y" /* yacc.c:1646  */
    {
            werror(E_OLD_STYLE,((yyvsp[-1].sym) ? (yyvsp[-1].sym)->name: "")) ;
            exit(1);
         }
#line 2285 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 25:
#line 257 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.asts) = newAst_VALUE(symbolVal((yyvsp[0].sym)));  }
#line 2291 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 26:
#line 258 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.asts) = newAst_VALUE((yyvsp[0].val));  }
#line 2297 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 28:
#line 260 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.asts) = (yyvsp[-1].asts) ;                   }
#line 2303 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 29:
#line 264 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newAst_VALUE((yyvsp[0].val)); }
#line 2309 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 31:
#line 269 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode  ('[', (yyvsp[-3].asts), (yyvsp[-1].asts)) ; }
#line 2315 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 32:
#line 270 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode  (CALL,(yyvsp[-2].asts),NULL);
                                          (yyval.asts)->left->funcName = 1;}
#line 2322 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 33:
#line 273 "SDCC.y" /* yacc.c:1646  */
    {
            (yyval.asts) = newNode  (CALL,(yyvsp[-3].asts),(yyvsp[-1].asts)) ; (yyval.asts)->left->funcName = 1;
          }
#line 2330 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 34:
#line 276 "SDCC.y" /* yacc.c:1646  */
    { ignoreTypedefType = 1; }
#line 2336 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 35:
#line 277 "SDCC.y" /* yacc.c:1646  */
    {
                        ignoreTypedefType = 0;
                        (yyvsp[0].sym) = newSymbol((yyvsp[0].sym)->name,NestLevel);
                        (yyvsp[0].sym)->implicit = 1;
                        (yyval.asts) = newNode(PTR_OP,newNode('&',(yyvsp[-3].asts),NULL),newAst_VALUE(symbolVal((yyvsp[0].sym))));
/*                      $$ = newNode('.',$1,newAst(EX_VALUE,symbolVal($4))) ;                   */
                      }
#line 2348 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 36:
#line 284 "SDCC.y" /* yacc.c:1646  */
    { ignoreTypedefType = 1; }
#line 2354 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 37:
#line 285 "SDCC.y" /* yacc.c:1646  */
    {
                        ignoreTypedefType = 0;
                        (yyvsp[0].sym) = newSymbol((yyvsp[0].sym)->name,NestLevel);
                        (yyvsp[0].sym)->implicit = 1;
                        (yyval.asts) = newNode(PTR_OP,(yyvsp[-3].asts),newAst_VALUE(symbolVal((yyvsp[0].sym))));
                      }
#line 2365 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 38:
#line 292 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(INC_OP,(yyvsp[-1].asts),NULL);}
#line 2371 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 39:
#line 294 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(DEC_OP,(yyvsp[-1].asts),NULL); }
#line 2377 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 41:
#line 299 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(PARAM,(yyvsp[-2].asts),(yyvsp[0].asts)); }
#line 2383 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 43:
#line 304 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(INC_OP,NULL,(yyvsp[0].asts));  }
#line 2389 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 44:
#line 305 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(DEC_OP,NULL,(yyvsp[0].asts));  }
#line 2395 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 45:
#line 306 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode((yyvsp[-1].yyint),(yyvsp[0].asts),NULL)    ;  }
#line 2401 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 46:
#line 307 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(SIZEOF,NULL,(yyvsp[0].asts));  }
#line 2407 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 47:
#line 308 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newAst_VALUE(sizeofOp((yyvsp[-1].lnk))); }
#line 2413 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 48:
#line 309 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(TYPEOF,NULL,(yyvsp[0].asts));  }
#line 2419 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 49:
#line 313 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = '&' ;}
#line 2425 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 50:
#line 314 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = '*' ;}
#line 2431 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 51:
#line 315 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = '+' ;}
#line 2437 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 52:
#line 316 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = '-' ;}
#line 2443 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 53:
#line 317 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = '~' ;}
#line 2449 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 54:
#line 318 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = '!' ;}
#line 2455 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 56:
#line 323 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(CAST,newAst_LINK((yyvsp[-2].lnk)),(yyvsp[0].asts)); }
#line 2461 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 58:
#line 328 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode('*',(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2467 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 59:
#line 329 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode('/',(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2473 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 60:
#line 330 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode('%',(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2479 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 62:
#line 335 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts)=newNode('+',(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2485 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 63:
#line 336 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts)=newNode('-',(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2491 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 65:
#line 341 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(LEFT_OP,(yyvsp[-2].asts),(yyvsp[0].asts)); }
#line 2497 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 66:
#line 342 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(RIGHT_OP,(yyvsp[-2].asts),(yyvsp[0].asts)); }
#line 2503 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 68:
#line 347 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode('<',  (yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2509 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 69:
#line 348 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode('>',  (yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2515 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 70:
#line 349 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(LE_OP,(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2521 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 71:
#line 350 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(GE_OP,(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2527 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 73:
#line 355 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(EQ_OP,(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2533 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 74:
#line 356 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(NE_OP,(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2539 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 76:
#line 361 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode('&',(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2545 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 78:
#line 366 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode('^',(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2551 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 80:
#line 371 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode('|',(yyvsp[-2].asts),(yyvsp[0].asts));}
#line 2557 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 82:
#line 376 "SDCC.y" /* yacc.c:1646  */
    { seqPointNo++;}
#line 2563 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 83:
#line 377 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(AND_OP,(yyvsp[-3].asts),(yyvsp[0].asts));}
#line 2569 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 85:
#line 382 "SDCC.y" /* yacc.c:1646  */
    { seqPointNo++;}
#line 2575 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 86:
#line 383 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(OR_OP,(yyvsp[-3].asts),(yyvsp[0].asts)); }
#line 2581 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 88:
#line 388 "SDCC.y" /* yacc.c:1646  */
    { seqPointNo++;}
#line 2587 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 89:
#line 389 "SDCC.y" /* yacc.c:1646  */
    {
                        (yyval.asts) = newNode(':',(yyvsp[-2].asts),(yyvsp[0].asts)) ;
                        (yyval.asts) = newNode('?',(yyvsp[-5].asts),(yyval.asts)) ;
                     }
#line 2596 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 91:
#line 398 "SDCC.y" /* yacc.c:1646  */
    {

                             switch ((yyvsp[-1].yyint)) {
                             case '=':
                                     (yyval.asts) = newNode((yyvsp[-1].yyint),(yyvsp[-2].asts),(yyvsp[0].asts));
                                     break;
                             case MUL_ASSIGN:
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), '*', (yyvsp[0].asts));
                                     break;
                             case DIV_ASSIGN:
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), '/', (yyvsp[0].asts));
                                     break;
                             case MOD_ASSIGN:
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), '%', (yyvsp[0].asts));
                                     break;
                             case ADD_ASSIGN:
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), '+', (yyvsp[0].asts));
                                     break;
                             case SUB_ASSIGN:
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), '-', (yyvsp[0].asts));
                                     break;
                             case LEFT_ASSIGN:
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), LEFT_OP, (yyvsp[0].asts));
                                     break;
                             case RIGHT_ASSIGN:
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), RIGHT_OP, (yyvsp[0].asts));
                                     break;
                             case AND_ASSIGN:
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), '&', (yyvsp[0].asts));
                                     break;
                             case XOR_ASSIGN:
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), '^', (yyvsp[0].asts));
                                     break;
                             case OR_ASSIGN:
/*                                   $$ = newNode('=',$1,newNode('|',removeIncDecOps(copyAst($1)),$3)); */
/*                                   $$ = newNode('=',removePostIncDecOps(copyAst($1)),
                                                      newNode('|',removePreIncDecOps(copyAst($1)),$3)); */
                                     (yyval.asts) = createRMW((yyvsp[-2].asts), '|', (yyvsp[0].asts));
                                     break;
                             default :
                                     (yyval.asts) = NULL;
                             }

                     }
#line 2645 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 92:
#line 445 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = '=' ;}
#line 2651 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 104:
#line 460 "SDCC.y" /* yacc.c:1646  */
    { seqPointNo++;}
#line 2657 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 105:
#line 460 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(',',(yyvsp[-3].asts),(yyvsp[0].asts));}
#line 2663 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 107:
#line 469 "SDCC.y" /* yacc.c:1646  */
    {
         if (uselessDecl)
           werror(W_USELESS_DECL);
         uselessDecl = TRUE;
         (yyval.sym) = NULL ;
      }
#line 2674 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 108:
#line 476 "SDCC.y" /* yacc.c:1646  */
    {
         /* add the specifier list to the id */
         symbol *sym , *sym1;

         for (sym1 = sym = reverseSyms((yyvsp[-1].sym));sym != NULL;sym = sym->next) {
             sym_link *lnk = copyLinkChain((yyvsp[-2].lnk));
             if (options.unsigned_char && SPEC_NOUN(lnk) == V_CHAR && !lnk->select.s.b_signed)
               SPEC_USIGN(lnk) = 1;
             /* do the pointer stuff */
             pointerTypes(sym->type,lnk);
             addDecl (sym,0,lnk) ;
         }

         uselessDecl = TRUE;
         (yyval.sym) = sym1 ;
      }
#line 2695 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 109:
#line 495 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = (yyvsp[0].lnk); }
#line 2701 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 110:
#line 496 "SDCC.y" /* yacc.c:1646  */
    {
     /* if the decl $2 is not a specifier */
     /* find the spec and replace it      */
     if ( !IS_SPEC((yyvsp[0].lnk))) {
       sym_link *lnk = (yyvsp[0].lnk) ;
       while (lnk && !IS_SPEC(lnk->next))
         lnk = lnk->next;
       lnk->next = mergeSpec((yyvsp[-1].lnk),lnk->next, "storage_class_specifier declaration_specifiers - skipped");
       (yyval.lnk) = (yyvsp[0].lnk) ;
     }
     else
       (yyval.lnk) = mergeSpec((yyvsp[-1].lnk),(yyvsp[0].lnk), "storage_class_specifier declaration_specifiers");
   }
#line 2719 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 111:
#line 509 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = (yyvsp[0].lnk); }
#line 2725 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 112:
#line 510 "SDCC.y" /* yacc.c:1646  */
    {
     /* if the decl $2 is not a specifier */
     /* find the spec and replace it      */
     if ( !IS_SPEC((yyvsp[0].lnk))) {
       sym_link *lnk = (yyvsp[0].lnk) ;
       while (lnk && !IS_SPEC(lnk->next))
         lnk = lnk->next;
       lnk->next = mergeSpec((yyvsp[-1].lnk),lnk->next, "type_specifier declaration_specifiers - skipped");
       (yyval.lnk) = (yyvsp[0].lnk) ;
     }
     else
       (yyval.lnk) = mergeSpec((yyvsp[-1].lnk),(yyvsp[0].lnk), "type_specifier declaration_specifiers");
   }
#line 2743 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 113:
#line 523 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = (yyvsp[0].lnk); }
#line 2749 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 114:
#line 524 "SDCC.y" /* yacc.c:1646  */
    {
     /* if the decl $2 is not a specifier */
     /* find the spec and replace it      */
     if ( !IS_SPEC((yyvsp[0].lnk))) {
       sym_link *lnk = (yyvsp[0].lnk) ;
       while (lnk && !IS_SPEC(lnk->next))
         lnk = lnk->next;
       lnk->next = mergeSpec((yyvsp[-1].lnk),lnk->next, "function_specifier declaration_specifiers - skipped");
       (yyval.lnk) = (yyvsp[0].lnk) ;
     }
     else
       (yyval.lnk) = mergeSpec((yyvsp[-1].lnk),(yyvsp[0].lnk), "function_specifier declaration_specifiers");
   }
#line 2767 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 116:
#line 541 "SDCC.y" /* yacc.c:1646  */
    { (yyvsp[0].sym)->next = (yyvsp[-2].sym) ; (yyval.sym) = (yyvsp[0].sym);}
#line 2773 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 117:
#line 545 "SDCC.y" /* yacc.c:1646  */
    { (yyvsp[0].sym)->ival = NULL ; }
#line 2779 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 118:
#line 546 "SDCC.y" /* yacc.c:1646  */
    { (yyvsp[-2].sym)->ival = (yyvsp[0].ilist)   ; }
#line 2785 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 119:
#line 551 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER) ;
                  SPEC_TYPEDEF((yyval.lnk)) = 1 ;
               }
#line 2794 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 120:
#line 555 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink(SPECIFIER);
                  SPEC_EXTR((yyval.lnk)) = 1 ;
               }
#line 2803 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 121:
#line 559 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER);
                  SPEC_STAT((yyval.lnk)) = 1 ;
               }
#line 2812 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 122:
#line 563 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER) ;
                  SPEC_SCLS((yyval.lnk)) = S_AUTO  ;
               }
#line 2821 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 123:
#line 567 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER);
                  SPEC_SCLS((yyval.lnk)) = S_REGISTER ;
               }
#line 2830 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 124:
#line 574 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER) ;
                  SPEC_INLINE((yyval.lnk)) = 1 ;
               }
#line 2839 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 125:
#line 581 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = INTNO_UNSPEC ; }
#line 2845 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 126:
#line 583 "SDCC.y" /* yacc.c:1646  */
    { int intno = (int) ulFromVal(constExprValue((yyvsp[0].asts),TRUE));
          if ((intno >= 0) && (intno <= INTNO_MAX))
            (yyval.yyint) = intno;
          else
            {
              werror(E_INT_BAD_INTNO, intno);
              (yyval.yyint) = INTNO_UNSPEC;
            }
        }
#line 2859 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 128:
#line 597 "SDCC.y" /* yacc.c:1646  */
    {
           /* add this to the storage class specifier  */
           SPEC_ABSA((yyvsp[-2].lnk)) = 1;   /* set the absolute addr flag */
           /* now get the abs addr from value */
           SPEC_ADDR((yyvsp[-2].lnk)) = (unsigned int) ulFromVal(constExprValue((yyvsp[0].asts),TRUE)) ;
        }
#line 2870 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 129:
#line 606 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_NOUN((yyval.lnk)) = V_CHAR  ;
                  ignoreTypedefType = 1;
               }
#line 2880 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 130:
#line 611 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_SHORT((yyval.lnk)) = 1 ;
                  ignoreTypedefType = 1;
               }
#line 2890 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 131:
#line 616 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_NOUN((yyval.lnk)) = V_INT   ;
                  ignoreTypedefType = 1;
               }
#line 2900 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 132:
#line 621 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_LONG((yyval.lnk)) = 1       ;
                  ignoreTypedefType = 1;
               }
#line 2910 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 133:
#line 626 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  (yyval.lnk)->select.s.b_signed = 1;
                  ignoreTypedefType = 1;
               }
#line 2920 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 134:
#line 631 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_USIGN((yyval.lnk)) = 1      ;
                  ignoreTypedefType = 1;
               }
#line 2930 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 135:
#line 636 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_NOUN((yyval.lnk)) = V_VOID  ;
                  ignoreTypedefType = 1;
               }
#line 2940 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 136:
#line 641 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_CONST((yyval.lnk)) = 1;
               }
#line 2949 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 137:
#line 645 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_VOLATILE((yyval.lnk)) = 1 ;
               }
#line 2958 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 138:
#line 649 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_RESTRICT((yyval.lnk)) = 1 ;
               }
#line 2967 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 139:
#line 653 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_NOUN((yyval.lnk)) = V_FLOAT;
                  ignoreTypedefType = 1;
               }
#line 2977 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 140:
#line 658 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_NOUN((yyval.lnk)) = V_FIXED16X16;
                  ignoreTypedefType = 1;
               }
#line 2987 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 141:
#line 663 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER);
                  SPEC_SCLS((yyval.lnk)) = S_XDATA  ;
               }
#line 2996 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 142:
#line 667 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER) ;
                  SPEC_SCLS((yyval.lnk)) = S_CODE ;
               }
#line 3005 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 143:
#line 671 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER) ;
                  SPEC_SCLS((yyval.lnk)) = S_EEPROM ;
               }
#line 3014 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 144:
#line 675 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER);
                  SPEC_SCLS((yyval.lnk)) = S_DATA   ;
               }
#line 3023 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 145:
#line 679 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER);
                  SPEC_SCLS((yyval.lnk)) = S_IDATA  ;
               }
#line 3032 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 146:
#line 683 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk) = newLink (SPECIFIER);
                  SPEC_SCLS((yyval.lnk)) = S_PDATA  ;
               }
#line 3041 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 147:
#line 687 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.lnk)=newLink(SPECIFIER);
                  SPEC_NOUN((yyval.lnk)) = V_BIT   ;
                  SPEC_SCLS((yyval.lnk)) = S_BIT   ;
                  SPEC_BLEN((yyval.lnk)) = 1;
                  SPEC_BSTR((yyval.lnk)) = 0;
                  ignoreTypedefType = 1;
               }
#line 3054 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 148:
#line 696 "SDCC.y" /* yacc.c:1646  */
    {
                                   uselessDecl = FALSE;
                                   (yyval.lnk) = (yyvsp[0].lnk) ;
                                   ignoreTypedefType = 1;
                                }
#line 3064 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 149:
#line 701 "SDCC.y" /* yacc.c:1646  */
    {
                           cenum = NULL ;
                           uselessDecl = FALSE;
                           ignoreTypedefType = 1;
                           (yyval.lnk) = (yyvsp[0].lnk) ;
                        }
#line 3075 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 150:
#line 708 "SDCC.y" /* yacc.c:1646  */
    {
            symbol *sym;
            sym_link   *p  ;
            sym = findSym(TypedefTab,NULL,(yyvsp[0].yychar)) ;
            (yyval.lnk) = p = copyLinkChain(sym ? sym->type : NULL);
            SPEC_TYPEDEF(getSpec(p)) = 0;
            ignoreTypedefType = 1;
         }
#line 3088 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 152:
#line 720 "SDCC.y" /* yacc.c:1646  */
    {
               (yyval.lnk) = newLink(SPECIFIER) ;
               SPEC_NOUN((yyval.lnk)) = V_SBIT;
               SPEC_SCLS((yyval.lnk)) = S_SBIT;
               SPEC_BLEN((yyval.lnk)) = 1;
               SPEC_BSTR((yyval.lnk)) = 0;
               ignoreTypedefType = 1;
            }
#line 3101 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 154:
#line 732 "SDCC.y" /* yacc.c:1646  */
    {
               (yyval.lnk) = newLink(SPECIFIER) ;
               FUNC_REGBANK((yyval.lnk)) = 0;
               SPEC_NOUN((yyval.lnk))    = V_CHAR;
               SPEC_SCLS((yyval.lnk))    = S_SFR ;
               SPEC_USIGN((yyval.lnk))   = 1 ;
               ignoreTypedefType = 1;
            }
#line 3114 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 155:
#line 740 "SDCC.y" /* yacc.c:1646  */
    {
               (yyval.lnk) = newLink(SPECIFIER) ;
               FUNC_REGBANK((yyval.lnk)) = 1;
               SPEC_NOUN((yyval.lnk))    = V_CHAR;
               SPEC_SCLS((yyval.lnk))    = S_SFR ;
               SPEC_USIGN((yyval.lnk))   = 1 ;
               ignoreTypedefType = 1;
            }
#line 3127 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 156:
#line 751 "SDCC.y" /* yacc.c:1646  */
    {
               (yyval.lnk) = newLink(SPECIFIER) ;
               FUNC_REGBANK((yyval.lnk)) = 0;
               SPEC_NOUN((yyval.lnk))    = V_INT;
               SPEC_SCLS((yyval.lnk))    = S_SFR;
               SPEC_USIGN((yyval.lnk))   = 1 ;
               ignoreTypedefType = 1;
            }
#line 3140 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 157:
#line 762 "SDCC.y" /* yacc.c:1646  */
    {
               (yyval.lnk) = newLink(SPECIFIER) ;
               FUNC_REGBANK((yyval.lnk)) = 0;
               SPEC_NOUN((yyval.lnk))    = V_INT;
               SPEC_SCLS((yyval.lnk))    = S_SFR;
               SPEC_LONG((yyval.lnk))    = 1;
               SPEC_USIGN((yyval.lnk))   = 1;
               ignoreTypedefType = 1;
            }
#line 3154 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 158:
#line 775 "SDCC.y" /* yacc.c:1646  */
    {
           if (!(yyvsp[0].sdef)->type)
             {
               (yyvsp[0].sdef)->type = (yyvsp[-1].yyint);
             }
           else
             {
               if ((yyvsp[0].sdef)->type != (yyvsp[-1].yyint))
                 werror(E_BAD_TAG, (yyvsp[0].sdef)->tag, (yyvsp[-1].yyint)==STRUCT ? "struct" : "union");
             }

        }
#line 3171 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 159:
#line 788 "SDCC.y" /* yacc.c:1646  */
    {
           structdef *sdef ;
           symbol *sym, *dsym;

           // check for errors in structure members
           for (sym=(yyvsp[-1].sym); sym; sym=sym->next) {
             if (IS_ABSOLUTE(sym->etype)) {
               werrorfl(sym->fileDef, sym->lineDef, E_NOT_ALLOWED, "'at'");
               SPEC_ABSA(sym->etype) = 0;
             }
             if (IS_SPEC(sym->etype) && SPEC_SCLS(sym->etype)) {
               werrorfl(sym->fileDef, sym->lineDef, E_NOT_ALLOWED, "storage class");
               printTypeChainRaw (sym->type,NULL);
               SPEC_SCLS(sym->etype) = 0;
             }
             for (dsym=sym->next; dsym; dsym=dsym->next) {
               if (*dsym->name && strcmp(sym->name, dsym->name)==0) {
                 werrorfl(sym->fileDef, sym->lineDef, E_DUPLICATE_MEMBER,
                        (yyvsp[-5].yyint)==STRUCT ? "struct" : "union", sym->name);
                 werrorfl(dsym->fileDef, dsym->lineDef, E_PREVIOUS_DEF);
               }
             }
           }

           /* Create a structdef   */
           sdef = (yyvsp[-4].sdef) ;
           sdef->fields   = reverseSyms((yyvsp[-1].sym)) ;   /* link the fields */
           sdef->size  = compStructSize((yyvsp[-5].yyint),sdef);   /* update size of  */
           promoteAnonStructs ((yyvsp[-5].yyint), sdef);

           /* Create the specifier */
           (yyval.lnk) = newLink (SPECIFIER) ;
           SPEC_NOUN((yyval.lnk)) = V_STRUCT;
           SPEC_STRUCT((yyval.lnk))= sdef ;
        }
#line 3211 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 160:
#line 824 "SDCC.y" /* yacc.c:1646  */
    {
            (yyval.lnk) = newLink(SPECIFIER) ;
            SPEC_NOUN((yyval.lnk)) = V_STRUCT;
            SPEC_STRUCT((yyval.lnk)) = (yyvsp[0].sdef);

           if (!(yyvsp[0].sdef)->type)
             {
               (yyvsp[0].sdef)->type = (yyvsp[-1].yyint);
             }
           else
             {
               if ((yyvsp[0].sdef)->type != (yyvsp[-1].yyint))
                 werror(E_BAD_TAG, (yyvsp[0].sdef)->tag, (yyvsp[-1].yyint)==STRUCT ? "struct" : "union");
             }
         }
#line 3231 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 161:
#line 842 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = STRUCT ; }
#line 3237 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 162:
#line 843 "SDCC.y" /* yacc.c:1646  */
    { (yyval.yyint) = UNION  ; }
#line 3243 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 164:
#line 848 "SDCC.y" /* yacc.c:1646  */
    {  /* synthesize a name add to structtable */
     (yyval.sdef) = newStruct(genSymName(NestLevel)) ;
     (yyval.sdef)->level = NestLevel ;
     addSym (StructTab, (yyval.sdef), (yyval.sdef)->tag,(yyval.sdef)->level,currBlockno, 0);
}
#line 3253 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 165:
#line 855 "SDCC.y" /* yacc.c:1646  */
    {  /* add name to structure table */
     (yyval.sdef) = findSymWithBlock (StructTab,(yyvsp[0].sym),currBlockno);
     if (! (yyval.sdef) ) {
       (yyval.sdef) = newStruct((yyvsp[0].sym)->name) ;
       (yyval.sdef)->level = NestLevel ;
       addSym (StructTab, (yyval.sdef), (yyval.sdef)->tag,(yyval.sdef)->level,currBlockno,0);
     }
}
#line 3266 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 167:
#line 868 "SDCC.y" /* yacc.c:1646  */
    {
           symbol *sym=(yyvsp[0].sym);

           /* go to the end of the chain */
           while (sym->next) sym=sym->next;
           sym->next = (yyvsp[-1].sym) ;

           (yyval.sym) = (yyvsp[0].sym);
       }
#line 3280 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 168:
#line 881 "SDCC.y" /* yacc.c:1646  */
    {
           /* add this type to all the symbols */
           symbol *sym ;
           for ( sym = (yyvsp[-1].sym) ; sym != NULL ; sym = sym->next ) {
               sym_link *btype = copyLinkChain((yyvsp[-2].lnk));
               if (options.unsigned_char && SPEC_NOUN(btype) == V_CHAR && !(btype)->select.s.b_signed)
                 SPEC_USIGN(btype) = 1;

               /* make the symbol one level up */
               sym->level-- ;

               pointerTypes(sym->type,btype);
               if (!sym->type) {
                   sym->type = btype;
                   sym->etype = getSpec(sym->type);
               }
               else
                 addDecl (sym,0,btype);
               /* make sure the type is complete and sane */
               checkTypeSanity(sym->etype, sym->name);
           }
           ignoreTypedefType = 0;
           (yyval.sym) = (yyvsp[-1].sym);
       }
#line 3309 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 170:
#line 910 "SDCC.y" /* yacc.c:1646  */
    {
           (yyvsp[0].sym)->next  = (yyvsp[-2].sym) ;
           (yyval.sym) = (yyvsp[0].sym) ;
       }
#line 3318 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 172:
#line 918 "SDCC.y" /* yacc.c:1646  */
    {
                           unsigned int bitsize;
                           (yyval.sym) = newSymbol (genSymName(NestLevel),NestLevel) ;
                           bitsize = (unsigned int) ulFromVal(constExprValue((yyvsp[0].asts),TRUE));
                           if (bitsize > (port->s.int_size * 8)) {
                             bitsize = port->s.int_size * 8;
                             werror(E_BITFLD_SIZE, bitsize);
                           }
                           if (!bitsize)
                             bitsize = BITVAR_PAD;
                           (yyval.sym)->bitVar = bitsize;
                        }
#line 3335 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 173:
#line 931 "SDCC.y" /* yacc.c:1646  */
    {
                          unsigned int bitsize;
                          bitsize = (unsigned int) ulFromVal(constExprValue((yyvsp[0].asts),TRUE));
                          if (bitsize > (port->s.int_size * 8)) {
                            bitsize = port->s.int_size * 8;
                            werror(E_BITFLD_SIZE, bitsize);
                          }
                          if (!bitsize) {
                            (yyval.sym) = newSymbol (genSymName(NestLevel),NestLevel) ;
                            (yyval.sym)->bitVar = BITVAR_PAD;
                            werror(W_BITFLD_NAMED);
                          }
                          else
                            (yyvsp[-2].sym)->bitVar = bitsize;
                        }
#line 3355 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 174:
#line 946 "SDCC.y" /* yacc.c:1646  */
    { (yyval.sym) = newSymbol ("", NestLevel) ; }
#line 3361 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 175:
#line 951 "SDCC.y" /* yacc.c:1646  */
    {
           (yyval.lnk) = newEnumType ((yyvsp[-1].sym));       //copyLinkChain(cenum->type);
           SPEC_SCLS(getSpec((yyval.lnk))) = 0;
         }
#line 3370 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 176:
#line 956 "SDCC.y" /* yacc.c:1646  */
    {
     symbol *csym ;
     sym_link *enumtype;

     csym=findSym(enumTab,(yyvsp[-3].sym),(yyvsp[-3].sym)->name);
     if ((csym && csym->level == (yyvsp[-3].sym)->level))
       {
         werrorfl((yyvsp[-3].sym)->fileDef, (yyvsp[-3].sym)->lineDef, E_DUPLICATE_TYPEDEF,csym->name);
         werrorfl(csym->fileDef, csym->lineDef, E_PREVIOUS_DEF);
       }

     enumtype = newEnumType ((yyvsp[-1].sym));       //copyLinkChain(cenum->type);
     SPEC_SCLS(getSpec(enumtype)) = 0;
     (yyvsp[-3].sym)->type = enumtype;

     /* add this to the enumerator table */
     if (!csym)
       addSym ( enumTab,(yyvsp[-3].sym),(yyvsp[-3].sym)->name,(yyvsp[-3].sym)->level,(yyvsp[-3].sym)->block, 0);
     (yyval.lnk) = copyLinkChain(enumtype);
   }
#line 3395 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 177:
#line 976 "SDCC.y" /* yacc.c:1646  */
    {
     symbol *csym ;

     /* check the enumerator table */
     if ((csym = findSym(enumTab,(yyvsp[0].sym),(yyvsp[0].sym)->name)))
       (yyval.lnk) = copyLinkChain(csym->type);
     else  {
       (yyval.lnk) = newLink(SPECIFIER) ;
       SPEC_NOUN((yyval.lnk)) = V_INT   ;
     }
   }
#line 3411 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 180:
#line 993 "SDCC.y" /* yacc.c:1646  */
    {
        (yyvsp[0].sym)->next = (yyvsp[-2].sym) ;
        (yyval.sym) = (yyvsp[0].sym)  ;
      }
#line 3420 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 181:
#line 1001 "SDCC.y" /* yacc.c:1646  */
    {
        symbol *sym;

        /* make the symbol one level up */
        (yyvsp[-1].sym)->level-- ;
        // check if the symbol at the same level already exists
        if ((sym = findSymWithLevel (SymbolTab, (yyvsp[-1].sym))) &&
          sym->level == (yyvsp[-1].sym)->level)
          {
            werrorfl ((yyvsp[-1].sym)->fileDef, (yyvsp[-1].sym)->lineDef, E_DUPLICATE_MEMBER, "enum", (yyvsp[-1].sym)->name);
            werrorfl (sym->fileDef, sym->lineDef, E_PREVIOUS_DEF);
          }
        (yyvsp[-1].sym)->type = copyLinkChain ((yyvsp[0].val)->type);
        (yyvsp[-1].sym)->etype= getSpec ((yyvsp[-1].sym)->type);
        SPEC_ENUM ((yyvsp[-1].sym)->etype) = 1;
        (yyval.sym) = (yyvsp[-1].sym) ;
        // do this now, so we can use it for the next enums in the list
        addSymChain (&(yyvsp[-1].sym));
      }
#line 3444 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 182:
#line 1023 "SDCC.y" /* yacc.c:1646  */
    {
                              value *val ;

                              val = constExprValue((yyvsp[0].asts),TRUE);
                              if (!IS_INT(val->type) && !IS_CHAR(val->type))
                                {
                                  werror(E_ENUM_NON_INTEGER);
                                  SNPRINTF(lbuff, sizeof(lbuff),
                                          "%d", (int) ulFromVal(val));
                                  val = constVal(lbuff);
                                }
                              (yyval.val) = cenum = val ;
                           }
#line 3462 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 183:
#line 1036 "SDCC.y" /* yacc.c:1646  */
    {
                              if (cenum)  {
                                 SNPRINTF(lbuff, sizeof(lbuff),
                                          "%d", (int) ulFromVal(cenum)+1);
                                 (yyval.val) = cenum = constVal(lbuff);
                              }
                              else {
                                 (yyval.val) = cenum = constCharVal(0);
                              }
                           }
#line 3477 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 184:
#line 1049 "SDCC.y" /* yacc.c:1646  */
    { (yyval.sym) = (yyvsp[0].sym) ; }
#line 3483 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 185:
#line 1051 "SDCC.y" /* yacc.c:1646  */
    {
             addDecl ((yyvsp[0].sym),0,reverseLink((yyvsp[-1].lnk)));
             (yyval.sym) = (yyvsp[0].sym) ;
         }
#line 3492 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 186:
#line 1058 "SDCC.y" /* yacc.c:1646  */
    { (yyval.sym) = (yyvsp[0].sym) ; }
#line 3498 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 187:
#line 1059 "SDCC.y" /* yacc.c:1646  */
    { (yyval.sym) = (yyvsp[0].sym) ; }
#line 3504 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 188:
#line 1063 "SDCC.y" /* yacc.c:1646  */
    { (yyval.sym) = (yyvsp[0].sym); }
#line 3510 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 189:
#line 1065 "SDCC.y" /* yacc.c:1646  */
    {
             addDecl ((yyvsp[0].sym),0,reverseLink((yyvsp[-1].lnk)));
             (yyval.sym) = (yyvsp[0].sym) ;
         }
#line 3519 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 190:
#line 1072 "SDCC.y" /* yacc.c:1646  */
    { (yyval.sym) = (yyvsp[0].sym) ; }
#line 3525 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 191:
#line 1073 "SDCC.y" /* yacc.c:1646  */
    {
           // copy the functionAttributes (not the args and hasVargs !!)
           struct value *args;
           unsigned hasVargs;
           sym_link *funcType=(yyvsp[-1].sym)->type;

           while (funcType && !IS_FUNC(funcType))
             funcType = funcType->next;

           if (!funcType)
             werror (E_FUNC_ATTR);
           else
             {
               args=FUNC_ARGS(funcType);
               hasVargs=FUNC_HASVARARGS(funcType);

               memcpy (&funcType->funcAttrs, &(yyvsp[0].lnk)->funcAttrs,
                   sizeof((yyvsp[0].lnk)->funcAttrs));

               FUNC_ARGS(funcType)=args;
               FUNC_HASVARARGS(funcType)=hasVargs;

               // just to be sure
               memset (&(yyvsp[0].lnk)->funcAttrs, 0,
                   sizeof((yyvsp[0].lnk)->funcAttrs));

               addDecl ((yyvsp[-1].sym),0,(yyvsp[0].lnk));
             }
   }
#line 3559 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 193:
#line 1106 "SDCC.y" /* yacc.c:1646  */
    { (yyval.sym) = (yyvsp[-1].sym); }
#line 3565 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 194:
#line 1108 "SDCC.y" /* yacc.c:1646  */
    {
            sym_link   *p;

            p = newLink (DECLARATOR);
            DCL_TYPE(p) = ARRAY ;
            DCL_ELEM(p) = 0     ;
            addDecl((yyvsp[-2].sym),0,p);
         }
#line 3578 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 195:
#line 1117 "SDCC.y" /* yacc.c:1646  */
    {
            sym_link *p;
            value *tval;
            int size;

            tval = constExprValue((yyvsp[-1].asts), TRUE);
            /* if it is not a constant then Error  */
            p = newLink (DECLARATOR);
            DCL_TYPE(p) = ARRAY;

            if (!tval || (SPEC_SCLS(tval->etype) != S_LITERAL))
              {
                werror(E_CONST_EXPECTED);
                /* Assume a single item array to limit the cascade */
                /* of additional errors. */
                size = 1;
              }
            else
              {
                if ((size = (int) ulFromVal(tval)) < 0)
                  {
                    werror(E_NEGATIVE_ARRAY_SIZE, (yyvsp[-3].sym)->name);
                    size = 1;
                  }
              }
            DCL_ELEM(p) = size;
            addDecl((yyvsp[-3].sym), 0, p);
         }
#line 3611 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 196:
#line 1148 "SDCC.y" /* yacc.c:1646  */
    {  addDecl ((yyvsp[-2].sym),FUNCTION,NULL) ;   }
#line 3617 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 197:
#line 1149 "SDCC.y" /* yacc.c:1646  */
    { NestLevel++ ; currBlockno++;  }
#line 3623 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 198:
#line 1151 "SDCC.y" /* yacc.c:1646  */
    {
             sym_link *funcType;

             addDecl ((yyvsp[-4].sym),FUNCTION,NULL) ;

             funcType = (yyvsp[-4].sym)->type;
             while (funcType && !IS_FUNC(funcType))
               funcType = funcType->next;

             assert (funcType);

             FUNC_HASVARARGS(funcType) = IS_VARG((yyvsp[-1].val));
             FUNC_ARGS(funcType) = reverseVal((yyvsp[-1].val));

             /* nest level was incremented to take care of the parms  */
             NestLevel-- ;
             currBlockno--;

             // if this was a pointer (to a function)
             if (!IS_FUNC((yyvsp[-4].sym)->type))
               cleanUpLevel(SymbolTab,NestLevel+1);

             (yyval.sym) = (yyvsp[-4].sym);
         }
#line 3652 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 199:
#line 1176 "SDCC.y" /* yacc.c:1646  */
    {
           werror(E_OLD_STYLE,(yyvsp[-3].sym)->name) ;
           /* assume it returns an int */
           (yyvsp[-3].sym)->type = (yyvsp[-3].sym)->etype = newIntLink();
           (yyval.sym) = (yyvsp[-3].sym) ;
         }
#line 3663 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 200:
#line 1185 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = (yyvsp[0].lnk) ;}
#line 3669 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 201:
#line 1187 "SDCC.y" /* yacc.c:1646  */
    {
             (yyval.lnk) = (yyvsp[-1].lnk)  ;
             if (IS_SPEC((yyvsp[0].lnk))) {
                 DCL_TSPEC((yyvsp[-1].lnk)) = (yyvsp[0].lnk);
                 DCL_PTR_CONST((yyvsp[-1].lnk)) = SPEC_CONST((yyvsp[0].lnk));
                 DCL_PTR_VOLATILE((yyvsp[-1].lnk)) = SPEC_VOLATILE((yyvsp[0].lnk));
                 DCL_PTR_RESTRICT((yyvsp[-1].lnk)) = SPEC_RESTRICT((yyvsp[0].lnk));
             }
             else
                 werror (W_PTR_TYPE_INVALID);
         }
#line 3685 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 202:
#line 1199 "SDCC.y" /* yacc.c:1646  */
    {
             (yyval.lnk) = (yyvsp[-1].lnk) ;
             (yyval.lnk)->next = (yyvsp[0].lnk) ;
             DCL_TYPE((yyvsp[0].lnk))=port->unqualified_pointer;
         }
#line 3695 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 203:
#line 1205 "SDCC.y" /* yacc.c:1646  */
    {
             (yyval.lnk) = (yyvsp[-2].lnk) ;
             if (IS_SPEC((yyvsp[-1].lnk)) && DCL_TYPE((yyvsp[0].lnk)) == UPOINTER) {
                 DCL_PTR_CONST((yyvsp[-2].lnk)) = SPEC_CONST((yyvsp[-1].lnk));
                 DCL_PTR_VOLATILE((yyvsp[-2].lnk)) = SPEC_VOLATILE((yyvsp[-1].lnk));
                 DCL_PTR_RESTRICT((yyvsp[-2].lnk)) = SPEC_RESTRICT((yyvsp[-1].lnk));
                 switch (SPEC_SCLS((yyvsp[-1].lnk))) {
                 case S_XDATA:
                     DCL_TYPE((yyvsp[0].lnk)) = FPOINTER;
                     break;
                 case S_IDATA:
                     DCL_TYPE((yyvsp[0].lnk)) = IPOINTER ;
                     break;
                 case S_PDATA:
                     DCL_TYPE((yyvsp[0].lnk)) = PPOINTER ;
                     break;
                 case S_DATA:
                     DCL_TYPE((yyvsp[0].lnk)) = POINTER ;
                     break;
                 case S_CODE:
                     DCL_TYPE((yyvsp[0].lnk)) = CPOINTER ;
                     break;
                 case S_EEPROM:
                     DCL_TYPE((yyvsp[0].lnk)) = EEPPOINTER;
                     break;
                 default:
                   // this could be just "constant"
                   // werror(W_PTR_TYPE_INVALID);
                     ;
                 }
             }
             else
                 werror (W_PTR_TYPE_INVALID);
             (yyval.lnk)->next = (yyvsp[0].lnk) ;
         }
#line 3735 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 204:
#line 1244 "SDCC.y" /* yacc.c:1646  */
    {
        (yyval.lnk) = newLink(DECLARATOR);
        DCL_TYPE((yyval.lnk))=UPOINTER;
      }
#line 3744 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 206:
#line 1253 "SDCC.y" /* yacc.c:1646  */
    {
     /* if the decl $2 is not a specifier */
     /* find the spec and replace it      */
     if ( !IS_SPEC((yyvsp[0].lnk))) {
       sym_link *lnk = (yyvsp[0].lnk) ;
       while (lnk && !IS_SPEC(lnk->next))
         lnk = lnk->next;
       lnk->next = mergeSpec((yyvsp[-1].lnk),lnk->next, "type_specifier_list type_specifier skipped");
       (yyval.lnk) = (yyvsp[0].lnk) ;
     }
     else
       (yyval.lnk) = mergeSpec((yyvsp[-1].lnk),(yyvsp[0].lnk), "type_specifier_list type_specifier");
   }
#line 3762 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 208:
#line 1271 "SDCC.y" /* yacc.c:1646  */
    {
           (yyvsp[0].sym)->next = (yyvsp[-2].sym);
           (yyval.sym) = (yyvsp[0].sym) ;
         }
#line 3771 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 210:
#line 1279 "SDCC.y" /* yacc.c:1646  */
    { (yyvsp[-2].val)->vArgs = 1;}
#line 3777 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 212:
#line 1285 "SDCC.y" /* yacc.c:1646  */
    {
            (yyvsp[0].val)->next = (yyvsp[-2].val) ;
            (yyval.val) = (yyvsp[0].val) ;
         }
#line 3786 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 213:
#line 1293 "SDCC.y" /* yacc.c:1646  */
    {
                  symbol *loop ;
                  pointerTypes((yyvsp[0].sym)->type,(yyvsp[-1].lnk));
                  if (options.unsigned_char && SPEC_NOUN((yyvsp[-1].lnk)) == V_CHAR && !((yyvsp[-1].lnk))->select.s.b_signed)
                    SPEC_USIGN((yyvsp[-1].lnk)) = 1;
                  addDecl ((yyvsp[0].sym),0,(yyvsp[-1].lnk));
                  for (loop=(yyvsp[0].sym);loop;loop->_isparm=1,loop=loop->next);
                  addSymChain (&(yyvsp[0].sym));
                  (yyval.val) = symbolVal((yyvsp[0].sym));
                  ignoreTypedefType = 0;
               }
#line 3802 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 214:
#line 1304 "SDCC.y" /* yacc.c:1646  */
    {
                  (yyval.val) = newValue() ;
                  if (options.unsigned_char && SPEC_NOUN((yyvsp[0].lnk)) == V_CHAR && !((yyvsp[0].lnk))->select.s.b_signed)
                    SPEC_USIGN((yyvsp[0].lnk)) = 1;
                  (yyval.val)->type = (yyvsp[0].lnk);
                  (yyval.val)->etype = getSpec((yyval.val)->type);
                  ignoreTypedefType = 0;
               }
#line 3815 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 215:
#line 1315 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = (yyvsp[0].lnk); ignoreTypedefType = 0;}
#line 3821 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 216:
#line 1317 "SDCC.y" /* yacc.c:1646  */
    {
                 /* go to the end of the list */
                 sym_link *p;
                 pointerTypes((yyvsp[0].lnk),(yyvsp[-1].lnk));
                 for ( p = (yyvsp[0].lnk) ; p && p->next ; p=p->next);
                 if (!p) {
                   werror(E_SYNTAX_ERROR, yytext);
                 } else {
                   p->next = (yyvsp[-1].lnk) ;
                 }
                 (yyval.lnk) = (yyvsp[0].lnk) ;
                 ignoreTypedefType = 0;
               }
#line 3839 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 217:
#line 1333 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = reverseLink((yyvsp[0].lnk)); }
#line 3845 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 219:
#line 1335 "SDCC.y" /* yacc.c:1646  */
    { (yyvsp[-1].lnk) = reverseLink((yyvsp[-1].lnk)); (yyvsp[-1].lnk)->next = (yyvsp[0].lnk) ; (yyval.lnk) = (yyvsp[-1].lnk);
          if (IS_PTR((yyvsp[-1].lnk)) && IS_FUNC((yyvsp[0].lnk)))
            DCL_TYPE((yyvsp[-1].lnk)) = CPOINTER;
        }
#line 3854 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 220:
#line 1342 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = (yyvsp[-1].lnk) ; }
#line 3860 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 221:
#line 1343 "SDCC.y" /* yacc.c:1646  */
    {
                                       (yyval.lnk) = newLink (DECLARATOR);
                                       DCL_TYPE((yyval.lnk)) = ARRAY ;
                                       DCL_ELEM((yyval.lnk)) = 0     ;
                                    }
#line 3870 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 222:
#line 1348 "SDCC.y" /* yacc.c:1646  */
    {
                                       value *val ;
                                       (yyval.lnk) = newLink (DECLARATOR);
                                       DCL_TYPE((yyval.lnk)) = ARRAY ;
                                       DCL_ELEM((yyval.lnk)) = (int) ulFromVal(val = constExprValue((yyvsp[-1].asts),TRUE));
                                    }
#line 3881 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 223:
#line 1354 "SDCC.y" /* yacc.c:1646  */
    {
                                       (yyval.lnk) = newLink (DECLARATOR);
                                       DCL_TYPE((yyval.lnk)) = ARRAY ;
                                       DCL_ELEM((yyval.lnk)) = 0     ;
                                       (yyval.lnk)->next = (yyvsp[-2].lnk) ;
                                    }
#line 3892 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 224:
#line 1361 "SDCC.y" /* yacc.c:1646  */
    {
                                       value *val ;
                                       (yyval.lnk) = newLink (DECLARATOR);
                                       DCL_TYPE((yyval.lnk)) = ARRAY ;
                                       DCL_ELEM((yyval.lnk)) = (int) ulFromVal(val = constExprValue((yyvsp[-1].asts),TRUE));
                                       (yyval.lnk)->next = (yyvsp[-3].lnk) ;
                                    }
#line 3904 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 225:
#line 1368 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = NULL;}
#line 3910 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 226:
#line 1369 "SDCC.y" /* yacc.c:1646  */
    { (yyval.lnk) = NULL;}
#line 3916 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 227:
#line 1370 "SDCC.y" /* yacc.c:1646  */
    {
     // $1 must be a pointer to a function
     sym_link *p=newLink(DECLARATOR);
     DCL_TYPE(p) = FUNCTION;
     if (!(yyvsp[-2].lnk)) {
       // ((void (code *) ()) 0) ()
       (yyvsp[-2].lnk)=newLink(DECLARATOR);
       DCL_TYPE((yyvsp[-2].lnk))=CPOINTER;
       (yyval.lnk) = (yyvsp[-2].lnk);
     }
     (yyvsp[-2].lnk)->next=p;
   }
#line 3933 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 228:
#line 1382 "SDCC.y" /* yacc.c:1646  */
    { NestLevel++ ; currBlockno++; }
#line 3939 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 229:
#line 1382 "SDCC.y" /* yacc.c:1646  */
    {
       sym_link *p=newLink(DECLARATOR);
       DCL_TYPE(p) = FUNCTION;

       FUNC_HASVARARGS(p) = IS_VARG((yyvsp[-1].val));
       FUNC_ARGS(p) = reverseVal((yyvsp[-1].val));

       /* nest level was incremented to take care of the parms  */
       NestLevel-- ;
       currBlockno--;
       if (!(yyvsp[-4].lnk)) {
         /* ((void (code *) (void)) 0) () */
         (yyvsp[-4].lnk)=newLink(DECLARATOR);
         DCL_TYPE((yyvsp[-4].lnk))=CPOINTER;
         (yyval.lnk) = (yyvsp[-4].lnk);
       }
       (yyvsp[-4].lnk)->next=p;

       // remove the symbol args (if any)
       cleanUpLevel(SymbolTab,NestLevel+1);
   }
#line 3965 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 230:
#line 1406 "SDCC.y" /* yacc.c:1646  */
    { (yyval.ilist) = newiList(INIT_NODE,(yyvsp[0].asts)); }
#line 3971 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 231:
#line 1407 "SDCC.y" /* yacc.c:1646  */
    { (yyval.ilist) = newiList(INIT_DEEP,revinit((yyvsp[-1].ilist))); }
#line 3977 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 232:
#line 1408 "SDCC.y" /* yacc.c:1646  */
    { (yyval.ilist) = newiList(INIT_DEEP,revinit((yyvsp[-2].ilist))); }
#line 3983 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 234:
#line 1413 "SDCC.y" /* yacc.c:1646  */
    {  (yyvsp[0].ilist)->next = (yyvsp[-2].ilist); (yyval.ilist) = (yyvsp[0].ilist); }
#line 3989 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 242:
#line 1424 "SDCC.y" /* yacc.c:1646  */
    {
                            ast *ex;
                            seqPointNo++;
                            ex = newNode(INLINEASM,NULL,NULL);
                            ex->values.inlineasm = strdup((yyvsp[-1].yyinline));
                            seqPointNo++;
                            (yyval.asts) = ex;
                         }
#line 4002 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 243:
#line 1435 "SDCC.y" /* yacc.c:1646  */
    {
                   inCritical++;
                   STACK_PUSH(continueStack,NULL);
                   STACK_PUSH(breakStack,NULL);
                   (yyval.sym) = NULL;
                }
#line 4013 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 244:
#line 1444 "SDCC.y" /* yacc.c:1646  */
    {
                   STACK_POP(breakStack);
                   STACK_POP(continueStack);
                   inCritical--;
                   (yyval.asts) = newNode(CRITICAL,(yyvsp[0].asts),NULL);
                }
#line 4024 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 245:
#line 1454 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.asts) = createLabel((yyvsp[-1].sym),NULL);
                                          (yyvsp[-1].sym)->isitmp = 0;  }
#line 4031 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 246:
#line 1457 "SDCC.y" /* yacc.c:1646  */
    {
       if (STACK_EMPTY(swStk))
         (yyval.asts) = createCase(NULL,(yyvsp[-1].asts),NULL);
       else
         (yyval.asts) = createCase(STACK_PEEK(swStk),(yyvsp[-1].asts),NULL);
     }
#line 4042 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 247:
#line 1463 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = newNode(DEFAULT,NULL,NULL); }
#line 4048 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 248:
#line 1464 "SDCC.y" /* yacc.c:1646  */
    {
       if (STACK_EMPTY(swStk))
         (yyval.asts) = createDefault(NULL,(yyvsp[-1].asts),NULL);
       else
         (yyval.asts) = createDefault(STACK_PEEK(swStk),(yyvsp[-1].asts),NULL);
     }
#line 4059 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 249:
#line 1473 "SDCC.y" /* yacc.c:1646  */
    {
                STACK_PUSH(blockNum,currBlockno);
                currBlockno = ++blockNo ;
                ignoreTypedefType = 0;
              }
#line 4069 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 250:
#line 1480 "SDCC.y" /* yacc.c:1646  */
    { currBlockno = STACK_POP(blockNum); }
#line 4075 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 251:
#line 1484 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = createBlock(NULL, NULL); }
#line 4081 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 252:
#line 1485 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = createBlock(NULL, (yyvsp[-1].asts)); }
#line 4087 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 253:
#line 1486 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = createBlock((yyvsp[-1].sym), NULL); }
#line 4093 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 254:
#line 1489 "SDCC.y" /* yacc.c:1646  */
    {(yyval.asts) = createBlock((yyvsp[-2].sym), (yyvsp[-1].asts)); }
#line 4099 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 255:
#line 1490 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = NULL ; }
#line 4105 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 256:
#line 1495 "SDCC.y" /* yacc.c:1646  */
    {
       /* if this is typedef declare it immediately */
       if ( (yyvsp[0].sym) && IS_TYPEDEF((yyvsp[0].sym)->etype)) {
         allocVariables ((yyvsp[0].sym));
         (yyval.sym) = NULL ;
       }
       else
         (yyval.sym) = (yyvsp[0].sym) ;
       ignoreTypedefType = 0;
       addSymChain(&(yyvsp[0].sym));
     }
#line 4121 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 257:
#line 1508 "SDCC.y" /* yacc.c:1646  */
    {
       symbol   *sym;

       /* if this is a typedef */
       if ((yyvsp[0].sym) && IS_TYPEDEF((yyvsp[0].sym)->etype)) {
         allocVariables ((yyvsp[0].sym));
         (yyval.sym) = (yyvsp[-1].sym) ;
       }
       else {
                                /* get to the end of the previous decl */
         if ( (yyvsp[-1].sym) ) {
           (yyval.sym) = sym = (yyvsp[-1].sym) ;
           while (sym->next)
             sym = sym->next ;
           sym->next = (yyvsp[0].sym);
         }
         else
           (yyval.sym) = (yyvsp[0].sym) ;
       }
       ignoreTypedefType = 0;
       addSymChain(&(yyvsp[0].sym));
     }
#line 4148 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 259:
#line 1534 "SDCC.y" /* yacc.c:1646  */
    {  (yyval.asts) = newNode(NULLOP,(yyvsp[-1].asts),(yyvsp[0].asts)) ;}
#line 4154 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 260:
#line 1538 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = NULL;}
#line 4160 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 261:
#line 1539 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = (yyvsp[-1].asts); seqPointNo++;}
#line 4166 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 262:
#line 1543 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = (yyvsp[0].asts)  ; }
#line 4172 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 263:
#line 1544 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = NULL;}
#line 4178 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 264:
#line 1549 "SDCC.y" /* yacc.c:1646  */
    { seqPointNo++;}
#line 4184 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 265:
#line 1550 "SDCC.y" /* yacc.c:1646  */
    {
                              noLineno++ ;
                              (yyval.asts) = createIf ((yyvsp[-4].asts), (yyvsp[-1].asts), (yyvsp[0].asts) );
                              (yyval.asts)->lineno = (yyvsp[-4].asts)->lineno;
                              (yyval.asts)->filename = (yyvsp[-4].asts)->filename;
                              noLineno--;
                           }
#line 4196 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 266:
#line 1557 "SDCC.y" /* yacc.c:1646  */
    {
                              ast *ex ;
                              static   int swLabel = 0 ;

                              seqPointNo++;
                              /* create a node for expression  */
                              ex = newNode(SWITCH,(yyvsp[-1].asts),NULL);
                              STACK_PUSH(swStk,ex);   /* save it in the stack */
                              ex->values.switchVals.swNum = swLabel ;

                              /* now create the label */
                              SNPRINTF(lbuff, sizeof(lbuff),
                                       "_swBrk_%d",swLabel++);
                              (yyval.sym)  =  newSymbol(lbuff,NestLevel);
                              /* put label in the break stack  */
                              STACK_PUSH(breakStack,(yyval.sym));
                           }
#line 4218 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 267:
#line 1574 "SDCC.y" /* yacc.c:1646  */
    {
                              /* get back the switch form the stack  */
                              (yyval.asts) = STACK_POP(swStk)  ;
                              (yyval.asts)->right = newNode (NULLOP,(yyvsp[0].asts),createLabel((yyvsp[-1].sym),NULL));
                              STACK_POP(breakStack);
                           }
#line 4229 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 268:
#line 1582 "SDCC.y" /* yacc.c:1646  */
    {  /* create and push the continue , break & body labels */
                  static int Lblnum = 0 ;
                  /* continue */
                  SNPRINTF (lbuff, sizeof(lbuff), "_whilecontinue_%d",Lblnum);
                  STACK_PUSH(continueStack,newSymbol(lbuff,NestLevel));
                  /* break */
                  SNPRINTF (lbuff, sizeof(lbuff), "_whilebreak_%d",Lblnum);
                  STACK_PUSH(breakStack,newSymbol(lbuff,NestLevel));
                  /* body */
                  SNPRINTF (lbuff, sizeof(lbuff), "_whilebody_%d",Lblnum++);
                  (yyval.sym) = newSymbol(lbuff,NestLevel);
               }
#line 4246 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 269:
#line 1596 "SDCC.y" /* yacc.c:1646  */
    {  /* create and push the continue , break & body Labels */
           static int Lblnum = 0 ;

           /* continue */
           SNPRINTF(lbuff, sizeof(lbuff), "_docontinue_%d",Lblnum);
           STACK_PUSH(continueStack,newSymbol(lbuff,NestLevel));
           /* break */
           SNPRINTF(lbuff, sizeof(lbuff), "_dobreak_%d",Lblnum);
           STACK_PUSH(breakStack,newSymbol(lbuff,NestLevel));
           /* do body */
           SNPRINTF(lbuff, sizeof(lbuff), "_dobody_%d",Lblnum++);
           (yyval.sym) = newSymbol (lbuff,NestLevel);
        }
#line 4264 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 270:
#line 1611 "SDCC.y" /* yacc.c:1646  */
    { /* create & push continue, break & body labels */
            static int Lblnum = 0 ;

            /* continue */
            SNPRINTF(lbuff, sizeof(lbuff), "_forcontinue_%d",Lblnum);
            STACK_PUSH(continueStack,newSymbol(lbuff,NestLevel));
            /* break    */
            SNPRINTF(lbuff, sizeof(lbuff), "_forbreak_%d",Lblnum);
            STACK_PUSH(breakStack,newSymbol(lbuff,NestLevel));
            /* body */
            SNPRINTF(lbuff, sizeof(lbuff), "_forbody_%d",Lblnum);
            (yyval.sym) = newSymbol(lbuff,NestLevel);
            /* condition */
            SNPRINTF(lbuff, sizeof(lbuff), "_forcond_%d",Lblnum++);
            STACK_PUSH(forStack,newSymbol(lbuff,NestLevel));
          }
#line 4285 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 271:
#line 1630 "SDCC.y" /* yacc.c:1646  */
    { seqPointNo++;}
#line 4291 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 272:
#line 1631 "SDCC.y" /* yacc.c:1646  */
    {
                           noLineno++ ;
                           (yyval.asts) = createWhile ( (yyvsp[-5].sym), STACK_POP(continueStack),
                                              STACK_POP(breakStack), (yyvsp[-3].asts), (yyvsp[0].asts) );
                           (yyval.asts)->lineno = (yyvsp[-5].sym)->lineDef;
                           (yyval.asts)->filename = (yyvsp[-5].sym)->fileDef;
                           noLineno-- ;
                         }
#line 4304 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 273:
#line 1640 "SDCC.y" /* yacc.c:1646  */
    {
                          seqPointNo++;
                          noLineno++ ;
                          (yyval.asts) = createDo ( (yyvsp[-6].sym) , STACK_POP(continueStack),
                                          STACK_POP(breakStack), (yyvsp[-2].asts), (yyvsp[-5].asts));
                          (yyval.asts)->lineno = (yyvsp[-6].sym)->lineDef;
                          (yyval.asts)->filename = (yyvsp[-6].sym)->fileDef;
                          noLineno-- ;
                        }
#line 4318 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 274:
#line 1650 "SDCC.y" /* yacc.c:1646  */
    {
                          noLineno++ ;

                          /* if break or continue statement present
                             then create a general case loop */
                          if (STACK_PEEK(continueStack)->isref ||
                              STACK_PEEK(breakStack)->isref) {
                              (yyval.asts) = createFor ((yyvsp[-8].sym), STACK_POP(continueStack),
                                              STACK_POP(breakStack) ,
                                              STACK_POP(forStack)   ,
                                              (yyvsp[-6].asts) , (yyvsp[-4].asts) , (yyvsp[-2].asts), (yyvsp[0].asts) );
                          } else {
                              (yyval.asts) = newNode(FOR,(yyvsp[0].asts),NULL);
                              AST_FOR((yyval.asts),trueLabel) = (yyvsp[-8].sym);
                              AST_FOR((yyval.asts),continueLabel) =  STACK_POP(continueStack);
                              AST_FOR((yyval.asts),falseLabel) = STACK_POP(breakStack);
                              AST_FOR((yyval.asts),condLabel)  = STACK_POP(forStack)  ;
                              AST_FOR((yyval.asts),initExpr)   = (yyvsp[-6].asts);
                              AST_FOR((yyval.asts),condExpr)   = (yyvsp[-4].asts);
                              AST_FOR((yyval.asts),loopExpr)   = (yyvsp[-2].asts);
                          }

                          noLineno-- ;
                        }
#line 4347 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 275:
#line 1677 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = NULL ; seqPointNo++; }
#line 4353 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 276:
#line 1678 "SDCC.y" /* yacc.c:1646  */
    { (yyval.asts) = (yyvsp[0].asts) ; seqPointNo++; }
#line 4359 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 277:
#line 1682 "SDCC.y" /* yacc.c:1646  */
    {
                              (yyvsp[-1].sym)->islbl = 1;
                              (yyval.asts) = newAst_VALUE(symbolVal((yyvsp[-1].sym)));
                              (yyval.asts) = newNode(GOTO,(yyval.asts),NULL);
                           }
#line 4369 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 278:
#line 1687 "SDCC.y" /* yacc.c:1646  */
    {
       /* make sure continue is in context */
       if (STACK_EMPTY(continueStack) || STACK_PEEK(continueStack) == NULL) {
           werror(E_BREAK_CONTEXT);
           (yyval.asts) = NULL;
       }
       else {
           (yyval.asts) = newAst_VALUE(symbolVal(STACK_PEEK(continueStack)));
           (yyval.asts) = newNode(GOTO,(yyval.asts),NULL);
           /* mark the continue label as referenced */
           STACK_PEEK(continueStack)->isref = 1;
       }
   }
#line 4387 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 279:
#line 1700 "SDCC.y" /* yacc.c:1646  */
    {
       if (STACK_EMPTY(breakStack) || STACK_PEEK(breakStack) == NULL) {
           werror(E_BREAK_CONTEXT);
           (yyval.asts) = NULL;
       } else {
           (yyval.asts) = newAst_VALUE(symbolVal(STACK_PEEK(breakStack)));
           (yyval.asts) = newNode(GOTO,(yyval.asts),NULL);
           STACK_PEEK(breakStack)->isref = 1;
       }
   }
#line 4402 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 280:
#line 1710 "SDCC.y" /* yacc.c:1646  */
    {
       seqPointNo++;
       if (inCritical) {
           werror(E_INVALID_CRITICAL);
           (yyval.asts) = NULL;
       } else {
           (yyval.asts) = newNode(RETURN,NULL,NULL);
       }
   }
#line 4416 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 281:
#line 1719 "SDCC.y" /* yacc.c:1646  */
    {
       seqPointNo++;
       if (inCritical) {
           werror(E_INVALID_CRITICAL);
           (yyval.asts) = NULL;
       } else {
           (yyval.asts) = newNode(RETURN,NULL,(yyvsp[-1].asts));
       }
   }
#line 4430 "SDCCy.c" /* yacc.c:1646  */
    break;

  case 282:
#line 1731 "SDCC.y" /* yacc.c:1646  */
    { (yyval.sym) = newSymbol ((yyvsp[0].yychar),NestLevel) ; }
#line 4436 "SDCCy.c" /* yacc.c:1646  */
    break;


#line 4440 "SDCCy.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 1733 "SDCC.y" /* yacc.c:1906  */

