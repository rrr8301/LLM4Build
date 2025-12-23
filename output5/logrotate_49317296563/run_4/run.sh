#!/bin/bash

set -e

# Bootstrap
if [ -f ./autogen.sh ]; then
    ./autogen.sh
else
    echo "autogen.sh not found, skipping bootstrap step."
fi

# Configure
if [ -f ./configure ]; then
    ./configure --enable-werror --disable-silent-rules || ( cat config.log; exit 1; )
else
    echo "configure script not found, cannot proceed."
    exit 1
fi

# Build
make -k

# Run tests
make -j9 check || ( cat test/test-suite.log; exit 1; )

# Install
make install

# Installcheck
make installcheck

# Distcheck
make -j9 distcheck DISTCHECK_CONFIGURE_FLAGS="--enable-werror --disable-silent-rules"

# Build RPM
make rpm RPM_FLAGS="--nodeps"