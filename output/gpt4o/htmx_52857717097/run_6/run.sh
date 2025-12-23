#!/bin/bash

# Run tests and capture output
set -e
echo "Starting test execution..."
npm test > test-output.log 2>&1 || true  # Continue even if npm test returns non-zero due to browser logs
echo "Test execution completed."

# Check if tests passed
if grep -q "all tests passed" test-output.log; then
    echo "All tests passed successfully!"
    exit 0
else
    echo "Some tests failed"
    cat test-output.log
    exit 1
fi