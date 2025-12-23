#!/bin/bash

# Create and activate a virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
python3.11 -m pip install --upgrade pip
pip install setuptools
pip install -e .[test]

# Install additional dependencies from requirements.txt if needed
if [ -f "examples/arrow_multitask/requirements.txt" ]; then
    pip install -r examples/arrow_multitask/requirements.txt
fi

# Run tests
set +e  # Ensure all tests run even if some fail
make test
status=$?

# Exit with the status of the tests
exit $status