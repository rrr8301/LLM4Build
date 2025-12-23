#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Check Go version
go version

# Install project dependencies
go mod tidy

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test -v -race ./...
EXIT_CODE=$?
set -e

# Exit with the test command's exit code
exit $EXIT_CODE