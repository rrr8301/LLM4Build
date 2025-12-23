#!/bin/bash

# Activate environments if any (none specified, so skipping)

# Install project dependencies
# Assuming the Python script handles dependencies, so no additional pip installs

# Update system package info
sudo apt-get update

# Install system dependencies using the provided Python script
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive proxygen
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Build proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. proxygen --project-install-prefix proxygen:/usr/local

# Copy artifacts (simulated, as upload is not supported)
python3 build/fbcode_builder/getdeps.py --allow-system-packages fixup-dyn-deps --strip --src-dir=. proxygen _artifacts/linux --project-install-prefix proxygen:/usr/local --final-install-prefix /usr/local

# Test proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. proxygen --project-install-prefix proxygen:/usr/local

# Ensure all tests are executed
set +e