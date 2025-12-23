#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
# Assuming .github/ubuntu_deps.sh installs necessary dependencies
source .github/ubuntu_deps.sh

# Build the project
source .github/build.sh

# Run tests
# Assuming tests are part of the build process or need to be run separately
# Ensure all tests are executed even if some fail
set +e
# Example test command, replace with actual test command if different
make test
set -e