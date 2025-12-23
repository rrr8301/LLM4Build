#!/bin/bash

# Install Go dependencies
go mod download

# Clean test cache and run tests
go clean -testcache

# Run tests
make test

# Exit with the status of the last command
exit $?