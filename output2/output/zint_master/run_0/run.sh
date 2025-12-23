#!/bin/bash

# Activate environment variables
export CMAKE_PREFIX_PATH=$QT_ROOT_DIR

# Configure CMake
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DZINT_TEST=ON -DZINT_STATIC=ON

# Build the project
cmake --build . -j8 --config Release

# Run tests
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$(pwd)/backend" PATH=$PATH:"$(pwd)/frontend" QT_QPA_PLATFORM=offscreen ctest -V -C Release || true