#!/bin/bash

# Run tests and other checks
set -e

# Ensure the test environment is correctly set up
# You might need to add commands here to prepare the test environment
# For example, copying necessary files or setting environment variables

# Ensure all necessary files are in place
# This is a placeholder for any setup that might be needed
# For example, if the test requires certain files to be generated or copied
# You can add commands here to ensure the test environment is correct

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