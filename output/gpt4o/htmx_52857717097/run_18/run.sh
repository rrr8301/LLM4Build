#!/bin/bash

# Enable strict error checking
set -eo pipefail

echo "Starting test execution..."

# Create test output directory if it doesn't exist
mkdir -p test-results

# Start http-server for test endpoints in background with retries
for i in {1..3}; do
    echo "Starting http-server attempt $i..."
    http-server -p 8000 --silent -c-1 . &
    SERVER_PID=$!
    sleep 5
    if ps -p $SERVER_PID > /dev/null && curl -s http://localhost:8000 >/dev/null; then
        echo "http-server started successfully"
        break
    else
        echo "http-server failed to start, retrying..."
        kill $SERVER_PID 2>/dev/null || true
    fi
done

# Function to clean up
cleanup() {
    echo "Cleaning up..."
    kill $SERVER_PID 2>/dev/null || true
}
trap cleanup EXIT

# Wait for server to be ready
echo "Waiting for server to be fully ready..."
sleep 10

# Run tests with more detailed output and capture exit code
echo "Running tests..."
TEST_EXIT_CODE=0
npm test -- --verbose --bail=false --retries=3 --timeout=60000 2>&1 | tee test-results/test-output.log || TEST_EXIT_CODE=$?

# Check test results
if [ $TEST_EXIT_CODE -eq 0 ]; then
    echo "All tests passed successfully!"
    # Print any expected network errors that are marked with 🚧
    if [ -f "test-results/test-output.log" ]; then
        echo "Reviewing test logs for expected errors..."
        grep -A 10 "🚧" test-results/test-output.log || true
    fi
    exit 0
else
    echo "Some tests failed"
    # Print the last 100 lines of test output for debugging
    if [ -f "test-results/test-output.log" ]; then
        echo "Last 100 lines of test output:"
        tail -n 100 test-results/test-output.log || true
    fi
    exit 1
fi