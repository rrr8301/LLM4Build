#!/bin/bash

# Set environment variables
export CC=gcc
export CONF_FLAGS="--enable-ipv6 --enable-jpeg --enable-fuse --enable-mp3lame \
--enable-fdkaac --enable-opus --enable-rfxcodec --enable-painter \
--enable-pixman --enable-utmp --with-imlib2 --with-freetype2 --enable-tests \
--enable-x264 --enable-openh264"

# Install project dependencies
echo "Installing project dependencies..."
echo RESET grub-efi/install_devices | sudo debconf-communicate grub-pc
sudo scripts/install_xrdp_build_dependencies_with_apt.sh max amd64 --allow-downgrades --allow-remove-essential --allow-change-held-packages

# Bootstrap the project
echo "Bootstrapping the project..."
./bootstrap

# Configure the project
echo "Configuring the project..."
./configure $CONF_FLAGS

# Build the project
echo "Building the project..."
make -j $(nproc)

# Run unittests
echo "Running unittests..."
make check -j $(nproc)

# Run distcheck
echo "Running distcheck..."
make distcheck -j $(nproc)

# Note: Skipping artifact upload as it is GitHub-specific