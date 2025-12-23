#!/bin/bash

# Install project dependencies
npm ci

# Run tests with coverage
set +e  # Continue execution even if some tests fail
npm run test-coverage
set -e