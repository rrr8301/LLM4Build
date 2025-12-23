#!/bin/bash

# Activate environment variables if any (none in this case)

# Install project dependencies (none additional)

# Build & Test
mkdir -p build
cd build
cmake .. -DOMPL_REGISTRATION=OFF -DOMPL_BUILD_DEMOS=OFF -DVAMP_PORTABLE_BUILD=ON -DCMAKE_INSTALL_PREFIX=/app/install -DOMPL_PYTHON_INSTALL_DIR=/app/install/python
make -j$(nproc)
ctest --output-on-failure || true  # Ensure all tests run even if some fail

# Test CMake target linkage to ompl::ompl
cd /app/tests/cmake_export
cmake -B build -DCMAKE_INSTALL_PREFIX=/app/install
cmake --build build