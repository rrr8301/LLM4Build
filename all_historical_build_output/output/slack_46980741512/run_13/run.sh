#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Enable CGO
export CGO_ENABLED=1

# Ensure the Go version matches the one installed
go version

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test -v -race ./...
EXIT_CODE=$?
set -e

# Check if tests failed
if [ $EXIT_CODE -ne 0 ]; then
    echo "Some tests failed."
    exit $EXIT_CODE
else
    echo "All tests passed successfully."
fi