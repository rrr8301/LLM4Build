#!/bin/bash

# Activate Python virtual environment
source /opt/venv/bin/activate

# Install project dependencies if not already installed
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
elif [ -f "requirements-dev.txt" ]; then
    pip install -r requirements-dev.txt
else
    pip install .
fi

# Reinstall pandas from source to ensure all extensions are compiled
cd /app/pandas
git pull origin main  # Ensure we have latest changes
python3.12 setup.py build_ext --inplace
pip install -e . --no-build-isolation
cd /app

# Rebuild the project to ensure all extensions are compiled
set +e  # Do not exit immediately on error
python3.12 setup.py build_ext --inplace || echo "Build extension step failed, continuing with tests"
set -e  # Re-enable exit on error

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
PYTHONPATH=/app pytest --junitxml=test-data.xml --continue-on-collection-errors -v
set -e  # Re-enable exit on error