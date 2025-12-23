#!/bin/bash

# Activate environment variables
export CC=gcc-11
export CXX=g++-11
export CMAKE_PARAMS="-D CMAKE_BUILD_TYPE=CI -D DEPS=LOCAL"

# Install project dependencies (if any)
# Placeholder for any additional setup

# Run build and test
ci/build

# Collect test directory from failed tests
ci/collect-testdir || true

# Note: Uploading artifacts is not supported in this script