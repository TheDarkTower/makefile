makefile Version 2
by: Kenneth Cascio
===================

Dynamic makefile for GNU gcc/g++ on Linux.

Version 2.0.2 fixed the order in the LDLIBS variable to push local (./lib) libraries first so that -lpthread, -ldl, etc. would properly to all object files.  Now uses full path and name for local project ./lib shared and static libraries.  If compiling against a new shared library, you will need to load the new .so via 'sudo ldconfig' before execution of the new file or the OS/dynamic loader will not know where to find the new shared library.

Version 2.0.1 moved all LDLIBS after the $^ (object files) for proper processing of all objects (i.e. -lpthread and -ldl after all obj files in ld.

Automatically loads project source files and builds release and debug versions of .exe, .so, and .a targets.  As detailed below under Defined Targets, you can also build the intermediate steps for the project to evaluate the pre-processor and/or assembly outputs.

Allows for simultaneous debug and release builds in the ./bin/debug/ and ./bin/release/ directoires with no overlap in builds.

NOTE:  When building shared libraries (.so via shared, dshared, or rshared) you may have to perform a 'make clean' to remove any object files created by previous calls to a non-shared target.  All shared library files must be built with -fPIC for Position Independent Code.  Those object files could be up to date via all dependencies; but, built w/out -fPIC.

The repository contains a simple mixed .c/.cpp 'hello world' project for testing purposes.  All you need is the actual makefile.

To create a new/empty project, copy 'makefile' to the project directory and run 'make mkdirs' to create the project directories.  Add .c/.cpp files to src; .h/.hpp files to inc; .so/.a files to lib; and make will auto-load all dependencies to build the selected target.  Edit the makefile to change the TARGET, version numbers, system libraries (.so or .a), and debug/release flags.

Do not put an extension in the TARGET string of the makefile - the extension is added based on the selected goal via command line 'make'.

If building shared libraries, edit SOMAJ, SOMIN, and SOREL (major, minor, and release versions) - the default is '.1.0.1'.  The target will be built with the '.so.MAJ.MIN.REL' suffix and the 'lib' prefix.  Additionally, the 'soname' will be created with the 'lib' prefix and a '.so.MAJ' suffix.

When building SHARED or STATIC libraries, any reference to main.c or main.cpp is automatically removed from the source and object strings since you don't need an entry point in a library.  This way, you can technically turn your functioning program into a library in the same project and copy the .so or .a to the next project (or make system wide with 'sudo ldconfig').  This allows you to have test routines in your project main.c/.cpp to debug before compiling the library.

Defined Targets:
* all (default build - same as debug for .exe target)
* debug (.exe target with debug flags/directories)
* release (.exe target with release flags/directories)
* dfull (.exe target with debug flags/directories building all incremental steps (e.g .d, .i, .s, .o, .exe))
* rfull (.exe target with release flags/directories building all incremental steps (e.g .d, .i, .s, .o, .exe))
* shared (.so target with debug flags/directories and .MAJ.MIN.REL suffix, soname.so.MAJ, -shared -fPIC)
* dshared (.so target with debug flags/directories and .MAJ.MIN.REL suffix, soname.so.MAJ, -shared -fPIC)
* rshared (.so target with release flags/directories and .MAJ.MIN.REL suffix, soname.so.MAJ, -shared -fPIC)
* static (.a target with debug flags/directories using $(AR) w/ rcsv flags set)
* dstatic (.a target with debug flags/directories using $(AR) w/ rcsv flags set)
* rstatic (.a target with release flags/directories using $(AR) w/ rcsv flags set)
* show (display variables for debugging makefile. Un-comment SHOW to force 'show' dependency for all targets)
* clean (remove all objects created with makefile - no source files are touched)
* makdirs (build default directory structure from project root (makefile home))

1. Uses MAKECMDGOALS logic to set proper build directories & flags for debug/release.

2. Automatically loads and seperates source files by extension (.c and .cpp) from ./src/ for proper processing via $(CC) and/or $(CXX); loads and parses .so/.a library files from ./lib/ for $(LD); generates all target files (.o/.opp, .i/.ipp, .s/.spp, .d/.dpp, and .exe/.so/.a) and provides the proper recipe and dependencies for selected TARGET.

3. Uses the proper compiler and options/flags (CC, or CXX) based on source extension .c and .cpp to build object files to avoid gcc/g++ default passthroughs.

4. If mixing .c and .cpp source/object files, the final target uses CXX for proper linking.  If not mixed, the final target uses the appropriate compiler/linger (CC or CXX) based on source file extensions.

5. .c and .cpp object files are designated with .o (for .c) and .opp (for .cpp) so that the correct compiler can be chosen by targeting the source and object extenstions.

6. Provides a 'show' target for debuging the makefile which displays status of variables.  By un-commenting the SHOW definition, you can force all targets to output a 'show' during execution.

7. Uses $(CC), $(CXX), $(LD), $(AR), and $(RM) for future platform independence.

8. Supports CPPFLAGS, CXXFLAGS, CFLAGS, and LDFLAGS with debug/release logic for proper build FLAGS while maintaining the ability to pass values via the command line.

9. DEPRECIATED - the code still exists but V2.0.2+ are using the fullpath/fullname for linking:  Version 2 loads .so and .a libraries from ./lib/ and parses the path/filename to strip the leading 'lib', the .so/.a suffix, and any Major/Minor/Release version tags (e.g. .1.0.1).  Example:  './lib/libMySharedLib.so.1.0.1' is parsed to '-lMySharedLib'.  The $(LIBDIR) string is prefixed by '-L' during linker for local library path.
