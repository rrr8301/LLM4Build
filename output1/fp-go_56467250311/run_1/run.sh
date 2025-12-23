#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Enable CGO
export CGO_ENABLED=1

# Install project dependencies
go mod tidy

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test -v -race -coverprofile=coverage.txt -covermode=atomic ./...
set -e