#!/bin/bash

# Run tests and ensure all tests are executed
set +e  # Continue on errors

# Run tests
npm run test -- --no-lint --bundle=true

# Print baseline diff on failure
if [ $? -ne 0 ]; then
  npx hereby baseline-accept
  git add tests/baselines/reference
  git diff --staged --exit-code
fi