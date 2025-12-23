#!/bin/bash

# Activate any necessary environments (none needed for Java)

# Install project dependencies
mvn -B dependency:go-offline -U --quiet --fail-never -DskipTests=true -f build-pom.xml

# Run tests, ensuring all tests are executed even if some fail
mvn -B verify -U --fail-at-end -Dsource.skip=true -Dmaven.javadoc.skip=true -f build-pom.xml