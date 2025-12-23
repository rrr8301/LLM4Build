#!/bin/bash

# Activate virtual environment if needed
# source venv/bin/activate

# Install project dependencies
uv pip install -r requirements-tests.txt

# Install Pydantic
uv pip install "pydantic>=2.0.2,<3.0.0"

# Run tests
set +e  # Continue execution even if some tests fail
bash scripts/test.sh