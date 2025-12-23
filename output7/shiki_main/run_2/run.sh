# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
# Adding --force to bypass any potential issues with unsupported protocols
npm install --legacy-peer-deps --force

# Run tests
# Ensure all tests are executed, even if some fail
npm test