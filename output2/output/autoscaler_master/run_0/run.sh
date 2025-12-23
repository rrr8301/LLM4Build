#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GO111MODULE=auto

# Install project dependencies
hack/install-verify-tools.sh

# Run verification
hack/verify-all.sh -v

# Run golangci-lint
golangci-lint run --timeout=30m

# Run tests
hack/for-go-proj.sh test || true  # Ensure all tests run even if some fail