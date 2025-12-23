#!/bin/bash

set -e

# Bootstrap
./autogen.sh

# Configure
./configure --enable-werror --disable-silent-rules || ( cat config.log; exit 1; )

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