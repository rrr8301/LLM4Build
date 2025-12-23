#!/bin/bash

set -e

# Activate Python 3.11 environment
source /opt/venv3.11/bin/activate

# Prepare compiler cache
export CCACHE_DIR="/app/.ccache"
mkdir -p "${CCACHE_DIR}"

# Build and install SciPy
spin build --werror

# Check installation
pushd tools
python check_installation.py build-install
./check_pyext_symbol_hiding.sh ../build
popd

# Check usage of install tags
rm -r build-install
spin build --tags=runtime,python-runtime,devel
python tools/check_installation.py build-install --no-tests
rm -r build-install
spin build --tags=runtime,python-runtime,devel,tests
python tools/check_installation.py build-install

# Check build-internal dependencies
ninja -C build -t missingdeps

# Run Mypy if Python 3.11
if [[ "$(python --version)" == "Python 3.11"* ]]; then
    pip install mypy==1.10.0 types-psutil typing_extensions
    pip install pybind11 sphinx
    spin mypy
fi

# Run tests
export OMP_NUM_THREADS=2
spin test -j3 -- --durations 10 --timeout=60 || true