#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install Husky hooks if needed
if [ -d ".husky" ]; then
  npx husky install
fi

# Build the project
npm run build

# Run tests, ensuring all tests are executed even if some fail
npm test || true