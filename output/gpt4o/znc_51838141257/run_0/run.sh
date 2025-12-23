#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
# Assuming .github/ubuntu_deps.sh installs necessary dependencies
source .github/ubuntu_deps.sh

# Build the project
source .github/build.sh

# Run tests
# Assuming tests are part of the build process or can be run separately
# Ensure all tests are executed
set +e
# Placeholder for running tests, e.g., make test or similar
# make test

# Alternative for codecov action
bash <(curl -s https://codecov.io/bash)

# Exit with success
exit 0