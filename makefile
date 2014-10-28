# Dynamic makefile for GNU gcc/g++/c/c++
# Author:  Kenneth Cascio
# Version: 2.0.2


# Define TARGET w/out extension 
TARGET = hello

# Define Major, Minor, and Release versions for SHARED Libs / .so
SOMAJ = .1
SOMIN = .0
SOREL = .1

# Default directory tree for project
SRCDIR = ./src/
INCDIR = ./inc/
LIBDIR = ./lib/
BINDIR = ./bin/

# Un-comment to RUN 'make show' with all targets for debugging variables
#SHOW = show

# Designate Project Specific Libraries here.
# Common:  -lpthread -ldl

LIBS =

# ld -shared, Wl,-soname=, cc -fPIC, AND ar rcsv added for shared/static targets
# the below flags are appended to any flags passed at the command line

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


# Load *.c, *.cpp, *.so, and *.a files for processing via make wildcard function

SRCCCC := $(wildcard $(SRCDIR)*.c)
SRCCPP := $(wildcard $(SRCDIR)*.cpp)
SRCSHAR := $(wildcard $(LIBDIR)*.so*)
SRCSTAT := $(wildcard $(LIBDIR)*.a*)

# Resolve SRCSHAR & SRCSTAT results to -lmylib FLAGS for CCC/LD
# Embeded basename calls strip .so/.a and any MAJ MIN REL suffixes
# Resulting LIBSHAR and LIBSTAT are appended to LDLIBS
# Any .so or .a will automatically be added to LDLIBS by default

# TESTING ONLY - remove # to overide wildcard pulls and test LIBSHAR & LIBSTAT values
#SRCSHAR := $(LIBDIR)libmysharedlib1.so.1.0.1 $(LIBDIR)libmysharedlib2.so.1.0.2
#SRCSTAT := $(LIBDIR)libmystaticlib1.a.1.0.1 $(LIBDIR)libmystaticlib2.a.1.0.2

SRCTEMP := $(basename $(basename $(basename $(basename $(SRCSHAR)))))
LIBSHAR := $(patsubst $(LIBDIR)lib%, -l%, $(SRCTEMP))

SRCTEMP := $(basename $(basename $(basename $(basename $(SRCSTAT)))))
LIBSTAT := $(patsubst $(LIBDIR)lib%, -l%, $(SRCTEMP))

# DEFINED BUILDS & DEFINED COMMANDS for expansion in .PHONY & build logic

DEFBLDS = all debug release dfull rfull shared dshared rshared static dstatic rstatic
DEFCMDS = show clean mkdirs

# Define .PHONY targets

.PHONY : $(DEFBLDS)
.PHONY : $(DEFCMDS)

# Set directories and flags based on MAKECMDGOALS

ifeq ($(MAKECMDGOALS), all)
LDTARGET = $(TARGET:=.exe)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += $(DCXXFLAGS)
CFLAGS += $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
endif

ifeq ($(MAKECMDGOALS), debug)
LDTARGET = $(TARGET:=.exe)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += $(DCXXFLAGS)
CFLAGS += $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
endif

