#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install --legacy-peer-deps --no-audit --no-fund

# Run tests without skipping any
npm test