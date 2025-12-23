#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Activate environments (if any)

# Install project dependencies
# Placeholder for any pip/npm install commands if needed

# Run environment information
npx envinfo

# Build the project
make build-ci -j4 V=1 CONFIG_FLAGS="--error-on-warn"

# Run tests
# Ensure all tests are executed, even if some fail
set +e
make test-internet -j4 V=1
set -e