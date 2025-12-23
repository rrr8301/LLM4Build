#!/bin/bash

# Set Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Compile binaries
make build

# Run tests
make test || true
make integration-test || true