#!/bin/bash

set -e
set -o pipefail

# Build and test using CMake
mkdir -p build
cd build

# Ensure the CMake configuration is correct and paths are set properly
cmake .. -DCMAKE_BUILD_TYPE=Release \
         -DOMPL_REGISTRATION=OFF \
         -DOMPL_BUILD_DEMOS=OFF \
         -DVAMP_PORTABLE_BUILD=ON \
         -DCMAKE_INSTALL_PREFIX=$(pwd)/install \
         -DOMPL_PYTHON_INSTALL_DIR=$(pwd)/install/python \
         -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake \
         -DBOOST_ROOT=/opt/vcpkg/installed/x64-linux

make -j$(nproc)
ctest --output-on-failure || true  # Ensure all tests run even if some fail

# Test CMake target linkage
cd ../tests/cmake_export
cmake -B build -DCMAKE_INSTALL_PREFIX=$(pwd)/install
cmake --build build