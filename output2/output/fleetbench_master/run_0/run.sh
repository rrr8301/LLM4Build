#!/bin/bash

# Activate Python environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies if any (e.g., from requirements.txt)
# pip install -r requirements.txt

# Build the project using Bazel
bazel build -c fastbuild //...

# Run tests using Bazel
# Ensure all tests are executed, even if some fail
bazel test -c fastbuild --test_output=errors //... || true