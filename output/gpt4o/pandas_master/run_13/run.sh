#!/bin/bash

# Activate Python virtual environment
source /opt/venv/bin/activate

# Ensure numpy and pandas versions are correct
pip install "numpy==1.26.4" "pandas==2.2.0" --no-build-isolation --force-reinstall

# Rebuild the project with proper Cython includes
set +e  # Do not exit immediately on error
PYTHONPATH=/app python3.11 setup.py build_ext --inplace --force || echo "Build extension step had warnings, continuing with tests"
set -e  # Re-enable exit on error

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
PYTHONPATH=/app pytest --junitxml=test-data.xml --continue-on-collection-errors -v -n auto
TEST_EXIT_CODE=$?
set -e  # Re-enable exit on error

exit $TEST_EXIT_CODE