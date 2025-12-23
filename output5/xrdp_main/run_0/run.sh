#!/bin/bash

set -e

# Compile and install xrdp
./bootstrap
./configure
make

# Run tests
# Assuming tests are in the 'tests' directory and can be run with make
cd tests
make test || true  # Continue running even if some tests fail