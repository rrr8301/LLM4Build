#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm)
# Assuming Node.js is already set up in the Dockerfile

# Navigate to the root directory
cd /app

# Install project dependencies
npm ci

# Install webview-ui dependencies
cd webview-ui
npm ci
cd ..

# Build tests and extension
npm run ci:build

# Run all tests with coverage
set +e  # Continue execution even if some tests fail
npx nyc --nycrc-path .nycrc.unit.json --reporter=lcov npm run test:unit
xvfb-run -a npm run test:coverage
cd webview-ui && npm run test:coverage
set -e  # Re-enable exit on error

# Note: Coverage reports are not saved as artifacts in this script