#!/bin/bash

set -e

# Compile the project
./bootstrap
./configure
make

# Run tests
# Ensure all tests are executed, even if some fail
set +e
make test
set -e