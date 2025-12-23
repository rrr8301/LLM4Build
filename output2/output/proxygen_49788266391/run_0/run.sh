#!/bin/bash

set -e

# Install system dependencies using getdeps.py
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive proxygen
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Fetch and build dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests ninja
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests cmake
# Add other fetch commands as needed...

# Build dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --no-tests ninja
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --no-tests cmake
# Add other build commands as needed...

# Build proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. proxygen --project-install-prefix proxygen:/usr/local

# Test proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. proxygen --project-install-prefix proxygen:/usr/local

# Ensure all tests are executed
exit 0