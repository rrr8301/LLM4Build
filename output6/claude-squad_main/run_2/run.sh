#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Ensure go.mod is correctly formatted
sed -i 's/go 1.23.0/go 1.23/' go.mod
sed -i '/^toolchain/d' go.mod

# Install Go dependencies
go mod download

# Run tests
go test -v ./...

# Build the binary
BINARY_NAME=claude-squad
GOOS=linux GOARCH=amd64 go build -v -o build/${GOOS}_${GOARCH}/$BINARY_NAME

# Note: Uploading artifacts is not handled as it is a GitHub-specific action