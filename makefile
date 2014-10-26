# makefile ksc

TARGET = hello

SRCDIR = ./src/
INCDIR = ./inc/
LIBDIR = ./lib/
BINDIR = ./bin/

#VPATH = src inc

# Run 'make show' with all targets for debugging variables
SHOW = show

# Designate Project Specific Libraries here.
# Common:  -lpthread -ldl

LIBS =

# ld -shared, cc -fPIC, AND ar rcsv added for shared/static targets
# ***  REMINDER:  add support for -soname  ***
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


DEFBLDS = all debug release dfull rfull shared dshared rshared static dstatic rstatic
DEFCMDS = show clean mkdirs

.PHONY : $(DEFBLDS)
.PHONY : $(DEFCMDS)


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
LDLIBS += $(DLDLIBS)
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
LDLIBS += $(DLDLIBS)
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
LDLIBS += $(RLDLIBS)
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
LDLIBS += $(DLDLIBS)
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
LDLIBS += $(RLDLIBS)
endif

ifeq ($(MAKECMDGOALS), shared)
LDTARGET = lib$(TARGET:=.so)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += -fPIC $(DCXXFLAGS)
CFLAGS += -fPIC $(DCFLAGS)
LDFLAGS += -shared -fPIC $(DLDFLAGS)
LDLIBS += $(DLDLIBS)
endif

ifeq ($(MAKECMDGOALS), dshared)
LDTARGET = lib$(TARGET:=.so)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += -fPIC $(DCXXFLAGS)
CFLAGS += -fPIC $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(DLDLIBS)
endif

ifeq ($(MAKECMDGOALS), rshared)
LDTARGET = lib$(TARGET:=.so)
TARDIR = $(BINDIR)release/
OBJDIR = $(BINDIR)release/obj/
DEPDIR = $(BINDIR)release/dep/
ASMDIR = $(BINDIR)release/asm/
CPPDIR = $(BINDIR)release/cpp/
CPPFLAGS += $(RCPPFLAGS)
CXXFLAGS += -fPIC $(RCXXFLAGS)
CFLAGS += -fPIC $(RCFLAGS)
LDFLAGS += $(RLDFLAGS)
LDLIBS += $(RLDLIBS)
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
CFLAGS += -fPIC $(DCFLAGS)
LDFLAGS += -shared -fPIC $(DLDFLAGS)
LDLIBS += $(DLDLIBS)
endif

ifeq ($(MAKECMDGOALS), dstatic)
LDTARGET = lib$(TARGET:=.a)
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += -fPIC $(DCXXFLAGS)
CFLAGS += -fPIC $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(DLDLIBS)
endif

ifeq ($(MAKECMDGOALS), rstatic)
LDTARGET = lib$(TARGET:=.a)
TARDIR = $(BINDIR)release/
OBJDIR = $(BINDIR)release/obj/
DEPDIR = $(BINDIR)release/dep/
ASMDIR = $(BINDIR)release/asm/
CPPDIR = $(BINDIR)release/cpp/
CPPFLAGS += $(RCPPFLAGS)
CXXFLAGS += -fPIC $(RCXXFLAGS)
CFLAGS += -fPIC $(RCFLAGS)
LDFLAGS += $(RLDFLAGS)
LDLIBS += $(RLDLIBS)
endif

ifeq ($(MAKECMDGOALS), clean)
LDTARGET = $(TARGET:=.*)
endif

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
LDLIBS += $(DLDLIBS)
endif


TESTST = $(DEFBLDS) $(DEFCMDS)


# Test routine for findsting logic - delete after commit
# Test ifeq empty/whitespace
ifeq ($(strip $(findstring $(MAKECMDGOALS), $(TESTST))),)
TESTIFEQ = "ifeq " $(strip $(findstring $(MAKECMDGOALS), $(TESTST)))
TESTIF = NOT FOUND $(TESTST)
else
TESTIFEQ = "ifeq " $(strip $(findstring $(MAKECMDGOALS), $(TESTST)))
TESTIF = FOUND $(TESTST)
endif

