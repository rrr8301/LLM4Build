#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH=/go
export GOCACHE=/go/.cache
export CGO_ENABLED=1

# Install project dependencies
go mod download

# Run tests with flags to skip enforcer and license checks
# Using build tags instead of command line flags
go test -v -race -tags=skip_enforcer,skip_license ./...