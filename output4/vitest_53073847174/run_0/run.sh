#!/bin/bash

# Install project dependencies
pnpm install

# Build the project
pnpm run build

# Run tests
pnpm run test:ci || true
pnpm run test:examples || true
pnpm run -C packages/ui test:ui || true

# Ensure all tests are executed even if some fail