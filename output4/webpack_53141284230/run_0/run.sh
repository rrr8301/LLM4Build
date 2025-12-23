#!/bin/bash

# Install project dependencies
yarn install --frozen-lockfile

# Link webpack
yarn link --frozen-lockfile || true
yarn link webpack --frozen-lockfile

# Run tests
yarn cover:integration:a --ci --cacheDirectory .jest-cache || yarn cover:integration:a --ci --cacheDirectory .jest-cache -f

# Merge coverage
yarn cover:merge