makefile
========

Dynamic makefile for GNU gcc/g++ on Linux.

I couldn't find anything that would allow me to build a release and debug version in seperate directories and I wanted soemthing that would allow for seperate procesing of .c and .cpp files without using default gcc passthrough.  I'm now writing a BASH script that can be used to setup new projects from the command line based on custom templates and this makefile.  Ultimately, this script will autogenerate a .pro file so that the projects can also be opened in Qt Creator for IDE editing.

Current Features/Functionality:

The makefile uses the following directory tree - all folders must currently exist:

* - /dir-to-project/
* -- /bin/
* --- /debug/
* ---- /dep/
* --- /release/
* ---- /dep/
* -- /inc/
* -- /lib/
* -- /src/

1. Uses MAKECMDGOALS logic to set proper build directories.

2. Automatically loads and seperates source files by extension (.c & .cpp) from ./src/ for proper processing via (CC) or (CXX).

3. Uses the proper compiler and options/flags (CC, or CXX) based on source extension .c and .cpp to build object files.

4. If mixing .c and .cpp source/object files, the final target uses CXX for proper linking.  If not mixed, the final target uses the appropriate compiler/linger (CC or CXX) based on source file extensions.

5. .c and .cpp object files are designated with .o (for .c) and .opp (for .cpp) so that the correct compiler can be chosen by targeting the source and object extenstions.

6. Provides a 'show' target for debuging make variables.

7. Uses $(RM) for future platform independence.

8. Supports CPPFLAGS, CXXFLAGS, and CFLAGS with debug/release logic for proper build FLAGS while maintaining the ability to pass values via the command line.
