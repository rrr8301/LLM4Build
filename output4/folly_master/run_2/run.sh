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
if [ -f /app/.github/scripts/buck_build_and_test.sh ]; then
    bash /app/.github/scripts/buck_build_and_test.sh
else
    echo "Error: /app/.github/scripts/buck_build_and_test.sh not found."
    exit 1
fi