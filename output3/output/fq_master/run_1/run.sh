#!/bin/bash

# Enable error handling
set -e

# Activate Go environment
export CGO_ENABLED=1
export GOARCH=amd64

# Install Go dependencies
go mod download

# Run tests with race detection
make test-race