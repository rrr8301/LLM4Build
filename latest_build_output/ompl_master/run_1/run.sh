#!/bin/bash

# Check if inside a git repository
if [ ! -d ".git" ]; then
    echo "Not a git repository. Initializing..."
    git init
    git remote add origin <your-repo-url>  # Replace <your-repo-url> with the actual URL
    git fetch
    git checkout <your-branch>  # Replace <your-branch> with the actual branch name
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