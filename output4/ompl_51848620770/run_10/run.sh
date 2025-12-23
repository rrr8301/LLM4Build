#!/bin/bash

# Activate environments if any (none specified)

# Install project dependencies (none specified beyond system packages)

# Build and test
mkdir -p build/Release
cd build/Release
cmake ../.. -DOMPL_REGISTRATION=OFF -DOMPL_BUILD_DEMOS=OFF -DVAMP_PORTABLE_BUILD=ON -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DOMPL_PYTHON_INSTALL_DIR=$(pwd)/install/python
make -j$(nproc)

# Run tests
ctest --output-on-failure || true

# Test CMake target linkage
cd ../../tests/cmake_export
cmake -B build -DCMAKE_INSTALL_PREFIX=$(pwd)/install
cmake --build build