#!/bin/bash

# Activate bun environment
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Install project dependencies
bun install

# Run tests with coverage, ensuring all tests run even if some fail
set +e
bun test --coverage
set -e