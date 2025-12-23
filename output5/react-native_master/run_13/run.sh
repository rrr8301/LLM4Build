#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies using yarn
# Temporarily disable frozen-lockfile to regenerate yarn.lock if needed
if [ -f yarn.lock ]; then
    yarn cache clean
    yarn install --network-timeout 100000 || (rm yarn.lock && yarn install --network-timeout 100000)
else
    npm install
fi

# Check if the build script exists in package.json
if npm run | grep -q 'build'; then
    # Build the project
    npm run build
else
    echo "No build script found in package.json"
fi

# Check if the test script exists in package.json
if npm run | grep -q 'test'; then
    # Run tests and ensure all tests are executed
    npm test
else
    echo "No test script found in package.json"
fi