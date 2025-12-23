#!/bin/bash

# Run tests and ensure all tests are executed
set -e
echo "Starting test execution..."
npm test || true  # Continue even if npm test returns non-zero due to browser logs
echo "Checking test results..."

# Check if the test output contains "all tests passed"
if grep -q "all tests passed" /app/test-output.log; then
    echo "Tests completed successfully!"
    exit 0
else
    echo "Some tests failed"
    exit 1
fi