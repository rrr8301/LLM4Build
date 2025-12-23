#!/bin/bash

# run.sh

# Set Java environment variables
export JAVA_HOME=/opt/jdk-21
export PATH=$JAVA_HOME/bin:$PATH

# Use the Gradle wrapper to ensure compatibility
./gradlew -Pmockito.test.java=21 build --stacktrace

# Check if the build was successful before generating the coverage report
if [ $? -eq 0 ]; then
    # Generate coverage report
    ./gradlew -Pmockito.test.java=21 coverageReport --stacktrace
else
    echo "Build failed, skipping coverage report generation."
    exit 1
fi

# Note: Coverage upload is not handled in this script