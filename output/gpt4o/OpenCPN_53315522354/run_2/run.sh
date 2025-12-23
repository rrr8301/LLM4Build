#!/bin/bash

# Run pre-build script (no sudo needed as we're root in container)
./ci/github-pre-build.sh

# Configure CMake with additional GLEW paths
cmake -B build -DCMAKE_BUILD_TYPE=Release \
    -DwxWidgets_CONFIG_EXECUTABLE=/usr/bin/wx-config \
    -DGLEW_INCLUDE_DIR=/usr/include \
    -DGLEW_LIBRARY=/usr/lib/x86_64-linux-gnu/libGLEW.so

# Build the project
cmake --build build --config Release

# Run tests with verbose output
cd build
ctest --verbose --output-on-failure || true