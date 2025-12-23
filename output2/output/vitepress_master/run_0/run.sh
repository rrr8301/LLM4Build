#!/bin/bash

# Install project dependencies
pnpm install --frozen-lockfile

# Install Playwright
pnpm playwright install chromium

# Run checks
pnpm check || true

# Ensure all tests are executed, even if some fail
set +e
pnpm test
set -e