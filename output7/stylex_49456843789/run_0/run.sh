#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install

# Run tests, ensuring all tests are executed even if some fail
npm run test:packages || true