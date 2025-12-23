#!/bin/bash

# Install project dependencies
pnpm install --frozen-lockfile

# Install Playwright
pnpm playwright install chromium

# Run checks
set +e  # Continue execution even if some tests fail
pnpm check
set -e