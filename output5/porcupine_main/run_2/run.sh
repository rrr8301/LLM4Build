#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests
# Ensure all test cases are executed, even if some fail
go test ./...