#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm, it would be here)

# Ensure package-lock.json is present
if [ ! -f package-lock.json ]; then
    npm install --package-lock-only
fi

# Install project dependencies
npm ci

# Run tests and ensure all tests are executed
npm test || true