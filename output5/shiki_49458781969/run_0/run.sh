#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
nci

# Build the project
nr build

# Run tests with coverage
nr test --coverage || true

# Placeholder for uploading coverage reports to Codecov
echo "Upload coverage reports to Codecov manually."