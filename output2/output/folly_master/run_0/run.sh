#!/bin/bash

# Update system package info
sudo apt-get update

# Install system dependencies using getdeps.py
sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive folly

# Build folly
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Test folly
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local

# Ensure all tests are executed, even if some fail
if [ $? -ne 0 ]; then
  echo "Some tests failed, but continuing..."
fi