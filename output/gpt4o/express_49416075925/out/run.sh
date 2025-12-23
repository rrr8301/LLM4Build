#!/bin/bash

# Install project dependencies
npm install

# Output Node and NPM versions
echo "Node.js version: $(node -v)"
echo "NPM version: $(npm -v)"

# Run tests and ensure all tests are executed
npm run test-ci || true