#!/bin/bash

# Activate Python environment
python3.12 -m venv venv
source venv/bin/activate

# Upgrade pip to the latest version
pip install --upgrade pip

# Install project dependencies if any (placeholder)
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

# Ensure Bazel is in the PATH
export PATH="/usr/local/bin:/usr/bin:${PATH}"

# Build the project
bazel build -c fastbuild //...

# Run tests
set +e  # Continue execution even if some tests fail
bazel test -c fastbuild --test_output=errors //...
set -e  # Stop execution on errors after tests

# Deactivate Python environment
deactivate