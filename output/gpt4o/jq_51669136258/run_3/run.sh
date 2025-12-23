#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run autoreconf
autoreconf -fi

# Build oniguruma first
cd vendor/oniguruma
./autogen.sh
./configure --enable-static --disable-shared
make -j"$(nproc)"
cd ../..

# Configure the build
./configure \
  --host=x86_64-linux-gnu \
  --disable-docs \
  --with-oniguruma=builtin \
  --enable-static \
  --enable-all-static \
  CFLAGS="-O2 -pthread -fstack-protector-all"

# Build the project
make -j"$(nproc)" || { echo "Build failed, trying with -k flag"; make -k -j"$(nproc)"; }

# Run tests
make check VERBOSE=yes || { echo "Some tests failed, continuing..."; }

# Check for any differences in the git repository
[ -d .git ] && git diff --exit-code || true