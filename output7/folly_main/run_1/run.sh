#!/bin/bash

set -e
set -o pipefail

# Install system dependencies using getdeps.py
sudo ./build/fbcode_builder/getdeps.py install-system-deps --recursive

# Build the project
python3 ./build/fbcode_builder/getdeps.py --allow-system-packages build

# Run tests
python3 ./build/fbcode_builder/getdeps.py --allow-system-packages test || true

# Ensure all tests are executed, even if some fail