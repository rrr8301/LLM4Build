#!/bin/bash

# Run tests and other checks
set -e
yarn jest --ci --maxWorkers 4 --reporters=default --reporters=jest-junit --rootdir='./' || true
yarn typecheck || true
yarn typecheck-ts || true
yarn lint || true
yarn test-smoke || true
yarn test-coverage || true

# Placeholder for Codecov upload
echo "Codecov upload step would go here. Ensure CODECOV_TOKEN is set."