#!/bin/bash

# Run tests and capture output
set -e
echo "Starting test execution..."
TEST_OUTPUT=$(npm test 2>&1)
echo "$TEST_OUTPUT" | tee test-output.log
echo "Test execution completed."

# Check test results
if echo "$TEST_OUTPUT" | grep -q "all tests passed! 🎉" || \
   echo "$TEST_OUTPUT" | grep -q "passed, 0 failed"; then
    echo "All tests passed successfully!"
    exit 0
else
    echo "Some tests failed"
    cat test-output.log
    exit 1
fi