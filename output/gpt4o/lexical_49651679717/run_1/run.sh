#!/bin/bash

# Install project dependencies (skip husky install)
npm install --ignore-scripts

# Run tests using jest directly if npm test isn't available
if [ -f "node_modules/.bin/jest" ]; then
    ./node_modules/.bin/jest --config jest.config.js
else
    echo "No test runner found. Please ensure jest is installed."
    exit 1
fi