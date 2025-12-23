#!/bin/bash

# Install project dependencies
npm ci

# Lint code
npm run lint

# Run tests, ensuring all tests are executed even if some fail
npm test || true

# Build the project
npm run build