#!/bin/bash

# Activate Python environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies if any
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Clean and sync Bazel workspace
bazel clean --expunge

# Initialize Bazel workspace if not present
if [ ! -f "WORKSPACE" ]; then
    echo "workspace(name = \"fleetbench\")" > WORKSPACE
fi

# Fetch all Bazel dependencies
bazel fetch @bazel_skylib//... @com_github_grpc_grpc//... @bazel_toolchains//... //...

# Build the project with proper flags
bazel build -c fastbuild \
    --define=no_tensorflow_py_deps=true \
    --incompatible_skip_genfiles_symlink=false \
    //...

# Run tests with proper flags
set +e  # Continue execution even if some tests fail
bazel test -c fastbuild \
    --test_output=errors \
    --define=no_tensorflow_py_deps=true \
    --incompatible_skip_genfiles_symlink=false \
    --test_verbose_timeout_warnings \
    //...
set -e  # Continue execution even if some tests fail

# Deactivate Python environment
deactivate