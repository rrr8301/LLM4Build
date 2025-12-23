#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the Makefile has a build target
if make -q build; then
    # Build the project
    make build
else
    echo "No build target in Makefile. Skipping build step."
fi

# Run tests and ensure all tests are executed
set +e
if make -q test; then
    make test
else
    echo "No test target in Makefile. Skipping test step."
fi
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE