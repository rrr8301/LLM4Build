#!/bin/bash

# Run pre-build script (no sudo needed as we're root in container)
./ci/github-pre-build.sh

# Configure CMake with additional paths
cmake -B build -DCMAKE_BUILD_TYPE=Release \
    -DwxWidgets_CONFIG_EXECUTABLE=/usr/bin/wx-config \
    -DGLEW_INCLUDE_DIR=/usr/include \
    -DGLEW_LIBRARY=/usr/lib/x86_64-linux-gnu/libGLEW.so \
    -DLibArchive_INCLUDE_DIR=/usr/include \
    -DLibArchive_LIBRARY=/usr/lib/x86_64-linux-gnu/libarchive.so \
    -DTINYXML_INCLUDE_DIR=/usr/include \
    -DTINYXML_LIBRARY=/usr/lib/x86_64-linux-gnu/libtinyxml2.so \
    -DUDEV_INCLUDE_DIR=/usr/include \
    -DUDEV_LIBRARY=/usr/lib/x86_64-linux-gnu/libudev.so \
    -DSHAPELIB_INCLUDE_DIR=/usr/include \
    -DSHAPELIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libshp.so

# Build the project
cmake --build build --config Release

# Run tests with verbose output
cd build
ctest --verbose --output-on-failure || true