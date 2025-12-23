#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies
pnpm install --frozen-lockfile

# Install Playwright Chromium
pnpm playwright install chromium

# Run tests
set +e  # Continue executing even if some tests fail
pnpm test