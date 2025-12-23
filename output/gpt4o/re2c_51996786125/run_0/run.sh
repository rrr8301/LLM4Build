#!/bin/bash

# Activate Python environment (if any virtual environment is used, activate it here)

# Install project dependencies (if any additional dependencies are needed, install them here)

# Run CMake configuration and build steps
cmake --list-presets
cmake --preset=linux-gcc-debug-ootree-skeleton-fast -DPython3_ROOT_DIR="/usr"
cmake --build --preset=linux-gcc-debug-ootree-skeleton-fast -j$(nproc)
cmake --build --preset=linux-gcc-debug-ootree-skeleton-fast --target install

# Run minimal install test
cd install/bin
./re2c --version
cd -

# Full configure and build
cmake --preset=linux-gcc-debug-ootree-skeleton-full -DPython3_ROOT_DIR="/usr"
find src -name '*.re' | xargs touch
cmake --build --preset=linux-gcc-debug-ootree-skeleton-full -j$(nproc)

# Run main test suite
ulimit -s 256
cmake --build --preset=linux-gcc-debug-ootree-skeleton-full --target tests -j$(nproc)

# Run skeleton tests
python run_tests.py --skeleton || true  # Ensure all tests run even if some fail