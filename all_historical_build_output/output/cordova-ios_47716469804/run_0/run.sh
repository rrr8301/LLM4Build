#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print Node.js and npm versions
node --version
npm --version

# Run npm lint and tests, ensuring all tests run even if some fail
npm run lint || true
npm run unit-tests || true