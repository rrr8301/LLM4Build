#!/bin/bash

# Set the environment variable for pnpm workers
export PNPM_WORKERS=3

# Install project dependencies
pnpm install

# Run tests based on the branch
if [ "$(git rev-parse --abbrev-ref HEAD)" == "main" ]; then
  pnpm run test-main
else
  pnpm run test-branch
fi

# Ensure all tests are executed, even if some fail