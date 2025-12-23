#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
go mod tidy

# Build the project
make

# Run tests, ensuring all tests are executed even if some fail
set +e
make test-go
TEST_EXIT_CODE=$?
set -e

# Exit with the test command's exit code
exit $TEST_EXIT_CODE