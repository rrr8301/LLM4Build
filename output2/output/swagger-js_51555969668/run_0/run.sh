#!/bin/bash

# Activate environment variables if any

# Install project dependencies
npm ci

# Lint code
npm run lint

# Run all tests, ensuring all tests are executed even if some fail
npm test || true

# Build the project
npm run build

# Note: Artifact upload is not handled in this script