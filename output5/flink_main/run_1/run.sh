#!/bin/bash

# Activate environment (if needed, otherwise this can be omitted)
# source /path/to/your/env/bin/activate

# Set the DEBUG_FILES_OUTPUT_DIR environment variable
export DEBUG_FILES_OUTPUT_DIR="/app/debug_files"

# Install project dependencies, skipping enforcer and RAT checks
mvn clean install -Denforcer.skip=true -Drat.skip=true -DskipTests

# Run the test suite, allowing all tests to run even if some fail
./tools/ci/test_controller.sh --continue