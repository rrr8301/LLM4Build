#!/bin/bash

# Source the .bashrc to ensure the environment variables are loaded
source /root/.bashrc

# Ensure PNPM_HOME is in the PATH
export PNPM_HOME="/root/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Install project dependencies with frozen lockfile to ensure consistency
pnpm install --frozen-lockfile

# Run tests
if [ "$GITHUB_REF_NAME" == "main" ]; then
  pnpm run test-main
else
  pnpm run test-branch
fi

# Ensure all tests are executed even if some fail