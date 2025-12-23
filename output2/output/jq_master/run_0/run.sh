#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
autoreconf -i
./configure --disable-docs --with-oniguruma=builtin --enable-static --enable-all-static CFLAGS="-O2 -pthread -fstack-protector-all"
make -j"$(nproc)"

# Run tests
set +e  # Allow the script to continue even if tests fail
make check VERBOSE=yes
git diff --exit-code || true  # Continue even if there are differences

# Note: Uploading test logs and artifacts is not supported in this script