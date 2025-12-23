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

# Ensure config directory exists for autoreconf
mkdir -p config

# Run autoreconf with more verbose output and proper include paths
autoreconf -vfi -I config

# Build oniguruma first if the directory exists
if [ -d "vendor/oniguruma" ]; then
    cd vendor/oniguruma
    # Check if autogen.sh exists, otherwise run autoreconf first
    if [ ! -f "autogen.sh" ]; then
        autoreconf -vfi
    else
        ./autogen.sh
    fi
    ./configure --enable-static --disable-shared
    make -j"$(nproc)"
    cd ../..
fi

# Configure the build with more explicit paths
./configure \
  --host=x86_64-linux-gnu \
  --disable-docs \
  --with-oniguruma=builtin \
  --enable-static \
  --enable-all-static \
  CFLAGS="-O2 -pthread -fstack-protector-all" \
  --prefix=/usr/local

# Build the project with more verbose output
make -j"$(nproc)" V=1 || { echo "Build failed, trying with -k flag"; make -k -j"$(nproc)" V=1; }

# Run tests (don't skip any tests)
make check VERBOSE=yes

# Check for any differences in the git repository if .git exists
if [ -d .git ]; then
    git diff --exit-code || true
fi