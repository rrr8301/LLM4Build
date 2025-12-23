#!/bin/sh

# Increase Java heap size for the Maven build process
export JAVA_TOOL_OPTIONS="-Xmx4096m"

# Install project dependencies and build
mvn -B package --file auth/pom.xml

# Run tests
mvn clean verify