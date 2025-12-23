# run.sh
#!/bin/bash

set -e

# Lint the project
echo "Linting the project..."
npm run lint || true

# Build the project
echo "Building the project..."
npm run dist || true

# Run tests
echo "Running tests..."
npm run test || true

# Ensure all tests are executed, even if some fail
echo "All steps completed."