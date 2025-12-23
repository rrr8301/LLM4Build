#!/bin/bash

# run.sh

# Activate the virtual environment
source .venv/bin/activate

# Ensure pytest-cov is installed
pip install pytest-cov

# Install project dependencies
pip install -r requirements.txt
pip install -r requirements-dev.txt

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
pytest -n auto --dist=loadfile --maxprocesses=4 --cov=botocore --cov-report xml unit/ functional/
TEST_EXIT_CODE=$?

# Placeholder for code coverage reporting
echo "Code coverage reporting is not supported in this script."

# Exit with the test exit code
exit $TEST_EXIT_CODE