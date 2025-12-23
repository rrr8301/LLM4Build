#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., source a virtualenv)

# Install project dependencies (if any specific installation is needed)

# Run tests with Maven, enabling full debug logging and skipping Javadoc generation
# Increase memory allocation for Maven Surefire plugin
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"

# Run Maven with additional options to ensure all tests are executed
mvn -B -V -e -ntp -X \
    "-Dstyle.color=always" -Pfull-build verify \
    -Dsurefire.forkCount=1 -DskipCppUnit \
    -Dsurefire.rerunFailingTestsCount=5 -Dmaven.javadoc.skip=true \
    -DskipTests=false -Denforcer.skip=true -Dlicense.skip=true