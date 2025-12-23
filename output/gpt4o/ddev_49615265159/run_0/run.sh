#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
# Assuming dependencies are managed via Go modules
go mod download

# Run tests
set +e  # Continue on errors
make test
set -e  # Stop on errors