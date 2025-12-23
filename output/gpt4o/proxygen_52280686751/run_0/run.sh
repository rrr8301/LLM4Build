#!/bin/bash

# Activate any necessary environments (none specified, so this is a placeholder)
# source /path/to/venv/bin/activate

# Install project dependencies
# Assuming dependencies are managed by a script or requirements file
# pip install -r requirements.txt

# Update system package info
sudo apt-get update

# Install system dependencies using the provided Python script
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive proxygen
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Query paths
python3 build/fbcode_builder/getdeps.py --allow-system-packages query-paths --recursive --src-dir=. proxygen

# Build proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. proxygen --project-install-prefix proxygen:/usr/local

# Copy artifacts
python3 build/fbcode_builder/getdeps.py --allow-system-packages fixup-dyn-deps --strip --src-dir=. proxygen _artifacts/linux --project-install-prefix proxygen:/usr/local --final-install-prefix /usr/local

# Test proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. proxygen --project-install-prefix proxygen:/usr/local

# Ensure all tests are executed
set +e
# Run tests (assuming a test command or script is available)
# ./run_tests.sh
set -e