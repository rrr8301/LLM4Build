#!/bin/bash

# Run tests and other checks
set -e
yarn jest --ci --maxWorkers 4 --reporters=default --reporters=jest-junit --rootdir='./'
yarn typecheck
yarn typecheck-ts
yarn lint
yarn test-smoke
yarn test-coverage

# Placeholder for Codecov upload
echo "Codecov upload step would go here. Ensure CODECOV_TOKEN is set."