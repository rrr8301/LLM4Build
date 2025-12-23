#!/bin/bash

set -e
set -o pipefail

# Clone vcpkg if not already present
if [ ! -d "vcpkg" ]; then
  git clone https://github.com/microsoft/vcpkg.git
fi

# Bootstrap vcpkg
cd vcpkg
./bootstrap-vcpkg.sh -disableMetrics
cd ..

# Install latest CMake (assuming it's already installed via Dockerfile)
# cmake is already installed

# Configure CMake
cmake -S . -B build -G Ninja \
  -DCMAKE_TOOLCHAIN_FILE=./vcpkg/scripts/buildsystems/vcpkg.cmake \
  -DVCPKG_TARGET_TRIPLET="x64-linux" \
  -DCMAKE_BUILD_TYPE=Debug \
  -DLIBTCOD_SDL3=find_package \
  -DLIBTCOD_ZLIB=find_package \
  -DLIBTCOD_LODEPNG=find_package \
  -DLIBTCOD_UTF8PROC=vcpkg \
  -DLIBTCOD_STB=vcpkg \
  -DCMAKE_INSTALL_PREFIX=local \
  -DBUILD_SHARED_LIBS=FALSE \
  -DLIBTCOD_SAMPLES=ON \
  -DLIBTCOD_TESTS=ON \
  -DCPACK_SYSTEM_NAME=x64-linux \
  -Wdev

# Build with CMake
cmake --build build

# Verify headers
cmake --build build --target all_verify_interface_header_sets

# List build files
find build

# Run tests
LD_LIBRARY_PATH=build/lib build/bin/unittest ~[!nonportable] ~[benchmark]

# CMake test install
cmake --install build --config Debug

# CPack (conditional)
# cpack --config build/CPackConfig.cmake --verbose

# Note: Upload CPack is not handled as it's a GitHub-specific action