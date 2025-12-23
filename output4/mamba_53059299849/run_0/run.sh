#!/bin/bash

# Activate micromamba environment
source /opt/conda/etc/profile.d/conda.sh
conda activate build_env

# Build mamba
cmake -B build/ -G Ninja \
  --preset mamba-unix-shared-debug \
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

# Install libmambapy
cmake --install build/ --prefix "${CONDA_PREFIX}"
python3 -m pip install --no-deps --no-build-isolation ./libmambapy

# Run libmamba Python bindings tests
python3 -m pytest libmambapy/tests/ --exitfirst || true

# Test generation of libmambapy stubs
stubgen -o stubs/ -p libmambapy -p libmambapy.bindings

# Test libmambapy-stubs
python3 -m build --wheel --no-isolation libmambapy-stubs/

# Run mamba integration tests
export TEST_MAMBA_EXE=$(pwd)/build/micromamba/mamba
unset CONDARC
python3 -m pytest micromamba/tests/ --exitfirst || true

# Run mamba-content-trust and auth tests
export MAMBA_ROOT_PREFIX="${HOME}/micromamba"
cd micromamba/test-server
./generate_gpg_keys.sh
./testserver_auth_pkg_signing.sh