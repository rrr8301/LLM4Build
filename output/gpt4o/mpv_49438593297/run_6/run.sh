#!/bin/bash

# Activate environment variables
export CC=gcc
export CXX=g++
export CC_LD=lld
export CXX_LD=lld

# Configure installation prefix to avoid guessing issues
export DESTDIR=/usr/local

# Create necessary directories for installation
mkdir -p ${DESTDIR}/share/man/man1
mkdir -p ${DESTDIR}/share/applications
mkdir -p ${DESTDIR}/share/doc/mpv
mkdir -p ${DESTDIR}/share/bash-completion/completions
mkdir -p ${DESTDIR}/share/zsh/site-functions
mkdir -p ${DESTDIR}/share/fish/vendor_completions.d
mkdir -p ${DESTDIR}/share/metainfo
mkdir -p ${DESTDIR}/share/icons/hicolor/{16x16,32x32,64x64,128x128,scalable,symbolic}/apps

# Build the project using Meson with explicit prefix and installation paths
./ci/build-tumbleweed.sh -Db_ndebug=true \
    --prefix=${DESTDIR} \
    --mandir=share/man \
    --datadir=share \
    --sysconfdir=etc \
    --bindir=bin \
    --libdir=lib \
    --includedir=include

# Check if build succeeded
if [ $? -ne 0 ]; then
    echo "Build failed!"
    cat ./build/meson-logs/meson-log.txt
    exit 1
fi

# Run tests and ensure all tests are executed
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions"
meson test -C build --print-errorlogs --no-suite=failing

# Print test logs if tests fail
if [ $? -ne 0 ]; then
    echo "Tests failed!"
    cat ./build/meson-logs/testlog.txt
    exit 1
fi