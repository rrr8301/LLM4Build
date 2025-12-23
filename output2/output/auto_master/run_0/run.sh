#!/bin/bash

# Install project dependencies
mvn -B dependency:go-offline -U --quiet --fail-never -DskipTests=true -f build-pom.xml

# Run tests
mvn -B verify -U --fail-at-end -Dsource.skip=true -Dmaven.javadoc.skip=true -f build-pom.xml