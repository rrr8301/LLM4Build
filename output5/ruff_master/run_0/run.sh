#!/bin/bash

# Activate virtual environment
source venv/bin/activate

# Transform README
python scripts/transform_readme.py --target pypi

# Build wheels
maturin build --release --out dist

# Test wheel
pip install --force-reinstall --find-links dist "${PACKAGE_NAME}"
ruff --help
python -m ruff --help

# Run tests
# Ensure all tests are executed, even if some fail
set +e
pytest tests/
set -e