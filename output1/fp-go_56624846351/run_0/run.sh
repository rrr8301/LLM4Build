#!/bin/bash

# Activate Go environment (if needed, but Go doesn't require activation like Python)
# Install project dependencies
go mod tidy

# Run tests
# Ensure all tests are executed, even if some fail
set -e
go test -v -race -coverprofile=coverage.txt -covermode=atomic ./... || true