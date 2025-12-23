#!/bin/bash

# Set NODE_OPTIONS for increased memory limit
export NODE_OPTIONS='--max-old-space-size=4096'

# Run tests with coverage
npm run test-coverage || true

# Placeholder for manual coverage upload
echo "Upload coverage to Codecov manually if needed."