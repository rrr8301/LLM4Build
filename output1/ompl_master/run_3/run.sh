#!/bin/bash

# Check if inside a git repository
if [ ! -d ".git" ]; then
    echo "Not a git repository. Initializing..."
    git init
    git remote add origin https://github.com/your-username/your-repo.git  # Replace with your actual repository URL
    git fetch
    git checkout main  # Replace 'main' with your actual branch name if different
fi

# Activate environment (if any)

# Install project dependencies
git submodule update --init --recursive

# Build & Test
mkdir -p build/Release
cd build/Release
cmake ../.. -DOMPL_REGISTRATION=OFF -DOMPL_BUILD_DEMOS=OFF -DVAMP_PORTABLE_BUILD=ON -DCMAKE_INSTALL_PREFIX=/app/install -DOMPL_PYTHON_INSTALL_DIR=/app/install/python
make -j$(nproc)
ctest --output-on-failure

# Test CMake target linkage to ompl::ompl
cd /app/tests/cmake_export
cmake -B build -DCMAKE_INSTALL_PREFIX=/app/install
cmake --build build