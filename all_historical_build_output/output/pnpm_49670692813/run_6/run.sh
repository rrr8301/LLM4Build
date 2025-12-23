#!/bin/bash

# Set the environment variable for pnpm workers
export PNPM_WORKERS=3

# Ensure the pnpm store is set correctly
export PNPM_HOME=/root/.local/share/pnpm
export PATH=$PNPM_HOME:$PATH

# Install project dependencies
pnpm install --frozen-lockfile

# Run tests based on the branch
if [ "$(git rev-parse --abbrev-ref HEAD)" == "main" ]; then
  pnpm run test-main
else
  pnpm run test-branch
fi

# Ensure all tests are executed, even if some fail