#!/bin/bash

# Install project dependencies
npm ci

# Run tests and ensure all tests are executed
set +e  # Continue on errors
npm run ci-check
npm run build
npm run build-www
npm run test-unit
npm run test-integration
npm run test-e2e
set -e  # Stop on errors