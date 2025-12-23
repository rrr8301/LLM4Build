#!/bin/bash

# Create and activate virtual environment
python3 -m venv /venv
source /venv/bin/activate

# Upgrade pip
/venv/bin/python -m pip install --upgrade pip

# Install project dependencies with retry
set +e
for i in {1..3}; do
    make dev-install pycoverage
    if [ $? -eq 0 ]; then
        break
    fi
    echo "Retrying installation (attempt $i)..."
    sleep 5
done

# Run tests
set +e  # Continue on errors
make test