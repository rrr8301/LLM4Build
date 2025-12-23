#!/bin/bash

# Install Go dependencies
go mod download

# Run tests
make test

# Exit with the status of the last command
exit $?