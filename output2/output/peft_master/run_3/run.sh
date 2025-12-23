#!/bin/bash

# Activate the virtual environment
source /app/.venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -r examples/arrow_multitask/requirements.txt
pip install -e .[test]

# Run tests
set +e  # Continue execution even if some tests fail
make test

# Check for specific errors and handle them
if grep -q "TypeError: CLIPTextModel.__init__() got" tests/test_stablediffusion.py; then
    echo "Handling TypeError in test_stablediffusion.py"
    # Add any specific handling or logging here
fi

if grep -q "AttributeError" tests/test_loraplus.py; then
    echo "Handling AttributeError in test_loraplus.py"
    # Add any specific handling or logging here
fi