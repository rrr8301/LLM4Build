#!/bin/bash

# Activate environment variables if any (none in this case)

# Install project dependencies
npm ci

# Lint commit message (conditionally)
if [ "$(git rev-parse --abbrev-ref HEAD)" != "master" ] && [ "$GITHUB_ACTOR" != "dependabot[bot]" ]; then
  git log -1 --pretty=format:"%s" | npx commitlint
fi

# Lint code
npm run lint

# Run all tests, ensuring all tests are executed even if some fail
set +e
npm test
TEST_EXIT_CODE=$?
set -e

# Build artifacts
npm run build

# Exit with the test exit code
exit $TEST_EXIT_CODE