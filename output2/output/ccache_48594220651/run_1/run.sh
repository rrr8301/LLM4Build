#!/bin/bash

set -e

# Activate environment variables
export CC=gcc-11
export CXX=g++-11

# Install project dependencies
# Assuming dependencies are managed by a build system like CMake
mkdir -p build
cd build
cmake -G Ninja -D CMAKE_BUILD_TYPE=CI ..
ninja

# Run tests
# Ensure all tests are executed, even if some fail
set +e
ctest --output-on-failure
set -e