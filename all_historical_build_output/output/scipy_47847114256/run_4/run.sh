#!/bin/bash

set -e

# Prepare compiler cache
CCACHE_DIR="/app/.ccache"
mkdir -p "${CCACHE_DIR}"

# Build and install SciPy
spin build --werror

# Check installation
pushd tools
python3.11 check_installation.py build-install
./check_pyext_symbol_hiding.sh ../build
popd

# Check usage of install tags
rm -r build-install
spin build --tags=runtime,python-runtime,devel
python3.11 tools/check_installation.py build-install --no-tests
rm -r build-install
spin build --tags=runtime,python-runtime,devel,tests
python3.11 tools/check_installation.py build-install

# Check build-internal dependencies
ninja -C build -t missingdeps

# Run Mypy for Python 3.11
python3.11 -m pip install mypy==1.10.0 types-psutil typing_extensions
python3.11 -m pip install pybind11 sphinx
spin mypy

# Run tests
export OMP_NUM_THREADS=2
spin test -j3 -- --durations 10 --timeout=60 || true