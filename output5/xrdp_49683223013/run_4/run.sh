#!/bin/bash

set -e

# Bootstrap and configure
autoreconf -fi

# Ensure Makefile.am exists in libpainter
if [ ! -f libpainter/Makefile.am ]; then
    echo "AUTOMAKE_OPTIONS = foreign" > libpainter/Makefile.am
    echo "SUBDIRS = ." >> libpainter/Makefile.am
    echo "bin_PROGRAMS = my_program" >> libpainter/Makefile.am
    echo "my_program_SOURCES = main.c" >> libpainter/Makefile.am
fi

# Generate configure script if missing
if [ ! -f configure ]; then
    ./autogen.sh
fi

# Configure the project
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