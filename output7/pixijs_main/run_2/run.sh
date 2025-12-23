# run.sh
#!/bin/bash

set -e

# Lint the project
echo "Linting the project..."
npm run lint

# Build the project
echo "Building the project..."
npm run dist

# Run tests
echo "Running tests..."
npm run test

echo "All steps completed."