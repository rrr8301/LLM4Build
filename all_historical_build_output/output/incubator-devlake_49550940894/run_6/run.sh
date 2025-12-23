#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Ensure the go.mod file is present
if [ ! -f go.mod ]; then
    echo "go.mod file is missing"
    exit 1
fi

# Install project dependencies
go mod tidy

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test ./...
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE