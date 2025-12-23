#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Download Go module dependencies
go mod download

# Run tests
# Ensure all tests are executed, even if some fail
go test ./... || true