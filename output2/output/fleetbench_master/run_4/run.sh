#!/bin/bash

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install pip in the virtual environment
pip install --upgrade pip

# Install project dependencies if any (e.g., from requirements.txt)
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

# Ensure Bazel 8.0.0 is in the PATH
export PATH="$PATH:/usr/bin"

# Check Bazel version
bazel_version=$(bazel --version)
echo "Bazel version: $bazel_version"

# Build the project using Bazel
bazel build -c fastbuild //...

# Run tests using Bazel
# Ensure all tests are executed, even if some fail
bazel test -c fastbuild --test_output=errors //...