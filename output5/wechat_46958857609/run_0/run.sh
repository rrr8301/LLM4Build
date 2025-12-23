#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies (if any)
# Assuming no additional dependencies are needed as Go modules are used

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test -v -race ./...
set -e