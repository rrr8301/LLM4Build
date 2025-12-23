#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
npm ci
cd webview-ui && npm ci
cd ..

# Build tests and extension
npm run pretest

# Run all tests, ensuring all tests are executed even if some fail
set +e
xvfb-run -a npm run test:e2e:optimal
npm run test:unit
node ./scripts/test-ci.js
set -e

# Webview tests with coverage
cd webview-ui
npm install --no-save @vitest/coverage-v8
npm run test:coverage
cd ..

# Note: Coverage reports are assumed to be handled within the container