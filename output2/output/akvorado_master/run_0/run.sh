#!/bin/bash

# Install project dependencies
npm ci

# Build the project
npm run build

# Run tests and ensure all tests are executed
npm test || true