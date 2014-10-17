makefile
========

Dynamic makefile for GNU gcc/g++ on Linux.

I couldn't find anything that would allow me to build a release and debug version in seperate directories and I wanted soemthing that would allow for seperate procesing of .c and .cpp files without using default gcc passthrough.  I'm now writing a BASH script that can be used to setup new projects from the command line based on custom templates and this makefile.  Ultimately, this script will autogenerate a .pro file so that the projects can also be opened in Qt Creator for IDE editing.

Current Features/Functionality:

1. The makefile uses the following directory tree:

/dir/to/project/
|~bin/        - Target binary
| |~debug/    - Debug object files
| | |~dep     - Debug dependency make files
| |~release/  - Release object files
| | |~dep     - Release dependency make files
|~inc/        - Include directory for header files
|~lib/        - Library directory for local libraries
|~src/        - Source file for all .c and .cpp files

2. Uses MAKECMDGOALS logic to set proper build directories.

3. Automatically loads and seperates source files by extension (.c & .cpp) from ./src/ for proper processing via (CC) or (CXX).

4. Uses the proper compiler and options/flags (CC, or CXX) based on source extension .c and .cpp to build object files.

5. If mixing .c and .cpp source/object files, the final target uses CXX for proper linking.  If not mixed, the final target uses the appropriate compiler/linger (CC or CXX) based on source file extensions.

6. .c and .cpp object files are designated with .o (for .c) and .opp (for .cpp) so that the correct compiler can be chosen by targeting the source and object extenstions.

7. Provides a 'show' target for debuging make variables.

8. Uses $(RM) for future platform independence.

9. Supports CPPFLAGS, CXXFLAGS, and CFLAGS with debug/release logic for proper build FLAGS while maintaining the ability to pass values via the command line.
