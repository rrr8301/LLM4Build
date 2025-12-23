#!/bin/bash

# Activate environment variables
export OPENSSL_VER=3.0.18
export PYTHONSTRICTEXTENSIONBUILD=1
export TERM=linux

# Configure OpenSSL environment variables
export MULTISSL_DIR=${PWD}/multissl
export OPENSSL_DIR=${PWD}/multissl/openssl/${OPENSSL_VER}
export LD_LIBRARY_PATH=${PWD}/multissl/openssl/${OPENSSL_VER}/lib

# Install OpenSSL if not cached
if [ ! -d "$OPENSSL_DIR" ]; then
    python3 Tools/ssl/multissltests.py --steps=library --base-directory "$MULTISSL_DIR" --openssl "$OPENSSL_VER" --system Linux
fi

# Setup directory envs for out-of-tree builds
export CPYTHON_RO_SRCDIR=$(realpath -m "${PWD}"/../cpython-ro-srcdir)
export CPYTHON_BUILDDIR=$(realpath -m "${PWD}"/../cpython-builddir)

# Create directories for read-only out-of-tree builds
mkdir -p "$CPYTHON_RO_SRCDIR" "$CPYTHON_BUILDDIR"

# Bind mount sources read-only
mount --bind -o ro "$PWD" "$CPYTHON_RO_SRCDIR"

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