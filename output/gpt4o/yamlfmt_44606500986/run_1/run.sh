#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Verify Go installation
go version

# Install project dependencies
go mod tidy

# Run tests
set +e  # Continue on errors
make vet
make test_v
make integrationtest
set -e  # Stop on errors