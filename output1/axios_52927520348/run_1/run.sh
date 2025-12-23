#!/bin/bash

# Install project dependencies
npm ci --ignore-scripts

# Build the project
npm run build

# Run tests
npm run test:node || true
npm run test:browser || true
npm run test:package || true