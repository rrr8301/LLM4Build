#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install

# Run tests using zx
# Ensure all tests are executed, even if some fail
set +e
zx test_script.mjs
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE