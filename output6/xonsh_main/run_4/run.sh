#!/bin/bash

# run.sh

# Activate the virtual environment
source venv/bin/activate

# Run tests with coverage
set +e  # Continue executing even if some tests fail
pytest --timeout=240 --cov --cov-report=xml --cov-report=term

# Check if any tests failed
if [ $? -ne 0 ]; then
    echo "Some tests failed. Please check the logs for details."
    exit 1
fi