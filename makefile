# Dynamic makefile for GNU gcc/g++/c/c++
# Author:  Kenneth Cascio
# Version: 3.1.0

# Set SHELL to use other than default /bin/sh
#SHELL = /bin/bash

# Set HOME env variable if not supported on build system.
#HOME =

# Define TARGET and TAREXT (target extension for binary - blank if none)
TARGET = hello
TAREXT = .exe

# Define Major, Minor, and Release versions for SHARED Libs / .so
SOMAJ = .1
SOMIN = .0
SOREL = .1

# Default directory tree for project
SRCDIR = ./src/
INCDIR = ./inc/
LIBDIR = ./lib/
BINDIR = ./bin/
LOGDIR = ./log/

# Default install directories
INSTALL_BIN = $(HOME)/bin/TESTBED/bin/
INSTALL_SHA = $(HOME)/bin/TESTBED/lib/
INSTALL_SYM = $(HOME)/bin/TESTBED/lib/
INSTALL_STA = $(HOME)/bin/TESTBED/lib/

# Un-comment to RUN 'make show' with all targets for debugging variables
SHOW = show

# Designate Project Specific Libraries here.
# Common:  -lpthread -ldl

LIBS =

# ld -shared, Wl,-soname=, cc -fPIC, AND ar rcsv added for shared/static targets
# the below flags are appended to any flags passed at the command line
# Common sqlite3 CPP flags: -DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_RTREE -DSQLITE_ENABLE_COLUMN_METADATA

RCPPFLAGS =
DCPPFLAGS =
RCXXFLAGS = -O2 -Wall -Wextra -Wfloat-equal -Weffc++ -std=c++11
DCXXFLAGS = -g3 -Wall -Wextra -Wfloat-equal -Weffc++ -std=c++11
RCFLAGS = -O2 -Wall -Wextra -Wfloat-equal -std=c99
DCFLAGS = -g3 -Wall -Wextra -Wfloat-equal -std=c99
RLDFLAGS =
DLDFLAGS =
RLDLIBS = $(LIBS)
DLDLIBS = $(LIBS)


############################# DO NOT EDIT BELOW THIS LINE ###############################

FALSE := 0
TRUE := 1

######################### BEGIN FUNCTION DEFINITIONS #########################

