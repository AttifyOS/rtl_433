#!/bin/sh
set -e

apk update
apk add alpine-sdk cmake librtlsdr-dev openssl-dev
git clone https://github.com/merbanan/rtl_433.git
cd rtl_433
git checkout 15637a2f2dbc30328e1fd75f38029ed1515444d3
sed -i '/cmake_minimum_required/c cmake_minimum_required(VERSION 3.23.1)' CMakeLists.txt
sed -i '/project(rtl433 C)/c project(rtl433 C) \
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a") \
set(BUILD_SHARED_LIBS OFF) \
set(CMAKE_EXE_LINKER_FLAGS "-static")' CMakeLists.txt
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/root/rtl_433-build/
make
make install
cd ../../rtl_433-build
tar czf ../rtl_433-21.12-146.tar.gz *
cd ..
