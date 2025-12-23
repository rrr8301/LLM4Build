#!/bin/bash

# Activate environment variables
export CONF_FLAGS="--enable-ipv6 --enable-jpeg --enable-fuse --enable-mp3lame --enable-fdkaac --enable-opus --enable-rfxcodec --enable-painter --enable-pixman --enable-utmp --with-imlib2 --with-freetype2 --enable-tests --enable-x264 --enable-openh264"

# Bootstrap
DEBIAN_FRONTEND=noninteractive ./bootstrap || { echo "Bootstrap failed"; exit 1; }

# Configure
DEBIAN_FRONTEND=noninteractive ./configure $CONF_FLAGS || { echo "Configure failed"; exit 1; }

# Build
DEBIAN_FRONTEND=noninteractive make -j $(nproc) || { echo "Build failed"; exit 1; }

# Run unittests
DEBIAN_FRONTEND=noninteractive make check -j $(nproc) || { echo "Unit tests failed"; exit 1; }

# Run distcheck
DEBIAN_FRONTEND=noninteractive make distcheck -j $(nproc) || { echo "Distcheck failed"; exit 1; }