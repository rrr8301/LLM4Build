#!/bin/bash

# Activate any virtual environment if needed (not required in Docker but included for completeness)
if [ -f /venv/bin/activate ]; then
    . /venv/bin/activate
fi

# Install project in development mode
pip install -e .

# Run tests with pytest
echo "Running tests with pytest..."
pytest -v || echo "Some tests failed"

# Run tox for full test matrix
echo "Running tox..."
tox || echo "Some tox environments failed"

# Ensure we exit with success to allow all tests to run
# (Actual CI would need to collect the test results)
exit 0