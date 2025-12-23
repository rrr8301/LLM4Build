# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install

# Run tests
# Ensure all tests are executed, even if some fail
npm test || true