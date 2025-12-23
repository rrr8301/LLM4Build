#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Enable Go modules
export GO111MODULE=on

# Install project dependencies
go mod tidy

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test -v ./...
set -e