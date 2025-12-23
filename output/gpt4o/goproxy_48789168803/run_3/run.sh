#!/bin/bash

# Activate Go environment with cgo enabled
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH=/go
export PATH=$GOPATH/bin:$PATH
export CGO_ENABLED=1

# Install project dependencies
go mod download

# Run tests with race detector
set +e  # Continue executing even if some tests fail
go test -v -race -covermode atomic -coverprofile coverage.out ./...