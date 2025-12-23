#!/bin/bash

set -e

# Install OpenSSL if not already installed
if ! dpkg -l | grep -q libssl-dev; then
    sudo apt-get update && sudo apt-get install -y libssl-dev
fi

# Install project dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive folly

# Fetch and build dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests boost
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --free-up-disk --no-tests boost

# Build folly with OpenSSL paths explicitly set if needed
OPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR:-/usr} \
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Test folly
set +e
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local
TEST_RESULT=$?
set -e

# Exit with test result
exit $TEST_RESULT