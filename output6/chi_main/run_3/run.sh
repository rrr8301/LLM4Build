#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Navigate to the directory containing the Go module
cd _examples/rest

# Install Go dependencies
go mod download

# Run Go tests directly
# Ensure all tests are executed, even if some fail
set +e
go test ./...
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE