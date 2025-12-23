#!/bin/bash

# Simulate the setup project step
echo "Setting up the project..."
# Placeholder for actual setup logic

# Simulate the lint project step
echo "Linting the project..."
# Placeholder for actual lint logic

# Simulate the unit test step
echo "Running unit tests..."
# Placeholder for actual unit test logic

# Build the project
echo "Building the project..."
npm run dist

# Ensure all tests are executed, even if some fail
set +e
npm test
set -e