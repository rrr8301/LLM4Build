#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., source a virtualenv)

# Install project dependencies (if any specific installation is needed)

# Run tests with Maven
mvn -B -V -e -ntp "-Dstyle.color=always" -Pfull-build verify -Dsurefire-forkcount=1 -DskipCppUnit -Dsurefire.rerunFailingTestsCount=5

# Ensure all test cases are executed, even if some fail
# Maven will continue to execute all tests by default, even if some fail