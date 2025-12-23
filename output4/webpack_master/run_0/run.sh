#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
yarn install --frozen-lockfile

# Link packages
yarn link --frozen-lockfile || true
yarn link webpack --frozen-lockfile

# Run tests and ensure all tests are executed
yarn test --ci --cacheDirectory .jest-cache || true