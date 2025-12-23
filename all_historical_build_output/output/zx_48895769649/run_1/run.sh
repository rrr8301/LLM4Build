#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install

# Run tests using zx
# Ensure all tests are executed, even if some fail
set +e

# Check if test_script.mjs exists
if [ -f "test_script.mjs" ]; then
  zx test_script.mjs
else
  echo "Error: test_script.mjs not found."
  exit 1
fi

TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE