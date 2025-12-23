#!/bin/bash

# Activate environment variables if any (none in this case)

# Install project dependencies
npm ci

# Run linting
npm run lint || true

# Run tests
npm test || true

# Build the project
npm run build || true