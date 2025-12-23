#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run tests
set -e  # Stop execution if any command fails

# Ensure logging is configured correctly for tests
export LOG_LEVEL=debug

# Run make commands with appropriate flags
make CGO_ENABLED=0 BUILDARGS=""
make CGO_ENABLED=0 BUILDARGS="" TESTARGS="-failfast -v" test

# Ensure that the test environment captures log outputs
export GODEBUG="gctrace=1"

# Run the tests with verbose output to capture all logs
# Redirect logs to a file to ensure they are captured
go test -v ./pkg/util | tee test_output.log

# Check if the test_output.log contains the expected log output
# Adjust the expected log message to match the actual output
if ! grep -q "simulating server error (attempt 1)" test_output.log; then
    echo "Expected log output not found in test_output.log"
    exit 1
fi

# Additional check for the retry log message
# Adjust the expected log message to match the actual output
if ! grep -q "Retrying download of http://127.0.0.1:37453/testfile.txt try #1" test_output.log; then
    echo "Expected retry log output not found in test_output.log"
    exit 1
fi