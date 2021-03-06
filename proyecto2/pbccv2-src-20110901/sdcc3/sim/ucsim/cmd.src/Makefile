#
# ucsim cmd.src/Makefile
#
# (c) Drotos Daniel, Talker Bt. 1997
#

STARTYEAR	= 1997

SHELL		= /bin/sh
CXX		= g++
CPP		= gcc -E
CXXCPP		= g++ -E
RANLIB		= ranlib
INSTALL	        = /usr/bin/install -c
MAKEDEP         = g++ -MM

LEX		= flex
YACC		= bison -y
BISON_PLUS_PLUS	= :

top_builddir	= ..
top_srcdir	= ..

DEFS            = $(subs -DHAVE_CONFIG_H,,-DHAVE_CONFIG_H)
CPPFLAGS        =  -I$(srcdir) -I$(top_srcdir) -I$(top_builddir) \
		  -I$(top_srcdir)/sim.src -I$(top_srcdir)/gui.src
CFLAGS          = -g -O2 -Wall
CXXFLAGS        = -g -O2 -g -Wall
WINSOCK_AVAIL   = 0

prefix          = /usr/local
exec_prefix     = ${prefix}
bindir          = ${exec_prefix}/bin
libdir          = ${exec_prefix}/lib
datadir         = ${datarootdir}
datarootdir     = ${prefix}/share
includedir      = ${prefix}/include
mandir          = ${datarootdir}/man
man1dir         = $(mandir)/man1
man2dir         = $(mandir)/man2
infodir         = ${datarootdir}/info
srcdir          = .


OBJECTS		= cmdset.o command.o cmdutil.o syntax.o \
		  get.o set.o timer.o bp.o info.o show.o cmdgui.o cmdconf.o \
		  cmduc.o cmdstat.o cmdmem.o \
		  cmdpars.o cmdlex.o newcmd.o

ifeq ($(WINSOCK_AVAIL), 1)
OBJECTS += newcmdwin32.o
else
OBJECTS += newcmdposix.o
endif

DEVEL		= $(shell test -d $(top_builddir)/devel && echo yes)

# Compiling entire program or any subproject
# ------------------------------------------
all: checkconf cmdlib

cmd.src: all


# Compiling and installing everything and runing test
# ---------------------------------------------------
install: all installdirs


# Deleting all the installed files
# --------------------------------
uninstall:


# Performing self-test
# --------------------
check:

test:


# Performing installation test
# ----------------------------
installcheck:


# Creating installation directories
# ---------------------------------
installdirs:


# Creating dependencies
# ---------------------
dep: Makefile.dep

Makefile.dep: $(srcdir)/*.cc $(srcdir)/*.h
	$(MAKEDEP) $(CPPFLAGS) $(addprefix $(srcdir)/, $(OBJECTS:.o=.cc)) >Makefile.dep

-include Makefile.dep
include $(srcdir)/clean.mk

cmdpars.cc: cmdpars.y

ifeq ($(DEVEL),yes)
  cmdlex.cc: cmdlex.l cmdpars.h
endif

# My rules
# --------

cmdlib: $(top_builddir)/libcmd.a

$(top_builddir)/libcmd.a: $(OBJECTS)
	ar -rcu $*.a $(OBJECTS)
	$(RANLIB) $*.a

.cc.o:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@

#.y.cc:
#	rm -f $*.cc $*.h
#	$(YACC) -d $<
#	mv y.tab.c $*.cc
#	mv y.tab.h $*.h

ifeq ($(DEVEL),yes)
.y.cc:
	rm -f $*.cc $*.h
	$(BISON_PLUS_PLUS) -d -o $*.cc $<

.l.cc:
	rm -f $*.cc
	$(LEX) --c++ -o $*.cc $<
endif


# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then\
	  $(MAKE) -f conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" freshconf;\
	fi

# End of cmd.src/Makefile.in
