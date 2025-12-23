#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install

# Run tests
# Assuming tests are defined in package.json scripts
npm test  # Run all tests without skipping