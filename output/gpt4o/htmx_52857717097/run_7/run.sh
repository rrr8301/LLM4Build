#!/bin/bash

# Run tests and capture output
set -e
echo "Starting test execution..."
npm test 2>&1 | tee test-output.log
echo "Test execution completed."

# Check test results more thoroughly
if grep -q "failed" test-output.log || ! grep -q "passed" test-output.log; then
    echo "Some tests failed"
    cat test-output.log
    exit 1
else
    echo "All tests passed successfully!"
    exit 0
fi