#!/bin/bash

# Source SDKMAN to use Gradle
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Install project dependencies
./gradlew build

# Validate Gradle wrapper
./gradlew wrapperValidation

# Check reproducibility of artifacts
./check_reproducibility.sh

# Run Spotless check
./gradlew spotlessCheck --stacktrace --scan

# Build the project with specific configurations
./gradlew -Pmockito.test.java=17 build --stacktrace --scan

# Generate coverage report
./gradlew -Pmockito.test.java=17 coverageReport --stacktrace --scan

# Note: Uploading coverage report is skipped due to unsupported action