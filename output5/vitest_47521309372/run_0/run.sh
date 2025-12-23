#!/bin/bash

# Activate environment variables
export PLAYWRIGHT_BROWSERS_PATH=/app/.cache/ms-playwright
export VITEST_GENERATE_UI_TOKEN='true'

# Install project dependencies
pnpm install

# Build the project
pnpm run build

# Run tests
set +e  # Continue on error
pnpm run test:ci
pnpm run test:examples
pnpm run -C packages/ui test:ui
set -e  # Stop on error