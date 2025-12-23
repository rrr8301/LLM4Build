#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies with legacy-peer-deps to resolve conflicts
pnpm install --legacy-peer-deps

# Run tests and ensure all tests are executed even if some fail
pnpm test