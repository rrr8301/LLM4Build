#!/bin/bash

set -e
set -o pipefail

# Create build directory
mkdir -p build/Release
cd build/Release

# Configure the project
cmake ../.. -DOMPL_REGISTRATION=OFF -DOMPL_BUILD_DEMOS=OFF -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DOMPL_PYTHON_INSTALL_DIR=$(pwd)/install/python

# Build the project
make -j$(nproc)

# Run tests
ctest --output-on-failure || true

# Test CMake target linkage
cd ../../tests/cmake_export
cmake -B build -DCMAKE_INSTALL_PREFIX=$(pwd)/install
cmake --build build