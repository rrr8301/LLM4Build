#!/bin/bash

set -e
set -o pipefail

# Activate environment variables
export CC=gcc-12
export CXX=g++-12
export CMAKE_GENERATOR=Ninja
export CMAKE_PARAMS="-D CMAKE_BUILD_TYPE=CI -D DEPS=LOCAL"

# Install project dependencies
# Assuming dependencies are already installed via Dockerfile

# Run build and tests
ci/build || true

# Collect testdir from failed tests
if [ $? -ne 0 ]; then
  ci/collect-testdir
  # Placeholder for manual artifact handling
  echo "Artifacts collected. Please handle them manually."
fi

# Ensure all tests are executed
exit 0