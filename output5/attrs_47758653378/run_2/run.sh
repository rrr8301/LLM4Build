#!/bin/bash

set -e
set -o pipefail

# Activate Python virtual environment
source /opt/venv/bin/activate

# Install project dependencies
pip install -r /app/requirements.txt

# Extract pre-built packages
if ls dist/*.tar.gz 1> /dev/null 2>&1; then
    tar xf dist/*.tar.gz --strip-components=1
fi

# Prepare tox environment
DO_MYPY=1
TOX_PYTHON=py311

# Run tox with mypy if applicable
if [ "$DO_MYPY" -eq 1 ]; then
    uvx --with=tox-uv tox run -e $TOX_PYTHON-mypy || true
fi

# Remove src directory to ensure tests run against wheel
rm -rf src

# Run tox tests
if ls dist/*.whl 1> /dev/null 2>&1; then
    uvx --with=tox-uv tox run --installpkg dist/*.whl -e $TOX_PYTHON-tests || true
fi