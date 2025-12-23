#!/bin/bash

# Activate environment (if any)

# Install project dependencies
git submodule update --init --recursive

# Build & Test
mkdir -p build/Release
cd build/Release
cmake ../.. -DOMPL_REGISTRATION=OFF -DOMPL_BUILD_DEMOS=OFF -DVAMP_PORTABLE_BUILD=ON -DCMAKE_INSTALL_PREFIX=/app/install -DOMPL_PYTHON_INSTALL_DIR=/app/install/python
make -j$(nproc)
ctest --output-on-failure || true

# Test CMake target linkage to ompl::ompl
cd /app/tests/cmake_export
cmake -B build -DCMAKE_INSTALL_PREFIX=/app/install
cmake --build build || true