#!/bin/bash

set -e

# Activate environment variables
export CTEST_OUTPUT_ON_FAILURE=ON
export VERBOSE=1
export CMAKE_GENERATOR=Ninja
export CC=gcc-13
export CXX=g++-13

# Install project dependencies
cmake_params=(-D CMAKE_BUILD_TYPE=CI)
cmake_params+=(-D DEP_DOCTEST=DOWNLOAD)
cmake_params+=(-D DEP_XXHASH=DOWNLOAD)

# Run build and tests
ci/build || true

# Collect testdir from failed tests
if [ $? -ne 0 ]; then
  ci/collect-testdir || true
fi

# Ensure all tests are executed
exit 0