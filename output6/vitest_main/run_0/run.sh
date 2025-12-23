#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests, ensuring all tests are executed even if some fail
pnpm run test:ci || true
pnpm run test:examples || true
pnpm run -C packages/ui test:ui || true
pnpm run test:browser:playwright || true
pnpm run test:browser:webdriverio || true