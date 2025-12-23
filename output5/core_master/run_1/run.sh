#!/bin/bash

# Run tests and checks
set -e
pnpm run test-unit
pnpm run test-e2e
pnpm run lint
pnpm run format-check
pnpm run check
pnpm run test-dts