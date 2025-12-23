#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Change to directory containing configure.ac if not in root
if [ ! -f "configure.ac" ]; then
    if [ -f "src/configure.ac" ]; then
        cd src
    elif [ -f "jq/configure.ac" ]; then
        cd jq
    else
        echo "Error: configure.ac not found in any expected location"
        exit 1
    fi
fi

# Run autoreconf if needed
if [ ! -f "configure" ]; then
    autoreconf -vfi
fi

# Configure and build
./configure \
    --enable-static \
    --enable-all-static \
    --with-oniguruma=builtin \
    CFLAGS="-O2 -pthread -fstack-protector-all"

make -j"$(nproc)" V=1

# Run tests
make check VERBOSE=yes

# Check for any differences in the git repository if .git exists
if [ -d .git ]; then
    git diff --exit-code || true
fi