#!/bin/bash

# Activate environment variables
export CI=true

# Install project dependencies
yarn install

# Run tests for the specified package
yarn nx test eslint-plugin || true

# Ensure all tests are executed, even if some fail
exit 0