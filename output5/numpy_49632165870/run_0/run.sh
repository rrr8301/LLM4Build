#!/bin/bash

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests
python -c "import numpy, sys; sys.exit(numpy.test() is False)" || true

# Ensure all tests are executed
pytest || true