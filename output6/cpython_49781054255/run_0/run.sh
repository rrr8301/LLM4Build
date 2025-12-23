#!/bin/bash

set -e
set -o pipefail

# Activate environment variables
export MULTISSL_DIR="/app/multissl"
export OPENSSL_DIR="/app/multissl/openssl/3.0.15"
export LD_LIBRARY_PATH="/app/multissl/openssl/3.0.15/lib"
export CPYTHON_RO_SRCDIR="/app/cpython-ro-srcdir"
export CPYTHON_BUILDDIR="/app/cpython-builddir"

# Create directories for out-of-tree builds
mkdir -p "$CPYTHON_RO_SRCDIR" "$CPYTHON_BUILDDIR"

# Bind mount sources read-only
mount --bind -o ro /app "$CPYTHON_RO_SRCDIR"

# Configure CPython out-of-tree
cd "$CPYTHON_BUILDDIR"
../cpython-ro-srcdir/configure --config-cache --with-pydebug --enable-slower-safety --enable-safety --with-openssl="$OPENSSL_DIR"

# Build CPython out-of-tree
make -j

# Display build info
make pythoninfo

# Remount sources writable for tests
mount "$CPYTHON_RO_SRCDIR" -oremount,rw

# Run tests
xvfb-run make ci || true