ifeq ($(MAKECMDGOALS), release)
LDTARGET = $(TARGET:=.exe)
TARDIR = $(BINDIR)release/
OBJDIR = $(BINDIR)release/obj/
DEPDIR = $(BINDIR)release/dep/
ASMDIR = $(BINDIR)release/asm/
CPPDIR = $(BINDIR)release/cpp/
CPPFLAGS += $(RCPPFLAGS)
CXXFLAGS += $(RCXXFLAGS)
CFLAGS += $(RCFLAGS)
LDFLAGS += $(RLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(RLDLIBS)
endif

ifeq ($(MAKECMDGOALS), dfull)
LDTARGET = $(TARGET:=.exe)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += $(DCXXFLAGS)
CFLAGS += $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
endif

ifeq ($(MAKECMDGOALS), rfull)
LDTARGET = $(TARGET:=.exe)
TARDIR = $(BINDIR)release/
OBJDIR = $(BINDIR)release/obj/
DEPDIR = $(BINDIR)release/dep/
ASMDIR = $(BINDIR)release/asm/
CPPDIR = $(BINDIR)release/cpp/
CPPFLAGS += $(RCPPFLAGS)
CXXFLAGS += $(RCXXFLAGS)
CFLAGS += $(RCFLAGS)
LDFLAGS += $(RLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(RLDLIBS)
endif

ifeq ($(MAKECMDGOALS), shared)
LDTARGET = lib$(TARGET:=.so)
LDSONAME = lib$(TARGET:=.so)$(SOMAJ)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += -fPIC $(DCXXFLAGS)
CFLAGS += -fPIC $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

ifeq ($(MAKECMDGOALS), dshared)
LDTARGET = lib$(TARGET:=.so)
LDSONAME = lib$(TARGET:=.so)$(SOMAJ)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += -fPIC $(DCXXFLAGS)
CFLAGS += -fPIC $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

ifeq ($(MAKECMDGOALS), rshared)
LDTARGET = lib$(TARGET:=.so)
LDSONAME = lib$(TARGET:=.so)$(SOMAJ)
TARDIR = $(BINDIR)release/
OBJDIR = $(BINDIR)release/obj/
DEPDIR = $(BINDIR)release/dep/
ASMDIR = $(BINDIR)release/asm/
CPPDIR = $(BINDIR)release/cpp/
CPPFLAGS += $(RCPPFLAGS)
CXXFLAGS += -fPIC $(RCXXFLAGS)
CFLAGS += -fPIC $(RCFLAGS)
LDFLAGS += $(RLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(RLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

ifeq ($(MAKECMDGOALS), static)
LDTARGET = lib$(TARGET:=.a)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += -fPIC $(DCXXFLAGS)
CFLAGS += $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

ifeq ($(MAKECMDGOALS), dstatic)
LDTARGET = lib$(TARGET:=.a)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += $(DCXXFLAGS)
CFLAGS += $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

ifeq ($(MAKECMDGOALS), rstatic)
LDTARGET = lib$(TARGET:=.a)
TARDIR = $(BINDIR)release/
OBJDIR = $(BINDIR)release/obj/
DEPDIR = $(BINDIR)release/dep/
ASMDIR = $(BINDIR)release/asm/
CPPDIR = $(BINDIR)release/cpp/
CPPFLAGS += $(RCPPFLAGS)
CXXFLAGS += $(RCXXFLAGS)
CFLAGS += $(RCFLAGS)
LDFLAGS += $(RLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(RLDLIBS)
TMPCCC := $(patsubst $(SRCDIR)main.c, , $(SRCCCC))
TMPCPP := $(patsubst $(SRCDIR)main.cpp, , $(SRCCPP))
SRCCCC := $(TMPCCC)
SRCCPP := $(TMPCPP)
endif

ifeq ($(MAKECMDGOALS), clean)
LDTARGET = $(TARGET:=.*)
endif

# Load typical environment for show

ifeq ($(MAKECMDGOALS), show)
LDTARGET = $(TARGET:=.exe)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += $(DCXXFLAGS)
CFLAGS += $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
endif

# Determine if DEFAULT build (no target passed to make) excluding whitespaces
# Set to DEBUG defaults (copied from 'debug')

ifeq ($(strip $(findstring $(MAKECMDGOALS), $(DEFBLDS) $(DEFCMDS))),)
DEFAULTBLD = true
LDTARGET = $(TARGET:=.exe)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += $(DCXXFLAGS)
CFLAGS += $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(SRCSTAT) $(SRCSHAR) $(DLDLIBS)
else
DEFAULTBLD = false
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

OBJS := $(patsubst $(SRCDIR)%.c, $(OBJDIR)%.o, $(SRCCCC))
OBJS += $(patsubst $(SRCDIR)%.cpp, $(OBJDIR)%.opp, $(SRCCPP))

SRCDDD := $(patsubst $(SRCDIR)%.c, $(DEPDIR)%.d, $(SRCCCC))
SRCDPP := $(patsubst $(SRCDIR)%.cpp, $(DEPDIR)%.dpp, $(SRCCPP))

SRCSCC := $(patsubst $(SRCDIR)%.c, $(ASMDIR)%.s, $(SRCCCC))
SRCSPP := $(patsubst $(SRCDIR)%.cpp, $(ASMDIR)%.spp, $(SRCCPP))

SRCICC := $(patsubst $(SRCDIR)%.c, $(CPPDIR)%.i, $(SRCCCC))
SRCIPP := $(patsubst $(SRCDIR)%.cpp, $(CPPDIR)%.ipp, $(SRCCPP))


######################### BEGIN RECIPES #########################

# Define .PHONY Targets and Dependencies

all : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "all Done - all/DEFAULT DEBUG!"

debug : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "debug Done!"

release : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "release Done!"

dfull : $(SHOW) $(SRCSCC) $(SRCSPP) $(SRCICC) $(SRCIPP) $(TARDIR)$(LDTARGET)
	@echo "dfull Done!"

rfull : $(SHOW) $(SRCSCC) $(SRCSPP) $(SRCICC) $(SRCIPP) $(TARDIR)$(LDTARGET)
	@echo "rfull Done!"

shared : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "shared Done!"

dshared : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "dshared Done!"

rshared : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "rshared Done!"

static : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "static Done!"

dstatic : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "dstatic Done!"

rstatic : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "rstatic Done!"


# Include .d and .dpp makefile dependencies when MAKECMDGOALS != DEFCMDS

ifeq ($(strip $(findstring $(MAKECMDGOALS), $(DEFCMDS))),)
include $(SRCDDD)
include $(SRCDPP)
endif


# Specific target dependencies & recipes: .exe, .so, .a, .o, .opp, .s, spp, .i, .ipp, .d, .dpp

$(TARDIR)$(basename $(LDTARGET)).exe : $(OBJS)
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
	@echo "MAKECMDGOALS = "$(MAKECMDGOALS)
	@echo "SRCCCC = "$(SRCCCC)
	@echo "SRCCPP = "$(SRCCPP)
	@echo "TARDIR = "$(TARDIR)
	@echo "OBJDIR = "$(OBJDIR)
	@echo "BINDIR = "$(BINDIR)
	@echo "DEPDIR = "$(DEPDIR)
	@echo "ASMDIR = "$(ASMDIR)
	@echo "CPPDIR = "$(CPPDIR)
	@echo "LIBS   = "$(LIBS)
	@echo "OBJS   = "$(OBJS)
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
	@echo "SHOW = "$(SHOW)
	@echo "=====================  TEST VARIABLS/FUNCTIONS ====================="
	@echo "wildcard SRCDIR = "$(wildcard $(SRCDIR)*.c)
	@echo "words SRCDIR =  "$(words $(wildcard $(SRCDIR)*.c))
	@echo "words CPPFLAGS = "$(words $(CPPFLAGS))
	@echo "basename LDTARGET = "$(basename $(LDTARGET))
	@echo "suffix LDTARGET = "$(suffix $(LDTARGET))
	@echo "DEFAULTBLD = "$(DEFAULTBLD)
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
	$(RM) $(BINDIR)debug/*.exe $(BINDIR)debug/*.so* $(BINDIR)debug/*.a*
	$(RM) $(BINDIR)release/*.exe $(BINDIR)release/*.so* $(BINDIR)release/*.a*


mkdirs: $(SHOW)
	mkdir -p $(SRCDIR)
	mkdir -p $(INCDIR)
	mkdir -p $(LIBDIR)
	mkdir -p $(BINDIR)debug/obj
	mkdir -p $(BINDIR)debug/dep
	mkdir -p $(BINDIR)debug/asm
	mkdir -p $(BINDIR)debug/cpp
	mkdir -p $(BINDIR)release/obj
	mkdir -p $(BINDIR)release/dep
	mkdir -p $(BINDIR)release/asm
	mkdir -p $(BINDIR)release/cpp