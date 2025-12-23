#!/bin/bash

set -e

# Install system dependencies using getdeps.py
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive mvfst
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Fetch and build dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests ninja
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests cmake
# Add other fetch commands as needed...

# Build mvfst
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. mvfst --project-install-prefix mvfst:/usr/local

# Run tests
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. mvfst --project-install-prefix mvfst:/usr/local || true

# Ensure all tests are executed, even if some fail
echo "All tests executed."