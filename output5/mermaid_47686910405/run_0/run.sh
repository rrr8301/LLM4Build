#!/bin/bash

# Activate environment variables if needed
export CYPRESS_CACHE_FOLDER=.cache/Cypress

# Run unit tests
pnpm test:coverage || true

# Run ganttDb tests using California timezone
export TZ=America/Los_Angeles
pnpm exec vitest run ./packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts --coverage || true

# Verify out-of-tree build with TypeScript
pnpm test:check:tsc || true

# Ensure all tests are executed, even if some fail
echo "All tests executed."