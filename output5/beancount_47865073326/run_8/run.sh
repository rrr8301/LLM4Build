#!/bin/bash

set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Upgrade pip and install mesonpy in the virtual environment
pip install --upgrade pip

# Ensure the latest version of mesonpy is installed
pip install meson-python

# Set PKG_CONFIG_PATH to include the virtual environment's pkgconfig directory
export PKG_CONFIG_PATH=$VIRTUAL_ENV/lib/pkgconfig:$PKG_CONFIG_PATH

# Install project dependencies
pip install -v --no-build-isolation -e .

# Run tests
pytest beancount || true
meson test -C build/ || true

# Ensure all tests are executed, even if some fail