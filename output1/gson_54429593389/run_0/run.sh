#!/bin/bash

# Activate any necessary environments (none needed for Java)

# Install project dependencies and build the project
mvn clean verify

# Run tests
mvn verify javadoc:jar || true

# Ensure all tests are executed, even if some fail
mvn test || true