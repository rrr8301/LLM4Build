#!/bin/bash

# Run all tests and checks, ensuring all are executed
set -e
pnpm run test-unit
pnpm run test-e2e
pnpm run lint
pnpm run format-check
pnpm run check
pnpm run test-dts