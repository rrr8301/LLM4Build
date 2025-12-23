#!/bin/bash

set -e
set -o pipefail

# Set GOBIN to a directory in PATH
export GOBIN=/usr/local/bin

# Install Go dependencies
go mod download

# Build the project
CGO_ENABLED=0 go build ./...
go install ./tools/build_gcsfuse

# Ensure build_gcsfuse is in PATH
if ! command -v build_gcsfuse &> /dev/null; then
    echo "build_gcsfuse could not be found"
    exit 1
fi

# Set a default version if GITHUB_SHA is not set
VERSION=${GITHUB_SHA:-"default_version"}

# Run build_gcsfuse with correct arguments
build_gcsfuse . /tmp $VERSION

# Run tests with coverage
echo "Running tests with coverage..."
CGO_ENABLED=0 go test -p 1 -count 1 -covermode=atomic -coverprofile=coverage.out -coverpkg=./... -v ./... || {
    echo "Tests failed. Check the output above for details."
    exit 1
}

# Run race detector tests
echo "Running race detector tests..."
go test -p 1 -count 1 -v -race ./internal/cache/... ./internal/gcsx/... || {
    echo "Race detector tests failed. Check the output above for details."
    exit 1
}

# Placeholder for uploading coverage reports
echo "Upload coverage reports manually using the coverage.out file."