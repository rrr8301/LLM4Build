#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Navigate to the directory containing the Go module
cd _examples/rest

# Install project dependencies
go mod download

# Run tests
make test