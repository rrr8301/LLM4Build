#!/bin/bash

# Activate environments (if any)

# Install project dependencies
# Assuming buck2 is installed or available in the repository
# If buck2 needs to be installed, add installation steps here

# Run buck2 build and test script
# Ensure all tests are executed even if some fail
set +e
bash ./.github/scripts/buck_build_and_test.sh
set -e