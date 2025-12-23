#!/bin/bash

# Source environment setup scripts
source .github/ubuntu_deps.sh
source .github/build.sh

# Run tests
# Assuming tests are part of the build process
# Ensure all tests run even if some fail
set +e
make test
set -e