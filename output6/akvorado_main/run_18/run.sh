#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
if [ -f package-lock.json ]; then
    npm ci
else
    npm install
fi

# Build the project
npm run build

# Run tests and ensure all tests are executed
npm test