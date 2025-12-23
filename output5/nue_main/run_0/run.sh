#!/bin/bash

# Activate environment (if any)

# Install project dependencies
npm install

# Run tests
# Ensure all tests are executed, even if some fail
set +e
npm test
set -e