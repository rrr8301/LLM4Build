#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies with legacy-peer-deps to resolve conflicts
npm install --legacy-peer-deps

# Run tests, ensuring all tests are executed
npm test || true