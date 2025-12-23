#!/bin/bash

# Activate environment variables
export CTEST_OUTPUT_ON_FAILURE=ON
export VERBOSE=1
export CMAKE_GENERATOR=Ninja

# Install project dependencies (if any)
# Placeholder for any additional setup

# Run build and test
ci/build

# Collect testdir from failed tests
if [ $? -ne 0 ]; then
  ci/collect-testdir
fi

# Note: Uploading artifacts is not supported in this script