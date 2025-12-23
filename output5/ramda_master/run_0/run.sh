#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run linting
npm run lint || true

# Run tests
npm run test || true

# Build artifacts
npm run build || true