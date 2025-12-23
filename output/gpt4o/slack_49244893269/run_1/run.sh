#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH=/go
export GOCACHE=/go/.cache

# Install project dependencies
go mod download

# Run tests
go test -v -race ./... || true