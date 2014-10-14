# makefile ksc

TARGET = hello.exe

SRCDIR = ./src/
INCDIR = ./inc/
LIBDIR = ./lib/
BINDIR = ./bin/

#VPATH = src inc

#Designate Library files here.
#Common:  -lpthread -ldl 

LIBS +=

RCPPFLAGS =
DCPPFLAGS =
RCXXFLAGS = -O2 -Wall -Wextra -Wfloat-equal -Weffc++ -std=c++11
DCXXFLAGS = -g3 -Wall -Wextra -Wfloat-equal -Weffc++ -std=c++11
RCFLAGS = -O2 -Wall -Wextra -Wfloat-equal -std=c99
DCFLAGS = -g3 -Wall -Wextra -Wfloat-equal -std=c99


####################################################################

.PHONY : all show clean release debug

ifeq ($(MAKECMDGOALS), release)
OBJDIR = ./bin/release/
CPPFLAGS += $(RCPPFLAGS)
CXXFLAGS += $(RCXXFLAGS)
CFLAGS += $(RCFLAGS)
else
OBJDIR = ./bin/debug/
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

#OBJS := $(SRCCCC) $(SRCCPP)

#OBJSS := $(patsubst $(SRCDIR)%.c, $(OBJDIR)%.o, $(OBJS))

all : $(BINDIR)$(TARGET)
	@echo "All Done (default debug)!"

release : $(BINDIR)$(TARGET)
	@echo "Release Done!"

debug : $(BINDIR)$(TARGET)
	@echo "Debug Done!"


$(BINDIR)$(TARGET) : $(OBJS)
	@echo "Compiling $@ from $^..."
	$(CCC) $(CCCFLAS) -I$(INCDIR) -L$(LIBDIR) $(LIBS) -o $@ $^

$(OBJDIR)%.o : $(SRCDIR)%.c
	@echo "Compiling $<...."
	$(CC) $(CPPFLAGS) $(CFLAGS) -I$(INCDIR) -L$(LIBDIR) $(LIBS) -o $@ -c $<

$(OBJDIR)%.opp : $(SRCDIR)%.cpp
	@echo "Compiling $<...."
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -I$(INCDIR) -L$(LIBDIR) $(LIBS) -o $@ -c $<

show:
	@echo 'SRCCCC = '$(SRCCCC)
	@echo 'SRCCPP = '$(SRCCPP)
	@echo 'OBJDIR = '$(OBJDIR)
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

clean:
	$(RM) ./bin/debug/*.o ./bin/debug/*.opp
	$(RM) ./bin/release/*.o ./bin/release/*.opp
	$(RM) $(BINDIR)$(TARGET)
