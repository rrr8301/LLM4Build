#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm, it would be here)

# Install project dependencies
npm ci

# Run tests and ensure all tests are executed
npm test || true