#!/bin/bash

# Activate Python environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies if any
# pip install -r requirements.txt

# Build the project
bazel build -c fastbuild //...

# Run tests
set +e  # Continue execution even if some tests fail
bazel test -c fastbuild --test_output=errors //...
set -e  # Stop execution on errors after tests

# Deactivate Python environment
deactivate