#!/bin/bash

# Install project dependencies
nci

# Build the project
nr build

# Run tests with coverage, ensuring all tests run even if some fail
set +e
nr test --coverage
set -e