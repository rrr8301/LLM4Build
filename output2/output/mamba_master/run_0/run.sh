#!/bin/bash

# Activate Python environment
source /usr/bin/activate

# Install project dependencies
python3.12 -m pip install -r requirements.txt

# Build the project
cmake -B build/ -G Ninja -D BUILD_LIBMAMBA=ON -D BUILD_MAMBA=ON
cmake --build build/ --parallel

# Run all tests
set +e  # Continue execution even if some tests fail
./build/libmamba/ext/solv-cpp/tests/test_solv_cpp
unset CONDARC
./build/libmamba/tests/test_libmamba
python3.12 -m pytest libmambapy/tests/ --exitfirst || true
python3.12 -m build --wheel --no-isolation libmambapy-stubs/
export TEST_MAMBA_EXE=$(pwd)/build/micromamba/mamba
python3.12 -m pytest micromamba/tests/ --exitfirst || true
cd micromamba/test-server
./generate_gpg_keys.sh
./testserver_auth_pkg_signing.sh