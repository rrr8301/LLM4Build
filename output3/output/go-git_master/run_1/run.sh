#!/bin/bash

# Set Git config
git config --global user.email "gha@example.com"
git config --global user.name "GitHub Actions"

# Install project dependencies
# Assuming dependencies are managed by Go modules
go mod download

# Run tests
set +e  # Continue on errors
make test-coverage
go test -timeout 45s -v ./...  # Run all tests in the module
set -e  # Stop on errors