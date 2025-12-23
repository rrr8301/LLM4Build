#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run tests
go test -v -coverprofile="coverage.txt" -covermode=atomic ./...

# Note: Codecov step is ignored as it is not supported outside GitHub Actions