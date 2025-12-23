#!/bin/bash

# Run tests and other checks
set -e

# Ensure the test environment is correctly set up
# You might need to add commands here to prepare the test environment
# For example, copying necessary files or setting environment variables

# Run the test suite
yarn jest --ci --maxWorkers 4 --reporters=default --reporters=jest-junit --rootdir='./'

# Run additional checks
yarn typecheck
yarn typecheck-ts
yarn lint
yarn test-smoke
yarn test-coverage

# Placeholder for Codecov upload
echo "Codecov upload step would go here. Ensure CODECOV_TOKEN is set."