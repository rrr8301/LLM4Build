#!/bin/bash

# Activate Node.js environment
# Switch to Node.js 20.11.0 for integrity tests
n 20.11.0

# Run integrity tests
npm run ci-check || true
npm run build || true
npm run build-www || true

# Switch to Node.js 18.18.0 for unit tests
n 18.18.0

# Run unit tests
npm run test-unit || true

# Ensure all tests are executed even if some fail
exit 0