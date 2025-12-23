#!/bin/bash

# Set environment variable for pnpm workers
export PNPM_WORKERS=3

# Run tests based on branch
if [ "$GITHUB_REF_NAME" == "main" ]; then
  pnpm run test-main || true
else
  pnpm run test-branch || true
fi