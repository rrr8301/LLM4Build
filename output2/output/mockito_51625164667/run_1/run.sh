#!/bin/bash

# run.sh

# Set Java environment variables
export JAVA_HOME=/opt/jdk-21
export PATH=$JAVA_HOME/bin:$PATH

# Build the project with Gradle
gradle -Pmockito.test.java=21 build --stacktrace --scan

# Generate coverage report
gradle -Pmockito.test.java=21 coverageReport --stacktrace --scan

# Note: Coverage upload is not handled in this script