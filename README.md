makefile
========

Working on general makefile for GNU Linux

Practicing with git amd make to generate a dynamic makefile for local projects.

What it does so far:

1. Uses following project tree:

./<project>
  ./src
  ./inc
  ./lib
  ./bin
    ./debug
    ./release

2. Uses MAKECMDGOALS to set OBJDIR for release and debug but still builds the
binary in ./bin (for now).  I have not updated the flags for gcc or g++ yet
but it's on the list.  This is just to separte the builds in future and allow
for debug and optimizaton defaults/targets.

3. Automatically loads and seperates object files in OBJS for .c and .cpp.

4. Uses the proper compiler (CC, or CXX) for .c and .cpp object builds.

5. If mixing .c and .cpp object files, the target build uses CXX.  if not,
the target build uses proper compiler based on source files.

6. .c and .cpp object files are designated with .o (for .c) and .opp (for .cpp)
so that the correct compilre can be chosen based on source extenstion.

7. Designated all .PHONY targets.

8. Added 'show' target to echo makefile variables for debuging.

9. Changed to $(RM) for platform independance.  Still working on other platform
dependency issues; but, I just use linux for now.


Still working on/learning a number of pieces - this is far from complete.  I'm
testing and learning as I go.  Ultimately I want a makefile that will address
the vast majority of my projects on multiple platforms.
