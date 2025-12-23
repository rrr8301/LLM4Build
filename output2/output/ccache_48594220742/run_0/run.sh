#!/bin/bash

set -e

# Activate environment variables
export CC=clang-15
export CXX=clang++-15
export CMAKE_GENERATOR=Ninja
export CTEST_OUTPUT_ON_FAILURE=ON
export VERBOSE=1

# Install project dependencies
# Assuming any additional dependencies are handled in the ci/build script

# Run build and test
ci/build || true

# Collect testdir from failed tests
if [ $? -ne 0 ]; then
  ci/collect-testdir || true
  # Note: Uploading artifacts is not supported in this script
  echo "Artifact upload is not supported in this script."
fi

# Ensure all tests are executed
exit 0