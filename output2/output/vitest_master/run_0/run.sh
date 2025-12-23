#!/bin/bash

# Run tests
set +e  # Continue on errors
pnpm run test:ci
pnpm run test:examples
pnpm run -C packages/ui test:ui
pnpm run test:browser:playwright
pnpm run test:browser:webdriverio
set -e  # Stop on errors