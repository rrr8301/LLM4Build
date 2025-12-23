#!/bin/bash
set -euo pipefail

# Activate environment variables
export MAVEN_OPTS="${MAVEN_OPTS}"
export MAVEN_INSTALL_OPTS="${MAVEN_INSTALL_OPTS}"
export MAVEN_FAST_INSTALL="${MAVEN_FAST_INSTALL}"
export MAVEN_TEST="${MAVEN_TEST}"

# Ensure the correct Java version is used
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Check Java version
java -version

# Set the Java version for Maven
echo "Setting Java version to 17 in Maven"
./mvnw versions:set-property -Dproperty=maven.compiler.source -DnewVersion=17
./mvnw versions:set-property -Dproperty=maven.compiler.target -DnewVersion=17

# Ensure the Maven wrapper uses the correct Java version
./mvnw -version

# Install project dependencies
./mvnw clean install ${MAVEN_FAST_INSTALL} -am -pl "core/trino-main"

# Run tests
set +e  # Allow script to continue even if some tests fail
./mvnw test ${MAVEN_TEST} -pl "core/trino-main"
set -e  # Re-enable exit on error