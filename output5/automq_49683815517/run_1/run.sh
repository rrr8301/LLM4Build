#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
npm install

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
npm test
set -e  # Re-enable exit on error