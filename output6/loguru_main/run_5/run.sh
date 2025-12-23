# run.sh
#!/bin/bash

# Activate Python environment (if any)
# Install project dependencies
python3.10 -m pip install --upgrade pip
python3.10 -m pip install tox

# Run tests
# Ensure all tests are executed, even if some fail
set +e
tox -e tests
set -e