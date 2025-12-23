#!/bin/bash

# Activate environment variables if needed
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
export CI=true

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
pnpm test
set -e  # Re-enable exit on error