fnPREP = _$(1)_
fnTEST = $(findstring \#$(1)\#, $(patsubst %, \#%\#, $(2)))
fnTEST_ = $(words $(findstring \#$(1)\#, $(patsubst %, \#%\#, $(2))))

######################### END FUNCTION DEFINITIONS #########################


# Load *.c, *.cpp, *.so, and *.a files for processing via make wildcard function

SRCCCC := $(wildcard $(SRCDIR)*.c)
SRCCPP := $(wildcard $(SRCDIR)*.cpp)
SRCSHAR := $(wildcard $(LIBDIR)*.so*)
SRCSTAT := $(wildcard $(LIBDIR)*.a*)

# Resolve SRCSHAR & SRCSTAT results to -lmylib FLAGS for CCC/LD
# Embeded basename calls strip .so/.a and any MAJ MIN REL suffixes
# Resulting LIBSHAR and LIBSTAT are appended to LDLIBS
# Any .so or .a will automatically be added to LDLIBS by default

# TESTING ONLY - remove # to override wildcard pulls and test LIBSHAR & LIBSTAT values
#SRCSHAR := $(LIBDIR)libmysharedlib1.so.1.0.1 $(LIBDIR)libmysharedlib2.so.1.0.2
#SRCSTAT := $(LIBDIR)libmystaticlib1.a.1.0.1 $(LIBDIR)libmystaticlib2.a.1.0.2

SRCTEMP := $(basename $(basename $(basename $(basename $(SRCSHAR)))))
LIBSHAR := $(patsubst $(LIBDIR)lib%, -l%, $(SRCTEMP))

SRCTEMP := $(basename $(basename $(basename $(basename $(SRCSTAT)))))
LIBSTAT := $(patsubst $(LIBDIR)lib%, -l%, $(SRCTEMP))

# DEFINED BUILDS & DEFINED COMMANDS for expansion in .PHONY & build logic
# Any target with 'full' in the name will add additional dependencies for .i/.ii .s/.spp

DEFBINS_D := all debug debug_full dfull
DEFSHAR_D := shared dshared shared_full dshared_full
DEFSTAT_D := static dstatic static_full dstatic_full
DEFBINS_R := release release_full rfull
DEFSHAR_R := rshared rshared_full
DEFSTAT_R := rstatic rstatic_full
DEFCMDS := show clean mkdirs install
DEFBLDS := $(DEFBINS_D) $(DEFSHAR_D) $(DEFSTAT_D) $(DEFBINS_R) $(DEFSHAR_R) $(DEFSTAT_R)

#DEFCMDS_T := $(patsubst %, _%_, $(DEFCMDS))
#DEFBLDS_T := $(patsubst %, _%_, $(DEFBLDS))

# Define .PHONY targets

.PHONY : $(DEFBLDS)
.PHONY : $(DEFCMDS)

#### set MAKECMDGOALS_ (default = 'all)

ifeq (0, $(words $(MAKECMDGOALS)))
DEFAULTBLD := true
override MAKECMDGOALS_ := all
else
DEFAULTBLD := false
override MAKECMDGOALS_ := $(MAKECMDGOALS)
endif

# Load log files if command target only

ifeq ($(TRUE), $(call fnTEST_,$(MAKECMDGOALS_),$(DEFCMDS)))
LASTBUILD := $(strip $(shell tempvar=$$(cat $(LOGDIR)lastbuild.log); echo $$tempvar))
LASTTPATH := $(dir $(strip $(shell tempvar=$$(cat $(LOGDIR)target.log); echo $$tempvar)))
LASTTARGET := $(notdir $(strip $(shell tempvar=$$(cat $(LOGDIR)target.log); echo $$tempvar)))
LASTSONAME := $(strip $(shell tempvar=$$(cat $(LOGDIR)soname.log); echo $$tempvar))
THISBUILD := $(MAKECMDGOALS_)
else
THISBUILD := $(MAKECMDGOALS_)
endif

##########  START: Set directories and flags based on MAKECMDGOALS_  ##########

# DEFBIN_D
ifeq ($(MAKECMDGOALS_), $(findstring $(MAKECMDGOALS_), $(DEFBINS_D)))
LDTARGET = $(TARGET:=$(TAREXT))
LDSONAME =
LDLSNAME = $(LDTARGET)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
override CPPFLAGS += $(DCPPFLAGS)
override CXXFLAGS += $(DCXXFLAGS)
override CFLAGS += $(DCFLAGS)
override LDFLAGS += $(DLDFLAGS)
override LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
endif

# DEFBIN_R
ifeq ($(MAKECMDGOALS_), $(findstring $(MAKECMDGOALS_), $(DEFBINS_R)))
LDTARGET = $(TARGET:=$(TAREXT))
LDSONAME =
LDLSNAME = $(LDTARGET)
TARDIR = $(BINDIR)release/
OBJDIR = $(BINDIR)release/obj/
DEPDIR = $(BINDIR)release/dep/
ASMDIR = $(BINDIR)release/asm/
CPPDIR = $(BINDIR)release/cpp/
override CPPFLAGS += $(RCPPFLAGS)
override CXXFLAGS += $(RCXXFLAGS)
override CFLAGS += $(RCFLAGS)
override LDFLAGS += $(RLDFLAGS)
override LDLIBS += $(SRCSTAT) $(SRCSHAR) $(RLDLIBS)
endif

# DEFSHA_D
ifeq ($(MAKECMDGOALS_), $(findstring $(MAKECMDGOALS_), $(DEFSHAR_D)))
LDTARGET = lib$(TARGET:=.so)
LDSONAME = lib$(TARGET:=.so)$(SOMAJ)
LDLSNAME = lib$(TARGET:=.so)$(SOMAJ)$(SOMIN)$(SOREL)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
override CPPFLAGS += $(DCPPFLAGS)
override CXXFLAGS += -fPIC $(DCXXFLAGS)
override CFLAGS += -fPIC $(DCFLAGS)
override LDFLAGS += $(DLDFLAGS)
override LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

# DEFSHA_R
ifeq ($(MAKECMDGOALS_), $(findstring $(MAKECMDGOALS_), $(DEFSHAR_R)))
LDTARGET = lib$(TARGET:=.so)
LDSONAME = lib$(TARGET:=.so)$(SOMAJ)
LDLSNAME = lib$(TARGET:=.so)$(SOMAJ)$(SOMIN)$(SOREL)
TARDIR = $(BINDIR)release/
OBJDIR = $(BINDIR)release/obj/
DEPDIR = $(BINDIR)release/dep/
ASMDIR = $(BINDIR)release/asm/
CPPDIR = $(BINDIR)release/cpp/
override CPPFLAGS += $(RCPPFLAGS)
override CXXFLAGS += -fPIC $(RCXXFLAGS)
override CFLAGS += -fPIC $(RCFLAGS)
override LDFLAGS += $(RLDFLAGS)
override LDLIBS += $(SRCSTAT) $(SRCSHAR) $(RLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

# DEFSTA_D
ifeq ($(MAKECMDGOALS_), $(findstring $(MAKECMDGOALS_), $(DEFSTAS_D)))
LDTARGET = lib$(TARGET:=.a)
LDSONAME =
LDLSNAME = $(LDTARGET)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
override CPPFLAGS += $(DCPPFLAGS)
override CXXFLAGS += -fPIC $(DCXXFLAGS)
override CFLAGS += $(DCFLAGS)
override LDFLAGS += $(DLDFLAGS)
override LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

# DEFSTA_R
ifeq ($(MAKECMDGOALS_), $(findstring $(MAKECMDGOALS_), $(DEFSTAT_R)))
LDTARGET = lib$(TARGET:=.a)
LDSONAME =
LDLSNAME = $(LDTARGET)
TARDIR = $(BINDIR)release/
OBJDIR = $(BINDIR)release/obj/
DEPDIR = $(BINDIR)release/dep/
ASMDIR = $(BINDIR)release/asm/
CPPDIR = $(BINDIR)release/cpp/
override CPPFLAGS += $(RCPPFLAGS)
override CXXFLAGS += $(RCXXFLAGS)
override CFLAGS += $(RCFLAGS)
override LDFLAGS += $(RLDFLAGS)
override LDLIBS += $(SRCSTAT) $(SRCSHAR) $(RLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

##########  END: Set directories and flags based on MAKECMDGOALS_  ##########

# Setup CLEAN variables

ifeq ($(MAKECMDGOALS_), clean)
LDTARGET = $(TARGET:=.*)
LDSONAME =
LDLSNAME = $(LDTARGET)
endif


# Setup SHOW variables

ifeq ($(MAKECMDGOALS_), show)
THISBUILD := $(MAKECMDGOALS_)
LDTARGET = $(TARGET:=$(TAREXT))
LDSONAME =
LDLSNAME = $(LDTARGET)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
override CPPFLAGS += $(DCPPFLAGS)
override CXXFLAGS += $(DCXXFLAGS)
override CFLAGS += $(DCFLAGS)
override LDFLAGS += $(DLDFLAGS)
override LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
endif


# Setup INSTALL environment based on log files

ifeq ($(MAKECMDGOALS_), install)
INSTALL_MS := @echo "Nothing to install..."
INSTALL_CP := @echo "No files to copy..."
INSTALL_L1 := @echo "No major symlinks to create..."
INSTALL_L2 := @echo "No basename symlinks to create..."
# Check for BIN
ifeq ($(LASTBUILD), $(findstring $(LASTBUILD), $(DEFBINS)))
INSTALL_MS := @echo "Installing binary: $(LASTTARGET)"
INSTALL_CP := cp $(LASTTPATH)$(LASTTARGET) $(INSTALL_BIN)$(LASTTARGET)
endif
# Check for SHA
ifeq ($(LASTBUILD), $(findstring $(LASTBUILD), $(DEFSHAR)))
INSTALL_MS := @echo "Installing shared library: $(LASTTARGET)"
INSTALL_CP := cp -f $(LASTTPATH)$(LASTTARGET) $(INSTALL_SHA)$(LASTTARGET)
INSTALL_L1 := ln -fs $(INSTALL_SHA)$(LASTTARGET) $(INSTALL_SYM)$(LASTSONAME)
INSTALL_L2 := ln -fs $(INSTALL_SHA)$(LASTTARGET) $(INSTALL_SYM)$(basename $(LASTSONAME))
endif
# Check for STA
ifeq ($(LASTBUILD), $(findstring $(LASTBUILD), $(DEFSTAT)))
INSTALL_MS := @echo "Installing static library: $(LASTTARGET)"
INSTALL_CP := cp -f $(LASTTPATH)$(LASTTARGET) $(INSTALL_STA)$(LASTTARGET)
endif
endif


# TARGET CC/LD Control for .c, .cpp, and mixed projects; default .cpp if SRCCPP != ""

ifneq (0, $(words $(SRCCPP)))
SRCEXT := .cpp
CCC = $(CXX)
CCCFLAGS = $(CPPFLAGS) $(CXXFLAGS)
else
SRCEXT := .c
CCC = $(CC)
CCCFLAGS = $(CPPFLAGS) $(CFLAGS)
endif


# Use patsubst to setup build .c/.cpp, .d/.dpp, .s/.spp, and i/.ipp source strings

OBJCCC := $(patsubst $(SRCDIR)%.c, $(OBJDIR)%.o, $(SRCCCC))
OBJCPP := $(patsubst $(SRCDIR)%.cpp, $(OBJDIR)%.opp, $(SRCCPP))

SRCDDD := $(patsubst $(SRCDIR)%.c, $(DEPDIR)%.d, $(SRCCCC))
SRCDPP := $(patsubst $(SRCDIR)%.cpp, $(DEPDIR)%.dpp, $(SRCCPP))

SRCSCC := $(patsubst $(SRCDIR)%.c, $(ASMDIR)%.s, $(SRCCCC))
SRCSPP := $(patsubst $(SRCDIR)%.cpp, $(ASMDIR)%.spp, $(SRCCPP))

SRCICC := $(patsubst $(SRCDIR)%.c, $(CPPDIR)%.i, $(SRCCCC))
SRCIPP := $(patsubst $(SRCDIR)%.cpp, $(CPPDIR)%.ipp, $(SRCCPP))

OBJS := $(OBJCCC) $(OBJCPP)


# Setup FULL build additional dependencies if necessary

ifeq (full, $(findstring full, $(MAKECMDGOALS_)))
ADDFULL := $(SRCSCC) $(SRCSPP) $(SRCICC) $(SRCIPP)
else
ADDFULL :=
endif


######################### BEGIN TARGET DEFINITIONS #########################


# Define .PHONY Targets and Dependencies

$(DEFBINS_D) : $(SHOW) $(ADDFULL) $(TARDIR)$(LDTARGET)
	@echo $(THISBUILD) > $(LOGDIR)lastbuild.log
	@echo $(TARDIR)$(LDLSNAME) > $(LOGDIR)target.log
	@echo $(LDSONAME) > $(LOGDIR)soname.log
	@echo "All Done - DEFBINS_D/$(MAKECMDGOALS_)"

$(DEFBINS_R) : $(SHOW) $(ADDFULL) $(TARDIR)$(LDTARGET)
	@echo $(THISBUILD) > $(LOGDIR)lastbuild.log
	@echo $(TARDIR)$(LDLSNAME) > $(LOGDIR)target.log
	@echo $(LDSONAME) > $(LOGDIR)soname.log
	@echo "All Done - DEFBINS_R/$(MAKECMDGOALS_)"

$(DEFSHAR_D) : $(SHOW) $(ADDFULL) $(TARDIR)$(LDTARGET)
	@echo $(THISBUILD) > $(LOGDIR)lastbuild.log
	@echo $(TARDIR)$(LDLSNAME) > $(LOGDIR)target.log
	@echo $(LDSONAME) > $(LOGDIR)soname.log
	@echo "All Done - DEFSHAR_D/$(MAKECMDGOALS_)"

$(DEFSHAR_R) : $(SHOW) $(ADDFULL) $(TARDIR)$(LDTARGET)
	@echo $(THISBUILD) > $(LOGDIR)lastbuild.log
	@echo $(TARDIR)$(LDLSNAME) > $(LOGDIR)target.log
	@echo $(LDSONAME) > $(LOGDIR)soname.log
	@echo "All Done - DEFSHAR_R/$(MAKECMDGOALS_)"

$(DEFSTAT_D) : $(SHOW) $(ADDFULL) $(TARDIR)$(LDTARGET)
	@echo $(THISBUILD) > $(LOGDIR)lastbuild.log
	@echo $(TARDIR)$(LDLSNAME) > $(LOGDIR)target.log
	@echo $(LDSONAME) > $(LOGDIR)soname.log
	@echo "All Done - DEFSTAT_D/$(MAKECMDGOALS_)"

$(DEFSTAT_R) : $(SHOW) $(ADDFULL) $(TARDIR)$(LDTARGET)
	@echo $(THISBUILD) > $(LOGDIR)lastbuild.log
	@echo $(TARDIR)$(LDLSNAME) > $(LOGDIR)target.log
	@echo $(LDSONAME) > $(LOGDIR)soname.log
	@echo "All Done - DEFSTAT_R/$(MAKECMDGOALS_)"


# Include .d and .dpp makefile dependencies when MAKECMDGOALS_ != DEFCMDS


###### FIX 'all' in 'install' bug  ###############################################
ifeq ($(TRUE), $(call fnTEST_,$(MAKECMDGOALS_),$(DEFBLDS)))
include $(SRCDDD)
include $(SRCDPP)
endif

# Specific target dependencies & recipes: .exe, .so, .a, .o, .opp, .s, spp, .i, .ipp, .d, .dpp

$(TARDIR)$(basename $(LDTARGET))$(TAREXT) : $(OBJS)
	@echo "Compiling $@ from $^...."
	$(CCC) $(LDFLAGS) -L$(LIBDIR) -o $@ $^ $(LDLIBS)

$(TARDIR)$(basename $(LDTARGET)).so : $(OBJS)
	@echo "Compiling $@ from $^...."
	$(CCC) -shared -fPIC $(LDFLAGS) -L$(LIBDIR) \
	 -Wl,-soname=$(LDSONAME) -o $@$(SOMAJ)$(SOMIN)$(SOREL) $^ $(LDLIBS)

$(TARDIR)$(basename $(LDTARGET)).a : $(OBJS)
	@echo "Compiling $@ from $^...."
	$(AR) rcsv $@ $^

$(OBJDIR)%.o : $(SRCDIR)%.c
	@echo "Compiling $@ from $<...."
	$(CC) $(CPPFLAGS) $(CFLAGS) -I$(INCDIR) -o $@ -c $<

$(OBJDIR)%.opp : $(SRCDIR)%.cpp
	@echo "Compiling $@ from $<...."
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -I$(INCDIR) -o $@ -c $<

$(ASMDIR)%.s : $(SRCDIR)%.c
	@echo "Compiling $@ from $<...."
	$(CC) -S $(CPPFLAGS) $(CFLAGS) -I$(INCDIR) -o $@ $<

$(ASMDIR)%.spp : $(SRCDIR)%.cpp
	@echo "Compiling $@ from $<...."
	$(CXX) -S $(CPPFLAGS) $(CXXFLAGS) -I$(INCDIR) -o $@ $<

$(CPPDIR)%.i : $(SRCDIR)%.c
	@echo "Compiling $@ from $<...."
	cpp $(CPPFLAGS) -I$(INCDIR) $<  -o $@

$(CPPDIR)%.ipp : $(SRCDIR)%.cpp
	@echo "Compiling $@ from $<...."
	cpp $(CPPFLAGS) -I$(INCDIR) $<  -o $@

# Build all .d make files from SRCCCC
$(DEPDIR)%.d : $(SRCDIR)%.c
	@echo "Compiling $@ from $<...."
	@set -e; $(RM) $@; \
         $(CC) -M -I$(INCDIR) $(CPPFLAGS) $< > $@.$$$$; \
         sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
         $(RM) $@.$$$$

# Build all .dpp make files from SRCCPP
$(DEPDIR)%.dpp : $(SRCDIR)%.cpp
	@echo "Compiling $@ from $<...."
	@set -e; $(RM) $@; \
         $(CXX) -M -I$(INCDIR) $(CPPFLAGS) $< > $@.$$$$; \
         sed 's,\($*\)\.o[ :]*,\1.opp $@ : ,g' < $@.$$$$ > $@; \
         $(RM) $@.$$$$


show:
	@echo "**************************  BEGIN SHOW  **************************"
	@echo "MAKECMDGOALS  = "$(MAKECMDGOALS)
	@echo "words         = "$(words $(MAKECMDGOALS))
	@echo "MAKECMDGOALS_ = "$(MAKECMDGOALS_)
	@echo "test to       = "$(findstring $(MAKECMDGOALS_), $(DEFCMDS))
	@echo "DEFBINS_D = "$(DEFBINS_D)
	@echo "DEFBINS_R = "$(DEFBINS_R)
	@echo "DEFSHAR_D = "$(DEFSHAR_D)
	@echo "DEFSTAT_D = "$(DEFSTAT_D)
	@echo "DEFSTAT_R = "$(DEFSTAT_R)
	@echo "DEFCMDS = "$(DEFCMDS)
	@echo "DEFBLDS = "$(DEFBLDS)
	@echo "DEFCMDS_T = "$(DEFCMDS_T)
	@echo "DEFBLDS_T = "$(DEFBLDS_T)
	@echo "SRCCCC = "$(SRCCCC)
	@echo "SRCCPP = "$(SRCCPP)
	@echo "TARDIR = "$(TARDIR)
	@echo "OBJDIR = "$(OBJDIR)
	@echo "BINDIR = "$(BINDIR)
	@echo "DEPDIR = "$(DEPDIR)
	@echo "ASMDIR = "$(ASMDIR)
	@echo "CPPDIR = "$(CPPDIR)
	@echo "LOGDIR = "$(LOGDIR)
	@echo "LIBS   = "$(LIBS)
	@echo "OBJS   = "$(OBJS)
	@echo "OBJCCC = "$(OBJCCC)
	@echo "OBJCPP = "$(OBJCPP)
	@echo "CCC    = "$(CCC)
	@echo "CC     = "$(CC)
	@echo "CXX    = "$(CXX)
	@echo "AR     = "$(AR)
	@echo "SRCEXT = "$(SRCEXT)
	@echo "RM     =  "$(RM)
	@echo "CPPFLAGS = "$(CPPFLAGS)
	@echo "CXXFLAGS = "$(CXXFLAGS)
	@echo "CFLAGS   = "$(CFLAGS)
	@echo "CCCFLAGS = "$(CCCFLAGS)
	@echo "SRCCCC = "$(SRCCCC)
	@echo "SRCCPP = "$(SRCCPP)
	@echo "SRCDDD = "$(SRCDDD)
	@echo "SRCDPP = "$(SRCDPP)
	@echo "SRCSCC = "$(SRCSCC)
	@echo "SRCSPP = "$(SRCSPP)
	@echo "SRCICC = "$(SRCICC)
	@echo "SRCIPP = "$(SRCIPP)
	@echo "LDTARGET = "$(LDTARGET)
	@echo "LDFLAGS  = "$(LDFLAGS)
	@echo "LDLIBS   = "$(LDLIBS)
	@echo "SRCSHAR  = "$(SRCSHAR)
	@echo "SRCSTAT  = "$(SRCSTAT)
	@echo "LIBSTAT  = "$(LIBSTAT)
	@echo "LIBSHAR  = "$(LIBSHAR)
	@echo "ADDFULL = "$(ADDFULL)
	@echo "SHOW = "$(SHOW)
	@echo "=====================  TEST VARIABLES/FUNCTIONS ====================="
	@echo "wildcard SRCDIR = "$(wildcard $(SRCDIR)*.c)
	@echo "words SRCDIR =  "$(words $(wildcard $(SRCDIR)*.c))
	@echo "words CPPFLAGS = "$(words $(CPPFLAGS))
	@echo "basename LDTARGET = "$(basename $(LDTARGET))
	@echo "suffix LDTARGET = "$(suffix $(LDTARGET))
	@echo "DEFAULTBLD = "$(DEFAULTBLD)
	@echo "INSTALL_BIN = "$(INSTALL_BIN)
	@echo "INSTALL_SHA = "$(INSTALL_SHA)
	@echo "INSTALL_SYM = "$(INSTALL_SYM)
	@echo "INSTALL_STA = "$(INSTALL_STA)
	@echo "PLATFORM = "$(PLATFORM)
	@echo "THISBUILD = "$(THISBUILD)
	@echo "LASTBUILD = "$(LASTBUILD)
	@echo "LASTTPATH = "$(LASTTPATH)
	@echo "LASTTARGET = "$(LASTTARGET)
	@echo "LASTSONAME = "$(LASTSONAME)
	@echo "HOME = "$(HOME)
	@echo "call fnPREP = "$(call fnPREP,$(MAKECMDGOALS_))
	@echo "call fnTEST = "$(call fnTEST,$(MAKECMDGOALS_),$(DEFCMDS))
	@echo "call fnTEST_ = "$(call fnTEST_,$(MAKECMDGOALS_),$(DEFCMDS))
	@echo "TRUE = "$(TRUE)
	@echo "FALSE = "$(FALSE)
	@echo "MAKECMDGOALS_ = "$(MAKECMDGOALS_)
	@echo "DEFCMDS       = "$(DEFCMDS)
	@echo "============================  END SHOW  ============================"

clean: $(SHOW)
	$(RM) $(BINDIR)debug/obj/*.o $(BINDIR)debug/obj/*.opp
	$(RM) $(BINDIR)release/obj/*.o $(BINDIR)release/obj/*.opp
	$(RM) $(BINDIR)debug/dep/*.d $(BINDIR)debug/dep/*.dpp
	$(RM) $(BINDIR)release/dep/*.d $(BINDIR)release/dep/*.dpp
	$(RM) $(BINDIR)debug/asm/*.s $(BINDIR)debug/asm/*.spp
	$(RM) $(BINDIR)release/asm/*.s $(BINDIR)release/asm/*.spp
	$(RM) $(BINDIR)debug/cpp/*.i $(BINDIR)debug/cpp/*.ipp
	$(RM) $(BINDIR)release/cpp/*.i $(BINDIR)release/cpp/*.ipp
	$(RM) $(BINDIR)debug/$(TARGET) $(BINDIR)debug/$(TARGET).* $(BINDIR)debug/*.so* $(BINDIR)debug/*.a*
	$(RM) $(BINDIR)release/$(TARGET) $(BINDIR)release/$(TARGET).* $(BINDIR)release/*.so* $(BINDIR)release/*.a*
	$(RM) $(LOGDIR)*

mkdirs: $(SHOW)
	mkdir -p $(SRCDIR)
	mkdir -p $(INCDIR)
	mkdir -p $(LIBDIR)
	mkdir -p $(LOGDIR)
	mkdir -p $(BINDIR)debug/obj
	mkdir -p $(BINDIR)debug/dep
	mkdir -p $(BINDIR)debug/asm
	mkdir -p $(BINDIR)debug/cpp
	mkdir -p $(BINDIR)release/obj
	mkdir -p $(BINDIR)release/dep
	mkdir -p $(BINDIR)release/asm
	mkdir -p $(BINDIR)release/cpp
	mkdir -p $(INSTALL_BIN)
	mkdir -p $(INSTALL_SHA)
	mkdir -p $(INSTALL_SYM)
	mkdir -p $(INSTALL_STA)

install: $(SHOW)
	$(INSTALL_MS)
	$(INSTALL_CP)
	$(INSTALL_L1)
	$(INSTALL_L2)
	@echo "Install Complete!"
	ls -lah $(INSTALL_BIN)
	ls -lah $(INSTALL_SHA)
	
