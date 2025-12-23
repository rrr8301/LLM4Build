#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests
echo "Running tests..."
npm test -- --no-parallel || { echo "Tests failed"; exit 1; }

# Run coverage
echo "Running coverage..."
npm run test-cov || { echo "Coverage failed"; exit 1; }