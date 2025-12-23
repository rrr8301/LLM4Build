# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
python3.12 -m pip install -r requirements.txt

# Build the project
python3.12 setup.py build

# Run tests and ensure all tests are executed
pytest