#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pnpm install

# Build the project
pnpm run build

# Run tests, ensuring all tests are executed
pnpm run test:ci || true
pnpm run test:examples || true
pnpm run -C packages/ui test:ui || true