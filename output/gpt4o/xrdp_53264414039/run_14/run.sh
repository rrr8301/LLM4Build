#!/bin/bash

# Activate environment variables
export CONF_FLAGS="--enable-ipv6 --enable-jpeg --enable-fuse --enable-mp3lame --enable-fdkaac --enable-opus --enable-rfxcodec --enable-painter --enable-pixman --enable-utmp --with-imlib2 --with-freetype2 --enable-tests --enable-x264 --enable-openh264"

# Set strict non-interactive mode
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
export NEEDRESTART_MODE=a
export UCF_FORCE_CONFFNEW=1

# Bootstrap
./bootstrap || { echo "Bootstrap failed"; exit 1; }

# Configure
./configure $CONF_FLAGS || { echo "Configure failed"; exit 1; }

# Build
make -j $(nproc) || { echo "Build failed"; exit 1; }

# Run unittests
make check -j $(nproc) || { echo "Unit tests failed"; exit 1; }

# Run distcheck
make distcheck -j $(nproc) || { echo "Distcheck failed"; exit 1; }