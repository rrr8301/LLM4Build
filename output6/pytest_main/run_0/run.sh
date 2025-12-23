#!/bin/bash

# Activate Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
python3.12 -m pip install --upgrade pip
pip install tox coverage

# Run tests
set +e  # Continue execution even if some tests fail
tox run -e py312 --installpkg $(find dist/*.tar.gz)

# Generate coverage report
python3.12 -m coverage xml

# Note: Codecov upload step is ignored as it's not supported outside GitHub Actions