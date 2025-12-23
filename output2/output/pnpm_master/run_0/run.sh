#!/bin/bash

# Activate environment (if any specific activation is needed, add here)

# Install project dependencies
pnpm install

# Run tests
pnpm run test || true  # Ensure all tests run even if some fail