#!/bin/bash

# Set JAVA_HOME and update PATH
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Navigate to the project directory
cd /app

# Run Maven with detailed output to help diagnose issues
mvn clean verify -fae -e -X

# Optionally, you can add more commands here if needed
# For example, to deploy (if needed)
# mvn deploy --show-version --no-transfer-progress --settings settings.xml