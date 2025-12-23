#!/bin/bash

# Install project dependencies
pnpm install --frozen-lockfile

# Install Playwright
pnpm playwright install chromium

# Run tests
set +e  # Continue on errors
pnpm check
set -e  # Stop on errors