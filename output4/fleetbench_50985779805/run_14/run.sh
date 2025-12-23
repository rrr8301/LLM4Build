#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies if any (none specified)

# Run build
bazel build -c opt //...

# Run tests
bazel test -c opt --test_output=errors //...

# Ensure all tests are executed, even if some fail
# Remove the unconditional exit 0 to ensure the script exits with the correct status
exit $?