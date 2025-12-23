#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies (if any)
# Assuming dependencies are handled by buck_build_and_test.sh

# Run tests
# Ensure all tests are executed, even if some fail
set -e
trap 'echo "An error occurred. Continuing with the next step."' ERR

# Check if the buck_build_and_test.sh script exists and is executable
BUCK_SCRIPT="/app/.github/scripts/buck_build_and_test.sh"
if [ -f "$BUCK_SCRIPT" ]; then
    chmod +x "$BUCK_SCRIPT"
    /bin/bash "$BUCK_SCRIPT" || true
else
    echo "Error: $BUCK_SCRIPT not found."
    exit 1
fi