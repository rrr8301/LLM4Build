#!/bin/bash

set -e

# Set Go environment variables
export PATH="/usr/local/go/bin:${PATH}"

# Set Git config
git config --global user.email "gha@example.com"
git config --global user.name "GitHub Actions"

# Create a known_hosts file with a default entry
mkdir -p ~/.ssh
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Set the SSH_KNOWN_HOSTS environment variable
export SSH_KNOWN_HOSTS=~/.ssh/known_hosts

# Ensure Go modules are enabled
export GO111MODULE=on

# Download Go module dependencies
go mod download

# Run tests
make test-coverage || true

# Run specific Go tests
go test -timeout 45s -v -run '^TestExamples$' github.com/go-git/go-git/v6/_examples --examples || true