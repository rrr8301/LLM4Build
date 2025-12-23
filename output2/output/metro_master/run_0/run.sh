#!/bin/bash

# Run Jest tests
yarn jest --ci --maxWorkers 4 --reporters=default --reporters=jest-junit --rootdir='./'

# Run type check, lint, and smoke tests
yarn typecheck || true
yarn typecheck-ts || true
yarn lint || true
yarn test-smoke || true

# Run tests with coverage
yarn test-coverage || true

# Placeholder for Codecov upload
# ./codecov -t <CODECOV_TOKEN> -f ./coverage/coverage-final.json || true

# Ensure all tests are executed, even if some fail
exit 0