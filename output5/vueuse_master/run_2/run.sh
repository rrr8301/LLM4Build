#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run build
nr build

# Run typecheck
nr typecheck

# Run all tests, ensuring all tests are executed even if some fail
set +e
pnpm run test:unit
pnpm run test:browser
pnpm run test:attw
cd playgrounds && bash ./build.sh
set -e