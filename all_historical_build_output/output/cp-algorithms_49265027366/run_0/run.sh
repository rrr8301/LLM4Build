#!/bin/bash

# Activate Python environment (if any) and install project dependencies
# Assuming dependencies are listed in a requirements.txt file
if [ -f "requirements.txt" ]; then
    python3.8 -m pip install -r requirements.txt
fi

# Run tests
# Ensure all test cases are executed, even if some fail
set +e
./test.sh
set -e