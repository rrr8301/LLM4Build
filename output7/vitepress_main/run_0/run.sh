#!/bin/bash

# Activate environment (if any, e.g., nvm, but not needed here)

# Install project dependencies
npm install

# Run tests
# Ensure all tests run even if some fail
npm test || true