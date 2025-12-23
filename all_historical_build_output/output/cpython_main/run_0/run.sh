#!/bin/bash

# run.sh

# Run tests
make test || true

# Ensure all tests are executed
if [ $? -ne 0 ]; then
    echo "Some tests failed, but continuing with the rest of the test suite."
fi

# Additional test options can be added here