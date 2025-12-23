#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Source SDKMAN to use Gradle
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Run Gradle build
./gradlew check --stacktrace

# Note: Removed '|| true' to ensure that all tests are executed and failures are not ignored