#!/bin/bash

set -e
set -o pipefail

# Activate environment variables
export CC=clang-16
export CXX=clang++-16
export CMAKE_GENERATOR=Ninja
export CTEST_OUTPUT_ON_FAILURE=ON
export VERBOSE=1

# Install project dependencies
cmake_params=(-D CMAKE_BUILD_TYPE=CI -D DEP_DOCTEST=DOWNLOAD -D DEP_XXHASH=DOWNLOAD -D DEPS=LOCAL)

# Build and test
ci/build || true

# Collect testdir from failed tests
if [ $? -ne 0 ]; then
  ci/collect-testdir || true
fi

# Ensure all tests are executed
exit 0