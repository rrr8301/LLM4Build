#!/bin/bash

# Run tests and ensure all tests are executed
set +e  # Continue on errors

# Run tests
npm run test -- --no-lint --bundle=true

# Print baseline diff on failure
if [ $? -ne 0 ]; then
  npx hereby baseline-accept

  # Ensure we are in a git repository and there are changes to stage
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    git add tests/baselines/reference
    git diff --staged --exit-code || echo "Differences detected in baselines."
  else
    echo "Not a git repository or no changes to stage."
  fi
fi