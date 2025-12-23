#!/bin/bash

# Enable strict error checking
set -eo pipefail

echo "Starting test execution..."

# Create test output directory if it doesn't exist
mkdir -p test-results

# Run tests with more detailed output and capture exit code
TEST_EXIT_CODE=0
npm test -- --verbose --output=test-results/test-output.log || TEST_EXIT_CODE=$?

# Check test results
if [ $TEST_EXIT_CODE -eq 0 ]; then
    echo "All tests passed successfully!"
    # Print any expected network errors that are marked with 🚧
    grep -A 10 "🚧" test-results/test-output.log || true
    exit 0
else
    echo "Some tests failed"
    # Print the last 100 lines of test output for debugging
    tail -n 100 test-results/test-output.log || true
    exit 1
fi