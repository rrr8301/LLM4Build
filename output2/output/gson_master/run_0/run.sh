#!/bin/bash

# Activate any necessary environments (none in this case)

# Install project dependencies and build the project
mvn --batch-mode --no-transfer-progress verify javadoc:jar

# Run tests
# Ensure all tests are executed, even if some fail
mvn test || true