# Determine if DEFAULT build (no target passed to make) excluding whitespaces
ifeq ($(strip $(findstring $(MAKECMDGOALS), $(DEFBLDS) $(DEFCMDS))),)
DEFAULTBLD = true
TARDIR = $(BINDIR)debug/
OBJDIR = $(BINDIR)debug/obj/
DEPDIR = $(BINDIR)debug/dep/
ASMDIR = $(BINDIR)debug/asm/
CPPDIR = $(BINDIR)debug/cpp/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += $(DCXXFLAGS)
CFLAGS += $(DCFLAGS)
LDFLAGS += $(DLDFLAGS)
LDLIBS += $(DLDLIBS)
else
DEFAULTBLD = false
endif


SRCCCC := $(shell echo $(SRCDIR)*.c)
SRCCPP := $(shell echo $(SRCDIR)*.cpp)


ifeq ($(SRCCCC), $(SRCDIR)*.c)
SRCCCC = 
else
SRCEXT := .c
endif

ifeq ($(SRCCPP), $(SRCDIR)*.cpp)
SRCCPP = 
else
SRCEXT := .cpp
endif

ifeq ($(SRCEXT), .cpp)
CCC = $(CXX)
CCCFLAGS = $(CPPFLAGS) $(CXXFLAGS)
else
CCC = $(CC)
CCCFLAGS = $(CPPFLAGS) $(CFLAGS)
endif

OBJS := $(patsubst $(SRCDIR)%.c, $(OBJDIR)%.o, $(SRCCCC))
OBJS += $(patsubst $(SRCDIR)%.cpp, $(OBJDIR)%.opp, $(SRCCPP))

SRCDDD := $(patsubst $(SRCDIR)%.c, $(DEPDIR)%.d, $(SRCCCC))
SRCDPP := $(patsubst $(SRCDIR)%.cpp, $(DEPDIR)%.dpp, $(SRCCPP))

SRCSCC := $(patsubst $(SRCDIR)%.c, $(ASMDIR)%.s, $(SRCCCC))
SRCSPP := $(patsubst $(SRCDIR)%.cpp, $(ASMDIR)%.spp, $(SRCCPP))

SRCICC := $(patsubst $(SRCDIR)%.c, $(CPPDIR)%.i, $(SRCCCC))
SRCIPP := $(patsubst $(SRCDIR)%.cpp, $(CPPDIR)%.ipp, $(SRCCPP))


############### BEGIN RECIPES ###############


all : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "all Done - all/DEFAULT DEBUG!"

debug : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "debug Done!"

release : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "release Done!"

dfull : $(SHOW) $(TARDIR)$(LDTARGET) $(SRCSCC) $(SRCSPP) $(SRCICC) $(SRCIPP)
	@echo "dfull Done - DEBUG!"

rfull : $(SHOW) $(TARDIR)$(LDTARGET) $(SRCSCC) $(SRCSPP) $(SRCICC) $(SRCIPP)
	@echo "rfull Done - RELEASE!"

shared : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "all Done - all/DEFAULT DEBUG!"

dshared : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "all Done - all/DEFAULT DEBUG!"

rshared : $(SHOW) $(TARDIR)$(LDTARGET)
	@echo "all Done - all/DEFAULT DEBUG!"


# include all .d and .dpp makefiles from BINDIR/DEPDIR if not show/clean/mkdirs

ifneq ($(MAKECMDGOALS), show)
ifneq ($(MAKECMDGOALS), clean)
ifneq ($(MAKECMDGOALS), mkdirs)
include $(SRCDDD)
include $(SRCDPP)
endif
endif
endif

$(TARDIR)$(basename $(LDTARGET)).exe : $(OBJS)
	@echo "Compiling $@ from $^...."
	$(CCC) $(LDFLAGS) -L$(LIBDIR) $(LDLIBS) -o $@ $^
#	$(CCC) $(CCCFLAS) -I$(INCDIR) -L$(LIBDIR) $(LIBS) -o $@ $^

