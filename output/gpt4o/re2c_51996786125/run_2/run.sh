#!/bin/bash

# Activate Python virtual environment
source /opt/venv/bin/activate

# Run CMake configuration and build steps
cmake --list-presets
cmake --preset=linux-gcc-debug-ootree-skeleton-fast -DPython3_ROOT_DIR="/opt/venv"
cmake --build --preset=linux-gcc-debug-ootree-skeleton-fast -j$(nproc)
cmake --build --preset=linux-gcc-debug-ootree-skeleton-fast --target install

# Run minimal install test
cd install/bin
./re2c --version
cd -

# Full configure and build
cmake --preset=linux-gcc-debug-ootree-skeleton-full -DPython3_ROOT_DIR="/opt/venv"
find src -name '*.re' | xargs touch
cmake --build --preset=linux-gcc-debug-ootree-skeleton-full -j$(nproc)

# Run main test suite
ulimit -s 256
cmake --build --preset=linux-gcc-debug-ootree-skeleton-full --target tests -j$(nproc)

# Determine build directory
if echo "linux-gcc-debug-ootree-skeleton" | grep -q "ootree"; then
    BUILD_DIR="/workspace/.build/linux-gcc-debug-ootree-skeleton-full"
else
    BUILD_DIR="/workspace"
fi

# Run skeleton tests from the correct directory
cd "$BUILD_DIR"
python run_tests.py --skeleton || true  # Ensure all tests run even if some fail