#!/bin/bash

set -e

# Run tests
echo "Running tests..."
go test -v ./... || true

# Build the binary
echo "Building the binary..."
BINARY_NAME=claude-squad
GOOS=linux GOARCH=amd64 go build -v -o build/${GOOS}_${GOARCH}/$BINARY_NAME

echo "Build completed. Binary is located in build/${GOOS}_${GOARCH}/"