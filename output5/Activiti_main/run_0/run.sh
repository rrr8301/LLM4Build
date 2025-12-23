#!/bin/bash

# Activate any necessary environments (if needed)
# For Java and Maven, this is typically not required, but you can set JAVA_HOME if needed
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Navigate to the project directory
cd /app

# Install project dependencies and run tests
# The `-fae` flag (fail at end) allows Maven to continue executing after a failure
mvn verify -fae

# Optionally, you can add more commands here if needed
# For example, to deploy (if needed)
# mvn deploy --show-version --no-transfer-progress --settings settings.xml