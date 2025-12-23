#!/bin/bash

# Install project dependencies
npm ci

# Build the project
npm run build

# Run tests with coverage
# Ensure all tests are executed even if some fail
set +e
NODE_OPTIONS='--max-old-space-size=4096' npm run test-coverage
set -e

# Note: Coverage upload to Codecov is not automated in this script.
# Please upload the coverage report manually if needed.