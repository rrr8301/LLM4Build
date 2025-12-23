#!/bin/bash

set -e

# Set necessary environment variables for CI
export CI=true
export TERM=dumb
export MAKEFLAGS=

# Set a default CI type if not already set
# Assuming "local" as a more appropriate default CI type
export CI_TYPE=${CI_TYPE:-"local"}

# Install project dependencies
./ci/install-dependencies.sh

# Run build and tests
set +e
./ci/run-build-and-tests.sh
TEST_RESULT=$?
set -e

# Print test failures if any
if [ $TEST_RESULT -ne 0 ]; then
    ./ci/print-test-failures.sh
fi

exit $TEST_RESULT