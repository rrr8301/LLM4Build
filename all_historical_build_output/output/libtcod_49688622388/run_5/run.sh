#!/bin/bash

set -e
set -o pipefail

# Fetch Vcpkg commits
cd vcpkg
git fetch --depth=1
./bootstrap-vcpkg.sh
cd ..

# CMake configure
cmake -S . -B build -G Ninja \
  -DCMAKE_TOOLCHAIN_FILE=/app/vcpkg/scripts/buildsystems/vcpkg.cmake \
  -DVCPKG_TARGET_TRIPLET="x64-linux" \
  -DCMAKE_BUILD_TYPE=Debug \
  -DLIBTCOD_SDL3=find_package \
  -DLIBTCOD_ZLIB=find_package \
  -DLIBTCOD_LODEPNG=find_package \
  -DLIBTCOD_UTF8PROC=vcpkg \
  -DLIBTCOD_STB=vcpkg \
  -DCMAKE_INSTALL_PREFIX=local \
  -DBUILD_SHARED_LIBS=TRUE \
  -DLIBTCOD_SAMPLES=ON \
  -DLIBTCOD_TESTS=ON \
  -DCPACK_SYSTEM_NAME=x64-linux \
  -Wdev

# CMake build
cmake --build build

# CMake verify headers
cmake --build build --target all_verify_interface_header_sets

# Run tests
LD_LIBRARY_PATH=build/lib build/bin/unittest ~[!nonportable] ~[benchmark]

# CMake test install
cmake --install build --config Debug