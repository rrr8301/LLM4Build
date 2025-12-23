#!/bin/bash

# Activate Go environment
export PATH="/usr/lib/go/bin:${PATH}"

# Install project dependencies
go mod tidy

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test ./...
set -e