#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
pnpm install

# Run tests, ensuring all tests are executed even if some fail
pnpm run test:ci || true
pnpm run test:examples || true
pnpm run -C packages/ui test:ui || true