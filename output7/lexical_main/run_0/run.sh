#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install

# Run tests and ensure all tests are executed
npm run test-unit || true
npm run test-e2e-chromium || true
npm run test-e2e-firefox || true
npm run test-e2e-webkit || true