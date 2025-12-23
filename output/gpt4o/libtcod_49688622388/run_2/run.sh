#!/bin/bash
set -e

# Initialize vcpkg if not present
if [ ! -d "vcpkg" ]; then
    git clone https://github.com/Microsoft/vcpkg.git
    cd vcpkg
    git checkout $(git describe --tags $(git rev-list --tags --max-count=1))
    ./bootstrap-vcpkg.sh
    cd ..
fi

# Set up vcpkg toolchain
export VCPKG_ROOT=/app/vcpkg
export PATH=$VCPKG_ROOT:$PATH
export CMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake

# CMake configure
cmake -S . -B build -G Ninja \
  -DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_FILE \
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
export LD_LIBRARY_PATH=build/lib
if [ -f "build/bin/unittest" ]; then
    build/bin/unittest ~[!nonportable] ~[benchmark]
else
    echo "Warning: unittest executable not found, skipping tests"
fi

# CMake test install
cmake --install build --config Debug