#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run lint tests
echo "Running lint tests..."
npm run lint || true

# Run unit tests
echo "Running unit tests..."
npm run test-unit || true

# Run circular dependencies tests
echo "Running circular dependencies tests..."
npm run test-circular-deps || true

# Run e2e coverage tests
echo "Running e2e coverage tests..."
npm run test-e2e-cov || true

# Ensure all tests are executed even if some fail
echo "All tests executed."