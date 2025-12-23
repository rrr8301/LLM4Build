#!/bin/bash

set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Find the file with a dynamic directory name
FILE_PATH=$(find ./src/test/resources/metadata/subSystemFilter/CommonModules/ -path "*/Ext/Module.bsl" -print -quit)

# Check if the file was found
if [ -z "$FILE_PATH" ]; then
    echo "Error: The file 'Module.bsl' does not exist in the expected directory."
    exit 1
fi

# Run Gradle build without skipping any tests
./gradlew check --stacktrace --warning-mode all