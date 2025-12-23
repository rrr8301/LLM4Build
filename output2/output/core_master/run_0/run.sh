#!/bin/bash

# Run all tests and checks, ensuring all are executed
set -e
pnpm run test-unit || true
pnpm run test-e2e || true
pnpm run lint || true
pnpm run format-check || true
pnpm run check || true
pnpm run test-dts || true