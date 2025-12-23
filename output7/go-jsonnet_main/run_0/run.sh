#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
go mod tidy

# Run tests, ensuring all tests are executed even if some fail
set +e
go test ./...
TEST_EXIT_CODE=$?

# Exit with the test exit code
exit $TEST_EXIT_CODE