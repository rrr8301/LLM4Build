#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm)
# For now, assume Node.js is globally available

# Install project dependencies
npm install

# Run tests
# Ensure all tests are executed, even if some fail
set +e
npm test
set -e