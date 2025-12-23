#!/bin/bash

# Update system package info
sudo apt-get update

# Install system dependencies using the provided Python script
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive proxygen
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Query paths
python3 build/fbcode_builder/getdeps.py --allow-system-packages query-paths --recursive --src-dir=. proxygen

# Build proxygen with verbose output
set -x
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. proxygen --project-install-prefix proxygen:/usr/local
set +x

# Copy artifacts
python3 build/fbcode_builder/getdeps.py --allow-system-packages fixup-dyn-deps --strip --src-dir=. proxygen _artifacts/linux --project-install-prefix proxygen:/usr/local --final-install-prefix /usr/local

# Test proxygen with verbose output and ensure all tests run
set -x
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. proxygen --project-install-prefix proxygen:/usr/local
set +x

# Run additional tests if needed
if [ -f "./proxygen/run_tests.sh" ]; then
    chmod +x ./proxygen/run_tests.sh
    ./proxygen/run_tests.sh
fi