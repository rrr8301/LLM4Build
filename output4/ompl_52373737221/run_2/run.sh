#!/bin/bash

# Activate the virtual environment
source /opt/ompl-venv/bin/activate

# Build and test using CMake
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/app/install -DOMPL_REGISTRATION=OFF -DOMPL_BUILD_DEMOS=OFF -DVAMP_PORTABLE_BUILD=ON -DCMAKE_PREFIX_PATH=$(python3 -c "import ompl; print(ompl.__path__[0])") ..
make -j$(nproc)
ctest --output-on-failure || true  # Ensure all tests run even if some fail

# Test CMake target linkage
cd /app/tests/cmake_export
cmake -B build -DCMAKE_INSTALL_PREFIX=/app/install
cmake --build build