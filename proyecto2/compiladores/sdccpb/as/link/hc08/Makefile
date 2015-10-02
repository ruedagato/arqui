#
#
#

VERSION         = 2.8.4
VERSIONHI       = 2
VERSIONLO       = 8
VERSIONP        = 4

SHELL           = /bin/sh
CC              = gcc
CPP             = gcc -E
INSTALL         = /usr/bin/install -c
STRIP           = strip

top_builddir    = ../../..
top_srcdir      = ../../..

srcdir          = .
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
infodir         = @info@

EXEEXT          = 



CPPFLAGS        =  -I$(srcdir)/.. -I$(top_builddir)
CFLAGS          = -pipe -ggdb -g -O2 -Wall -DUNIX -I$(srcdir)/.. -I$(top_builddir)
M_OR_MM         = -MM
LDFLAGS         = 

OBJDIR = obj

ASXXLIB = $(srcdir)/../../asxxsrc

LKLIB = $(srcdir)/..

ASXXLIBSRC = strcmpi.c

LKLIBSRC = lkaomf51.c lkdata.c lkeval.c \
           lkhead.c lklex.c lklibr.c lklist.c \
           lknoice.c lkstore.c lksym.c

SRC = lkmain.c lkarea.c lkihx.c \
      lkrloc.c lks19.c lkelf.c lkmem.c

LKSOURCES = $(SRC) $(LKLIBSRC:%.c=$(LKLIB)/%.c) $(ASXXLIBSRC:%.c=$(ASXXLIB)/%.c)

OBJS = $(SRC:%.c=$(OBJDIR)/%.o)
LKOBJS = $(LKLIBSRC:%.c=$(OBJDIR)/%.o)
ASXXLIBOBJS = $(ASXXLIBSRC:%.c=$(OBJDIR)/%.o)
LKOBJECTS = $(OBJS) $(LKOBJS) $(ASXXLIBOBJS)

ASLINK = $(top_builddir)/bin/link-hc08$(EXEEXT)

transform       = s,x,x,

# Compiling entire program or any subproject
# ------------------------------------------
all: checkconf $(ASLINK)
#all:
#	echo $(LKSOURCES)

$(ASLINK): $(LKOBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(LKOBJECTS)

# Compiling and installing everything and running test
# ----------------------------------------------------
install: all installdirs
	$(INSTALL) $(ASLINK) `echo $(DESTDIR)$(bindir)/link-hc08$(EXEEXT)|sed '$(transform)'`
	$(STRIP) `echo $(DESTDIR)$(bindir)/link-hc08$(EXEEXT)|sed '$(transform)'`

# Deleting all the installed files
# --------------------------------
uninstall:
	rm -f $(DESTDIR)$(bindir)/link-hc08$(EXEEXT)


# Performing self-test
# --------------------
check:


# Performing installation test
# ----------------------------
installcheck:


# Creating installation directories
# ---------------------------------
installdirs:
	$(INSTALL) -d $(DESTDIR)$(bindir)


# Creating dependencies
# ---------------------
dep: Makefile.dep

Makefile.dep: $(LKSOURCES) $(LKLIB)/*.h $(top_builddir)/*.h
	$(CPP) $(CPPFLAGS) $(M_OR_MM) $(filter %.c,$^) >Makefile.dep

ifeq "$(findstring $(MAKECMDGOALS),uninstall check installcheck installdirs \
                                   clean distclean mostlyclean realclean)" ""
  -include Makefile.dep
endif
include $(srcdir)/clean.mk

# My rules
# --------
$(OBJDIR)/.stamp:
	mkdir -p $(OBJDIR)
	touch $(OBJDIR)/.stamp

$(OBJDIR)/%.o: %.c $(OBJDIR)/.stamp
	$(CC) -c $(CFLAGS) -o $@ $<

$(OBJDIR)/%.o: $(LKLIB)/%.c $(OBJDIR)/.stamp
	$(CC) -c $(CFLAGS) -o $@ $<

$(OBJDIR)/%.o: $(ASXXLIB)/%.c $(OBJDIR)/.stamp
	$(CC) -c $(CFLAGS) -o $@ $<


# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then\
          $(MAKE) -f conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" freshconf;\
        fi

# End of Makefile
