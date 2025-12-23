#!/bin/bash

# Activate environment (if any)

# Install project dependencies
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive folly

# Fetch and build dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests boost
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --free-up-disk --no-tests boost

# Build folly
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Run tests
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local || true

# Ensure all test cases are executed