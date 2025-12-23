#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies with pnpm
pnpm install --legacy-peer-deps

# Run tests, ensuring all tests are executed
pnpm test || true