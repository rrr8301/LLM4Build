#!/bin/bash

set -e

# Validate Gradle wrapper
./gradlew wrapper --gradle-version 7.3.3

# Check reproducibility of artifacts
./check_reproducibility.sh || true

# Spotless check
./gradlew spotlessCheck --stacktrace --scan || true

# Build with Gradle
./gradlew -Pmockito.test.java=17 build --stacktrace --scan || true

# Generate coverage report
./gradlew -Pmockito.test.java=17 coverageReport --stacktrace --scan || true

# Note: Uploading coverage report is skipped due to GitHub-specific action