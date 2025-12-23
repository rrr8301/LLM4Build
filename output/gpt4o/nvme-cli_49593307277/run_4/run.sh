#!/bin/bash

# Set PKG_CONFIG_PATH to include libnvme
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig

# Verify libnvme installation
if ! pkg-config --exists libnvme; then
    echo "libnvme not found in pkg-config path: $PKG_CONFIG_PATH"
    echo "Trying to locate libnvme.pc..."
    find /usr -name "libnvme.pc" 2>/dev/null
    exit 1
fi

# Verify libnvme version is correct
pkg-config --modversion libnvme || { echo "libnvme version check failed"; exit 1; }

# Install project dependencies
meson setup .build || { echo "Meson setup failed"; exit 1; }

# Run build script with matrix parameters
./scripts/build.sh -b release -c gcc -x || { echo "Build script failed"; exit 1; }

# Run tests
meson test -C .build --no-rebuild --print-errorlogs || { echo "Tests failed"; exit 1; }

# Ensure all test cases are executed
exit 0