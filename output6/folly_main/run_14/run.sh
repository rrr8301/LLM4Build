#!/bin/bash

set -e
set -o pipefail

# Install system dependencies (no sudo needed in Docker)
# Assuming getdeps.py is correctly configured to not require sudo
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive folly || true

# Ensure the directory permissions are set correctly
chmod -R 777 /app

# Build folly
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Run tests with verbose output to diagnose issues
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local -- --output-on-failure -V