# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true

# Run tests with tox
tox || true

# Ensure all tests are executed, even if some fail
set +e
tox