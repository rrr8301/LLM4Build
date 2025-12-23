#!/bin/bash

# Check if the necessary files exist
EXPECTED_FILE="./src/test/resources/references/annotations/??????????????????????????????????2.os"
if [ ! -f "$EXPECTED_FILE" ]; then
    echo "Warning: Expected file is missing. Please ensure all necessary files are present."
    # Optionally, you can create a placeholder or handle the missing file scenario
    # touch "$EXPECTED_FILE"
fi

# Run Gradle build
./gradlew check --stacktrace --continue

# Note: The '--continue' flag allows the build to continue even if some tasks fail.