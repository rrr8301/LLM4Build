#!/bin/bash

# Source the .bashrc to ensure the environment variables are loaded
source /root/.bashrc

# Install project dependencies
pnpm install

# Run tests
if [ "$GITHUB_REF_NAME" == "main" ]; then
  pnpm run test-main
else
  pnpm run test-branch
fi

# Ensure all tests are executed even if some fail