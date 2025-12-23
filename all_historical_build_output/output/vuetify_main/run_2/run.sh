#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pnpm install

# Build Vuetify
pnpm build vuetify

# Check if the test script exists in package.json
if ! pnpm run | grep -q "test"; then
  echo "No test script found in package.json. Please define a test script."
  exit 1
fi

# Run unit tests
pnpm run test --project unit

# Run browser tests, continue on error
set +e
pnpm run test --project browser
set -e

# Note: Artifacts upload is not supported in this script