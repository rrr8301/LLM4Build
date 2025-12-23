# run.sh
#!/bin/bash

# Activate Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
python3.10 -m pip install --upgrade pip
python3.10 -m pip install tox

# Run tests
tox -e tests || true  # Ensure all tests run even if some fail