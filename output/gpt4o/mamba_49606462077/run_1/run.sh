#!/bin/bash

# Activate virtual environment
source /opt/micromamba-venv/bin/activate

# Activate micromamba environment
micromamba activate build_env

# Install project dependencies
micromamba install -f ./dev/environment-dev.yml

# Build the project
cmake -B build/ -G Ninja --preset mamba-unix-shared-release \
    -D CMAKE_CXX_COMPILER_LAUNCHER=sccache \
    -D CMAKE_C_COMPILER_LAUNCHER=sccache \
    -D MAMBA_WARNING_AS_ERROR=ON \
    -D BUILD_LIBMAMBAPY=OFF \
    -D ENABLE_MAMBA_ROOT_PREFIX_FALLBACK=OFF
cmake --build build/ --parallel

# Run tests
set +e  # Continue on error
./build/libmamba/ext/solv-cpp/tests/test_solv_cpp
./build/libmamba/tests/test_libmamba
python -m pytest libmambapy/tests/ --exitfirst
python -m pytest micromamba/tests/ --exitfirst
set -e  # Stop on error