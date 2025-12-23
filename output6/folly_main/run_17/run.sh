#!/bin/bash

set -e
set -o pipefail

# Install system dependencies (no sudo needed in Docker)
# Assuming getdeps.py is correctly configured to not require sudo
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive folly || true

# Ensure the directory permissions are set correctly
chmod -R 777 /app

# Set environment variables that might be needed for tests
export TEST_TMPDIR=/tmp
mkdir -p $TEST_TMPDIR
chmod 777 $TEST_TMPDIR

# Build folly
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Run tests with verbose output to diagnose issues
# Correct the arguments for the test command
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local --verbose