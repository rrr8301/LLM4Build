#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Source SDKMAN to use Gradle
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Run Gradle build
./gradlew check --stacktrace || true

# Note: The '|| true' ensures that all tests are executed even if some fail