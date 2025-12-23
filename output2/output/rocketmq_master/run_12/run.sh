#!/bin/sh

# Increase Java heap size for the Maven build process
export JAVA_TOOL_OPTIONS="-Xmx40960m"

# Install project dependencies and build
mvn -B package --file auth/pom.xml -Denforcer.skip=true -Dlicense.skip=true

# Run tests
mvn clean verify -Denforcer.skip=true -Dlicense.skip=true