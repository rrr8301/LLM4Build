#!/bin/bash

# Activate environments if any (none specified)

# Install project dependencies if any (none specified)

# Run build and test
ci/build

# Collect testdir from failed tests
if [ $? -ne 0 ]; then
  ci/collect-testdir
fi

# Note: Uploading artifacts is not supported in this script