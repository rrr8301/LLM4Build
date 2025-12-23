#!/bin/bash

# Activate nvm
export NVM_DIR="/root/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Set environment variables
export NODE_OPTIONS="--max-old-space-size=6144"
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD="1"
export VITEST_SEGFAULT_RETRY=3

# Install project dependencies
pnpm install

# Build the project
pnpm run build

# Run tests
set +e  # Continue on errors
pnpm run test-unit
pnpm run test-serve
pnpm run test-build
set -e  # Stop on errors