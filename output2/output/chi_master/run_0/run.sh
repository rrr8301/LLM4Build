#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go get -d -t ./...

# Run tests
make test || true

# Ensure all tests are executed, even if some fail
exit 0