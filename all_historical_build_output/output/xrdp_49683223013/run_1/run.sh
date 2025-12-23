#!/bin/bash

set -e

# Bootstrap and configure
./bootstrap
./configure $CONF_FLAGS

# Compile the code
make -j $(nproc)

# Run unit tests
if [ "$UNITTESTS" = "true" ]; then
    make check -j $(nproc) || (cat tests/*/test-suite.log && exit 1)
fi

# Run distcheck
if [ "$DISTCHECK" = "true" ]; then
    make distcheck -j $(nproc)
fi