#!/bin/bash

# Run tests and capture output
set -e
echo "Starting test execution..."
npm test 2>&1 | tee test-output.log
echo "Test execution completed."

# Check test results by looking for the success message or test summary
if grep -q "all tests passed! 🎉" test-output.log || \
   grep -q "passed, 0 failed" test-output.log; then
    echo "All tests passed successfully!"
    exit 0
else
    echo "Some tests failed"
    cat test-output.log
    exit 1
fi