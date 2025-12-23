#!/bin/bash

set -e

# Activate Python environment (if any)
# Assuming any virtual environment setup is handled in test.sh

# Install project dependencies
# Assuming dependencies are installed in test.sh

# Run tests
# Ensure all tests are executed even if some fail
set +e
./test.sh
set -e