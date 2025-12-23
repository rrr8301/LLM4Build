#!/bin/bash

# Install root dependencies
npm ci

# Install webview-ui dependencies
cd webview-ui && npm ci && cd ..

# Build tests and extension
npm run ci:build

# Run all tests with coverage
npx nyc --nycrc-path .nycrc.unit.json --reporter=lcov npm run test:unit || true
xvfb-run -a npm run test:coverage || true
cd webview-ui && npm run test:coverage || true

# Placeholder for saving coverage reports
echo "Coverage reports would be saved here if not for unsupported actions."