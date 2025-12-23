#!/bin/bash

set -e

# Enable CGO for testing
export CGO_ENABLED=1

# Run Go tests
go test -v -race -covermode atomic -coverprofile coverage.out ./...

# Disable CGO for building
export CGO_ENABLED=0

# Build Go binary
go build -v -trimpath -ldflags "-s -w" -o bin/ ./cmd/goproxy

# Note: The following steps are ignored as they are unsupported in this context:
# - Upload code coverage
# - Build Docker image
# - Set up QEMU
# - Run GoReleaser