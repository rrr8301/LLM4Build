#!/bin/bash

# Run tests and generate coverage
# Ensure all tests are executed, even if some fail
set -e
yarn test:coverage --ci --shard=4/4 || true

# Placeholder for manual Codecov upload
echo "Please upload coverage to Codecov manually."