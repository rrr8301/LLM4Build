#!/bin/bash

# Activate environment variables if any (none specified)

# Install project dependencies
npm ci

# Build the project
npm run build

# Run tests with coverage
npm run test-coverage || true

# Placeholder for manual upload to Codecov
echo "Upload coverage to Codecov manually using the ./.coverage/lcov.info file."