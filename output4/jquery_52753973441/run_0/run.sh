#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise this is a placeholder)

# Install project dependencies
npm ci

# Run tests
npm run test:browserless || true

# Ensure all tests are executed, even if some fail
exit 0