#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run tests
set +e  # Continue on error
go test -v -race -covermode atomic -coverprofile coverage.out ./...
set -e  # Stop on error

# Build Go binary
CGO_ENABLED=0 go build -v -trimpath -ldflags "-s -w" -o bin/ ./cmd/goproxy