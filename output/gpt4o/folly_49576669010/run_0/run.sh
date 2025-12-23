#!/bin/bash

# Activate environments if any (none specified)

# Install project dependencies
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive folly

# Fetch and build dependencies
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests boost
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages build --free-up-disk --no-tests boost

# Build folly
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Test folly
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local

# Ensure all test cases are executed
set +e
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local
set -e