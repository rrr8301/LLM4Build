#!/bin/bash

set -e
set -o pipefail

# Install system dependencies (no sudo needed in Docker)
# Assuming getdeps.py is correctly configured to not require sudo
python3 build/fbcode_builder/getdeps.py --allow-system-packages --no-sudo install-system-deps --recursive folly

# Build folly
python3 build/fbcode_builder/getdeps.py --allow-system-packages --no-sudo build --src-dir=. folly --project-install-prefix folly:/usr/local

# Test folly
python3 build/fbcode_builder/getdeps.py --allow-system-packages --no-sudo test --src-dir=. folly --project-install-prefix folly:/usr/local