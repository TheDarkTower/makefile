# makefile ksc

TARGET = hello.exe

SRCDIR = ./src/
INCDIR = ./inc/
LIBDIR = ./lib/
BINDIR = ./bin/

#VPATH = src inc

# Designate Library files here.
# Common:  -lpthread -ldl 
LIBS +=

RCPPFLAGS =
DCPPFLAGS =
RCXXFLAGS = -O2 -Wall -Wextra -Wfloat-equal -Weffc++ -std=c++11
DCXXFLAGS = -g3 -Wall -Wextra -Wfloat-equal -Weffc++ -std=c++11
RCFLAGS = -O2 -Wall -Wextra -Wfloat-equal -std=c99
DCFLAGS = -g3 -Wall -Wextra -Wfloat-equal -std=c99

# Evluate for later inclusion
#LDFLAGS =
#LDLIBS =

####################################################################

.PHONY : all show clean release debug

ifeq ($(MAKECMDGOALS), release)
OBJDIR = ./bin/release/
DEPDIR = ./bin/release/dep/
CPPFLAGS += $(RCPPFLAGS)
CXXFLAGS += $(RCXXFLAGS)
CFLAGS += $(RCFLAGS)
else
OBJDIR = ./bin/debug/
DEPDIR = ./bin/debug/dep/
CPPFLAGS += $(DCPPFLAGS)
CXXFLAGS += $(DCXXFLAGS)
CFLAGS += $(DCFLAGS)
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


############### BEGIN RECIPES ###############


all : $(BINDIR)$(TARGET)
	@echo "All Done (default debug)!"

release : $(BINDIR)$(TARGET)
	@echo "Release Done!"

debug : $(BINDIR)$(TARGET)
	@echo "Debug Done!"

# include all .d and .dpp makefiles from BINDIR/DEPDIR
include $(SRCDDD)
include $(SRCDPP)

$(BINDIR)$(TARGET) : $(OBJS)
	@echo "Compiling $@ from $^..."
	$(CCC) $(CCCFLAS) -I$(INCDIR) -L$(LIBDIR) $(LIBS) -o $@ $^

$(OBJDIR)%.o : $(SRCDIR)%.c
	@echo "Compiling $<...."
	#include $(SRCDDD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -I$(INCDIR) -L$(LIBDIR) $(LIBS) -o $@ -c $<

$(OBJDIR)%.opp : $(SRCDIR)%.cpp
	@echo "Compiling $<...."
	#include $(SRCDPP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -I$(INCDIR) -L$(LIBDIR) $(LIBS) -o $@ -c $<

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
	@echo 'OBJDIR = '$(OBJDIR)
	@echo "BINDIR = "$(BINDIR)
	@echo "DEPDIR = "$(DEPDIR)
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

clean:
	$(RM) ./bin/debug/*.o ./bin/debug/*.opp
	$(RM) ./bin/release/*.o ./bin/release/*.opp
	$(RM) ./bin/debug/dep/*.d ./bin/debug/dep/*.dpp
	$(RM) ./bin/release/dep/*.d ./bin/release/dep/*.dpp
	$(RM) $(BINDIR)$(TARGET)
