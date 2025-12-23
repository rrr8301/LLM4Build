#!/bin/bash

set -e

# Activate vcpkg environment
source /vcpkg/scripts/vcpkg_env.sh

# Build the project
make

# Run tests, ensuring all tests are executed
set +e
make test
set -e