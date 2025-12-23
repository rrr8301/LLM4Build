#!/bin/bash

# run.sh

# Run tests and ensure all tests are executed even if some fail
set +e
npm run test -- --no-lint --bundle=true
TEST_EXIT_CODE=$?

# Print baseline diff on failure
if [ $TEST_EXIT_CODE -ne 0 ]; then
  npx hereby baseline-accept
  git add tests/baselines/reference
  git diff --staged --exit-code
fi

# Exit with the test exit code
exit $TEST_EXIT_CODE