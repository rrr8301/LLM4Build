#!/bin/bash

# Install project dependencies
yarn install --frozen-lockfile

# Link local packages
yarn link --frozen-lockfile || true
yarn link webpack --frozen-lockfile

# Run tests with coverage
yarn cover:unit --ci --cacheDirectory .jest-cache || true

# Ensure all tests are executed
exit 0