$(TARDIR)$(basename $(LDTARGET)).so : $(OBJS)
	@echo "Compiling $@ from $^...."
	$(CCC) -shared -fPIC $(LDFLAGS) -L$(LIBDIR) $(LDLIBS) -o $@ $^

$(TARDIR)$(basename $(LDTARGET)).a : $(OBJS)
	@echo "Compiling $@ from $^...."
	$(AR) rcsv $@ $^

$(OBJDIR)%.o : $(SRCDIR)%.c
	@echo "Compiling $<...."
	#include $(SRCDDD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -I$(INCDIR) -o $@ -c $<
#	$(CC) $(CPPFLAGS) $(CFLAGS) -I$(INCDIR) -L$(LIBDIR) $(LIBS) -o $@ -c $<


$(OBJDIR)%.opp : $(SRCDIR)%.cpp
	@echo "Compiling $<...."
	#include $(SRCDPP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -I$(INCDIR) -o $@ -c $<
#	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -I$(INCDIR) -L$(LIBDIR) $(LIBS) -o $@ -c $<

$(ASMDIR)%.s : $(SRCDIR)%.c
	@echo "Compiling to Assembly $<...."
	#include $(SRCDDD)
	$(CC) -S $(CPPFLAGS) $(CFLAGS) -I$(INCDIR) -o $@ $<

$(ASMDIR)%.spp : $(SRCDIR)%.cpp
	@echo "Compiling to Assembly $<...."
	#include $(SRCDPP)
	$(CXX) -S $(CPPFLAGS) $(CXXFLAGS) -I$(INCDIR) -o $@ $<

$(CPPDIR)%.i : $(SRCDIR)%.c
	@echo "Pre-Processing $<...."
	#include $(SRCDDD)
	cpp $(CPPFLAGS) -I$(INCDIR) $<  -o $@

$(CPPDIR)%.ipp : $(SRCDIR)%.cpp
	@echo "Pre-Processing $<...."
	#include $(SRCDPP)
	cpp $(CPPFLAGS) -I$(INCDIR) $<  -o $@


# Build all .d make files from SRCCCC
$(DEPDIR)%.d : $(SRCDIR)%.c
	@echo "Compiling $@...."
	@set -e; $(RM) $@; \
         $(CC) -M -I$(INCDIR) $(CPPFLAGS) $< > $@.$$$$; \
         sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
         $(RM) $@.$$$$


# Build all .dpp make files from SRCCPP
$(DEPDIR)%.dpp : $(SRCDIR)%.cpp
	@echo "Compiling $@...."
	@set -e; $(RM) $@; \
         $(CXX) -M -I$(INCDIR) $(CPPFLAGS) $< > $@.$$$$; \
         sed 's,\($*\)\.o[ :]*,\1.opp $@ : ,g' < $@.$$$$ > $@; \
         $(RM) $@.$$$$


# sed breakout for %.d : %.c target/depend rule
# converts $(CC) -M $< output saved in $@.$$$$ temp file from
# main.o : main.c module.h
# to
# main.o main.d : main.c moudle.h
#
# sed	begin sed command
# '	open quote for substitution pattern
# s,	designate substitution with comma ',' as the seperator
# \(	open group \1 with escape \ and (
# $*	target name minus the suffix
# \)	close group \1 with escape \ and )
# \.	change . character from REGEXP "anything" to single . with escap \
# [	open bracket expression - match a single character contained in brackets
# ' :'	' ' & ':' - characters to match in bracket expression
# ]	close bracket expression - match a single character contained in brackets
# *	match previous expression zero or more times. ' ', ':', ' :', ': '
# '	comma pattern seperator
# \1	refers to the characters captured by escaped parentheses, group 1
# .o	adds the .o extension back to group 1 caputred characters
# $@	insert the target file name (%.d)
#  : 	inster space colon space ' : ' as the target/depend seperator
# ,	comma pattern seperator
# g	repeat the substitution until EOL
# '	close quote for suptitution pattern
# <	input file redirection; input file created by CC to sed
# $@	use target filename
# .$$$$	append PID; $$$$ resolves to $$ in make; PID = Process ID of calling process
# >	out file redirection; output results to target file $@
# $(RM)	make rm/del replacement; resolves to rm -f on linux to remove temp file
# $@	target file name
# .$$$$	append PID; $$$$ resolves to $$ in make; PID = Process ID of calling process


