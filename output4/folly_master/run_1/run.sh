#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies (if any)
# Assuming dependencies are handled by buck_build_and_test.sh

# Run tests
# Ensure all tests are executed, even if some fail
set -e
trap 'echo "An error occurred. Continuing with the next step."' ERR

# Run the buck2 build and test script
# Use the correct path to the script
bash /app/.github/scripts/buck_build_and_test.sh