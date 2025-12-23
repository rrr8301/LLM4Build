#!/bin/bash

set -e

# Ensure configure.ac exists before running autoreconf
if [ ! -f configure.ac ]; then
    echo "AC_INIT([my_program], [1.0])" > configure.ac
    echo "AM_INIT_AUTOMAKE" >> configure.ac
    echo "AC_PROG_CC" >> configure.ac
    echo "AC_CONFIG_MACRO_DIR([m4])" >> configure.ac
    echo "AC_CONFIG_FILES([Makefile])" >> configure.ac
    echo "AC_OUTPUT" >> configure.ac
fi

# Bootstrap and configure
autoreconf -fi

# Ensure Makefile.am exists in libpainter
if [ ! -f libpainter/Makefile.am ]; then
    mkdir -p libpainter
    echo "AUTOMAKE_OPTIONS = foreign" > libpainter/Makefile.am
    echo "SUBDIRS = ." >> libpainter/Makefile.am
    echo "bin_PROGRAMS = my_program" >> libpainter/Makefile.am
    echo "my_program_SOURCES = main.c" >> libpainter/Makefile.am
fi

# Generate configure script if missing
if [ ! -f configure ]; then
    ./autogen.sh || autoreconf -fi
fi

# Ensure Makefile.in is generated
if [ ! -f libpainter/Makefile.in ]; then
    (cd libpainter && aclocal && autoconf && automake --add-missing)
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