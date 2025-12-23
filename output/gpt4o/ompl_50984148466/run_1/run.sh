#!/bin/bash

# Activate environments if any (placeholder)
# source /path/to/env/bin/activate

# Install project dependencies (if any)
# Placeholder for additional dependency installation

# Build and test
mkdir -p build/Release
cd build/Release
cmake ../.. -DOMPL_REGISTRATION=OFF -DOMPL_BUILD_DEMOS=OFF -DVAMP_PORTABLE_BUILD=ON -DCMAKE_INSTALL_PREFIX=/app/install -DOMPL_PYTHON_INSTALL_DIR=/app/install/python
make -j$(nproc)

# Run tests
ctest --output-on-failure || true

# Test CMake target linkage
cd /app/tests/cmake_export
cmake -B build -DCMAKE_INSTALL_PREFIX=/app/install
cmake --build build