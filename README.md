makefile Version 3.1.4
by: Kenneth Cascio
===================

Dynamic makefile for GNU gcc/g++ on Linux.

As you can probably tell from the number of commits and branches (and major changes from start to current), this project was my way of learning to use git/github and gnu make for c/c++ project on my new Linux machine (currently using Ubuntu 14.04).  I don't expect anyone to be running over to get this; but, if you do happen upon it, I hope you will provide some feedback and/or point out any glaring mistakes...  I did my best to accomodate any single target project from simple binaries to shared and static libraries and I've successfuly tested all of the features using the sample program provided in the release and the sqlite3 amalgamation for a more complex solution.

See CHANGE LOG below for important version updates/changes.

To use, simply copy makefile to your project root directory and execute 'make mkdirs' to create the project tree.  Add any .c/.cpp files to ./src; any .h/.hpp files to ./inc; and any local .so/.a files to ./lib. make <target> will auto-load all source dependencies to build the selected target.  Edit the makefile to change the TARGET to your project name (output fileanme), target extension including the '.' (leave blank to create binary with no extension), version numbers for library builds, add any system .so or .a libraries to LIBS, and update any of the debug/release flags as desired.

make will automatically loads project source files and builds release and debug versions of binary, .so, and .a targets in the same project tree (./bin/debug for debug and ./bin/release for release).  As detailed below under Defined Targets, you can also build the intermediate steps for the project to evaluate the pre-processor and/or assembly outputs with one of the all/_all goals.

Allows for simultaneous debug and release builds in the ./bin/debug/ and ./bin/release/ directoires with no overlap in builds including .i/.ipp, .s/.spp, .o/.opp, .d/.dpp, and final targets.

Stores the last successfull build information in the ./log directory for 'install' and 'uninstall' goals.

NOTE:  When building shared libraries (.so) you may have to perform a 'make clean' to remove any object files created by previous calls to a non-shared target.  All shared library files must be built with -fPIC for Position Independent Code.  Those object files could be up to date via all dependencies; but, built w/out -fPIC.

NOTE:  Do not put an extension in the TARGET string of the makefile - the extension is added based on the selected goal via command line 'make'.  This can confuse the mult-targeted rules which need the basename of the TARGET.

NOTE:  The repository contains a simple mixed .c/.cpp 'hello world' project for testing purposes.  All you need is the actual makefile and the default build directoires (created by 'make makdirs') to use.

NOTE:  To test your new shared/static libraries, make sure you define 'LIBRARY_PATH' and that it points to the install directory used by the makefile that created the libraries.

