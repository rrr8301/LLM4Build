#!/bin/bash

set -e

# Run Go tests
go test -v -race -covermode atomic -coverprofile coverage.out ./...

# Build Go binary
CGO_ENABLED=0 go build -v -trimpath -ldflags "-s -w" -o bin/ ./cmd/goproxy

# Note: The following steps are ignored as they are unsupported in this context:
# - Upload code coverage
# - Build Docker image
# - Set up QEMU
# - Run GoReleaser