show:
	@echo 'SRCCCC = '$(SRCCCC)
	@echo 'SRCCPP = '$(SRCCPP)
	@echo "TARDIR = "$(TARDIR)
	@echo "OBJDIR = "$(OBJDIR)
	@echo "BINDIR = "$(BINDIR)
	@echo "DEPDIR = "$(DEPDIR)
	@echo "ASMDIR = "$(ASMDIR)
	@echo "CPPDIR = "$(CPPDIR)
	@echo 'LIBS =   '$(LIBS)
	@echo 'OBJS =   '$(OBJS)
	@echo 'CCC =    '$(CCC)
	@echo 'CC =     '$(CC)
	@echo 'CXX =    '$(CXX)
	@echo 'SRCEXT = '$(SRCEXT)
	@echo 'RM =     '$(RM)
	@echo 'CPPFLAGS='$(CPPFLAGS)
	@echo 'CXXFLAGS='$(CXXFLAGS)
	@echo 'CFLAGS = '$(CFLAGS)
	@echo 'CCCFLAGS='$(CCCFLAGS)
	@echo "SRCCCC = "$(SRCCCC)
	@echo "SRCCPP = "$(SRCCPP)
	@echo "SRCDDD = "$(SRCDDD)
	@echo "SRCDPP = "$(SRCDPP)
	@echo "SRCSCC = "$(SRCSCC)
	@echo "SRCSPP = "$(SRCSPP)
	@echo "SRCICC = "$(SRCICC)
	@echo "SRCIPP = "$(SRCIPP)
	@echo "LDTARGET="$(LDTARGET)
	@echo "SHOW    ="$(SHOW)
	@echo "=========================================================="
	@echo "wildcard SRCDIR = "$(wildcard $(SRCDIR)*.c)
	@echo "words SRCDIR =  "$(words $(wildcard $(SRCDIR)*.c))
	@echo "words CPPFLAGS ="$(words $(CPPFLAGS))
	@echo "basename LDTARGET = "$(basename $(LDTARGET))
	@echo "suffix LDTARGET = "$(suffix $(LDTARGET))
	@echo "MAKECMDGOALS = "$(MAKECMDGOALS)
	@echo "DEFAULTBLD = "$(DEFAULTBLD)
	@echo "TESTST = "$(TESTST)
	@echo "TESTIF = "$(TESTIF)
	@echo "TESTIFEQ = "$(TESTIFEQ)
	@echo "=========================================================="


clean: $(SHOW)
	$(RM) $(BINDIR)debug/obj/*.o $(BINDIR)debug/obj/*.opp
	$(RM) $(BINDIR)release/obj/*.o $(BINDIR)release/obj/*.opp
	$(RM) $(BINDIR)debug/dep/*.d $(BINDIR)debug/dep/*.dpp
	$(RM) $(BINDIR)release/dep/*.d $(BINDIR)release/dep/*.dpp
	$(RM) $(BINDIR)debug/asm/*.s $(BINDIR)debug/asm/*.spp
	$(RM) $(BINDIR)release/asm/*.s $(BINDIR)release/asm/*.spp
	$(RM) $(BINDIR)debug/cpp/*.i $(BINDIR)debug/cpp/*.ipp
	$(RM) $(BINDIR)release/cpp/*.i $(BINDIR)release/cpp/*.ipp
	$(RM) $(BINDIR)debug/*.exe $(BINDIR)debug/*.so $(BINDIR)debug/*.ar
	$(RM) $(BINDIR)release/*.exe $(BINDIR)release/*.so $(BINDIR)release/*.ar


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

