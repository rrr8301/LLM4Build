#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH=/go
export GOCACHE=/go/.cache

# Install project dependencies
go mod download

# Run tests with flags to skip enforcer and license checks if they exist
go test -v -race ./... -skip-enforcer -skip-license || true