#!/bin/bash

# Install project dependencies
npm ci --ignore-scripts

# Build the project
npm run build

# Run server tests
npm run test:node || true

# Run browser tests (only for Node.js version 22.x)
if [ "$(node -v)" == "v22.x" ]; then
  npm run test:browser || true
fi

# Run package tests
npm run test:package || true