#!/bin/bash

set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Check for the existence of the problematic file
if [ ! -f "./src/test/resources/metadata/subSystemFilter/CommonModules/??????????????????????2/Ext/Module.bsl" ]; then
    echo "Error: The file './src/test/resources/metadata/subSystemFilter/CommonModules/??????????????????????2/Ext/Module.bsl' does not exist."
    exit 1
fi

# Run Gradle build without skipping any tests
./gradlew check --stacktrace --warning-mode all