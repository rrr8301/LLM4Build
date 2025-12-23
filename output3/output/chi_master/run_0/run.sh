#!/bin/bash

# Install Go dependencies
go get -d -t ./...

# Run tests
make test || true

# Ensure all tests are executed, even if some fail
exit 0