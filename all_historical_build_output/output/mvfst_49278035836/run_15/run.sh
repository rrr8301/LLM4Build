#!/bin/bash

set -e

# Activate environment (if any)

# Install project dependencies
# Remove 'sudo' from the command
python3 ./build/fbcode_builder/getdeps.py install-system-deps --recursive --install-prefix=$(pwd)/_build mvfst

# Build the project
./getdeps.sh

# Run tests
set +e
python3 ./build/fbcode_builder/getdeps.py test mvfst --install-prefix=$(pwd)/_build
set -e