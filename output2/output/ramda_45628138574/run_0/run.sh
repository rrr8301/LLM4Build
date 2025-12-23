#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm, it would be here)

# Install project dependencies
npm ci

# Run linting
npm run lint || true

# Run tests
npm run test || true

# Build artifacts
npm run build || true

# Ensure all steps are executed even if some fail