#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Source SDKMAN to use Gradle
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Check if the problematic file exists and has the correct name
if [ ! -f "./src/test/resources/references/annotations/??????????????????????????????????2.os" ]; then
    echo "The file with special characters in the name is missing or incorrectly named."
    exit 1
fi

# Run Gradle build
./gradlew check --stacktrace --warning-mode all