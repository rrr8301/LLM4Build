#!/bin/bash

# Install project dependencies
pnpm install --recursive

# Run tests
set +e  # Continue execution even if some tests fail

# Check if the test script exists in package.json
if pnpm run | grep -q "test"; then
    pnpm run test
else
    echo "No test script found in package.json. Running default test command."
    # Default test command if no test script is found
    # Replace this with a suitable default test command for your project
    pnpm test || echo "Default test command failed or not applicable."
fi