#!/bin/bash

set -e
set -o pipefail

# Run tests and builds
pnpm test:ci || true
pnpm integration-tests:ci || true
pnpm devtools:test || true
pnpm devtools:build:chrome || true
pnpm bazel test //adev/... || true
pnpm bazel build //adev:build --config=release || true
pnpm bazel build \
  //packages/zone.js/bundles:zone.umd.js \
  //packages/zone.js:npm_package \
  //packages/zone.js/test/closure:closure || true
pnpm -C packages/zone.js install --frozen-lockfile || true
pnpm -C packages/zone.js promisefinallytest || true
pnpm -C packages/zone.js jest:test || true
pnpm -C packages/zone.js jest:nodetest || true
pnpm -C packages/zone.js vitest:test || true
pnpm -C packages/zone.js electrontest || true
pnpm -C packages/zone.js/test/typings test || true