#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., source a virtualenv)

# Install project dependencies (if any specific installation is needed)

# Run tests with Maven, enabling full debug logging and skipping Javadoc generation
# Increase memory allocation for Maven Surefire plugin
MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=256m" mvn -B -V -e -ntp -X \
    "-Dstyle.color=always" -Pfull-build verify \
    -Dsurefire.forkCount=1 -DskipCppUnit \
    -Dsurefire.rerunFailingTestsCount=5 -Dmaven.javadoc.skip=true

# Ensure all test cases are executed, even if some fail
# Maven will continue to execute all tests by default, even if some fail