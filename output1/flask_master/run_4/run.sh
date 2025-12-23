#!/bin/bash

# Create and activate Python virtual environment
python3.12 -m venv /app/venv
source /app/venv/bin/activate

# Install project dependencies
pip install -r examples/celery/requirements.txt

# Run tests
set +e  # Continue on errors

# Ensure UV is installed and available
if ! command -v uv &> /dev/null; then
    echo "UV is not installed. Installing UV..."
    # Correct the URL or provide a valid installation method for UV
    # Assuming UV can be installed via pip for this example
    pip install uv
    export PATH="/root/.local/bin:$PATH"
fi

uv run --locked tox run -e py3.12