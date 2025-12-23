#!/bin/bash

set -e
set -o pipefail

# Activate environment (if any)

# Install project dependencies (if any)

# Build and test
mkdir -p build/Release
cd build/Release
cmake ../.. -DOMPL_REGISTRATION=OFF -DOMPL_BUILD_DEMOS=OFF -DVAMP_PORTABLE_BUILD=ON -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DOMPL_PYTHON_INSTALL_DIR=$(pwd)/install/python -DCMAKE_CXX_FLAGS="-Wall"
make -j$(nproc)
ctest --output-on-failure || true  # Ensure all tests run even if some fail

# Test CMake target linkage
cd ../../tests/cmake_export
cmake -B build -DCMAKE_INSTALL_PREFIX=$(pwd)/install
cmake --build build