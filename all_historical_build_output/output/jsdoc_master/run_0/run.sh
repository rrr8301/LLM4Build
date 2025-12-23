#!/bin/bash

# Activate environment (if any)

# Install project dependencies
npm install

# Run license check
npm run license-check || true

# Run lint
npm run lint || true

# Run tests
npm run test || true

# Ensure all tests are executed, even if some fail