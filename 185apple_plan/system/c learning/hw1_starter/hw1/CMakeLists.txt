cmake_minimum_required(VERSION 3.16)
project(hw1 C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(hw1
        beargit.c
        beargit.h
        main.c
        util.h)
