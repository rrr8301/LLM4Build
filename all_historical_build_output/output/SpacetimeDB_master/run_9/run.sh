#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure all dependencies are installed
pnpm install

# Build the project
pnpm run build

# Run tests, ensuring all tests are executed even if some fail
set +e

# Check if test files exist before running tests
if find . -name '*.{test,spec}.?(c|m)[jt]s?(x)' | grep -q .; then
    pnpm test
    TEST_EXIT_CODE=$?
else
    echo "No test files found. Skipping tests."
    TEST_EXIT_CODE=0
fi

set -e

# Exit with the test command's exit code
exit $TEST_EXIT_CODE