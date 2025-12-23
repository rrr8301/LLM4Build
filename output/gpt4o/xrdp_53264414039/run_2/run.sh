#!/bin/bash

# Activate environment variables
export CONF_FLAGS="--enable-ipv6 --enable-jpeg --enable-fuse --enable-mp3lame --enable-fdkaac --enable-opus --enable-rfxcodec --enable-painter --enable-pixman --enable-utmp --with-imlib2 --with-freetype2 --enable-tests --enable-x264 --enable-openh264"

# Bootstrap
./bootstrap

# Configure
./configure $CONF_FLAGS

# Build
make -j $(nproc)

# Run unittests
make check -j $(nproc) || true

# Run distcheck
make distcheck -j $(nproc) || true