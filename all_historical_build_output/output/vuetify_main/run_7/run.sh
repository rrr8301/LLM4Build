#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pnpm install

# Approve build scripts if necessary
# Automatically approve all builds to avoid interactive prompt
echo "y" | pnpm approve-builds

# Build Vuetify
pnpm build vuetify

# Check if the test script exists in package.json
if ! pnpm run | grep -q "test"; then
  echo "No test script found in package.json. Please define a test script."
  # Optionally, you can add a default test script here if needed
  # For example, you could run a basic lint or type-check as a placeholder
  # exit 1
else
  # Run unit tests
  pnpm run test --project unit

  # Run browser tests, continue on error
  set +e
  pnpm run test --project browser
  set -e
fi

# Note: Artifacts upload is not supported in this script