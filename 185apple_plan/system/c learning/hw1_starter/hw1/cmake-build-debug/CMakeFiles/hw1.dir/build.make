# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/cmake-build-debug"

# Include any dependencies generated for this target.
include CMakeFiles/hw1.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/hw1.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/hw1.dir/flags.make

CMakeFiles/hw1.dir/beargit.c.o: CMakeFiles/hw1.dir/flags.make
CMakeFiles/hw1.dir/beargit.c.o: ../beargit.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/cmake-build-debug/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/hw1.dir/beargit.c.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hw1.dir/beargit.c.o   -c "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/beargit.c"

CMakeFiles/hw1.dir/beargit.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hw1.dir/beargit.c.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/beargit.c" > CMakeFiles/hw1.dir/beargit.c.i

CMakeFiles/hw1.dir/beargit.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hw1.dir/beargit.c.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/beargit.c" -o CMakeFiles/hw1.dir/beargit.c.s

CMakeFiles/hw1.dir/main.c.o: CMakeFiles/hw1.dir/flags.make
CMakeFiles/hw1.dir/main.c.o: ../main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/cmake-build-debug/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/hw1.dir/main.c.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hw1.dir/main.c.o   -c "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/main.c"

CMakeFiles/hw1.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hw1.dir/main.c.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/main.c" > CMakeFiles/hw1.dir/main.c.i

CMakeFiles/hw1.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hw1.dir/main.c.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/main.c" -o CMakeFiles/hw1.dir/main.c.s

# Object files for target hw1
hw1_OBJECTS = \
"CMakeFiles/hw1.dir/beargit.c.o" \
"CMakeFiles/hw1.dir/main.c.o"

# External object files for target hw1
hw1_EXTERNAL_OBJECTS =

hw1: CMakeFiles/hw1.dir/beargit.c.o
hw1: CMakeFiles/hw1.dir/main.c.o
hw1: CMakeFiles/hw1.dir/build.make
hw1: CMakeFiles/hw1.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/cmake-build-debug/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable hw1"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/hw1.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/hw1.dir/build: hw1

.PHONY : CMakeFiles/hw1.dir/build

CMakeFiles/hw1.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/hw1.dir/cmake_clean.cmake
.PHONY : CMakeFiles/hw1.dir/clean

CMakeFiles/hw1.dir/depend:
	cd "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/cmake-build-debug" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1" "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1" "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/cmake-build-debug" "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/cmake-build-debug" "/Users/zhangxinlu/Documents/self-teaching/185apple_plan/system/c learning/hw1_starter/hw1/cmake-build-debug/CMakeFiles/hw1.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/hw1.dir/depend

