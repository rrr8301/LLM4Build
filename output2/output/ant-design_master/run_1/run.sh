#!/bin/bash

# Activate Bun environment
export BUN_INSTALL="/root/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Install project dependencies
bun install

# Run lint, compile, dist, and test commands
set -e
bun run lint || true
bun run compile || true
bun run dist || true
bun run test -- --maxWorkers=2 --coverage || true