#!/bin/bash

# Set environment variables
export NODE_OPTIONS="--max-old-space-size=6144"
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD="1"
export VITEST_SEGFAULT_RETRY=3

# Install project dependencies
pnpm install

# Build the project
pnpm run build

# Run tests, ensuring all tests are executed even if some fail
set +e
pnpm run test-unit
pnpm run test-serve
pnpm run test-build
set -e