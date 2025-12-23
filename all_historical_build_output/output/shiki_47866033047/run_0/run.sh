#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
nci

# Build the project
nr build

# Run tests and ensure all tests are executed even if some fail
set +e
nr test --coverage
EXIT_CODE=$?

# Exit with the test command's exit code
exit $EXIT_CODE