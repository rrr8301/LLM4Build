#!/bin/bash

# Activate any necessary environments (none needed for Java)

# Install project dependencies
# Maven will handle dependencies during the build process

# Run tests
# Ensure all tests are executed, even if some fail
set -e
mvn --batch-mode --no-transfer-progress verify javadoc:jar || true