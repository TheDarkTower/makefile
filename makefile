# makefile ksc

TARGET = hello.exe

SRCDIR = ./src/
INCDIR = ./inc/
LIBDIR = ./lib/
OBJDIR = ./bin/debug/
BINDIR = ./bin/

#OBJS = main.o module.o

#VPATH = src inc

####################################################################

SRCCCC := $(shell echo $(SRCDIR)*.c)
SRCCPP := $(shell echo $(SRCDIR)*.cpp)

ifeq ($(SRCCCC), $(SRCDIR)*.c)
SRCCCC = 
else
SRCEXT = .c
endif

ifeq ($(SRCCPP), $(SRCDIR)*.cpp)
SRCCPP = 
else
SRCEXT = .cpp
endif

ifeq ($(SRCEXT), .cpp)
CCC = $(CXX)
else
CCC = $(CC)
endif

OBJS := $(SRCCCC) $(SRCCPP)

OBJSS := $(patsubst $(SRCDIR)%.c, $(OBJDIR)%.o, $(OBJS))

all : $(BINDIR)$(TARGET)
	@echo "All Done!"

$(BINDIR)$(TARGET) : $(OBJSS)
	@echo "Compiling $@ from $^..."
	gcc -g -I$(INCDIR) -o $@ $^

$(OBJDIR)%.o : $(SRCDIR)%.c
	@echo "Compiling $<...."
	gcc -g -I$(INCDIR) -o $@ -c $<

clean:
	@echo 'SRCCCC = '$(SRCCCC)
	@echo 'SRCCPP = '$(SRCCPP)
	@echo 'SRCEXT = '$(SRCEXT)
	@echo 'CCC =    '$(CCC)
	rm -f $(OBJSS)
	rm -f $(BINDIR)$(TARGET)



