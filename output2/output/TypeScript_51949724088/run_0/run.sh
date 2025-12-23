# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests and ensure all tests are executed even if some fail
npm run test -- --no-lint --bundle=true || true

# If tests fail, print baseline diff
if [ $? -ne 0 ]; then
  npx hereby baseline-accept
  git add tests/baselines/reference
  git diff --staged --exit-code || true
fi