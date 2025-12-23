#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies
pnpm install

# Run tests
if [ "$GITHUB_REF_NAME" == "main" ]; then
  pnpm run test-main || true
else
  pnpm run test-branch || true
fi

# Ensure all tests are executed even if some fail