# makefile ksc

TARGET = hello.exe

SRCDIR = ./src/
INCDIR = ./inc/
LIBDIR = ./lib/
OBJDIR = ./bin/debug/
BINDIR = ./bin/

OBJS = main.o module.o

#VPATH = src inc

####################################################################


OBJSS := $(patsubst %.o, $(OBJDIR)%.o, $(OBJS))

all : $(BINDIR)$(TARGET)
	@echo "All Done!"

$(BINDIR)$(TARGET) : $(OBJSS)
	@echo "Compiling $@ from $^..."
	gcc -g -I$(INCDIR) -o $@ $^

$(OBJDIR)%.o : $(SRCDIR)%.c
	@echo "Compiling $<...."
	gcc -g -I$(INCDIR) -o $@ -c $<

clean:
	rm -f $(OBJSS)
	rm -f $(BINDIR)$(TARGET)



