#!/bin/bash

# Activate environment variables
export CFLAGS="-g -O2 -Werror=pointer-arith -Werror=implicit-function-declaration"
export CCACHE_DIR="/app/.ccache"
export CCACHE_COMPRESS=true
export CCACHE_MAXSIZE=1G
export PYTHON="python3"
export JOBS=2
export DEBUG=0
export CONFIGURE_FLAGS="--enable-binreloc=no"
export CC="ccache gcc"
export CXX="ccache g++"

# Install project dependencies (no sudo needed in Docker)
apt-get update -qq
apt-get install --assume-yes --no-install-recommends \
    ccache \
    gettext autopoint \
    libtool \
    libgtk-3-dev \
    doxygen \
    python3-docutils \
    python3-lxml \
    rst2pdf

# Configure the build
NOCONFIGURE=1 ./autogen.sh
mkdir -p _build
cd _build
{ ../configure $CONFIGURE_FLAGS || { cat config.log; exit 1; } ; }

# Build the project
make -j $JOBS

# Run tests
make -j $JOBS check || {
    err="$?"
    echo "make exited with code $err" >&2
    echo "Test suite logs:" >&2
    find . -name 'test-suite.log' -exec cat '{}' ';' >&2
    exit "${err:-1}"
}

# Run distcheck
make -j $JOBS distcheck DISTCHECK_CONFIGURE_FLAGS="$CONFIGURE_FLAGS"