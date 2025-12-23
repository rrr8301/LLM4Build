#!/bin/bash

# Activate environment variables if needed
export FORCE_COLOR=2

# Install project dependencies
npm install

# Run tests
# Ensure all tests are executed, even if some fail
set +e
npm test
set -e