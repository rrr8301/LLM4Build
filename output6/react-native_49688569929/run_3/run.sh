#!/bin/bash

set -e

# Setup Node.js environment
echo "Setting up Node.js environment..."
node -v
yarn -v

# Install project dependencies
echo "Installing dependencies..."
MAX_ATTEMPTS=2
ATTEMPT=0
WAIT_TIME=20
while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
    yarn install --non-interactive --frozen-lockfile && break
    echo "yarn install failed. Retrying in $WAIT_TIME seconds..."
    sleep $WAIT_TIME
    ATTEMPT=$((ATTEMPT + 1))
done
if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
    echo "All attempts to invoke yarn install failed - Aborting the workflow"
    exit 1
fi

# Run JavaScript tests
echo "Running JavaScript tests..."
set +e
node ./scripts/run-ci-javascript-tests.js --maxWorkers 2
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE