#
#
#

# Version
VERSION         = 2.8.4
VERSIONHI       = 2
VERSIONLO       = 8
VERSIONP        = 4

# Programs
SHELL		= /bin/sh
CC		= gcc
CPP		= gcc -E
RANLIB		= ranlib
INSTALL		= /usr/bin/install -c
AUTOCONF        = :

# Directories
PRJDIR		= .

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

# Flags
DEFS            = $(subs -DHAVE_CONFIG_H,,-DHAVE_CONFIG_H)
CPPFLAGS        =  -I$(PRJDIR)
CFLAGS          = -pipe -ggdb -g -O2
M_OR_MM         = -MM


# Compiling entire program or any subproject
# ------------------------------------------
all: checkconf


# Compiling and installing everything and runing test
# ---------------------------------------------------
install: all installdirs


# Deleting all the installed files
# --------------------------------
uninstall:


# Performing self-test
# --------------------
check:


# Performing installation test
# ----------------------------
installcheck:


# Creating installation directories
# ---------------------------------
installdirs:


# Creating dependencies
# ---------------------
dep: #main.dep

#main.dep: *.c *.h
#	$(CPP) $(CPPFLAGS) $(M_OR_MM) *.c >main.dep

#-include main.dep
include $(srcdir)/clean.mk

# My rules
# --------
.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

.y.c:
	rm -f $*.cc $*.h
	$(YACC) -d $<
	mv y.tab.c $*.cc
	mv y.tab.h $*.h

.l.c:
	rm -f $*.cc
	$(LEX) -t $< >$*.cc


# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(PRJDIR)/devel ]; then\
	  $(MAKE) -f $(srcdir)/conf.mk srcdir="$(srcdir)" freshconf;\
	fi

# End of main_in.mk/main.mk

