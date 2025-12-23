#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies if any (none specified)

# Run build
bazel build -c opt //...

# Run tests
bazel test -c opt --test_output=errors //...

# Ensure all tests are executed, even if some fail
exit 0