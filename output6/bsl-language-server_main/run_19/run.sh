#!/bin/bash

set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Debugging: List files in the expected directory
echo "Listing files in ./src/test/resources/metadata/subSystemFilter/CommonModules/:"
find ./src/test/resources/metadata/subSystemFilter/CommonModules/ -type f

# Find the file with a dynamic directory name
# Adjust the path to match the actual directory structure
FILE_PATH=$(find ./src/test/resources/metadata/subSystemFilter/CommonModules/ -name "Module.bsl" -print -quit)

# Check if the file was found
if [ -z "$FILE_PATH" ]; then
    echo "Error: The file 'Module.bsl' does not exist in the expected directory."
    exit 1
fi

# Print the found file path for debugging
echo "Found Module.bsl at: $FILE_PATH"

# Check if the file path contains any non-standard characters
if [[ "$FILE_PATH" =~ [^a-zA-Z0-9/_\.-] ]]; then
    echo "Warning: The file path contains non-standard characters which may cause issues."
fi

# Run Gradle build without skipping any tests
./gradlew check --stacktrace --warning-mode all