If building shared libraries, edit SOMAJ, SOMIN, and SOREL (major, minor, and release versions) - the default is '.1.0.1'.  The target will be built with the '.so.MAJ.MIN.REL' suffix and the 'lib' prefix.  Additionally, the 'soname' will be created with the 'lib' prefix and a '.so.MAJ' suffix.  When installing a shared library, the target library is copied, a symlink to the target with the soname is copied, and finally a symlink to the target with the basename is copied (no MAJ version appended - this allows for '-lyourlib' flags in the linker as long as the shared libraries are installed by 'ldconfig' or in a directory in the environment variable 'LD_LIBRARY_PATH'.

When building SHARED or STATIC libraries, any reference to main.c or main.cpp is automatically removed from the source and object strings since you don't need an entry point in a library.  This way, you can technically turn your functioning standalone binary into a library in the same project and copy the .so or .a to the next project (or make system wide with 'sudo ldconfig').  This allows you to have test routines in your project main.c/.cpp to debug before compiling the library (rember to setup 'LD_LIBARY_PATH' and 'LIBRARY_PATH' for any non-system shared or static libraries you build.

Defined Targets/Goals:
* all (default binary build with debug flags/directories - same as debug_all)
* debug (binary target with debug flags/directories)
* debug_all (binary target with debug flags/directories building all incremental steps (e.g .d, .i, .s, .o, .exe))
* release (binary target with release flags/directories)
* release_all (binary target with release flags/directories building all incremental steps (e.g .d, .i, .s, .o, .exe))
* shared (.so target with debug flags/directories and .MAJ.MIN.REL suffix, soname.so.MAJ, -shared -fPIC)
* shared_all (.so target with debug flags/directories and .MAJ.MIN.REL suffix, soname.so.MAJ, -shared -fPIC) building all incremental steps (e.g .d, .i, .s, .o, .exe)
* dshared (.so target with debug flags/directories and .MAJ.MIN.REL suffix, soname.so.MAJ, -shared -fPIC)
* dshared_all (.so target with debug flags/directories and .MAJ.MIN.REL suffix, soname.so.MAJ, -shared -fPIC) building all incremental steps (e.g .d, .i, .s, .o, .exe)
* rshared (.so target with release flags/directories and .MAJ.MIN.REL suffix, soname.so.MAJ, -shared -fPIC)
* rshare_all (.so target with release flags/directories and .MAJ.MIN.REL suffix, soname.so.MAJ, -shared -fPIC) building all incremental steps (e.g .d, .i, .s, .o, .exe)
* static (.a target with debug flags/directories using $(AR) w/ rcsv flags set)
* static_all (.a target with debug flags/directories using $(AR) w/ rcsv flags set) building all incremental steps (e.g .d, .i, .s, .o, .exe)
* dstatic (.a target with debug flags/directories using $(AR) w/ rcsv flags set)
* dstatic_all (.a target with debug flags/directories using $(AR) w/ rcsv flags set) building all incremental steps (e.g .d, .i, .s, .o, .exe)
* rstatic (.a target with release flags/directories using $(AR) w/ rcsv flags set)
* rstatic_all (.a target with release flags/directories using $(AR) w/ rcsv flags set) building all incremental steps (e.g .d, .i, .s, .o, .exe)
* show (display variables for debugging makefile. Un-comment SHOW to force 'show' dependency for all targets)
* clean (remove all objects created with makefile - no source files are touched)
* install (install last successful build to default install directory)
* uninstall (un-install last successful bild from default install directory)
* makdirs (build default directory structure from project root (makefile home))
* version (display version information of current makefile)

1. Uses MAKECMDGOALS logic to set proper build directories & flags for debug/release and intermediate build steps.

2. Automatically loads and seperates source files by extension (.c and .cpp) from ./src/ for proper processing via $(CC) and/or $(CXX); loads and parses .so/.a library files from ./lib/ for $(LD); generates all target files (.o/.opp, .i/.ipp, .s/.spp, .d/.dpp, and .exe/.so/.a) and provides the proper recipe and dependencies for selected TARGET.

3. Uses the proper compiler and options/flags (CC, or CXX) based on source extension .c and .cpp to build object files while avoiding gcc/g++ default passthroughs.

4. If mixing .c and .cpp source/object files, the final target uses CXX for proper linking.  If not mixed, the final target uses the appropriate compiler/linker (CC or CXX) based on source file extensions.

5. .c and .cpp object files are designated with .o (for .c) and .opp (for .cpp) so that the correct compiler can be chosen by targeting the source and object extenstions.

6. Provides a 'show' target for debuging the makefile which displays status of variables.  By un-commenting the SHOW definition, you can force all targets to output a 'show' during execution.

7. Uses $(CC), $(CXX), $(LD), $(AR), and $(RM) for future platform independence.

8. Supports CPPFLAGS, CXXFLAGS, CFLAGS, and LDFLAGS with debug/release logic for proper build FLAGS while maintaining the ability to pass values via the command line (set with 'override +=').

9. DEPRECIATED - the code still exists but V2.0.2+ are using the fullpath/fullname for linking:  Version 2 loads .so and .a libraries from ./lib/ and parses the path/filename to strip the leading 'lib', the .so/.a suffix, and any Major/Minor/Release version tags (e.g. .1.0.1).  Example:  './lib/libMySharedLib.so.1.0.1' is parsed to '-lMySharedLib'.  The $(LIBDIR) string is prefixed by '-L' during linker for local library path.

10. Added install/uninstall goals which rely on the install directory variables set at the beginning of the makefile.  You can edit these or use the defaults.  'make mkdirs' will create the TESTBED directories for you if they don't exist.

11. Automatically generates and includes (for builds, not commands) source file dependencies using the pre-processor so that any updated header files, etc. will trigger a rebuild of any objects depending on/including it.

CHANGE LOG:

Version 3.1.4 - BIG UPDATE / GOALS UPDATED/ADDED/REMOVED from all previous versions - see below for details.  Added install, un-install, and version goals.  Completely re-worked the build logic and Targets/Goals using multiple-targets to simplify the code and allow for easy add/delete/change to existing goals.  Added functions to determine unique goals/targets to eliminate the possiblity of incorrect build assignments due to a targets name being part of the name of another target.  An exact match to the single target 'all' or a findsting match of any target containing '_all' now causes the full project build (makes .i, .ipp, .s, .spp, .o, .opp, .d, .dpp, etc.).  Defaults an empty MAKECMDGOALS to 'all' determined by word count to exclude matching leading/trailing spaces in previous ifeq/ifneq tests, etc.

Version 3.0.1 - added TAREXT so that you can specify other than .exe for binaries (including nothing).  Added ./log/ directory to the project tree to store information about the last successful build for use in the new 'instal' target.  Setup a directory tree to support testing (TESTBED) of .exe, .so, and .a (BASH script to set and reset LD_LIBRARY_PATH and PATH for TESTBED tree).  Removed the ./sym/ directory as those functions have moved to ./log/.  Defined option to set the SHELL variable (/bin/bash inesteadof /bin/sh) and added/commented-out HOME for systems that do not include support for '~' or inherit HOME from parent process.  Defined the default directories for installation (TESTBED) near top for customization.  Broke out the .PHONY targets into groups for testing in 'install' setup.  Pull LASTBUILD, LASTTPATH, LASTTARGET, and LASTSONAME from log files for 'install' logic.  Updated 'show', 'mkdirs', and 'clean' to support new directory trees, files, and extensions.

Version 2.0.2 fixed the order in the LDLIBS variable to push local (./lib) libraries first so that -lpthread, -ldl, etc. would properly to all object files.  Now uses full path and name for local project ./lib shared and static libraries.  If compiling against a new shared library, you will need to load the new .so via 'sudo ldconfig' before execution of the new file or the OS/dynamic loader will not know where to find the new shared library.

Version 2.0.1 moved all LDLIBS after the $^ (object files) for proper processing of all objects (i.e. -lpthread and -ldl after all obj files in ld.
