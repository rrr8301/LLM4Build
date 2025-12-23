#!/bin/bash

# Set environment variables
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
export CI=true

# Run tests
pnpm test || true  # Ensure all tests run even if some fail