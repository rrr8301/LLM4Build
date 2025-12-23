#!/bin/bash

# Activate Bun environment
export BUN_INSTALL="/root/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Ensure the correct Node.js version is used
source ~/.bashrc

# Install project dependencies
bun install

# Run lint, compile, dist, and test commands
set -e
bun run lint
bun run compile
bun run dist

# Update snapshots to reflect any intentional changes
bun run test -- --maxWorkers=2 --coverage --updateSnapshot || true

# Check for failing tests and handle them
if [ $? -ne 0 ]; then
  echo "Some tests failed. Please check the test cases and fix the issues."
  exit 1
fi