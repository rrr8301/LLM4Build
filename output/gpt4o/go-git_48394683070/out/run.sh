#!/bin/bash

# Set Go environment variables
export PATH="/usr/local/go/bin:${PATH}"

# Set Git config
git config --global user.email "gha@example.com"
git config --global user.name "GitHub Actions"

# Run tests
make test-coverage

# Run specific Go tests
go test -timeout 45s -v -run '^TestExamples$' github.com/go-git/go-git/v6/_examples --examples || true