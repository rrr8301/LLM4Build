#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run tests
set -e  # Stop execution if any command fails

# Ensure logging is configured correctly for tests
export LOG_LEVEL=debug

# Run make commands with appropriate flags
make CGO_ENABLED=0 BUILDARGS=""
make CGO_ENABLED=0 BUILDARGS="" TESTARGS="-failfast -v" test