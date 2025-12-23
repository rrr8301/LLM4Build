#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm)
# For now, assuming Node.js is already set up

# Install project dependencies
npm ci

# Run tests and ensure all tests are executed
set +e  # Continue on errors
npm run test:browserless
set -e  # Stop on errors