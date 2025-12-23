#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH=/go
export PATH="$GOPATH/bin:${PATH}"

# Create build directory if it doesn't exist
mkdir -p build/linux_amd64

# Install project dependencies
go mod tidy

# Run tests
go test -v ./... || true

# Build the binary
BINARY_NAME=claude-squad
GOOS=linux GOARCH=amd64 go build -v -o build/linux_amd64/$BINARY_NAME