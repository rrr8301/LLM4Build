#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
# Assuming dependencies are managed by go.mod
go mod tidy

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test -v -coverprofile="coverage.txt" -covermode=atomic ./...
set -e

# Placeholder for Codecov upload
echo "Please manually upload coverage.txt to Codecov."