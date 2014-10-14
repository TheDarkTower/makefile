# makefile ksc

TARGET = hello.exe

SRCDIR = ./src/
INCDIR = ./inc/
LIBDIR = ./lib/
#OBJDIR = ./bin/debug/
BINDIR = ./bin/

#OBJS = main.o module.o

#VPATH = src inc

####################################################################

.PHONY : all show clean release debug

ifeq ($(MAKECMDGOALS), release)
OBJDIR = ./bin/release/
else
OBJDIR = ./bin/debug/
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
else
CCC = $(CC)
endif

OBJS := $(patsubst $(SRCDIR)%.c, $(OBJDIR)%.o, $(SRCCCC))
OBJS += $(patsubst $(SRCDIR)%.cpp, $(OBJDIR)%.opp, $(SRCCPP))

#OBJS := $(SRCCCC) $(SRCCPP)

#OBJSS := $(patsubst $(SRCDIR)%.c, $(OBJDIR)%.o, $(OBJS))

all : $(BINDIR)$(TARGET)
	@echo "All Done!"

release : $(BINDIR)$(TARGET)
	@echo "Release Done!"

debug : $(BINDIR)$(TARGET)
	@echo "Debug Done!"


$(BINDIR)$(TARGET) : $(OBJS)
	@echo "Compiling $@ from $^..."
	$(CCC) -g -I$(INCDIR) -o $@ $^

$(OBJDIR)%.o : $(SRCDIR)%.c
	@echo "Compiling $<...."
	$(CC) -g -I$(INCDIR) -o $@ -c $<

$(OBJDIR)%.opp : $(SRCDIR)%.cpp
	@echo "Compiling $<...."
	$(CXX) -g -I$(INCDIR) -o $@ -c $<

show:
	@echo 'SRCCCC = '$(SRCCCC)
	@echo 'SRCCPP = '$(SRCCPP)
	@echo 'OBJDIR = '$(OBJDIR)
	@echo 'OBJS =   '$(OBJS)
	@echo 'CCC =    '$(CCC)
	@echo 'CC =     '$(CC)
	@echo 'CXX =    '$(CXX)
	@echo 'SRCEXT = '$(SRCEXT)
	@echo 'RM =     '$(RM)

clean:
	$(RM) ./bin/debug/*.o ./bin/debug/*.opp
	$(RM) ./bin/release/*.o ./bin/release/*.opp
	$(RM) $(BINDIR)$(TARGET)
