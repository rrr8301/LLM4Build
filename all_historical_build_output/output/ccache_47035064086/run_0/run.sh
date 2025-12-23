#!/bin/bash

# Activate environment variables
export CC=gcc-12
export CXX=g++-12
export CMAKE_GENERATOR=Ninja
export CTEST_OUTPUT_ON_FAILURE=ON
export VERBOSE=1

# Install project dependencies (if any)
# Placeholder for any additional setup

# Run build and test
ci/build

# Collect testdir from failed tests
if [ $? -ne 0 ]; then
    ci/collect-testdir
    # Placeholder for uploading artifacts
    echo "Upload testdir from failed tests (not implemented in Docker)"
fi