#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Source SDKMAN to use Gradle
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Run Gradle build
./gradlew check --stacktrace --warning-mode all