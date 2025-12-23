#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install

# Check if a test script is defined in package.json
if npm run | grep -q "test"; then
  # Run tests
  npm test  # Run all tests without skipping
else
  echo "No test script found in package.json"
fi