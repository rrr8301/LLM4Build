#!/bin/bash

# Activate environment (if any)

# Install project dependencies
npm ci

# Install webview-ui dependencies
cd webview-ui && npm ci && cd ..

# Build Tests and Extension
npm run ci:build

# Run Unit Tests with coverage - Linux
npx nyc --nycrc-path .nycrc.unit.json --reporter=lcov npm run test:unit || true

# Run Extension Integration Tests - Linux
xvfb-run -a npm run test:coverage || true

# Run Webview Tests with Coverage
cd webview-ui && npm run test:coverage || true