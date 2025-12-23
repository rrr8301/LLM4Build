#!/bin/bash

# Activate virtual environment
source /app/venv/bin/activate

# Install project dependencies
uv pip install -r requirements-tests.txt

# Install Pydantic v2 if specified
uv pip install --upgrade "pydantic>=2.0.2,<3.0.0"

# Run tests
set +e  # Continue execution even if some tests fail
bash scripts/test.sh