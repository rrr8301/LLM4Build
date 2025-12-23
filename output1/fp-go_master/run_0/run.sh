#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run go mod tidy to ensure all dependencies are available
go mod tidy

# Run tests and ensure all tests are executed even if some fail
set +e
go test -v -race -coverprofile=coverage.txt -covermode=atomic ./...
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE