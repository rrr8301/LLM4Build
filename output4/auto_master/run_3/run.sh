#!/bin/bash

# Activate any necessary environments (none needed for Java)

# Update Maven dependencies
mvn -B dependency:resolve -U --quiet --fail-never -DskipTests=true -f build-pom.xml

# Ensure the necessary dependencies are included
mvn -B dependency:tree -Dverbose -f build-pom.xml

# Run tests, ensuring all tests are executed even if some fail
mvn -B verify -U --fail-at-end -Dsource.skip=true -Dmaven.javadoc.skip=true -Denforcer.skip=true -Dlicense.skip=true -f build-pom.xml