#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Set Git config
git config --global user.email "gha@example.com"
git config --global user.name "GitHub Actions"

# Run make test-coverage
make test-coverage || true

# Run Go test for examples
go test -timeout 45s -v -run '^TestExamples$' github.com/go-git/go-git/v6/_examples --examples || true