#!/bin/bash

# Activate Python environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies if any
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Sync Bazel dependencies
bazel sync --configure

# Fetch all Bazel dependencies first
bazel fetch @com_github_grpc_grpc//... //...

# Build the project
bazel build -c fastbuild //...

# Run tests
set +e  # Continue execution even if some tests fail
bazel test -c fastbuild --test_output=errors //...
set -e  # Stop execution on errors after tests

# Deactivate Python environment
deactivate