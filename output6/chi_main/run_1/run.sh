#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Enable cgo
export CGO_ENABLED=1

# Install Go dependencies
go get -t ./...

# Run tests
# Ensure all tests are executed, even if some fail
set +e
make test
EXIT_CODE=$?
set -e

# Exit with the test command's exit code
exit $EXIT_CODE