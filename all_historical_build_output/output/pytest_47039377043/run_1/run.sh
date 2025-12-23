#!/bin/bash
set -e

# Upgrade pip
python -m pip install --upgrade pip

# Install tox and coverage
pip install tox coverage

# Check if dist directory exists and has tar.gz files
if compgen -G "dist/*.tar.gz" > /dev/null; then
    PACKAGE_PATH=$(find dist/*.tar.gz | head -n 1)
else
    echo "Warning: No package found in dist/*.tar.gz. Please place your package tarball there."
    PACKAGE_PATH=""
fi

# Set environment variable to provide a fallback version for setuptools_scm if git metadata is missing
export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_APP=0.0.0

# Run tox with environment py39-xdist and install package if available
if [ -n "$PACKAGE_PATH" ]; then
    tox run -e py39-xdist --installpkg "$PACKAGE_PATH"
else
    tox run -e py39-xdist
fi