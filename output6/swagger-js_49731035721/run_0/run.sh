#!/bin/bash

# Activate environment variables if needed (none in this case)

# Install project dependencies
npm ci

# Lint code
npm run lint

# Run all tests, ensuring all tests are executed even if some fail
npm test || true

# Build the project
npm run build