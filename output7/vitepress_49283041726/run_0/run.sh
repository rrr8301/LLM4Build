#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pnpm install

# Install Playwright
pnpm playwright install chromium

# Run the check command
pnpm check || true

# Run tests and ensure all tests are executed
pnpm test || true