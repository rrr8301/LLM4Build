#!/bin/bash

# Activate Node.js environment
pnpm env use -g 20.18.1

# Ensure pnpm global bin directory is in PATH
export PATH=$(pnpm bin -g):$PATH

# Install project dependencies
pnpm install

# Run tests based on branch
if [ "$(git rev-parse --abbrev-ref HEAD)" == "main" ]; then
  PNPM_WORKERS=3 pnpm run test-main || true
else
  PNPM_WORKERS=3 pnpm run test-branch || true
fi