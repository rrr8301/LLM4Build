#!/bin/bash

# Run tests and ensure all tests are executed even if some fail
set +e

# Increase the timeout for the tests to handle potential timeouts
npm run test -- --no-lint --bundle=true --timeout=60000
TEST_EXIT_CODE=$?

# If tests fail, print baseline diff
if [ $TEST_EXIT_CODE -ne 0 ]; then
  npx hereby baseline-accept
  git add tests/baselines/reference
  git diff --staged --exit-code
fi

# Exit with the test exit code
exit $TEST_EXIT_CODE