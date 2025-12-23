#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm, it would be here)

# Install project dependencies
npm install

# Run tests, ensuring all tests are executed even if some fail
npm test -- --no-parallel || true