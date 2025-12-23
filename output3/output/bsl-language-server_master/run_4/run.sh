#!/bin/bash

# Define the directory and file pattern
DIR="./src/test/resources/references/annotations/"
FILE_PATTERN="??????????????????????????????????2.os"

# Create the directory if it doesn't exist
mkdir -p "$DIR"

# Check if any file matches the pattern
if ! ls "$DIR$FILE_PATTERN" 1> /dev/null 2>&1; then
    echo "Warning: Expected file is missing. Creating a placeholder file."
    # Create a placeholder file with a specific name
    PLACEHOLDER_FILE="${DIR}placeholder_file_2.os"
    touch "$PLACEHOLDER_FILE"
fi

# Run Gradle build
./gradlew check --stacktrace --continue

# Note: The '--continue' flag allows the build to continue even if some tasks fail.