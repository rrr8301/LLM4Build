#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run tests
set -e  # Stop execution if any command fails
make CGO_ENABLED=0 BUILDARGS=""
make CGO_ENABLED=0 BUILDARGS="" TESTARGS="-failfast" test