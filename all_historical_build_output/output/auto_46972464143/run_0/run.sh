#!/bin/bash

# Activate environment (if any specific setup is needed, add here)

# Install project dependencies
mvn -B dependency:go-offline test clean -U --quiet --fail-never -DskipTests=true -f build-pom.xml

# Run tests, ensuring all tests are executed even if some fail
mvn -B verify -U --fail-at-end -Dsource.skip=true -Dmaven.javadoc.skip=true -f build-pom.xml