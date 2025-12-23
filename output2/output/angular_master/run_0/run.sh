#!/bin/bash

# Install project dependencies
pnpm install --frozen-lockfile

# Run all tests, ensuring all tests are executed even if some fail
set +e
pnpm test:ci
pnpm integration-tests:ci
pnpm devtools:test
pnpm devtools:test:e2e
pnpm bazel test //adev/...
pnpm bazel test //vscode-ng-language-service/...
pnpm -C packages/zone.js promisefinallytest
pnpm -C packages/zone.js jest:test
pnpm -C packages/zone.js jest:nodetest
pnpm -C packages/zone.js vitest:test
pnpm -C packages/zone.js electrontest
pnpm -C packages/zone.js/test/typings test
set -e