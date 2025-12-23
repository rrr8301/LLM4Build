#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run npm install to ensure all dependencies are installed
npm install

# Run tests, ensuring all tests are executed even if some fail
set +e
npm run test:packages
EXIT_CODE=$?

# Exit with the test command's exit code
exit $EXIT_CODE