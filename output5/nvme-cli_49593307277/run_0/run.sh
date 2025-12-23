#!/bin/bash

set -e

# Activate environment (if any specific activation is needed, e.g., source venv/bin/activate)

# Install project dependencies (if any)
# For this project, dependencies are handled by the build script

# Run build script with matrix parameters
scripts/build.sh -b release -c gcc -x || true

# Ensure all test cases are executed, even if some fail
# Collect logs
mkdir -p logs
cp .build-ci/meson-logs/*.txt logs/ || true

# Print a message indicating where logs are stored
echo "Build logs are stored in the 'logs' directory."