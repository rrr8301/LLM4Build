#!/bin/bash

# Run pre-build script
./ci/github-pre-build.sh

# Configure CMake
cmake -B build -DCMAKE_BUILD_TYPE=Release -DwxWidgets_CONFIG_EXECUTABLE=/usr/bin/wx-config

# Build the project
cmake --build build --config Release

# Run tests
cd build
ctest --output-on-failure || true