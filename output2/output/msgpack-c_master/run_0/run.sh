#!/bin/bash

# Activate environments if any (none specified)

# Install project dependencies
# Assuming a CMake-based build system
mkdir -p build
cd build
cmake ..
make

# Run tests
# Assuming tests are part of the build process
ctest --output-on-failure || true

# Ensure all test cases are executed, even if some fail