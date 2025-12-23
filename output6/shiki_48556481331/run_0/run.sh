#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
nci

# Build the project
nr build

# Run tests with coverage, continue even if some tests fail
set +e
nr test --coverage
set -e