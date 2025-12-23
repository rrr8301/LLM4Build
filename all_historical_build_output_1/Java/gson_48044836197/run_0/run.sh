#!/bin/bash

# run.sh

# Set Java Home
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

# Build and test the project with Maven
# Ensure all tests are executed, even if some fail
mvn --batch-mode --no-transfer-progress verify javadoc:jar || true