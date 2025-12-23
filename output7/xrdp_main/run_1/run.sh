#!/bin/bash

set -e

# Compile the project
./bootstrap || exit 1
./configure || exit 1
make || exit 1

# Run tests
# Ensure all tests are executed, even if some fail
set +e
make test
set -e