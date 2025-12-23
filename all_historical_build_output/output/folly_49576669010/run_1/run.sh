#!/bin/bash

set -e

# Activate any necessary environments (if applicable)

# Set environment variable to bypass sudo
export GETDEPS_NO_SUDO=1

# Install project dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests folly

# Build the project
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Run tests
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local || true

# Ensure all tests are executed, even if some fail