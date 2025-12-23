#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run tests
set +e  # Continue execution even if some tests fail
make CGO_ENABLED=0 BUILDARGS=""
make CGO_ENABLED=0 BUILDARGS="" TESTARGS="-failfast" test