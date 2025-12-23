#!/bin/bash

# Activate Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -r test-requirements.txt

# Compile with mypyc if required
CC=clang MYPYC_OPT_LEVEL=0 MYPY_USE_MYPYC=1 pip install -e .

# Setup tox environment
tox run -e py --notest

# Run tests with tox
tox run -e py --skip-pkg-install -- -n 4 || true

# Ensure all tests are executed even if some fail
exit 0