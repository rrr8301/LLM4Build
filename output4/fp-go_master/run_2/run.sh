#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Enable cgo
export CGO_ENABLED=1

# Install project dependencies
go mod tidy

# Run tests
set -e  # Stop execution if any test fails
go test -v -race -coverprofile=coverage.txt -covermode=atomic ./...