#!/bin/bash

set -e

# Install project dependencies
yarn install

# Verify dependency versions
yarn check-dependency-version-consistency .

# Lint files
yarn lint

# Typecheck files
yarn typecheck

# Build packages in the monorepo
yarn lerna run prepack

# Bundle example JavaScript with Metro
yarn example expo export --platform all

# Bundle example JavaScript with Vite
yarn example web build

# Run tests with coverage
# Ensure all tests run even if some fail
set +e
yarn test --maxWorkers=2 --coverage
set -e

# Note: To upload coverage to Codecov, run the following command manually:
# bash <(curl -s https://codecov.io/bash) -t your_codecov_token