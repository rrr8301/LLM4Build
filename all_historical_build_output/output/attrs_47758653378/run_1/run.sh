#!/bin/bash

# Activate virtual environment
source venv/bin/activate

# Extract pre-built packages
tar xf dist/*.tar.gz --strip-components=1

# Prepare tox environment
DO_MYPY=1
TOX_PYTHON=py311

# Run mypy if applicable
if [ "$DO_MYPY" -eq 1 ]; then
    uvx --with=tox-uv tox run -e $TOX_PYTHON-mypy || true
fi

# Remove source directory to ensure tests run against wheel
rm -rf src

# Run tests
uvx --with=tox-uv tox run --installpkg dist/*.whl -e $TOX_PYTHON-tests || true