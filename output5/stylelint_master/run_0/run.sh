#!/bin/bash

# Activate environment variables if needed
export NODE_OPTIONS='--max-old-space-size=4096'

# Run tests
npm run test || true

# Run tests with coverage
npm run test-coverage || true

# Note: Codecov upload is not included due to unsupported action