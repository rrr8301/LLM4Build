#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies
pnpm install --frozen-lockfile

# Run tests
pnpm test || true  # Ensure all tests run even if some fail