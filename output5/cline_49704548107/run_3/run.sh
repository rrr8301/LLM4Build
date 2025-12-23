#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install Node.js dependencies
npm ci

# Ensure all necessary directories exist
mkdir -p /app/src/generated/hosts
mkdir -p /app/webview-ui/src/services

# Install webview-ui dependencies
cd webview-ui && npm ci && cd ..

# Run type checks, lint checks, and format checks
npm run check-types
npm run lint
npm run format

# Build tests and extension
npm run pretest

# Run unit tests
npm run test:unit

# Run extension integration tests with coverage
node ./scripts/test-ci.js 2>&1 | tee extension_coverage.txt || true
PYTHONUTF8=1 PYTHONPATH=.github/scripts python3.10 -m coverage_check extract-coverage extension_coverage.txt --type=extension --github-output --verbose || true

# Run webview tests with coverage
cd webview-ui
npm install --no-save @vitest/coverage-v8
npm run test:coverage 2>&1 | tee webview_coverage.txt || true
cd ..
PYTHONUTF8=1 PYTHONPATH=.github/scripts python3.10 -m coverage_check extract-coverage webview-ui/webview_coverage.txt --type=webview --github-output --verbose || true

# Check for test failures
if [ "${PIPESTATUS[0]}" -ne 0 ]; then
    echo "Extension Integration Tests failed, see previous step for test output."
fi
if [ "${PIPESTATUS[1]}" -ne 0 ]; then
    echo "Webview Tests failed, see previous step for test output."
fi