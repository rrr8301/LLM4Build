#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run all tests, ensuring all test cases are executed
{
    # Run make test-coverage
    make test-coverage

    # Run specific Go tests
    go test -timeout 45s -v -run '^TestExamples$' github.com/go-git/go-git/v6/_examples --examples
} || true