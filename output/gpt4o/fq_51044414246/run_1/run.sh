#!/bin/bash

# Set Go environment variables
export CGO_ENABLED=0
export GOARCH=386

# Install Go dependencies
go mod download

# Run tests
make test || true