#!/bin/bash

# Enable strict error checking
set -eo pipefail

echo "Starting test execution..."

# Create test output directory if it doesn't exist
mkdir -p test-results

# Start http-server for test endpoints in background
http-server -p 8000 --silent &
SERVER_PID=$!

# Function to clean up
cleanup() {
    echo "Cleaning up..."
    kill $SERVER_PID 2>/dev/null || true
}
trap cleanup EXIT

# Run tests with more detailed output and capture exit code
TEST_EXIT_CODE=0
npm test -- --verbose --bail=false 2>&1 | tee test-results/test-output.log || TEST_EXIT_CODE=$?

# Check test results
if [ $TEST_EXIT_CODE -eq 0 ]; then
    echo "All tests passed successfully!"
    # Print any expected network errors that are marked with 🚧
    if [ -f "test-results/test-output.log" ]; then
        grep -A 10 "🚧" test-results/test-output.log || true
    fi
    exit 0
else
    echo "Some tests failed"
    # Print the last 100 lines of test output for debugging
    if [ -f "test-results/test-output.log" ]; then
        tail -n 100 test-results/test-output.log || true
    fi
    exit 1
fi