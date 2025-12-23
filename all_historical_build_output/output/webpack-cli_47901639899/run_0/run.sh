#!/bin/bash

# Install project dependencies
yarn --frozen-lockfile --ignore-engines --ignore-scripts

# Prepare environment for tests
yarn build:ci

# Run tests and generate coverage
# Ensure all tests run even if some fail
set +e
yarn test:coverage --ci --shard=3/4
set -e

# Note: To upload coverage to Codecov, run the following command manually:
# bash <(curl -s https://codecov.io/bash) -t your_codecov_token