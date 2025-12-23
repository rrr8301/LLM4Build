#!/bin/bash

# run.sh

# Set Java environment variables
export JAVA_HOME=/opt/jdk-21
export PATH=$JAVA_HOME/bin:$PATH

# Use the Gradle wrapper to ensure compatibility
./gradlew -Pmockito.test.java=21 build --stacktrace

# Generate coverage report
./gradlew -Pmockito.test.java=21 coverageReport --stacktrace

# Note: Coverage upload is not handled in this script