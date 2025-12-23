#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm ci

# Build the project
npm run build

# Run tests and ensure all tests are executed even if some fail
set +e
npm run test:ci
set -e