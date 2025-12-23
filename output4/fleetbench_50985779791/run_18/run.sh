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
export PATH="/usr/local/bin:/usr/bin:/usr/local/bazel/bin:/usr/bin/bazel:${PATH}"

# Verify Bazel installation
if ! command -v bazel &> /dev/null; then
    echo "Bazel could not be found, please check the installation."
    exit 1
fi

# Build the project
bazel build -c fastbuild //...

# Run tests
set +e  # Continue execution even if some tests fail
bazel test -c fastbuild --test_output=errors //...
set -e  # Stop execution on errors after tests

# Deactivate Python environment
deactivate