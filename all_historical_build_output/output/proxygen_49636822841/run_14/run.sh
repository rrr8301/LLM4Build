#!/bin/bash

set -e

# Remove sudo from all Python scripts in the build/fbcode_builder directory
find build/fbcode_builder -name "*.py" -exec sed -i 's/\bsudo\b//g' {} +

# Install system dependencies using getdeps.py without sudo
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Fetch and build dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests ninja
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --no-tests ninja

python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests cmake
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --no-tests cmake

# Add more fetch and build steps as needed for other dependencies

# Build proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. proxygen --project-install-prefix proxygen:/usr/local

# Test proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. proxygen --project-install-prefix proxygen:/usr/local