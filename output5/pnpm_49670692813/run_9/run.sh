#!/bin/bash

# Set the environment variable for pnpm workers
export PNPM_WORKERS=3

# Ensure the pnpm store is set correctly
export PNPM_HOME=/root/.local/share/pnpm
export PATH=$PNPM_HOME:$PATH

# Clear pnpm store and reinstall project dependencies to ensure everything is in place
pnpm store prune
pnpm install --frozen-lockfile --store-dir $PNPM_HOME

# Run tests based on the branch
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH_NAME" == "main" ]; then
  pnpm run test-main
else
  pnpm run test-branch
fi