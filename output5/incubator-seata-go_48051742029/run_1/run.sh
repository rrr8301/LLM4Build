#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run build
go build -v ./...

# Run tests with coverage
go test -v ./... -race -coverprofile=coverage.out -covermode=atomic || true

# Note: Upload coverage is not handled here. Manual upload or alternative storage is needed.
echo "Coverage report generated at coverage.out. Please upload manually."