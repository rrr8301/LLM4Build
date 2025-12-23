#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Build the project
go build ./...

# Run tests and ensure all tests are executed
set +e
go test ./...
set -e