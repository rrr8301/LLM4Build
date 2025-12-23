#!/bin/bash

# Run build and tests
set -e
npx hereby build || true
npx hereby test || true
npx hereby test:benchmarks || true
npx hereby test:tools || true
npx hereby test:api || true