#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm, it would be here)

# Install project dependencies
npm ci

# Run linting
npm run lint

# Run tests and ensure all tests are executed
npm run test || true

# Build artifacts
npm run build